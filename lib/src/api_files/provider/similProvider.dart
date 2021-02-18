// To parse this JSON data, do
//
//     final similModel = similModelFromJson(jsonString);

import 'dart:convert';

SimilModel similModelFromJson(String str) => SimilModel.fromJson(json.decode(str));

String similModelToJson(SimilModel data) => json.encode(data.toJson());

class SimilModel {
    SimilModel({
        this.similaires,
    });

    List<Similaire> similaires;

    factory SimilModel.fromJson(Map<String, dynamic> json) => SimilModel(
        similaires: List<Similaire>.from(json["similaires"].map((x) => Similaire.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "similaires": List<dynamic>.from(similaires.map((x) => x.toJson())),
    };
}

class Similaire {
    Similaire({
        this.id,
        this.titre,
        this.description,
        this.image,
    });

    int id;
    String titre;
    String description;
    String image;

    factory Similaire.fromJson(Map<String, dynamic> json) => Similaire(
        id: json["id"],
        titre: json["titre"],
        description: json["description"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titre": titre,
        "description": description,
        "image": image,
    };
}
