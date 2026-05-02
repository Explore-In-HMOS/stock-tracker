export interface ChartDataItem {
  x: number;
  y: number;
  date: string;
}

export function createChartDataItem(x: number, y: number, date: string): ChartDataItem {
  return { x, y, date };
}

export interface ChartData {
  id: string;
  values: ChartDataItem[];
}

export interface LineStyle {
  stroke: string;
  lineWidth: number;
  lineCap?: string;
  lineJoin?: string;
}

export interface PointStyle {
  fill: string;
  stroke: string;
  lineWidth: number;
  size?: number;
}

export interface ChartAnimation {
  duration: number;
  easing: string;
  type: string;
}

interface GeneratedTypeLiteralInterface_1 {
  style: LineStyle;
}

interface GeneratedTypeLiteralInterface_2 {
  visible: boolean;
  size?: number;
  style: PointStyle;
}

export interface SeriesConfig {
  type: string;
  dataId: string;
  xField: string;
  yField: string;
  line?: GeneratedTypeLiteralInterface_1;
  point?: GeneratedTypeLiteralInterface_2;
  animation?: boolean;
  animationAppear?: ChartAnimation;
}

interface GeneratedTypeLiteralInterface_4 {
  fill: string;
}

interface GeneratedTypeLiteralInterface_3 {
  style: GeneratedTypeLiteralInterface_4;
}

export interface AxisConfig {
  orient: string;
  visible: boolean;
  type: string;
  label?: GeneratedTypeLiteralInterface_3;
}

export interface TooltipContent {
  key: string;
  value: (datum: ChartDataItem) => string;
}

interface GeneratedTypeLiteralInterface_6 {
  value: (datum: ChartDataItem) => string;
}

interface GeneratedTypeLiteralInterface_5 {
  visible: boolean;
  title: GeneratedTypeLiteralInterface_6;
  content: TooltipContent[];
}

export interface TooltipConfig {
  mark: GeneratedTypeLiteralInterface_5;
}

export interface CrosshairLineStyle {
  stroke: string;
  lineWidth: number;
  opacity: number;
  lineDash?: number[];
}

interface GeneratedTypeLiteralInterface_8 {
  style: CrosshairLineStyle;
}

interface GeneratedTypeLiteralInterface_9 {
  visible: boolean;
}

interface GeneratedTypeLiteralInterface_7 {
  visible: boolean;
  line: GeneratedTypeLiteralInterface_8;
}

export interface CrosshairConfig {
  xField: GeneratedTypeLiteralInterface_7;
  yField: GeneratedTypeLiteralInterface_9;
}

interface GeneratedTypeLiteralInterface_11 {
  palette: string[];
}

interface GeneratedTypeLiteralInterface_10 {
  default: GeneratedTypeLiteralInterface_11;
}

export interface ThemeConfig {
  colorScheme: GeneratedTypeLiteralInterface_10;
}

export interface VChartSpec {
  type: string;
  height: number;
  padding: number;
  data: ChartData[];
  series: SeriesConfig[];
  axes: AxisConfig[];
  tooltip?: TooltipConfig;
  crosshair?: CrosshairConfig;
  theme?: ThemeConfig;
  background: string;
}