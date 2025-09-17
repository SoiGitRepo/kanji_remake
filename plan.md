# GoRouter 检查与修复计划（2025-09-17）

## 已完成
- [x] 定位所有 `context.pop()`/`popThisPageOut` 调用，补充 canPop 判定与兜底
- [x] 加强关闭逻辑：双重 canPop（GoRouter + Navigator）+ `Navigator.maybePop()` + try/catch 兜底
- [x] 将兜底路径统一为 `'/lesson'`，覆盖：
  - `lib/page/question_page/page_question.dart`
  - `lib/page/kanji_overview_page/page_kanji_overview.dart`
  - `lib/page/lesson_page/page_lesson.dart`
  - `lib/page/setting_dialog/setting_general.dart`
  - `lib/page/setting_dialog/feedback/setting_send_feedback.dart`
  - `lib/page/setting_dialog/auth/setting_account/setting_account.dart`
  - `lib/page/setting_dialog/sync/setting_sync.dart`
- [x] 审查 `lib/main.dart` 的 GoRouter 配置（结构简单清晰，无 ShellRoute 嵌套问题）
- [x] 将前进导航统一改为 `context.push(...)` 以保留返回栈：
  - `lib/page/level_page/page_level.dart`: `'/lesson'`
  - `lib/page/lesson_page/page_lesson.dart`: `'/learning'`、`'/kanji_overview'`

## 待验证
- [ ] 运行 `flutter analyze` 确认无静态问题
- [ ] 手测导航流：
  - 从 Level -> Lesson -> Learning，逐级返回是否正确
  - Lesson -> KanjiOverview 返回是否正确
  - 各设置/反馈/同步对话框关闭时无 GoError，且在无返回栈时落到 `'/lesson'`

## 备注
- 若未来引入 ShellRoute 或多 Navigator 嵌套，再评估是否需要 `useRootNavigator: true`
