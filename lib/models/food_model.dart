// To parse this JSON data, do
//
//     final foodModel = foodModelFromJson(jsonString);

import 'dart:convert';

FoodModel foodModelFromJson(String str) => FoodModel.fromJson(json.decode(str));

String foodModelToJson(FoodModel data) => json.encode(data.toJson());

class FoodModel {
  Results? results;

  FoodModel({
    this.results,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
    results: json["results"] == null ? null : Results.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "results": results?.toJson(),
  };
}

class Results {
  Paging? paging;
  List<FoodProduct>? products;
  List<String>? brands;
  List<String>? categories;

  Results({
    this.paging,
    this.products,
    this.brands,
    this.categories,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
    products: json["products"] == null ? [] : List<FoodProduct>.from(json["products"]!.map((x) => FoodProduct.fromJson(x))),
    brands: json["brands"] == null ? [] : List<String>.from(json["brands"]!.map((x) => x)),
    categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "paging": paging?.toJson(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x)),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
  };
}

class Paging {
  int? totalproducts;
  int? firstproduct;
  int? lastproduct;
  int? perpage;
  int? pagecount;
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

class FoodProduct {
  String? brand;
  String? category;
  String? product;
  String? packaging;
  String? status;
  String? passover;
  String? yoshon;
  String? cholovYisroel;
  String? pasYisroel;
  String? glatt;
  String? fish;
  String? kitnius;
  String? restriction;
  String? note;
  String? industrial;
  String? retail;
  String? kid;

  FoodProduct({
    this.brand,
    this.category,
    this.product,
    this.packaging,
    this.status,
    this.passover,
    this.yoshon,
    this.cholovYisroel,
    this.pasYisroel,
    this.glatt,
    this.fish,
    this.kitnius,
    this.restriction,
    this.note,
    this.industrial,
    this.retail,
    this.kid,
  });

  factory FoodProduct.fromJson(Map<String, dynamic> json) => FoodProduct(
    brand: json["Brand"],
    category: json["Category"],
    product: json["Product"],
    packaging: json["Packaging"],
    status: json["Status"],
    passover: json["Passover"],
    yoshon: json["Yoshon"],
    cholovYisroel: json["CholovYisroel"],
    pasYisroel: json["PasYisroel"],
    glatt: json["Glatt"],
    fish: json["Fish"],
    kitnius: json["Kitnius"],
    restriction: json["Restriction"],
    note: json["Note"],
    industrial: json["Industrial"],
    retail: json["Retail"],
    kid: json["KID"],
  );

  Map<String, dynamic> toJson() => {
    "Brand": brand??"",
    "Category": category??"",
    "Product": product??"",
    "Packaging": packaging??"",
    "Status": status??"",
    "Passover": passover??"",
    "Yoshon": yoshon??"",
    "CholovYisroel": cholovYisroel??"",
    "PasYisroel": pasYisroel??"",
    "Glatt": glatt??"",
    "Fish": fish??"",
    "Kitnius": kitnius??"",
    "Restriction": restriction??"",
    "Note": note??"",
    "Industrial": industrial??"",
    "Retail": retail??"",
    "KID": kid??"",
  };
}
