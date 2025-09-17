# 项目体检结论与重构方案（定制版）

本方案基于对 `lib/` 的扫描与重点源码阅读，聚焦状态管理、数据仓库、模型与页面耦合问题，兼顾最小化改动与保留现有交互行为。

## 主要发现

- 重复/不一致的全局 Provider
  - `lib/global_providers.dart` 与 `lib/providers/app_providers.dart` 重复定义 `sharedPreferencesProvider`、`authServiceProvider`。
  - 仍有文件引用 `global_providers.dart`（需替换为 `providers/app_providers.dart`）：
    - `lib/page/setting_dialog/auth/auth_viewmodel.dart`
    - `lib/page/setting_dialog/auth/setting_auth_route.dart`

- 仓库命名与接线
  - `lib/repo/lesso_repo.dart` 命名错误，应为 `lesson_repository.dart`，且含 `part 'lesso_repo.g.dart';`。
  - 暂未与业务 Provider 打通（如课程加载）。

- 模型重复与归档不清
  - `lib/model/kanji_word_1.dart` 承载实际使用的实体（ObjectBox）。
  - `lib/model/kanji_word.dart` 仅存放 `KanjiField` 与 `cardTypeToFieldMap`，旧版 `KanjiWord` 已注释。
  - 建议：将 `KanjiField` 拆到 `model/kanji_field.dart`；统一仅保留 `model/kanji_word.dart` 为实体定义。

- Question 状态存在两套实现
  - 旧：`lib/page/question_page/question_state_provider.dart`
  - 新：`lib/providers/question_providers.dart`
  - 新版缺少 `kanjikata` 拼字题能力与“错题放队尾”的行为，UI 仍依赖旧文件（`page_question.dart` 与三张卡片均 import 旧文件）。

- Lesson 状态也存在两套
  - 旧：`lib/page/lesson_page/lesson_provider.dart`
  - 新：`lib/providers/lesson_providers.dart`
  - `page_lesson.dart` 仍用旧 Provider，并直接写入学习词表。

## 重构目标

- 统一 Provider 来源到 `lib/providers/`，页面不再 import `page/.../xxx_provider.dart`。
- 保留既有交互：错题放到队尾、`kanjikata` 拼字题正常可用。
- 规范命名与目录：仓库重命名；模型拆分归一。

## 分阶段实施方案

### 阶段 1（低风险清理与统一入口）

- 合并全局 Provider
  - 以 `providers/app_providers.dart` 为唯一入口。
  - 将 `global_providers.dart` 改为重导出或删除并替换引用到 `app_providers.dart`。

- 设置项完善
  - 为 `themeModeProvider`、`appLanguageProvider` 增加 setter，并持久化写回 `SharedPreferences`。

- 仓库命名与对接
  - `repo/lesso_repo.dart` → `repo/lesson_repository.dart`
  - `part 'lesso_repo.g.dart'` → `part 'lesson_repository.g.dart'`
  - 在 `providers/lesson_providers.dart` 的 `LessonsNotifier.loadLessons()` 中接入仓库（JLPT 默认 5，可配置）。

验收点
- App 正常启动，导航不回归。
- 本阶段不动 Question 流程，功能保持原状。

### 阶段 2（Lesson 状态统一与页面适配）

- 用 `providers/lesson_providers.dart` 替换旧的 `page/lesson_page/lesson_provider.dart`
  - `lessonsListProvider` → `lessonsProvider`
  - `lessonNeedReview` → `lessonsNeedReviewProvider`
  - `page_lesson.dart` onTap 不再写 `currentLessonKanjiWordsProvider`，改为设置 `selectedLessonProvider`。

- 在 `providers/question_providers.dart` 读取 `selectedLessonProvider` 初始化题卡。

验收点
- 课程列表与进入学习流程正常。

### 阶段 3（Question 状态统一与行为保真）

- 合并 `question_state_provider.dart` → `providers/question_providers.dart`（仅保留后者）
  - 补齐能力：
    - `currentKanjikataQueue`（供 `ChooseKanjiCard` 使用）
    - `allChoicesProvider` 增加 `KanjiField.kanjikata` case，返回 `List<MapEntry<int, String>>`
    - `isWrongAnswerProvider`（统一命名）
    - `showSubtitleProvider`（对齐旧 `showSubTitle`）
  - 为 `QuestionCardsNotifier` 增加：
    - `removeAt(int index)`、`add(QuestionCard)`、`requeueAtEnd(int index)` 以复刻“错题放队尾”
    - 保留 `shuffle()`

- 页面组件适配（尽量仅替换 import 与 Provider 名称）
  - `page_question.dart`、`card_kanji_choice.dart`、`card_four_choice.dart`、`card_overview.dart`

验收点
- 错题重新排队行为一致。
- `kanjikata` 拼字题正常。

### 阶段 4（模型整合与命名清理）

- 新增 `model/kanji_field.dart`（存 `KanjiField` 与 `cardTypeToFieldMap`）
- 统一 `KanjiWord`：
  - 将 `model/kanji_word_1.dart` 合并/重命名为 `model/kanji_word.dart`
  - 全项目替换引用，并删除旧 `model/kanji_word.dart` 中历史残留
- 统一命名：`ifTokeWrongProvider` → `isWrongAnswerProvider`

验收点
- 构建通过，ObjectBox 与仓库工作正常。

## 影响面与替换清单

- Provider 替换
  - `import 'page/question_page/question_state_provider.dart'`
    → `import 'providers/question_providers.dart'`
  - `import 'page/lesson_page/lesson_provider.dart'`
    → `import 'providers/lesson_providers.dart'`
  - `import 'global_providers.dart'`
    → `import 'providers/app_providers.dart'`

- 模型替换
  - `import 'model/kanji_word_1.dart'`
    → `import 'model/kanji_word.dart'`
  - 新增 `import 'model/kanji_field.dart'`

- 仓库替换
  - `import 'repo/lesso_repo.dart'`
    → `import 'repo/lesson_repository.dart'`
  - `part 'lesso_repo.g.dart'`
    → `part 'lesson_repository.g.dart'`

## 目标目录结构

- `providers/`: `app_providers.dart`、`lesson_providers.dart`、`question_providers.dart`
- `repo/`: `lesson_repository.dart`
- `model/`: `kanji.dart`、`kanji_word.dart`、`kanji_field.dart`、`lesson_pre.dart`、`question_card.dart`
- `page/`: 页面只 import `providers/` 下的文件

## 风险与回归点

- `kanjikata` 拼字题需补全，否则 `ChooseKanjiCard` 失效。
- 错题重排行为需在 `QuestionCardsNotifier` 里实现。
- 仓库文件重命名需同步 `part` 路径；若使用代码生成，需执行一次生成任务。

## 工期与提交节奏（建议）

- 阶段 1：0.5 天
- 阶段 2：0.5 天
- 阶段 3：1 天
- 阶段 4：0.5 天

提交信息使用简明中文。

## 需要确认的决策

- JLPT 默认加载级别（建议默认 5，可在设置中更改）。
- Question 状态合并策略
  - 建议：在 `QuestionCardsNotifier` 中复刻 `ListCardOrder` 的关键行为，页面改动最小。

已确认：
- JLPT 默认加载级别采用 5。
- Question 状态合并采用在 `QuestionCardsNotifier` 内新增方法复刻“错题放队尾”。

## 执行追踪（勾选清单）

- [x] 阶段 1：全局 Provider 合并与设置项完善
- [x] 阶段 1：仓库重命名与 `loadLessons()` 对接（采用 `repo/lesson_repository.dart` 别名导出，稳定引用路径；`LessonsNotifier.loadLessons()` 已接入）
- [x] 阶段 2：Lesson 状态统一与页面适配（`page_lesson.dart`、`page_level.dart` 已切换到 `providers/lesson_providers.dart` 并通过 `selectedLessonProvider` 进入学习）
- [x] 阶段 3：Question 状态统一（补齐 kanjikata 与错题重排）（`providers/question_providers.dart` 已补齐；`page_question.dart` 和三张卡片已切换新 Provider 并保持原交互）
- [x] 阶段 4：模型整合与命名清理
- [ ] 补充基础测试（Providers/Repository）

## 阶段更新日志

- 2025-09-16 22:38
  - 完成：全局 Provider 合并（`lib/global_providers.dart` -> `export providers/app_providers.dart`）；新增主题/语言/JLPT setter 并持久化。
  - 完成：仓库对接（新增 `repo/lesson_repository.dart` 别名导出；`lessonsProvider.loadLessons()` 通过 `lessonRepoProvider` 与 JLPT 设置加载课程）。
  - 完成：Lesson 页面替换与行为调整（`page_lesson.dart`、`page_level.dart`）。
  - 完成：Question 流统一（补齐 `currentKanjikataQueue`、`allChoicesProvider` 的 `kanjikata` 分支、错题放队尾 `requeue` 能力），三张卡片与问题页已适配。
  - 待办：阶段 4 模型整合（拆分 `kanji_field.dart` 与统一实体文件），以及补充基础测试。
  - 决策已确认：JLPT 默认 5；错题放队尾策略采用 `QuestionCardsNotifier` 的方法实现。

- 2025-09-16 23:27
  - 完成：模型整合与命名清理：新增 `model/kanji_field.dart`，将实体统一由 `model/kanji_word.dart` 重导出 `kanji_word_1.dart`；将 `cardTypeToFieldMap` 迁移到 `model/question_card.dart`；清理旧 `question_state_provider.dart` 为重导出新 providers。
  - 新增：`test/question_providers_test.dart` 基础用例，准备执行测试验证。

- 2025-09-17 10:27
  - 完成：Android 构建修复与工具链对齐。
    - `android/app/build.gradle`：`compileSdkVersion`/`targetSdkVersion` 升至 35；指定 `buildToolsVersion "34.0.0"`，避免 rc 版构建工具引发 aapt2 资源链接错误。
    - `android/build.gradle`：Android Gradle Plugin 升级到 `8.3.2`；Kotlin 插件升级到 `1.9.24`。
    - `android/gradle/wrapper/gradle-wrapper.properties`：Gradle 升级到 `8.6`。
    - 安装并对齐 SDK 组件：`platforms;android-34` 与 `build-tools;34.0.0`。
  - 结果：
    - Debug 构建通过：`build/app/outputs/flutter-apk/app-debug.apk`。
    - Release 构建通过（未签名）：`build/app/outputs/flutter-apk/app-release.apk`。
  - 备注：日志提示 Gradle 插件旧式 `apply from:` 用法后续需要迁移到 `plugins {}`，不影响当前构建。
