// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MarketData marketDataFromJson(String str) =>
    MarketData.fromJson(json.decode(str));

String welcomeToJson(MarketData data) => json.encode(data.toJson());

class MarketData {
  MetaData metaData;
  Map<String, TimeSeriesFxDaily> timeSeriesFxDaily;

  MarketData({
    required this.metaData,
    required this.timeSeriesFxDaily,
  });

  factory MarketData.fromJson(Map<String, dynamic> json) => MarketData(
        metaData: MetaData.fromJson(json["Meta Data"]),
        timeSeriesFxDaily: Map.from(json["Time Series FX (Daily)"]).map(
            (k, v) => MapEntry<String, TimeSeriesFxDaily>(
                k, TimeSeriesFxDaily.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "Meta Data": metaData.toJson(),
        "Time Series FX (Daily)": Map.from(timeSeriesFxDaily)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class MetaData {
  String the1Information;
  String the2FromSymbol;
  String the3ToSymbol;
  String the4OutputSize;
  DateTime the5LastRefreshed;
  String the6TimeZone;

  MetaData({
    required this.the1Information,
    required this.the2FromSymbol,
    required this.the3ToSymbol,
    required this.the4OutputSize,
    required this.the5LastRefreshed,
    required this.the6TimeZone,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        the1Information: json["1. Information"],
        the2FromSymbol: json["2. From Symbol"],
        the3ToSymbol: json["3. To Symbol"],
        the4OutputSize: json["4. Output Size"],
        the5LastRefreshed: DateTime.parse(json["5. Last Refreshed"]),
        the6TimeZone: json["6. Time Zone"],
      );

  Map<String, dynamic> toJson() => {
        "1. Information": the1Information,
        "2. From Symbol": the2FromSymbol,
        "3. To Symbol": the3ToSymbol,
        "4. Output Size": the4OutputSize,
        "5. Last Refreshed": the5LastRefreshed.toIso8601String(),
        "6. Time Zone": the6TimeZone,
      };
}

class TimeSeriesFxDaily {
  String the1Open;
  String the2High;
  String the3Low;
  String the4Close;

  TimeSeriesFxDaily({
    required this.the1Open,
    required this.the2High,
    required this.the3Low,
    required this.the4Close,
  });

  factory TimeSeriesFxDaily.fromJson(Map<String, dynamic> json) =>
      TimeSeriesFxDaily(
        the1Open: json["1. open"],
        the2High: json["2. high"],
        the3Low: json["3. low"],
        the4Close: json["4. close"],
      );

  Map<String, dynamic> toJson() => {
        "1. open": the1Open,
        "2. high": the2High,
        "3. low": the3Low,
        "4. close": the4Close,
      };
}

class ProfileItem {
  int? id;
  String? name;
  List<Market>? markets;

  ProfileItem({
    this.id,
    this.name,
    this.markets,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'markets': json.encode(markets!.map((market) => market.toMap()).toList()),
    };
  }

  factory ProfileItem.fromMap(Map<String, dynamic> map) {
    return ProfileItem(
      id: map['id'],
      name: map['name'],
      markets: List<Market>.from(
          json.decode(map['markets']).map((x) => Market.fromMap(x))),
    );
  }

  ProfileItem copy({
    int? id,
    String? name,
    List<Market>? markets,
  }) =>
      ProfileItem(
        id: id ?? this.id,
        name: name ?? this.name,
        markets: markets ?? this.markets,
      );
}

class Market {
  int? id;
  String? marketName;

  Market({
    this.id,
    this.marketName,
  });
// Market
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'marketName': marketName,
    };
  }

  factory Market.fromMap(Map<String, dynamic> map) {
    return Market(
      id: map['id'],
      marketName: map['marketName'],
    );
  }

  Market copy({
    int? id,
    String? marketName,
  }) =>
      Market(
        id: id ?? this.id,
        marketName: marketName ?? this.marketName,
      );
}
