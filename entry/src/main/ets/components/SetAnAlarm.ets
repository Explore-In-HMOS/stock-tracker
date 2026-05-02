import { reminderAgentManager } from '@kit.BackgroundTasksKit';
import { notificationManager } from '@kit.NotificationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { vibrator } from '@kit.SensorServiceKit';
import { common } from '@kit.AbilityKit';
import { ArcButton, ArcButtonOptions, ArcButtonPosition, ArcButtonStyleMode } from '@kit.ArkUI';

@Component
export struct SetAnAlarmButton {
  @Prop context: common.UIAbilityContext;
  @State private pageState: number = 0;
  @State private selectedHour: number = new Date().getHours();
  @State private selectedMinute: number = new Date().getMinutes();
  @State private activeReminderId: number = -1;
  @State private isAlarmSet: boolean = false;

  private triggerHaptic(): void {
    try {
      vibrator.startVibration(
        { type: 'preset', effectId: 'haptic.clock.timer', count: 1 },
        { usage: 'alarm' }
      );
    } catch (err) {

    }
  }

  private async publishAlarm(): Promise<void> {
    const rm = this.context.resourceManager;
    const bundleName = this.context.abilityInfo.bundleName;

    const alarm: reminderAgentManager.ReminderRequestAlarm = {
      reminderType: reminderAgentManager.ReminderType.REMINDER_TYPE_ALARM,
      hour: this.selectedHour,
      minute: this.selectedMinute,
      daysOfWeek: [],
      actionButton: [
        {
          title: rm.getStringSync($r('app.string.alarm_close_button').id),
          type: reminderAgentManager.ActionButtonType.ACTION_BUTTON_TYPE_CLOSE
        },
        {
          title: rm.getStringSync($r('app.string.alarm_snooze_button').id),
          type: reminderAgentManager.ActionButtonType.ACTION_BUTTON_TYPE_SNOOZE
        }
      ],
      slotType: notificationManager.SlotType.SOCIAL_COMMUNICATION,
      ringDuration: 30,
      wantAgent: {
        pkgName: bundleName,
        abilityName: 'EntryAbility'
      },
      title: rm.getStringSync($r('app.string.alarm_title').id),
      content: rm.getStringSync($r('app.string.alarm_content').id),
      snoozeTimes: 1,
      timeInterval: 300
    };

    try {
      if (this.activeReminderId !== -1) {
        await reminderAgentManager.cancelReminder(this.activeReminderId);
        this.activeReminderId = -1;
      }
      const reminderId: number = await reminderAgentManager.publishReminder(alarm);
      this.activeReminderId = reminderId;
      this.isAlarmSet = true;
      this.triggerHaptic();
    } catch (err) {
      const error = err as BusinessError;
      console.error(`Failed to publish alarm: ${error.code} - ${error.message}`);
    }
  }

  private async cancelAlarm(): Promise<void> {
    if (this.activeReminderId === -1) {
      return;
    }
    try {
      await reminderAgentManager.cancelReminder(this.activeReminderId);
      this.activeReminderId = -1;
      this.isAlarmSet = false;
      this.triggerHaptic();
    } catch (err) {
      const error = err as BusinessError;
      console.error(`Failed to cancel alarm: ${error.code} - ${error.message}`);
    }
  }

  build() {
    Column() {
      if (this.pageState === 0) {
        // ── Main button view ──
        Column({ space: 4 }) {
          if (this.isAlarmSet) {
            Row({ space: 4 }) {
              Text('⏰')
                .fontSize(12)
              Text(`${this.selectedHour.toString().padStart(2, '0')}:${this.selectedMinute.toString()
                .padStart(2, '0')}`)
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .fontColor($r('app.color.indicator_selected'))
            }
            .padding({
              left: 10,
              right: 10,
              top: 4,
              bottom: 4
            })
            .borderRadius(12)
            .backgroundColor($r('app.color.alarm_button_background'))
            .margin({ bottom: 4 })
          }

          ArcButton({
            options: new ArcButtonOptions({
              label: this.isAlarmSet
                ? $r('app.string.alarm_cancel_button')
                : $r('app.string.alarm_set_button'),
              position: ArcButtonPosition.BOTTOM_EDGE,
              styleMode: this.isAlarmSet
                ? ArcButtonStyleMode.NORMAL_DARK
                : ArcButtonStyleMode.EMPHASIZED_LIGHT,
              onClick: () => {
                if (this.isAlarmSet) {
                  this.cancelAlarm();
                } else {
                  this.pageState = 1;
                }
              }
            })
          })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.End)
        .width('100%')

      } else {
        
        Column({ space: 0 }) {
          Text($r('app.string.alarm_page_title'))
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_primary'))
            .margin({ top: 20, bottom: 4 })

          Stack() {
            Row()
              .width('70%')
              .height(44)
              .borderRadius(12)
              .backgroundColor($r('app.color.alarm_button_background'))
              .border({
                width: 1,
                color: $r('app.color.alarm_button_border'),
                radius: 12
              })

            TimePicker()
              .useMilitaryTime(true)
              .disappearTextStyle({
                color: $r('app.color.text_secondary'),
                font: { size: 14, weight: FontWeight.Regular }
              })
              .textStyle({
                color: $r('app.color.text_secondary'),
                font: { size: 16, weight: FontWeight.Regular }
              })
              .selectedTextStyle({
                color: $r('app.color.time_picker_selected'),
                font: { size: 20, weight: FontWeight.Bold }
              })
              .onChange((value: TimePickerResult) => {
                this.selectedHour = value.hour;
                this.selectedMinute = value.minute;
              })
              .width('100%')
              .height(130)
          }
          .width('100%')
          .height(130)

          ArcButton({
            options: new ArcButtonOptions({
              label: $r('app.string.alarm_confirm_button'),
              position: ArcButtonPosition.BOTTOM_EDGE,
              styleMode: ArcButtonStyleMode.EMPHASIZED_LIGHT,
              onClick: () => {
                this.pageState = 0;
                this.publishAlarm();
              }
            })
          })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .height('100%')
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(this.pageState === 0 ? FlexAlign.End : FlexAlign.Start)
  }
}
