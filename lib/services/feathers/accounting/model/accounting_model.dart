import "package:cloud_firestore/cloud_firestore.dart";
import "package:freezed_annotation/freezed_annotation.dart";
part 'accounting_model.freezed.dart';

@freezed
class AccountingModel with _$AccountingModel {
  const AccountingModel._();

  factory AccountingModel({
    required String? category,
    required String? type,
    // required AccountingCategoryType? category,
    // required AccountingInOrOutType? type,
    required double? amount,
    required String? context,
    required Timestamp? date,
    required Timestamp? createdAt,
    required String? userId,
    required String? id,
  }) = _AccountingModel;

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'type': type,
      'amount': amount,
      'context': context,
      'date': date,
      'createdAt': createdAt,
      'userId': userId,
    };
  }

  factory AccountingModel.fromJson(QueryDocumentSnapshot<Object?> json) {
    return AccountingModel(
      category: json['category'],
      type: json['type'],
      amount: json['amount'],
      context: json['context'],
      date: json['date'],
      createdAt: json['createdAt'],
      userId: json['userId'],
      id: json.id,
    );
  }
}
