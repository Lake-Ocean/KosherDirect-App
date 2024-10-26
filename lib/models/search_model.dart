// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
    final Results? results;

    SearchModel({
        this.results,
    });

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        results: json["results"] == null ? null : Results.fromJson(json["results"]),
    );

    Map<String, dynamic> toJson() => {
        "results": results?.toJson(),
    };
}

class Results {
    final Paging? paging;
    final List<Product>? products;
    final List<dynamic>? brands;
    final List<dynamic>? categories;

    Results({
        this.paging,
        this.products,
        this.brands,
        this.categories,
    });

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        paging: json["paging"] == null ? null : Paging.fromJson(json["paging"]),
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        brands: json["brands"] == null ? [] : List<dynamic>.from(json["brands"]!.map((x) => x.toString())),
        categories: json["categories"] == null ? [] : List<dynamic>.from(json["categories"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "paging": paging?.toJson(),
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x)),
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    };
}

class Paging {
    final int? totalproducts;
    final int? firstproduct;
    final int? lastproduct;
    final int? perpage;
    final int? pagecount;
    final int? currentpage;

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

class Product {
    final String? brand;
    final String? category;
    final String? product;
    final String? packaging;
    final String? status;
    final String? passover;
    final String? yoshon;
    final String? cholovYisroel;
    final String? pasYisroel;
    final String? glatt;
    final String? fish;
    final String? kitnius;
    final String? restriction;
    final String? note;
    final String? industrial;
    final String? retail;
    final String? kid;

    Product({
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

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        "Brand": brand,
        "Category": category,
        "Product": product,
        "Packaging": packaging,
        "Status": status,
        "Passover": passover,
        "Yoshon": yoshon,
        "CholovYisroel": cholovYisroel,
        "PasYisroel": pasYisroel,
        "Glatt": glatt,
        "Fish": fish,
        "Kitnius": kitnius,
        "Restriction": restriction,
        "Note": note,
        "Industrial": industrial,
        "Retail": retail,
        "KID": kid,
    };
}






