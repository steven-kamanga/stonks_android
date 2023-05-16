// To parse this JSON data, do
//
//     final mpiko = mpikoFromJson(jsonString);

import 'dart:convert';

Mpiko mpikoFromJson(String str) => Mpiko.fromJson(json.decode(str));

String mpikoToJson(Mpiko data) => json.encode(data.toJson());

class Mpiko {
  String companyName;
  String website;
  String mdCeo;
  CompanySecretary companySecretary;
  String transferSecretary;
  String listingDate;
  String sharesInIssue;
  String listingPrice;
  Price price;
  String marketCapitalisation;

  Mpiko({
    required this.companyName,
    required this.website,
    required this.mdCeo,
    required this.companySecretary,
    required this.transferSecretary,
    required this.listingDate,
    required this.sharesInIssue,
    required this.listingPrice,
    required this.price,
    required this.marketCapitalisation,
  });

  factory Mpiko.fromJson(Map<String, dynamic> json) => Mpiko(
        companyName: json["company_name"],
        website: json["website"],
        mdCeo: json["md_ceo"],
        companySecretary: CompanySecretary.fromJson(json["company_secretary"]),
        transferSecretary: json["transfer_secretary"],
        listingDate: json["listing_date"],
        sharesInIssue: json["shares_in_issue"],
        listingPrice: json["listing_price"],
        price: Price.fromJson(json["price"]),
        marketCapitalisation: json["market_capitalisation"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "website": website,
        "md_ceo": mdCeo,
        "company_secretary": companySecretary.toJson(),
        "transfer_secretary": transferSecretary,
        "listing_date": listingDate,
        "shares_in_issue": sharesInIssue,
        "listing_price": listingPrice,
        "price": price.toJson(),
        "market_capitalisation": marketCapitalisation,
      };
}

class CompanySecretary {
  String name;

  CompanySecretary({
    required this.name,
  });

  factory CompanySecretary.fromJson(Map<String, dynamic> json) =>
      CompanySecretary(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Price {
  String value;
  String dateTime;

  Price({
    required this.value,
    required this.dateTime,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        value: json["value"],
        dateTime: json["date_time"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "date_time": dateTime,
      };
}
