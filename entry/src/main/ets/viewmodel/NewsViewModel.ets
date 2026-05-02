import { NewsItem } from '../model/NewsItem';

@Observed
export class NewsViewModel {
  newsList: Array<NewsItem> = [
    {
      title: 'Cryptex Nears All-Time High as Market Confidence Grows'
    },
    {
      title: 'Vizion AI Unveils New Chipset for Smart Devices'
    },
    {
      title: 'Federal Reserve Holds Rates Steady Amid Inflation Concerns'
    },
    {
      title: 'Global Markets Rally on Strong Employment Data'
    },
    {
      title: 'Tech Sector Leads S&P 500 to Record Close'
    }
  ];
}
