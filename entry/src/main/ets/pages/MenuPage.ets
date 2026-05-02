import { ChartsPage } from './ChartsPage';
import { NewsPage } from './NewsPage';
import { vibrator } from '@kit.SensorServiceKit';

@Entry
@Component
struct Index {
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack();

  private triggerHaptic(): void {
    try {
      vibrator.startVibration(
        {
          type: 'preset',
          effectId: 'haptic.tap',
          count: 1
        },
        {
          usage: 'touch'
        }
      );
    } catch (err) {
    }
  }

  @Builder
  routeMap(name: string, params: object) {
    NavDestination() {
      if (name === 'ChartsPage') {
        ChartsPage();
      } else if (name === 'NewsPage') {
        NewsPage();
      }
    }
    .hideTitleBar(true);
  }

  build() {
    Navigation(this.pageStack) {
      Stack({ alignContent: Alignment.Center }) {
        Column()
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

        // Menu icons
        Row({ space: 12 }) {
          Column({ space: 6 }) {
            Image($r('app.media.news'))
              .height(72)
              .width(72)
              .padding(8)
              .borderRadius(12)
              .backgroundColor($r('app.color.icon_background'))
              .accessibilityText($r('app.string.menu_news_label'))
              .onClick(() => {
                this.triggerHaptic();
                this.pageStack.pushPath({ name: 'NewsPage' });
              })

            Text($r('app.string.menu_news_label'))
              .fontSize(10)
              .fontColor($r('app.color.text_secondary'))
          }
          .alignItems(HorizontalAlign.Center)

          Column({ space: 6 }) {
            Image($r('app.media.line_chart_icon'))
              .padding(8)
              .height(72)
              .width(72)
              .borderRadius(12)
              .backgroundColor($r('app.color.icon_background'))
              .accessibilityText($r('app.string.menu_charts_label'))
              .onClick(() => {
                this.triggerHaptic();
                this.pageStack.pushPath({ name: 'ChartsPage' });
              })

            Text($r('app.string.menu_charts_label'))
              .fontSize(10)
              .fontColor($r('app.color.text_secondary'))
          }
          .alignItems(HorizontalAlign.Center)
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height('100%')
    }
    .navDestination(this.routeMap)
    .ignoreLayoutSafeArea()
    .hideTitleBar(true)
    .width('100%')
    .height('100%');
  }
}
