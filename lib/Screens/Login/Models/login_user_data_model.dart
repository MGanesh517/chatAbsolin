// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    int? status;
    Tokens? tokens;
    User? user;

    LoginModel({
        this.status,
        this.tokens,
        this.user,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "tokens": tokens?.toJson(),
        "user": user?.toJson(),
    };
}

class Tokens {
    String? access;
    String? refresh;

    Tokens({
        this.access,
        this.refresh,
    });

    factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        access: json["access"],
        refresh: json["refresh"],
    );

    Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
    };
}

class User {
    String? id;
    String? name;
    bool? showInChatlist;
    bool? isActive;
    String? username;
    String? email;
    bool? isStaff;
    bool? isGuest;
    String? firstname;
    String? lastname;
    int? phone;
    dynamic alternatePhone;
    String? latitude;
    String? longitude;
    bool? isEmailVerified;
    bool? isPhoneVerified;
    int? v;

    User({
        this.id,
        this.name,
        this.showInChatlist,
        this.isActive,
        this.username,
        this.email,
        this.isStaff,
        this.isGuest,
        this.firstname,
        this.lastname,
        this.phone,
        this.alternatePhone,
        this.latitude,
        this.longitude,
        this.isEmailVerified,
        this.isPhoneVerified,
        this.v,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        showInChatlist: json["show_in_chatlist"],
        isActive: json["is_active"],
        username: json["username"],
        email: json["email"],
        isStaff: json["is_staff"],
        isGuest: json["is_guest"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        alternatePhone: json["alternate_phone"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isEmailVerified: json["is_email_verified"],
        isPhoneVerified: json["is_phone_verified"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "show_in_chatlist": showInChatlist,
        "is_active": isActive,
        "username": username,
        "email": email,
        "is_staff": isStaff,
        "is_guest": isGuest,
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "alternate_phone": alternatePhone,
        "latitude": latitude,
        "longitude": longitude,
        "is_email_verified": isEmailVerified,
        "is_phone_verified": isPhoneVerified,
        "__v": v,
    };
}
