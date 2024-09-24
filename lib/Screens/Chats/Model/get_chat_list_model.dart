// To parse this JSON data, do
//
//     final getChatData = getChatDataFromJson(jsonString);

import 'dart:convert';

GetChatData getChatDataFromJson(String str) => GetChatData.fromJson(json.decode(str));

String getChatDataToJson(GetChatData data) => json.encode(data.toJson());

class GetChatData {
  String? status;
  Data? data;

  GetChatData({
    this.status,
    this.data,
  });

  factory GetChatData.fromJson(Map<String, dynamic> json) => GetChatData(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data==null?null:data!.toJson(),
      };
}

class Data {
  Chat? chat;
  int? messageCount;
  bool? muteStatus;
  int? unreadCount;

  Data({
    this.chat,
    this.messageCount,
    this.muteStatus,
    this.unreadCount
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
        messageCount: json["messageCount"],
        muteStatus: json["mute_status"],
        unreadCount: json["unread_count"],
      );

  Map<String, dynamic> toJson() => {"chat": chat?.toJson(), "messageCount": messageCount, "mute_status": muteStatus};
}

class Chat {
  String? id;
  String? type;
  bool? onlyAdmin;
  bool? isActive;
  bool? isBlocked;
  dynamic blockedBy;
  String? approver;
  UserDetails? createdBy;
  String? modifiedBy;
  DateTime? blockedOn;
  DateTime? createdOn;
  DateTime? modifiedOn;
  int? v;
  UserDetails? otherUser;
  GroupDetails? groupDetails;

  Chat({
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
    this.groupDetails,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        type: json["type"],
        onlyAdmin: json["only_admin"],
        isActive: json["is_active"],
        isBlocked: json["is_blocked"],
        blockedBy: json["blocked_by"],
        approver: json["approver"],
        createdBy: json["created_by"] == null ? null : UserDetails.fromJson(json["created_by"]),
        modifiedBy: json["modified_by"],
        blockedOn: json["blocked_on"] == null ? null : DateTime.parse(json["blocked_on"]),
        createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
        modifiedOn: json["modified_on"] == null ? null : DateTime.parse(json["modified_on"]),
        v: json["__v"],
        otherUser: json["other_user"] == null ? null : UserDetails.fromJson(json["other_user"]),
        groupDetails: json["group_details"] == null ? null : GroupDetails.fromJson(json["group_details"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "only_admin": onlyAdmin,
        "is_active": isActive,
        "is_blocked": isBlocked,
        "blocked_by": blockedBy,
        "approver": approver,
        "created_by": createdBy?.toJson(),
        "modified_by": modifiedBy,
        "blocked_on": blockedOn?.toIso8601String(),
        "created_on": createdOn?.toIso8601String(),
        "modified_on": modifiedOn?.toIso8601String(),
        "__v": v,
        "other_user": otherUser?.toJson(),
        "group_details": groupDetails?.toJson(),
      };
}

class UserDetails {
  String? id;
  String? dUserId;
  String? username;
  String? name;
  String? picture;
  bool? isActive;
  int? v;

  UserDetails({
    this.id,
    this.dUserId,
    this.username,
    this.name,
    this.picture,
    this.isActive,
    this.v,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
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
