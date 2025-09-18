# 构建失败修复计划（Gradle plugins 声明式迁移）

更新时间：2025-09-19 00:30 (+08)

## 问题描述
- 构建失败，错误信息来源：`C:\Users\Administrator\fvm\versions\3.35.2\packages\flutter_tools\gradle\app_plugin_loader.gradle` line 9
- 提示：正在以“apply 脚本式”方式应用 Flutter 的 app_plugin_loader 插件，已不再支持；需要迁移到 `plugins` 声明式写法。

## 根因分析
- `android/settings.gradle` 使用了：
  - `apply from: "$flutterSdkPath/packages/flutter_tools/gradle/app_plugin_loader.gradle"`
- `android/app/build.gradle` 使用了：
  - `apply plugin: 'com.android.application'`
  - `apply plugin: 'kotlin-android'`
  - `apply plugin: 'com.google.gms.google-services'`
  - `apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"`

以上均为旧式“命令式 apply”写法，需迁移到 Gradle `plugins` 声明式方式。

## 修改项
1) 更新 `android/settings.gradle`
   - 添加 `pluginManagement { includeBuild(...) repositories {...} }`
   - 添加 `plugins { id "dev.flutter.flutter-plugin-loader" version "1.0.0" ... }`
   - 去除 `app_plugin_loader.gradle` 的 apply 方式

2) 更新 `android/app/build.gradle`
   - 添加 `plugins { id 'com.android.application'; id 'org.jetbrains.kotlin.android'; id 'com.google.gms.google-services'; id 'dev.flutter.flutter-gradle-plugin' }`
   - 移除 `apply plugin: ...` 与 `apply from: ".../flutter.gradle"`
   - 保留既有 `android {}`、`flutter {}`、`dependencies {}` 配置

## 进度
- [x] 创建/更新计划文件（本文件）并确认已在 `.gitignore` 中忽略
- [x] 检查 Gradle 配置文件（settings.gradle、build.gradle、app/build.gradle、gradle.properties）
- [x] 迁移到 `plugins` 声明式写法
- [x] 升级 AGP 至 8.6.0、Kotlin 至 2.1.0
- [x] 验证构建（`fvm flutter build apk` 已成功，产物：`build/app/outputs/flutter-apk/app-release.apk`）

## 版本与兼容性说明
- Gradle Wrapper：8.7（`android/gradle/wrapper/gradle-wrapper.properties`）
- Android Gradle Plugin（AGP）：8.6.0（`android/settings.gradle`）
- Kotlin：2.1.0（`android/settings.gradle`）
- Google Services：4.3.15

## 后续动作
- 如需本地调试：`fvm flutter run`。
- 如需发布前进一步优化，可考虑升级 Firebase BoM 与 desugar 版本，并清理不必要的 Proguard 规则提示。

