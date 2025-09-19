import UIKit
import Flutter
import Foundation

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // MethodChannel for iCloud sync
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.soigrames.kanjiremake/icloud_sync",
                                       binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      guard let _ = self else { return }
      let store = NSUbiquitousKeyValueStore.default

      switch call.method {
      case "isAvailable":
        // 简单判断：若未启用 iCloud，将无法同步；此处返回是否存在 iCloud 目录。
        // 更严格的判断需要在 Xcode 中启用 Capability，并在真机环境下测试。
        let token = FileManager.default.ubiquityIdentityToken
        result(token != nil)

      case "enable":
        // iCloud KVS 无需显式 enable，这里尝试同步一次
        store.synchronize()
        result(nil)

      case "disable":
        // 无法真正禁用，只做一次同步以确保状态落盘
        store.synchronize()
        result(nil)

      case "push":
        guard let args = call.arguments as? [String: Any],
              let data = args["data"] as? [String: Any] else {
          result(FlutterError(code: "ARG_ERROR", message: "Missing data", details: nil))
          return
        }
        do {
          let json = try JSONSerialization.data(withJSONObject: data, options: [])
          let str = String(data: json, encoding: .utf8)
          store.set(str, forKey: "progress_payload")
          let ok = store.synchronize()
          if ok { result(nil) } else {
            result(FlutterError(code: "SYNC_FAIL", message: "iCloud synchronize failed", details: nil))
          }
        } catch {
          result(FlutterError(code: "SERIALIZE_ERROR", message: error.localizedDescription, details: nil))
        }

      case "pull":
        store.synchronize()
        if let str = store.string(forKey: "progress_payload"), let data = str.data(using: .utf8) {
          do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
              result(["data": json])
            } else {
              result(["data": NSNull()])
            }
          } catch {
            result(FlutterError(code: "DESERIALIZE_ERROR", message: error.localizedDescription, details: nil))
          }
        } else {
          result(["data": NSNull()])
        }

      default:
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
