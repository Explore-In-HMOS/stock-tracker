import { FinancialAsset } from '../model/FinancialAsset';
import { VChart } from '@visactor/harmony-vchart';
import {
  AxisConfig,
  ChartAnimation,
  ChartData,
  ChartDataItem,
  CrosshairConfig,
  CrosshairLineStyle,
  LineStyle,
  PointStyle,
  SeriesConfig,
  ThemeConfig,
  TooltipConfig,
  TooltipContent,
  VChartSpec
} from '../model/ChartModels';

@Component
export struct FinancialListTile {
  @Prop financialAsset: FinancialAsset;
  @State spec: VChartSpec = this.getInitialSpec();

  aboutToAppear() {
    this.setupChartSpec();
  }

  private getInitialSpec(): VChartSpec {
    return {
      type: 'line',
      height: 120,
      padding: 0,
      data: [],
      series: [],
      axes: [],
      background: 'transparent'
    };
  }

  private getColorHex(isPositive: boolean): string {
    return isPositive ? '#00C853' : '#FF3B30';
  }

  setupChartSpec() {
    const isPositive = this.financialAsset.dailyPercentage >= 0;
    const color = this.getColorHex(isPositive);

    const chartDataValues: ChartDataItem[] = this.financialAsset.historicalData?.map((point, index) => {
      return { x: index, y: point.value, date: point.date } as ChartDataItem;
    }) || [];

    const chartData: ChartData = { id: 'lineData', values: chartDataValues };

    const lineStyle: LineStyle = {
      stroke: color,
      lineWidth: 2,
      lineCap: 'round',
      lineJoin: 'round'
    };

    const pointStyle: PointStyle = {
      fill: '#FFFFFF',
      stroke: '#FFE9CC',
      lineWidth: 2,
      size: 0
    };

    const animation: ChartAnimation = {
      duration: 1000,
      easing: 'cubicOut',
      type: 'clipIn'
    };

    const seriesConfig: SeriesConfig = {
      type: 'line',
      dataId: 'lineData',
      xField: 'x',
      yField: 'y',
      line: { style: lineStyle },
      point: { visible: false, size: 0, style: pointStyle },
      animation: true,
      animationAppear: animation
    };

    const xAxis: AxisConfig = { orient: 'bottom', visible: false, type: 'linear' };
    const yAxis: AxisConfig = { orient: 'left', visible: false, type: 'linear' };

    const tooltipContent: TooltipContent = {
      key: this.financialAsset.name,
      value: (datum: ChartDataItem) => `$${datum?.y?.toFixed(2) || '0.00'}`
    };

    const tooltip: TooltipConfig = {
      mark: {
        visible: false,
        title: { value: (datum: ChartDataItem) => datum?.date || '' },
        content: [tooltipContent]
      }
    };

    const crosshairLineStyle: CrosshairLineStyle = {
      stroke: '#666666',
      lineWidth: 1,
      opacity: 0.6,
      lineDash: [4, 4]
    };

    const crosshair: CrosshairConfig = {
      xField: { visible: false, line: { style: crosshairLineStyle } },
      yField: { visible: false }
    };

    const theme: ThemeConfig = {
      colorScheme: { default: { palette: [color] } }
    };

    this.spec = {
      type: 'line',
      height: 120,
      padding: 0,
      data: [chartData],
      series: [seriesConfig],
      axes: [xAxis, yAxis],
      theme: theme,
      background: 'transparent'
    };
  }

  build() {
    // Full size container — ArcSwiper handles clipping for circular screen
    Column({ space: 8 }) {
      // Header info
      Column({ space: 4 }) {
        Text(this.financialAsset.name)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row({ space: 8 }) {
          Text(`$${this.financialAsset.currentValue.toLocaleString('en-US', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
          })}`)
            .fontSize(16)
            .fontColor($r('app.color.text_primary'))

          Text(`${this.financialAsset.dailyPercentage >= 0 ? '+' : ''}${this.financialAsset.dailyPercentage.toFixed(2)}%`)
            .fontSize(14)
            .fontColor(this.financialAsset.dailyPercentage >= 0
              ? $r('app.color.price_positive')
              : $r('app.color.price_negative'))
        }
      }
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 40, left: 16, right: 16 })

      // Chart
      if (this.financialAsset.historicalData && this.financialAsset.historicalData.length > 0) {
        Column() {
          VChart({ spec: this.spec })
            .height(10)
        }
        .width('100%')
        .height(100)
        .padding({ left: 8, right: 8 })
      } else {
        Text($r('app.string.chart_no_data'))
          .fontSize(14)
          .fontColor($r('app.color.chart_no_data_text'))
          .width('100%')
          .height(100)
          .textAlign(TextAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }

  onPageShow() {
    this.setupChartSpec();
  }
}
