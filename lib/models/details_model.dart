// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'dart:convert';

DetailsModel detailsModelFromJson(String str) =>
    DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
  Results? results;

  DetailsModel({
    this.results,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        results:
            json["results"] == null ? null : Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "results": results?.toJson(),
      };
}

class Results {
  Paging? paging;
  List<Restaurant>? restaurants;

  Results({
    this.paging,
    this.restaurants,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
        restaurants: json["restaurants"] == null
            ? []
            : List<Restaurant>.from(
                json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "paging": paging?.toJson(),
        "restaurants": restaurants == null
            ? []
            : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}

class Paging {
  int? totalproducts;
  dynamic firstproduct;
  dynamic lastproduct;
  dynamic perpage;
  dynamic pagecount;
  int? currentpage;

  Paging({
    this.totalproducts,
    this.firstproduct,
    this.lastproduct,
    this.perpage,
    this.pagecount,
    this.currentpage,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        totalproducts: json["totalproducts"],
        firstproduct: json["firstproduct"],
        lastproduct: json["lastproduct"],
        perpage: json["perpage"],
        pagecount: json["pagecount"],
        currentpage: json["currentpage"],
      );

  Map<String, dynamic> toJson() => {
        "totalproducts": totalproducts,
        "firstproduct": firstproduct,
        "lastproduct": lastproduct,
        "perpage": perpage,
        "pagecount": pagecount,
        "currentpage": currentpage,
      };
}

class Restaurant {
  int? facilityId;
  String? name;
  String? address;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  dynamic latitude;
  dynamic longitude;
  String? type;
  String? phone;
  String? issuedDate;
  String? certification;
  String? certificateUrl;
  double? distance;

  Restaurant(
      {this.facilityId,
      this.name,
      this.address,
      this.city,
      this.state,
      this.postalCode,
      this.country,
      this.latitude,
      this.longitude,
      this.type,
      this.phone,
      this.issuedDate,
      this.certification,
      this.certificateUrl,
      this.distance});

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        facilityId: json["FacilityID"],
        name: json["Name"],
        address: json["Address"],
        city: json["City"],
        state: json["State"],
        postalCode: json["PostalCode"],
        country: json["Country"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        type: json["Type"],
        phone: json["Phone"],
        issuedDate: json["IssuedDate"],
        certification: json["Certification"],
        certificateUrl: json["CertificateUrl"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "FacilityID": facilityId,
        "Name": name,
        "Address": address,
        "City": city,
        "State": state,
        "PostalCode": postalCode,
        "Country": country,
        "Latitude": latitude.toString(),
        "Longitude": longitude.toString(),
        "Type": type,
        "Phone": phone,
        "IssuedDate": issuedDate,
        "Certification": certification,
        "CertificateUrl": certificateUrl,
        "distance": distance
      };
}
