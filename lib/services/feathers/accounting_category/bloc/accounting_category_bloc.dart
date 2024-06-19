import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:random_job/services/services.dart';

part 'accounting_category_event.dart';
part 'accounting_category_state.dart';

class AccountingCategoryBloc
    extends Bloc<AccountingCategoryEvent, AccountingCategoryState> {
  final AccountingCategoryRepository _accountingCategoryRepository;
  final String key;
  final String value;
  late final StreamSubscription _subscription;
  AccountingCategoryBloc({
    required AccountingCategoryRepository accountingCategoryRepository,
    required this.key,
    required this.value,
  })  : _accountingCategoryRepository = accountingCategoryRepository,
        super(LoadingAccountingCategoryState()) {
    final usrId = _accountingCategoryRepository.userId;
    if (usrId == null) return;

    _subscription = _accountingCategoryRepository
        .getItems(
      mainCollection: AccountingCategoryRepositoryImpl.mainCollection(),
      uid: usrId,
      secondaryCollection:
          AccountingCategoryRepositoryImpl.secondaryCollection(),
      isDescending: AccountingCategoryRepositoryImpl
          .isAccountingCategoryStreamDescending(),
      key: key,
      value: value,
    )
        .listen((event) {
      try {
        final lists = event.docs
            .map(
              ((val) => AccountingModel.fromJson(val)
              // AccountingModel(
              //       category: val['category'],
              //       type: val['type'],
              //       amount: val['amount'],
              //       context: val['context'],
              //       date: val['date'],
              //       createdAt: val['createdAt'],
              //       userId: val['userId'],
              //       id: val.id,
              //     )
              ),
            )
            .toList();
        add(
          LoadingAccountingCategoryEvent(lists),
        );
      } on FirebaseException catch (err) {
        add(
          ErrorAccountingCategoryEvent(err.code),
        );
      }
    });

    on<AccountingCategoryEvent>(
      (_, emit) => emit(
        LoadingAccountingCategoryState(),
      ),
    );
    on<LoadingAccountingCategoryEvent>(_loadingAccountingCategory);
    on<ErrorAccountingCategoryEvent>(_error);
  }
  _loadingAccountingCategory(
      LoadingAccountingCategoryEvent event, Emitter emit) {
    emit(
      LoadedAccountingCategoryState(event.lists),
    );
  }

  _error(ErrorAccountingCategoryEvent event, Emitter emit) {
    emit(
      ErrorAccountingCategoryState(event.message),
    );
  }

  @override
  Future<void> close() async {
    super.close();
    await _subscription.cancel();
  }
}
