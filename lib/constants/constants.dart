const String apiKey = "6OWEJYO9Q16206O4";
const String eur = "EUR";
const String usd = "USD";
const String jpy = "JPY";
const String gbp = "GBP";

class Urls {
  static const String News =
      "https://api.marketaux.com/v1/news/all?symbols=TSLA,AMZN,MSFT&filter_entities=true&language=en&api_token=B4Ocp32SEDzQV4Ae6RTpeQ1I5Lyq48eYAWUk70L5";
  static const String eurUsd =
      "https://www.alphavantage.co/query?function=FX_DAILY&from_symbol=$eur&to_symbol=$usd&apikey=$apiKey";
  static const String eurJpy =
      "https://www.alphavantage.co/query?function=FX_DAILY&from_symbol=$eur&to_symbol=$jpy&apikey=$apiKey";
  static const String usdJpy =
      "https://www.alphavantage.co/query?function=FX_DAILY&from_symbol=$usd&to_symbol=$jpy&apikey=$apiKey";
}
