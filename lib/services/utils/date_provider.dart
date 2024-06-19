import 'package:cloud_firestore/cloud_firestore.dart';

class DateProvider {
  static Timestamp staticAccountingStartAt() => Timestamp.fromDate(
        DateTime.now().subtract(
          const Duration(days: 90),
        ),
      );
  static Timestamp staticAccountingEndAt() => Timestamp.fromDate(
        DateTime.now().add(
          const Duration(days: 10),
        ),
      );
  static Timestamp staticTodoStartAt() => Timestamp.fromDate(
        DateTime.now().subtract(
          const Duration(days: 30),
        ),
      );
  static Timestamp staticTodoEndAt() => Timestamp.fromDate(
        DateTime.now().add(
          const Duration(days: 70),
        ),
      );
  static Timestamp staticChatStartAt() => Timestamp.fromDate(
        DateTime.now().subtract(
          const Duration(days: 16),
        ),
      );
  static Timestamp staticChatEndAt() => Timestamp.fromDate(
        DateTime.now().add(
          const Duration(days: 16),
        ),
      );
  static DateTime dateStartDistant() => DateTime.parse("2008-07-07");
  static DateTime dateEndDistant() => DateTime.parse("2099-12-31");
  static DateTime dateStart() => DateTime.now().subtract(
        const Duration(days: 90),
      );
  static DateTime dateEnd() => DateTime.now().add(
        const Duration(days: 1),
      );
}
