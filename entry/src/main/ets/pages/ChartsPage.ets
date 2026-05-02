import { FinancialListTile } from '../components/FinancialListTile';
import { FinancialAsset } from '../model/FinancialAsset';
import { ListViewModel } from '../viewmodel/ListViewModel';
import { SetAnAlarmButton } from '../components/SetAnAlarm';
import { vibrator } from '@kit.SensorServiceKit';
import { common } from '@kit.AbilityKit';
import {
  ArcSwiper,
  ArcSwiperAttribute,
  ArcDotIndicator,
  ArcDirection,
  ArcSwiperController
} from '@kit.ArkUI';

@Entry
struct ChartsPage {
  private viewModel: ListViewModel = new ListViewModel();
  private context = this.getUIContext().getHostContext() as common.UIAbilityContext;
  @State private currentIndex: number = 0;

  private triggerHaptic(): void {
    try {
      vibrator.startVibration(
        { type: 'preset', effectId: 'haptic.slide', count: 1 },
        { usage: 'touch' }
      );
    } catch (err) {

    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      ArcSwiper() {
        ForEach(this.viewModel.listContents, (item: FinancialAsset, index: number) => {
          Column() {
            FinancialListTile({ financialAsset: item })
          }
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Left,
            repeating: false,
            angle: 12,
            colors: [
              [$r('app.color.gradient_start'), 0.0],
              [$r('app.color.gradient_mid'), 0.25],
              [$r('app.color.gradient_end'), 0.5]
            ]
          })
        }, (item: FinancialAsset) => item.name)
      }
      .indicator(
        new ArcDotIndicator()
          .arcDirection(ArcDirection.SIX_CLOCK_DIRECTION)
          .itemColor($r('app.color.text_secondary'))
          .selectedItemColor($r('app.color.indicator_selected'))
      )
      .vertical(true)
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
      .digitalCrownSensitivity(CrownSensitivity.MEDIUM)
      .onChange((index: number) => {
        this.currentIndex = index;
        this.triggerHaptic();
      })
      .height('100%')
      .width('100%')

      Column() {
        SetAnAlarmButton({ context: this.context })
      }
      .width('100%')
      .padding({ bottom: 4 })
    }
    .width('100%')
    .height('100%')
  }
}

export { ChartsPage };
