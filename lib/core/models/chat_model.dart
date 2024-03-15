// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:loveguru_ai/core/models/timestamp_model.dart';

enum ChatOwner { ai, user }

class ChatModel {
  final String id;
  final TimestampModel timestamp;
  final ChatOwner owner;
  final String message;
  ChatModel({
    required this.id,
    required this.timestamp,
    required this.owner,
    required this.message,
  });

  ChatModel copyWith({
    TimestampModel? timestamp,
    ChatOwner? owner,
    String? message,
    String? id,
  }) {
    return ChatModel(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      owner: owner ?? this.owner,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timestamp': timestamp.toMap(),
      'owner': owner.name.toString(),
      'message': message,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      timestamp: TimestampModel.fromMap(map['timestamp'] as Map<String, dynamic>),
      owner: ChatOwner.values.firstWhere((val) => val.name.toString() == map['owner']),
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChatModel(timestamp: $timestamp, owner: $owner, message: $message)';

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.timestamp == timestamp && other.owner == owner && other.message == message;
  }

  @override
  int get hashCode => timestamp.hashCode ^ owner.hashCode ^ message.hashCode;
}
