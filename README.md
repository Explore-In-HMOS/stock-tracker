# Stock Tracker
This demo showcases a stock tracking application built with HarmonyOS NEXT APIs.

# Preview
<div>
<img src="screenshots/ss.gif" width="24%">
<img src="screenshots/ss1.png" width="24%">
<img src="screenshots/ss2.png" width="24%">
<img src="screenshots/ss3.png" width="24%">
</div>

# Use Cases
- Track stock market data with interactive charts
- View recent financial news with video content
- Set and manage portfolio check alarms
- Navigate with digital crown and arc gestures

# Technology
## Stack
- **Languages**: ArkTS
- **Frameworks**: HarmonyOS SDK 5.1.0(18)
- **Tools**: DevEco Studio Version 5.1.0.828
- **Libraries**
  - `@visactor/harmony-vchart` — Interactive stock charts
  - `@ohos.mediakit` — Video playback
  - `@kit.BackgroundTasksKit` — Agent-powered reminders
  - `@kit.NotificationKit` — Notification management
  - `@kit.SensorServiceKit` — Haptic feedback

## Required Permissions
- `ohos.permission.PUBLISH_AGENT_REMINDER`
- `ohos.permission.VIBRATE`
# Directory Structure
```
entry/src/main/ets/
|---viewmodel
|   |---ListViewModel.ets          // Stock asset data and generation
|   |---NewsViewModel.ets          // News feed data
|---pages
|   |---MenuPage.ets               // Main menu with navigation
|   |---ChartsPage.ets             // Stock charts with alarm button
|   |---NewsPage.ets               // Financial news feed
|---components
|   |---FinancialListTile.ets      // Stock card with VChart
|   |---NewsListTile.ets           // News card with video
|   |---SetAnAlarm.ets             // Alarm set/cancel component
|---model
|   |---ChartModels.ets            // VChart type definitions
|   |---FinancialAsset.ets         // Stock asset model
|   |---NewsItem.ets               // News item model
|---entryability
|   |---EntryAbility.ets           // App entry, notification setup
|---entrybackupability
|   |---EntryBackupAbility.ets
|---resources
```

# Constraints and Restrictions

## Supported Devices

- Huawei Watch 5

# LICENSE

**Stock Tracker** is distributed under the terms of the MIT License.
See the [license](/LICENSE) for more information.