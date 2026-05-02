import { NewsListTile } from '../components/NewsListTile';
import { NewsItem } from '../model/NewsItem';
import { NewsViewModel } from '../viewmodel/NewsViewModel';
import { vibrator } from '@kit.SensorServiceKit';
import {
  ArcSwiper,
  ArcSwiperAttribute,
  ArcDotIndicator,
  ArcDirection
} from '@kit.ArkUI';

@Entry
struct NewsPage {
  private viewModel: NewsViewModel = new NewsViewModel();

  private triggerHaptic(): void {
    try {
      vibrator.startVibration(
        {
          type: 'preset',
          effectId: 'haptic.slide',
          count: 1
        },
        {
          usage: 'touch'
        }
      );
    } catch (err) {
    }
  }

  build() {
    ArcSwiper() {
      ForEach(this.viewModel.newsList, (item: NewsItem) => {
        NewsListTile({
          newsItem: item
        })
      }, (item: NewsItem) => item.title)
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
    .onChange((_index: number) => {
      this.triggerHaptic();
    })
    .height('100%')
    .width('100%')
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
  }
}

export { NewsPage };
