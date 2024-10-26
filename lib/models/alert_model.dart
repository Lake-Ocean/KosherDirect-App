// To parse this JSON data, do
//
//     final alertModel = alertModelFromJson(jsonString);

class AlertModel {
  final int? id;
  bool? detailsOpen;
  final DateTime? date;
  final DateTime? dateGmt;
  final Guid? guid;
  final DateTime? modified;
  final DateTime? modifiedGmt;
  final String? slug;
  final String? status;
  final String? type;
  final String? link;
  final Guid? title;
  final Content? content;
  final Content? excerpt;
  final int? author;
  final int? featuredMedia;
  final String? template;
  final List<dynamic>? acf;
  final String? yoastHead;
  final YoastHeadJson? yoastHeadJson;
  final Links? links;

  AlertModel(
      {this.id,
      this.date,
      this.dateGmt,
      this.guid,
      this.modified,
      this.modifiedGmt,
      this.slug,
      this.status,
      this.type,
      this.link,
      this.title,
      this.content,
      this.excerpt,
      this.author,
      this.featuredMedia,
      this.template,
      this.acf,
      this.yoastHead,
      this.yoastHeadJson,
      this.links,
      this.detailsOpen = false});

  factory AlertModel.fromJson(Map<String, dynamic> json) => AlertModel(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        dateGmt:
            json["date_gmt"] == null ? null : DateTime.parse(json["date_gmt"]),
        guid: json["guid"] == null ? null : Guid.fromJson(json["guid"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedGmt: json["modified_gmt"] == null
            ? null
            : DateTime.parse(json["modified_gmt"]),
        slug: json["slug"],
        status: json["status"],
        type: json["type"],
        link: json["link"],
        title: json["title"] == null ? null : Guid.fromJson(json["title"]),
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
        excerpt:
            json["excerpt"] == null ? null : Content.fromJson(json["excerpt"]),
        author: json["author"],
        featuredMedia: json["featured_media"],
        template: json["template"],
        acf: json["acf"] == null
            ? []
            : List<dynamic>.from(json["acf"]!.map((x) => x)),
        yoastHead: json["yoast_head"],
        yoastHeadJson: json["yoast_head_json"] == null
            ? null
            : YoastHeadJson.fromJson(json["yoast_head_json"]),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date?.toIso8601String(),
        "date_gmt": dateGmt?.toIso8601String(),
        "guid": guid?.toJson(),
        "modified": modified?.toIso8601String(),
        "modified_gmt": modifiedGmt?.toIso8601String(),
        "slug": slug,
        "status": status,
        "type": type,
        "link": link,
        "title": title?.toJson(),
        "content": content?.toJson(),
        "excerpt": excerpt?.toJson(),
        "author": author,
        "featured_media": featuredMedia,
        "template": template,
        "acf": acf == null ? [] : List<dynamic>.from(acf!.map((x) => x)),
        "yoast_head": yoastHead,
        "yoast_head_json": yoastHeadJson?.toJson(),
        "_links": links?.toJson(),
      };
}

class Content {
  final String? rendered;
  final bool? protected;

  Content({
    this.rendered,
    this.protected,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
      };
}

class Guid {
  final String? rendered;

  Guid({
    this.rendered,
  });

  factory Guid.fromJson(Map<String, dynamic> json) => Guid(
        rendered: json["rendered"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
      };
}

class Links {
  final List<About>? self;
  final List<About>? collection;
  final List<About>? about;
  final List<Author>? author;
  final List<About>? wpAttachment;
  final List<Cury>? curies;

  Links({
    this.self,
    this.collection,
    this.about,
    this.author,
    this.wpAttachment,
    this.curies,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null
            ? []
            : List<About>.from(json["self"]!.map((x) => About.fromJson(x))),
        collection: json["collection"] == null
            ? []
            : List<About>.from(
                json["collection"]!.map((x) => About.fromJson(x))),
        about: json["about"] == null
            ? []
            : List<About>.from(json["about"]!.map((x) => About.fromJson(x))),
        author: json["author"] == null
            ? []
            : List<Author>.from(json["author"]!.map((x) => Author.fromJson(x))),
        wpAttachment: json["wp:attachment"] == null
            ? []
            : List<About>.from(
                json["wp:attachment"]!.map((x) => About.fromJson(x))),
        curies: json["curies"] == null
            ? []
            : List<Cury>.from(json["curies"]!.map((x) => Cury.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self == null
            ? []
            : List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": collection == null
            ? []
            : List<dynamic>.from(collection!.map((x) => x.toJson())),
        "about": about == null
            ? []
            : List<dynamic>.from(about!.map((x) => x.toJson())),
        "author": author == null
            ? []
            : List<dynamic>.from(author!.map((x) => x.toJson())),
        "wp:attachment": wpAttachment == null
            ? []
            : List<dynamic>.from(wpAttachment!.map((x) => x.toJson())),
        "curies": curies == null
            ? []
            : List<dynamic>.from(curies!.map((x) => x.toJson())),
      };
}

class About {
  final String? href;

  About({
    this.href,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Author {
  final bool? embeddable;
  final String? href;

  Author({
    this.embeddable,
    this.href,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        embeddable: json["embeddable"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "embeddable": embeddable,
        "href": href,
      };
}

class Cury {
  final String? name;
  final String? href;
  final bool? templated;

  Cury({
    this.name,
    this.href,
    this.templated,
  });

  factory Cury.fromJson(Map<String, dynamic> json) => Cury(
        name: json["name"],
        href: json["href"],
        templated: json["templated"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "href": href,
        "templated": templated,
      };
}

class YoastHeadJson {
  final String? title;
  final Robots? robots;
  final String? ogLocale;
  final String? ogType;
  final String? ogTitle;
  final String? ogDescription;
  final String? ogUrl;
  final String? ogSiteName;
  final DateTime? articleModifiedTime;
  final String? twitterCard;
  final Schema? schema;
  final TwitterMisc? twitterMisc;

  YoastHeadJson({
    this.title,
    this.robots,
    this.ogLocale,
    this.ogType,
    this.ogTitle,
    this.ogDescription,
    this.ogUrl,
    this.ogSiteName,
    this.articleModifiedTime,
    this.twitterCard,
    this.schema,
    this.twitterMisc,
  });

  factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
      title: json["title"],
      robots: json["robots"] == null ? null : Robots.fromJson(json["robots"]),
      ogLocale: json["og_locale"],
      ogType: json["og_type"],
      ogTitle: json["og_title"],
      ogDescription: json["og_description"],
      ogUrl: json["og_url"],
      ogSiteName: json["og_site_name"],
      articleModifiedTime: json["article_modified_time"] == null
          ? null
          : DateTime.parse(json["article_modified_time"]),
      twitterCard: json["twitter_card"],
      schema: json["schema"] == null ? null : Schema.fromJson(json["schema"]),
      twitterMisc: json["twitter_misc"] == null ? null : TwitterMisc.fromJson(json["twitter_misc"]),);

  Map<String, dynamic> toJson() => {
        "title": title,
        "robots": robots?.toJson(),
        "og_locale": ogLocale,
        "og_type": ogType,
        "og_title": ogTitle,
        "og_description": ogDescription,
        "og_url": ogUrl,
        "og_site_name": ogSiteName,
        "article_modified_time": articleModifiedTime?.toIso8601String(),
        "twitter_card": twitterCard,
        "schema": schema?.toJson(),
        "twitter_misc": twitterMisc?.toJson(),
      };
}

class Robots {
  final String? index;
  final String? follow;

  Robots({
    this.index,
    this.follow,
  });

  factory Robots.fromJson(Map<String, dynamic> json) => Robots(
        index: json["index"],
        follow: json["follow"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "follow": follow,
      };
}

class Schema {
  final String? context;
  final List<Graph>? graph;

  Schema({
    this.context,
    this.graph,
  });

  factory Schema.fromJson(Map<String, dynamic> json) => Schema(
        context: json["@context"],
        graph: json["@graph"] == null
            ? []
            : List<Graph>.from(json["@graph"]!.map((x) => Graph.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@graph": graph == null
            ? []
            : List<dynamic>.from(graph!.map((x) => x.toJson())),
      };
}

class Graph {
  final String? type;
  final String? id;
  final String? url;
  final String? name;
  final Breadcrumb? isPartOf;
  final DateTime? datePublished;
  final DateTime? dateModified;
  final Breadcrumb? breadcrumb;
  final String? inLanguage;
  final List<PotentialAction>? potentialAction;
  final List<ItemListElement>? itemListElement;
  final String? description;

  Graph({
    this.type,
    this.id,
    this.url,
    this.name,
    this.isPartOf,
    this.datePublished,
    this.dateModified,
    this.breadcrumb,
    this.inLanguage,
    this.potentialAction,
    this.itemListElement,
    this.description,
  });

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
        type: json["@type"],
        id: json["@id"],
        url: json["url"],
        name: json["name"],
        isPartOf: json["isPartOf"] == null
            ? null
            : Breadcrumb.fromJson(json["isPartOf"]),
        datePublished: json["datePublished"] == null
            ? null
            : DateTime.parse(json["datePublished"]),
        dateModified: json["dateModified"] == null
            ? null
            : DateTime.parse(json["dateModified"]),
        breadcrumb: json["breadcrumb"] == null
            ? null
            : Breadcrumb.fromJson(json["breadcrumb"]),
        inLanguage: json["inLanguage"],
        potentialAction: json["potentialAction"] == null
            ? []
            : List<PotentialAction>.from(json["potentialAction"]!
                .map((x) => PotentialAction.fromJson(x))),
        itemListElement: json["itemListElement"] == null
            ? []
            : List<ItemListElement>.from(json["itemListElement"]!
                .map((x) => ItemListElement.fromJson(x))),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "@type": type,
        "@id": id,
        "url": url,
        "name": name,
        "isPartOf": isPartOf?.toJson(),
        "datePublished": datePublished?.toIso8601String(),
        "dateModified": dateModified?.toIso8601String(),
        "breadcrumb": breadcrumb?.toJson(),
        "inLanguage": inLanguage,
        "potentialAction": potentialAction == null
            ? []
            : List<dynamic>.from(potentialAction!.map((x) => x.toJson())),
        "itemListElement": itemListElement == null
            ? []
            : List<dynamic>.from(itemListElement!.map((x) => x.toJson())),
        "description": description,
      };
}

class Breadcrumb {
  final String? id;

  Breadcrumb({
    this.id,
  });

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
        id: json["@id"],
      );

  Map<String, dynamic> toJson() => {
        "@id": id,
      };
}

class ItemListElement {
  final String? type;
  final int? position;
  final String? name;
  final String? item;

  ItemListElement({
    this.type,
    this.position,
    this.name,
    this.item,
  });

  factory ItemListElement.fromJson(Map<String, dynamic> json) =>
      ItemListElement(
        type: json["@type"],
        position: json["position"],
        name: json["name"],
        item: json["item"],
      );

  Map<String, dynamic> toJson() => {
        "@type": type,
        "position": position,
        "name": name,
        "item": item,
      };
}

class PotentialAction {
  final String? type;
  final dynamic target;
  final String? queryInput;

  PotentialAction({
    this.type,
    this.target,
    this.queryInput,
  });

  factory PotentialAction.fromJson(Map<String, dynamic> json) =>
      PotentialAction(
        type: json["type"],
        target: json["target"],
        queryInput: json["query-input"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "target": target,
        "query-input": queryInput,
      };
}

class TargetClass {
  final String? type;
  final String? urlTemplate;

  TargetClass({
    this.type,
    this.urlTemplate,
  });

  factory TargetClass.fromJson(Map<String, dynamic> json) => TargetClass(
        type: json["@type"],
        urlTemplate: json["urlTemplate"],
      );

  Map<String, dynamic> toJson() => {
        "@type": type,
        "urlTemplate": urlTemplate,
      };
}
class TwitterMisc {
    final String? estReadingTime;

    TwitterMisc({
        this.estReadingTime,
    });

    factory TwitterMisc.fromJson(Map<String, dynamic> json) => TwitterMisc(
        estReadingTime: json["Est. reading time"],
    );

    Map<String, dynamic> toJson() => {
        "Est. reading time": estReadingTime,
    };
}