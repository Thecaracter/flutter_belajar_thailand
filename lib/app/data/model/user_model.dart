// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class UserModel {
  final RxInt id;
  final RxString name;
  final RxString email;
  final RxString? noHp;
  final RxString? avatarBase64;
  final RxString? fcmToken;
  final RxString? emailVerifiedAt;
  final RxString createdAt;
  final RxString updatedAt;

  UserModel({
    required int id,
    required String name,
    required String email,
    String? noHp,
    String? avatarBase64,
    String? fcmToken,
    String? emailVerifiedAt,
    required String createdAt,
    required String updatedAt,
  })  : id = id.obs,
        name = name.obs,
        email = email.obs,
        noHp = (noHp ?? '').obs,
        avatarBase64 = avatarBase64?.obs,
        fcmToken = (fcmToken ?? '').obs,
        emailVerifiedAt = (emailVerifiedAt ?? '').obs,
        createdAt = createdAt.obs,
        updatedAt = updatedAt.obs;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      noHp: json['no_hp'],
      avatarBase64: json['avatar'],
      fcmToken: json['fcm_token'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.value,
      'name': name.value,
      'email': email.value,
      'no_hp': noHp?.value,
      'avatar': avatarBase64?.value,
      'fcm_token': fcmToken?.value,
      'email_verified_at': emailVerifiedAt?.value,
      'created_at': createdAt.value,
      'updated_at': updatedAt.value,
    };
  }

  ImageProvider? get avatarImage {
    if (avatarBase64?.value != null && avatarBase64!.value.isNotEmpty) {
      try {
        return MemoryImage(base64Decode(avatarBase64!.value));
      } catch (e) {
        print('Error decoding avatar: $e');
        return null;
      }
    }
    return null;
  }
}
