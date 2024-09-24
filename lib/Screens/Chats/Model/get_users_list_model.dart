// To parse this JSON data, do
//
//     final getUsersList = getUsersListFromJson(jsonString);

import 'dart:convert';

GetUsersList getUsersListFromJson(String str) => GetUsersList.fromJson(json.decode(str));

String getUsersListToJson(GetUsersList data) => json.encode(data.toJson());

class GetUsersList {
  String? status;
  Data? data;

  GetUsersList({
    this.status,
    this.data,
  });

  factory GetUsersList.fromJson(Map<String, dynamic> json) => GetUsersList(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  List<GetUsersListData>? users;
  int? count;

  Data({
    this.users,
    this.count,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        users: json["users"] == null ? [] : List<GetUsersListData>.from(json["users"]!.map((x) => GetUsersListData.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
        "count": count,
      };
}

class GetUsersListData {
  String? id;
  String? name;
  String? picture;

  GetUsersListData({
    this.id,
    this.name,
    this.picture,
  });

  factory GetUsersListData.fromJson(Map<String, dynamic> json) => GetUsersListData(
        id: json["_id"],
        name: json["name"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "picture": picture,
      };
}
