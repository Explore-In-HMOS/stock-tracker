export interface FinancialAsset {
  name: string
  currentValue: number
  dailyPercentage: number
  historicalData?: FinancialDataPoint[]
}

export interface FinancialDataPoint {
  date: string
  value: number
}
