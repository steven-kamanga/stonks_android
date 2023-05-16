// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  Meta meta;
  List<Datum> data;

  News({
    required this.meta,
    required this.data,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        meta: Meta.fromJson(json["meta"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String uuid;
  String title;
  String description;
  String keywords;
  String snippet;
  String url;
  String imageUrl;
  String language;
  DateTime publishedAt;
  String source;
  dynamic relevanceScore;
  List<Entity> entities;
  List<Datum>? similar;

  Datum({
    required this.uuid,
    required this.title,
    required this.description,
    required this.keywords,
    required this.snippet,
    required this.url,
    required this.imageUrl,
    required this.language,
    required this.publishedAt,
    required this.source,
    this.relevanceScore,
    required this.entities,
    this.similar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uuid: json["uuid"],
        title: json["title"],
        description: json["description"],
        keywords: json["keywords"],
        snippet: json["snippet"],
        url: json["url"],
        imageUrl: json["image_url"],
        language: json["language"],
        publishedAt: DateTime.parse(json["published_at"]),
        source: json["source"],
        relevanceScore: json["relevance_score"],
        entities:
            List<Entity>.from(json["entities"].map((x) => Entity.fromJson(x))),
        similar: json["similar"] == null
            ? []
            : List<Datum>.from(json["similar"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "title": title,
        "description": description,
        "keywords": keywords,
        "snippet": snippet,
        "url": url,
        "image_url": imageUrl,
        "language": language,
        "published_at": publishedAt.toIso8601String(),
        "source": source,
        "relevance_score": relevanceScore,
        "entities": List<dynamic>.from(entities.map((x) => x.toJson())),
        "similar": similar == null
            ? []
            : List<dynamic>.from(similar!.map((x) => x.toJson())),
      };
}

class Entity {
  String symbol;
  String name;
  String exchange;
  String exchangeLong;
  String country;
  Type type;
  Industry industry;
  double matchScore;
  double sentimentScore;
  List<Highlight> highlights;

  Entity({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.exchangeLong,
    required this.country,
    required this.type,
    required this.industry,
    required this.matchScore,
    required this.sentimentScore,
    required this.highlights,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        symbol: json["symbol"],
        name: json["name"],
        exchange: json["exchange"],
        exchangeLong: json["exchange_long"],
        country: json["country"],
        type: typeValues.map[json["type"]]!,
        industry: industryValues.map[json["industry"]]!,
        matchScore: json["match_score"]?.toDouble(),
        sentimentScore: json["sentiment_score"]?.toDouble(),
        highlights: List<Highlight>.from(
            json["highlights"].map((x) => Highlight.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "name": name,
        "exchange": exchange,
        "exchange_long": exchangeLong,
        "country": country,
        "type": typeValues.reverse[type],
        "industry": industryValues.reverse[industry],
        "match_score": matchScore,
        "sentiment_score": sentimentScore,
        "highlights": List<dynamic>.from(highlights.map((x) => x.toJson())),
      };
}

class Highlight {
  String highlight;
  double sentiment;
  HighlightedIn highlightedIn;

  Highlight({
    required this.highlight,
    required this.sentiment,
    required this.highlightedIn,
  });

  factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
        highlight: json["highlight"],
        sentiment: json["sentiment"]?.toDouble(),
        highlightedIn: highlightedInValues.map[json["highlighted_in"]]!,
      );

  Map<String, dynamic> toJson() => {
        "highlight": highlight,
        "sentiment": sentiment,
        "highlighted_in": highlightedInValues.reverse[highlightedIn],
      };
}

enum HighlightedIn { MAIN_TEXT, TITLE }

final highlightedInValues = EnumValues(
    {"main_text": HighlightedIn.MAIN_TEXT, "title": HighlightedIn.TITLE});

enum Industry { CONSUMER_CYCLICAL, FINANCIAL_SERVICES, N_A }

final industryValues = EnumValues({
  "Consumer Cyclical": Industry.CONSUMER_CYCLICAL,
  "Financial Services": Industry.FINANCIAL_SERVICES,
  "N/A": Industry.N_A
});

enum Type { EQUITY }

final typeValues = EnumValues({"equity": Type.EQUITY});

class Meta {
  int found;
  int returned;
  int limit;
  int page;

  Meta({
    required this.found,
    required this.returned,
    required this.limit,
    required this.page,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        found: json["found"],
        returned: json["returned"],
        limit: json["limit"],
        page: json["page"],
      );

  Map<String, dynamic> toJson() => {
        "found": found,
        "returned": returned,
        "limit": limit,
        "page": page,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
