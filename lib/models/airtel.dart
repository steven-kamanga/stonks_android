// To parse this JSON data, do
//
//     final airtel = airtelFromJson(jsonString);

import 'dart:convert';

Airtel airtelFromJson(String str) => Airtel.fromJson(json.decode(str));

String airtelToJson(Airtel data) => json.encode(data.toJson());

class Airtel {
  String companyName;
  String website;
  String mdCeo;
  String dofCfo;
  CompanySecretary companySecretary;
  String transferSecretary;
  String transferSecretaryWebsite;
  String listingDate;
  String sharesInIssue;
  String listingPrice;
  Price price;
  String marketCapitalisation;

  Airtel({
    required this.companyName,
    required this.website,
    required this.mdCeo,
    required this.dofCfo,
    required this.companySecretary,
    required this.transferSecretary,
    required this.transferSecretaryWebsite,
    required this.listingDate,
    required this.sharesInIssue,
    required this.listingPrice,
    required this.price,
    required this.marketCapitalisation,
  });

  factory Airtel.fromJson(Map<String, dynamic> json) => Airtel(
        companyName: json["company_name"],
        website: json["website"],
        mdCeo: json["md_ceo"],
        dofCfo: json["dof_cfo"],
        companySecretary: CompanySecretary.fromJson(json["company_secretary"]),
        transferSecretary: json["transfer_secretary"],
        transferSecretaryWebsite: json["transfer_secretary_website"],
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
        "dof_cfo": dofCfo,
        "company_secretary": companySecretary.toJson(),
        "transfer_secretary": transferSecretary,
        "transfer_secretary_website": transferSecretaryWebsite,
        "listing_date": listingDate,
        "shares_in_issue": sharesInIssue,
        "listing_price": listingPrice,
        "price": price.toJson(),
        "market_capitalisation": marketCapitalisation,
      };
}

class CompanySecretary {
  String name;
  String email;

  CompanySecretary({
    required this.name,
    required this.email,
  });

  factory CompanySecretary.fromJson(Map<String, dynamic> json) =>
      CompanySecretary(
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
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
