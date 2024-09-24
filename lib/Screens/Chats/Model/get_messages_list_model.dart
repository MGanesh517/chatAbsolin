// To parse this JSON data, do
//
//     final getMessagesList = getMessagesListFromJson(jsonString);

import 'dart:convert';

GetMessagesList getMessagesListFromJson(String str) => GetMessagesList.fromJson(json.decode(str));

String getMessagesListToJson(GetMessagesList data) => json.encode(data.toJson());

class GetMessagesList {
  String? status;
  Data? data;

  GetMessagesList({
    this.status,
    this.data,
  });

  factory GetMessagesList.fromJson(Map<String, dynamic> json) => GetMessagesList(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  List<GetMessagesListData>? results;
  int? count;

  Data({
    this.results,
    this.count,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        results: json["results"] == null ? [] : List<GetMessagesListData>.from(json["results"]!.map((x) => GetMessagesListData.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "count": count,
      };
}

class GetMessagesListData {
  String? id;
  User? user;
  String? message;
  String? type;
  String? file;
  dynamic mimeType;
  DateTime? createdOn;

  GetMessagesListData({
    this.id,
    this.user,
    this.message,
    this.type,
    this.file,
    this.mimeType,
    this.createdOn,
  });

  factory GetMessagesListData.fromJson(Map<String, dynamic> json) => GetMessagesListData(
        id: json["_id"],
        user: json["user"] == null ? null : json["user"].runtimeType==String?User(id: json["user"],dUserId: json["user"]):User.fromJson(json["user"]),
        message: json["message"],
        type: json["type"],
        file: json["file"],
        mimeType: json["mime_type"],
        createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "message": message,
        "type": type,
        "file": file,
        "mime_type": mimeType,
        "created_on": createdOn?.toIso8601String(),
      };
}

class User {
  String? id;
  String? dUserId;
  String? name;

  User({
    this.id,
    this.dUserId,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        dUserId: json["d_user_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "d_user_id": dUserId,
        "name": name,
      };
}
