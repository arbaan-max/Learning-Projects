import 'dart:convert';

List<ApiModel> welcomeFromJson(String str) => List<ApiModel>.from(json.decode(str).map((x) => ApiModel.fromJson(x)));

String welcomeToJson(List<ApiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiModel {
    ApiModel({
        required this.userId,
        required this.id,
        required this.title,
        required this.body,
    });

    int userId;
    int id;
    String title;
    String body;

    factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
