import "package:cloud_firestore/cloud_firestore.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "todo_model.freezed.dart";

@freezed
class TodoModel with _$TodoModel {
  const TodoModel._();

  factory TodoModel({
    required String text,
    required String uid,
    required bool isChecked,
    required Timestamp date,
    required Timestamp createdAt,
    required String? id,
  }) = _TodoModel;

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'uid': uid,
      'isChecked': isChecked,
      'date': date,
      'createdAt': createdAt,
    };
  }

  factory TodoModel.fromJson(QueryDocumentSnapshot<Object?> json) {
    return TodoModel(
      text: json['text'],
      uid: json['uid'],
      isChecked: json['isChecked'],
      date: json['date'],
      createdAt: json['createdAt'],
      id: json.id,
    );
  }
}
