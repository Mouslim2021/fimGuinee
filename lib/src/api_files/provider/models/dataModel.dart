// To parse this JSON Model, do
//
//     final FimData = FimDataFromJson(jsonString);

import 'dart:convert';

FimModel fimModelFromJson(String str) => FimModel.fromJson(json.decode(str));

String fimModelToJson(FimModel data) => json.encode(data.toJson());

class FimModel {
    FimModel({
        this.sliders,
        this.recents,
        this.videos,
        this.populaires,
        this.others,
        this.teams,
    });

    List<Other> sliders;
    List<Other> recents;
    List<Video> videos;
    List<Other> populaires;
    List<Other> others;
    List<Team> teams;

    factory FimModel.fromJson(Map<String, dynamic> json) => FimModel(
        sliders: List<Other>.from(json["sliders"].map((x) => Other.fromJson(x))),
        recents: List<Other>.from(json["recents"].map((x) => Other.fromJson(x))),
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        populaires: List<Other>.from(json["populaires"].map((x) => Other.fromJson(x))),
        others: List<Other>.from(json["others"].map((x) => Other.fromJson(x))),
        teams: List<Team>.from(json["teams"].map((x) => Team.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
        "recents": List<dynamic>.from(recents.map((x) => x.toJson())),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "populaires": List<dynamic>.from(populaires.map((x) => x.toJson())),
        "others": List<dynamic>.from(others.map((x) => x.toJson())),
        "teams": List<dynamic>.from(teams.map((x) => x.toJson())),
    };
}

class Other {
    Other({
        this.id,
        this.titre,
        this.description,
        this.image,
        this.categorie,
    });

    int id;
    String titre;
    String description;
    String image;
    Map categorie;

    factory Other.fromJson(Map<String, dynamic> json) => Other(
        id: json["id"],
        titre: json["titre"],
        description: json["description"],
        image: json["image"],
        categorie: json["categorie"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titre": titre,
        "description": description,
        "image": image,
        "categorie": categorie,
    };
}


class Team {
    Team({
        this.name,
        this.fonction,
        this.image,
    });

    String name;
    String fonction;
    String image;

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        name: json["name"],
        fonction: json["fonction"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "fonction": fonction,
        "image": image,
    };
}

class Video {
    Video({
        this.id,
        this.titre,
        this.url,
        this.type,
    });

    int id;
    String titre;
    String url;
    String type;

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        titre: json["titre"],
        url: json["url"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titre": titre,
        "url": url,
        "type": type,
    };
}
