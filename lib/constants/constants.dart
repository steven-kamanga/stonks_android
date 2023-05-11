const String apiKey = "6OWEJYO9Q16206O4";
const String eur = "EUR";
const String usd = "USD";
const String jpy = "JPY";
const String gbp = "GBP";

class Urls {
  static const String eurUsd =
      "https://www.alphavantage.co/query?function=FX_DAILY&from_symbol=$eur&to_symbol=$usd&apikey=$apiKey";
  static const String usdJpy =
      "https://www.alphavantage.co/query?function=FX_DAILY&from_symbol=$usd&to_symbol=$jpy&apikey=$apiKey";
}
