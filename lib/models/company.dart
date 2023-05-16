import 'dart:convert';

class CompanyInfo {
  // Add all the fields from the JSON
  final String companyName;
  final String address;
  final String telephone;
  final String email;
  final String website;
  final String mdCeo;
  final String dofCfo;
  final String companySecretaryName;
  final String companySecretaryEmail;
  final String transferSecretary;
  final String listingDate;
  final String sharesInIssue;
  final String listingPrice;
  final String priceValue;
  final String priceDateTime;
  final String marketCapitalisation;

  // Constructor
  CompanyInfo({
    required this.companyName,
    required this.address,
    required this.telephone,
    required this.email,
    required this.website,
    required this.mdCeo,
    required this.dofCfo,
    required this.companySecretaryName,
    required this.companySecretaryEmail,
    required this.transferSecretary,
    required this.listingDate,
    required this.sharesInIssue,
    required this.listingPrice,
    required this.priceValue,
    required this.priceDateTime,
    required this.marketCapitalisation,
  });

  // Method to deserialize JSON
  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
      companyName: json['company_name'],
      address: json['address'],
      telephone: json['telephone'],
      email: json['email'],
      website: json['website'],
      mdCeo: json['md_ceo'],
      dofCfo: json['dof_cfo'],
      companySecretaryName: json['company_secretary']['name'],
      companySecretaryEmail: json['company_secretary']['email'],
      transferSecretary: json['transfer_secretary'],
      listingDate: json['listing_date'],
      sharesInIssue: json['shares_in_issue'],
      listingPrice: json['listing_price'],
      priceValue: json['price']['value'],
      priceDateTime: json['price']['date_time'],
      marketCapitalisation: json['market_capitalisation'],
    );
  }
}
