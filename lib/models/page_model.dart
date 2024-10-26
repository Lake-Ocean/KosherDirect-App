// To parse this JSON data, do
//
//     final pageModel = pageModelFromJson(jsonString);

import 'dart:convert';

PageModel pageModelFromJson(String str) => PageModel.fromJson(json.decode(str));

String pageModelToJson(PageModel data) => json.encode(data.toJson());

class PageModel {
    final int? id;
    final String? title;
    final Content? content;

    PageModel({
        this.id,
        this.title,
        this.content,
    });

    factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
        id: json["id"],
        title: json["title"],
        content: json["content"] == null ? null : Content.fromJson(json["content"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content?.toJson(),
    };
}

class Content {
    final String? rendered;

    Content({
        this.rendered,
    });

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
    };
}
