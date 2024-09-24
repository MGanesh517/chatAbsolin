// To parse this JSON data, do
//
//     final getUsersChatList = getUsersChatListFromJson(jsonString);

import 'dart:convert';

GetUsersChatList getUsersChatListFromJson(String str) => GetUsersChatList.fromJson(json.decode(str));

String getUsersChatListToJson(GetUsersChatList data) => json.encode(data.toJson());

class GetUsersChatList {
  String? status;
  Data? data;

  GetUsersChatList({
    this.status,
    this.data,
  });

  factory GetUsersChatList.fromJson(Map<String, dynamic> json) => GetUsersChatList(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  List<GetUsersChatListData>? results;
  int? count;

  Data({
    this.results,
    this.count,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        results: json["results"] == null ? [] : List<GetUsersChatListData>.from(json["results"]!.map((x) => GetUsersChatListData.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "count": count,
      };
}

class GetUsersChatListData {
  String? id;
  String? type;
  bool? onlyAdmin;
  bool? isActive;
  bool? isBlocked;
  dynamic blockedBy;
  String? approver;
  String? createdBy;
  String? modifiedBy;
  DateTime? blockedOn;
  DateTime? createdOn;
  DateTime? modifiedOn;
  int? v;
  OtherUser? otherUser;
  LastMessage? lastMessage;
  GroupDetails? groupDetails;
  int? unreadCount;

  GetUsersChatListData({
    this.id,
    this.type,
    this.onlyAdmin,
    this.isActive,
    this.isBlocked,
    this.blockedBy,
    this.approver,
    this.createdBy,
    this.modifiedBy,
    this.blockedOn,
    this.createdOn,
    this.modifiedOn,
    this.v,
    this.otherUser,
    this.lastMessage,
    this.groupDetails,
    this.unreadCount,
  });

  factory GetUsersChatListData.fromJson(Map<String, dynamic> json) => GetUsersChatListData(
        id: json["_id"],
        type: json["type"],
        onlyAdmin: json["only_admin"],
        isActive: json["is_active"],
        isBlocked: json["is_blocked"],
        blockedBy: json["blocked_by"],
        approver: json["approver"],
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        blockedOn: json["blocked_on"] == null ? null : DateTime.parse(json["blocked_on"]),
        createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
        modifiedOn: json["modified_on"] == null ? null : DateTime.parse(json["modified_on"]),
        v: json["__v"],
        otherUser: json["other_user"] == null ? null : OtherUser.fromJson(json["other_user"]),
        lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
        groupDetails: json["group_details"] == null ? null : GroupDetails.fromJson(json["group_details"]),
        unreadCount: json["unread_count"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "only_admin": onlyAdmin,
        "is_active": isActive,
        "is_blocked": isBlocked,
        "blocked_by": blockedBy,
        "approver": approver,
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "blocked_on": blockedOn?.toIso8601String(),
        "created_on": createdOn?.toIso8601String(),
        "modified_on": modifiedOn?.toIso8601String(),
        "__v": v,
        "other_user": otherUser?.toJson(),
        "last_message": lastMessage?.toJson(),
        "group_details": groupDetails?.toJson(),
        "unread_count": unreadCount,
      };
}

class GroupDetails {
  String? id;
  String? chat;
  String? event;
  String? name;
  List<String>? admins;
  String? createdBy;
  String? modifiedBy;
  DateTime? createdOn;
  DateTime? modifiedOn;
  int? v;

  GroupDetails({
    this.id,
    this.chat,
    this.event,
    this.name,
    this.admins,
    this.createdBy,
    this.modifiedBy,
    this.createdOn,
    this.modifiedOn,
    this.v,
  });

  factory GroupDetails.fromJson(Map<String, dynamic> json) => GroupDetails(
        id: json["_id"],
        chat: json["chat"],
        event: json["event"],
        name: json["name"],
        admins: json["admins"] == null ? [] : List<String>.from(json["admins"]!.map((x) => x)),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
        modifiedOn: json["modified_on"] == null ? null : DateTime.parse(json["modified_on"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chat": chat,
        "event": event,
        "name": name,
        "admins": admins == null ? [] : List<dynamic>.from(admins!.map((x) => x)),
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "created_on": createdOn?.toIso8601String(),
        "modified_on": modifiedOn?.toIso8601String(),
        "__v": v,
      };
}

class LastMessage {
  String? id;
  String? chat;
  String? user;
  String? message;
  String? type;
  String? mimeType;
  String? createdBy;
  DateTime? createdOn;
  int? v;
  String? file;

  LastMessage({
    this.id,
    this.chat,
    this.user,
    this.message,
    this.type,
    this.mimeType,
    this.createdBy,
    this.createdOn,
    this.v,
    this.file,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        id: json["_id"],
        chat: json["chat"],
        user: json["user"],
        message: json["message"],
        type: json["type"],
        mimeType: json["mime_type"],
        createdBy: json["created_by"],
        createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
        v: json["__v"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chat": chat,
        "user": user,
        "message": message,
        "type": type,
        "mime_type": mimeType,
        "created_by": createdBy,
        "created_on": createdOn?.toIso8601String(),
        "__v": v,
        "file": file,
      };
}

class OtherUser {
  String? id;
  String? dUserId;
  String? username;
  String? name;
  String? picture;
  bool? isActive;
  int? v;

  OtherUser({
    this.id,
    this.dUserId,
    this.username,
    this.name,
    this.picture,
    this.isActive,
    this.v,
  });

  factory OtherUser.fromJson(Map<String, dynamic> json) => OtherUser(
        id: json["_id"],
        dUserId: json["d_user_id"],
        username: json["username"],
        name: json["name"],
        picture: json["picture"],
        isActive: json["is_active"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "d_user_id": dUserId,
        "username": username,
        "name": name,
        "picture": picture,
        "is_active": isActive,
        "__v": v,
      };
}
