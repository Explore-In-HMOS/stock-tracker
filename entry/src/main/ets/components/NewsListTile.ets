import { NewsItem } from '../model/NewsItem';

@Component
export struct NewsListTile {
  @Prop newsItem: NewsItem;
  private controller: VideoController = new VideoController();

  build() {
    Column() {
      Text(this.newsItem.title)
        .fontColor($r('app.color.news_title_text'))
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .margin(12)
        .maxLines(3)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Center)

      Video({
        src: $r('app.media.sample'),
        controller: this.controller,
        previewUri: $r('app.media.poster')
      })
        .autoPlay(false)
        .muted(false)
        .objectFit(ImageFit.Contain)
        .height('70%')
        .borderRadius(12)
        .width('100%')
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('60%')
    .height('80%')
    .padding(18)
  }
}
