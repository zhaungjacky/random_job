import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String senderEmail;
  final String reciverId;
  final String message;
  final Timestamp timestamp;
  final String? id;

  MessageModel({
    required this.senderId,
    required this.senderEmail,
    required this.reciverId,
    required this.message,
    required this.timestamp,
    required this.id,
  });

  factory MessageModel.fromJson(
    QueryDocumentSnapshot<Object?> json,
  ) {
    return MessageModel(
      senderId: json['senderId'],
      senderEmail: json['senderEmail'],
      reciverId: json['reciverId'],
      message: json['message'],
      timestamp: json['timestamp'],
      id: json.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'reciverId': reciverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
