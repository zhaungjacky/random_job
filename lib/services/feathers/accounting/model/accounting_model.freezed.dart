// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accounting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountingModel {
  String? get category => throw _privateConstructorUsedError;
  String? get type =>
      throw _privateConstructorUsedError; // required AccountingCategoryType? category,
// required AccountingInOrOutType? type,
  double? get amount => throw _privateConstructorUsedError;
  String? get context => throw _privateConstructorUsedError;
  Timestamp? get date => throw _privateConstructorUsedError;
  Timestamp? get createdAt => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountingModelCopyWith<AccountingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountingModelCopyWith<$Res> {
  factory $AccountingModelCopyWith(
          AccountingModel value, $Res Function(AccountingModel) then) =
      _$AccountingModelCopyWithImpl<$Res, AccountingModel>;
  @useResult
  $Res call(
      {String? category,
      String? type,
      double? amount,
      String? context,
      Timestamp? date,
      Timestamp? createdAt,
      String? userId,
      String? id});
}

/// @nodoc
class _$AccountingModelCopyWithImpl<$Res, $Val extends AccountingModel>
    implements $AccountingModelCopyWith<$Res> {
  _$AccountingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? type = freezed,
    Object? amount = freezed,
    Object? context = freezed,
    Object? date = freezed,
    Object? createdAt = freezed,
    Object? userId = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountingModelImplCopyWith<$Res>
    implements $AccountingModelCopyWith<$Res> {
  factory _$$AccountingModelImplCopyWith(_$AccountingModelImpl value,
          $Res Function(_$AccountingModelImpl) then) =
      __$$AccountingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? category,
      String? type,
      double? amount,
      String? context,
      Timestamp? date,
      Timestamp? createdAt,
      String? userId,
      String? id});
}

/// @nodoc
class __$$AccountingModelImplCopyWithImpl<$Res>
    extends _$AccountingModelCopyWithImpl<$Res, _$AccountingModelImpl>
    implements _$$AccountingModelImplCopyWith<$Res> {
  __$$AccountingModelImplCopyWithImpl(
      _$AccountingModelImpl _value, $Res Function(_$AccountingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? type = freezed,
    Object? amount = freezed,
    Object? context = freezed,
    Object? date = freezed,
    Object? createdAt = freezed,
    Object? userId = freezed,
    Object? id = freezed,
  }) {
    return _then(_$AccountingModelImpl(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AccountingModelImpl extends _AccountingModel {
  _$AccountingModelImpl(
      {required this.category,
      required this.type,
      required this.amount,
      required this.context,
      required this.date,
      required this.createdAt,
      required this.userId,
      required this.id})
      : super._();

  @override
  final String? category;
  @override
  final String? type;
// required AccountingCategoryType? category,
// required AccountingInOrOutType? type,
  @override
  final double? amount;
  @override
  final String? context;
  @override
  final Timestamp? date;
  @override
  final Timestamp? createdAt;
  @override
  final String? userId;
  @override
  final String? id;

  @override
  String toString() {
    return 'AccountingModel(category: $category, type: $type, amount: $amount, context: $context, date: $date, createdAt: $createdAt, userId: $userId, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountingModelImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category, type, amount, context,
      date, createdAt, userId, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountingModelImplCopyWith<_$AccountingModelImpl> get copyWith =>
      __$$AccountingModelImplCopyWithImpl<_$AccountingModelImpl>(
          this, _$identity);
}

abstract class _AccountingModel extends AccountingModel {
  factory _AccountingModel(
      {required final String? category,
      required final String? type,
      required final double? amount,
      required final String? context,
      required final Timestamp? date,
      required final Timestamp? createdAt,
      required final String? userId,
      required final String? id}) = _$AccountingModelImpl;
  _AccountingModel._() : super._();

  @override
  String? get category;
  @override
  String? get type;
  @override // required AccountingCategoryType? category,
// required AccountingInOrOutType? type,
  double? get amount;
  @override
  String? get context;
  @override
  Timestamp? get date;
  @override
  Timestamp? get createdAt;
  @override
  String? get userId;
  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$AccountingModelImplCopyWith<_$AccountingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
