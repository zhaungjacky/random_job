import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import "package:equatable/equatable.dart";
import 'package:random_job/services/feathers/accounting/model/accounting_category_type.dart';
import 'package:random_job/services/feathers/accounting/model/accounting_in_or_out_type.dart';
import 'package:random_job/services/feathers/accounting/model/accounting_model.dart';
import 'package:random_job/services/feathers/accounting/repository/accounting_repository.dart';
import 'package:random_job/services/feathers/accounting/repository/accounting_repository_impl.dart';

part 'accounting_event.dart';

enum EnumAccountingState { initial, loaded, error }

class AccountingBloc extends Bloc<AccountingEvent, AccountingState> {
  final AccountingRepository _accountingRepository;
  late StreamSubscription _subscription;

  AccountingBloc(AccountingRepository accountingRepository)
      : _accountingRepository = accountingRepository,
        super(const AccountingState()) {
    on<InitAccountingEvent>(_init);
    on<LoadAccountingEvent>(_load);
    on<ToggleIsShowChartEvent>(_isShowChartZone);
    on<ToggleBarOrPieEvent>(_toggleBarOrPieChart);
    on<UpdateNewStartEndDateEvent>(_updateStartEndDate);
    on<ResetStartEndDateEvent>(_resetStartAndEndDate);
    // print(_accountingService.userId);
    String? userId = _accountingRepository.userId;

    // print("userId_accounting_bloc: $userId");
    // print("userId_accounting_bloc: ${_accountingService.userId}");
    if (userId == null) {
      // _subscription.cancel();
      // print("no_user");
      return;
    }

    _subscription = _accountingRepository
        .getItems(
      mainCollection: AccountingRepositoryImpl.mainCollection(),
      uid: userId,
      // uid: _accountingService.userId!,
      secondaryCollection: AccountingRepositoryImpl.secondaryCollection(),
      endAt: _accountingRepository.endAt,
      startAt: _accountingRepository.startAt,
      isDescending: AccountingRepositoryImpl.isAccountingStreamDescending(),
    )
        .listen((event) {
      final lists = event.docs
          .map((val) => AccountingModel.fromJson(val)
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
              )
          .toList();

      // print(lists[0]);

      add(
        LoadAccountingEvent(
          lists: lists,
        ),
      );
      // if(even)
      // print("bloc_stream_listen: $event");
    });
  }

  _init(InitAccountingEvent event, Emitter emit) {
    emit(
      state.copyWith(
        lists: state.lists,
        status: EnumAccountingState.loaded,
        expense: state.expense,
        incoming: state.incoming,
        chartDataPie: state.chartDataPie,
        chartDataBar: state.chartDataBar,
        showChart: state.showChart,
        showBarChart: state.showBarChart,
        startAt: _accountingRepository.startAt,
        endAt: _accountingRepository.endAt,
      ),
    );
  }

  _load(LoadAccountingEvent event, Emitter emit) {
    final lists = event.lists;

    final obj = _accountingRepository.updateSum(lists: lists);

    // print(obj);

    emit(
      state.copyWith(
        lists: lists,
        status: EnumAccountingState.loaded,
        expense: obj['expense'],
        incoming: obj['incoming'],
        chartDataPie: obj['chartDataPie'],
        chartDataBar: obj['chartDataBar'],
        showChart: state.showChart,
        showBarChart: state.showBarChart,
        startAt: _accountingRepository.startAt,
        endAt: _accountingRepository.endAt,
      ),
    );
  }

  _isShowChartZone(ToggleIsShowChartEvent event, Emitter emit) {
    emit(
      state.copyWith(
        lists: state.lists,
        status: state.status,
        expense: state.expense,
        incoming: state.incoming,
        chartDataPie: state.chartDataPie,
        chartDataBar: state.chartDataBar,
        showChart: !state.showChart,
        showBarChart: state.showBarChart,
        startAt: _accountingRepository.startAt,
        endAt: _accountingRepository.endAt,
      ),
    );
  }

  _toggleBarOrPieChart(ToggleBarOrPieEvent event, Emitter emit) {
    emit(
      state.copyWith(
        lists: state.lists,
        status: state.status,
        expense: state.expense,
        incoming: state.incoming,
        chartDataPie: state.chartDataPie,
        chartDataBar: state.chartDataBar,
        showChart: state.showChart,
        showBarChart: !state.showBarChart,
        startAt: _accountingRepository.startAt,
        endAt: _accountingRepository.endAt,
      ),
    );
  }

  _updateStartEndDate(UpdateNewStartEndDateEvent event, Emitter emit) async {
    String? userId = _accountingRepository.userId;
    if (userId == null) return;
    _accountingRepository.updateStartAndEndDate(
      newStartAt: event.startAt,
      newEndAt: event.endAt,
    );
    await _subscription.cancel();

    // print(userId);

    // print(_accountingService.startAt.toDate());
    // print(_accountingService.endAt.toDate());
    _subscription = _accountingRepository
        .getItems(
      mainCollection: AccountingRepositoryImpl.mainCollection(),
      uid: userId,
      // uid: _accountingService.userId!,
      secondaryCollection: AccountingRepositoryImpl.secondaryCollection(),
      endAt: _accountingRepository.endAt,
      startAt: _accountingRepository.startAt,
      isDescending: AccountingRepositoryImpl.isAccountingStreamDescending(),
    )
        .listen(
      (event) {
        final lists =
            event.docs.map((val) => AccountingModel.fromJson(val)).toList();

        // print(lists[0]);

        add(LoadAccountingEvent(lists: lists));
      },
    );
  }

  _resetStartAndEndDate(ResetStartEndDateEvent event, Emitter emit) async {
    _accountingRepository.resetStartAndEndDate();
    await _subscription.cancel();
    String? userId = _accountingRepository.userId;

    // print(_accountingService.startAt.toDate());
    // print(_accountingService.endAt.toDate());
    _subscription = _accountingRepository
        .getItems(
      mainCollection: AccountingRepositoryImpl.mainCollection(),
      uid: userId,
      // uid: _accountingService.userId!,
      secondaryCollection: AccountingRepositoryImpl.secondaryCollection(),
      endAt: _accountingRepository.endAt,
      startAt: _accountingRepository.startAt,
      isDescending: AccountingRepositoryImpl.isAccountingStreamDescending(),
    )
        .listen(
      (event) {
        final lists =
            event.docs.map((val) => AccountingModel.fromJson(val)).toList();

        // print(lists[0]);

        add(
          LoadAccountingEvent(
            lists: lists,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    super.close();
    _subscription.cancel();
  }
}

class AccountingState extends Equatable {
  final List<AccountingModel> lists;
  final EnumAccountingState status;
  final double expense;
  final double incoming;
  final Map<AccountingCategoryType, double> chartDataPie;
  final Map<AccountingInOrOutType, double> chartDataBar;
  final bool showChart; //  是否现实图区域
  final bool showBarChart; // 现实bar or pie
  final Timestamp? startAt;
  final Timestamp? endAt;

  const AccountingState({
    this.lists = const [],
    this.status = EnumAccountingState.initial,
    this.expense = 0,
    this.incoming = 0,
    this.chartDataPie = const {},
    this.chartDataBar = const {},
    this.showChart = false,
    this.showBarChart = false, //if true show in and out sum
    this.startAt,
    this.endAt,
  });

  AccountingState copyWith({
    required List<AccountingModel>? lists,
    required EnumAccountingState? status,
    required double? expense,
    required double? incoming,
    required Map<AccountingCategoryType, double>? chartDataPie,
    required Map<AccountingInOrOutType, double>? chartDataBar,
    required bool? showChart,
    required bool? showBarChart,
    required Timestamp? startAt,
    required Timestamp? endAt,
  }) {
    return AccountingState(
      lists: lists ?? this.lists,
      status: status ?? this.status,
      expense: expense ?? this.expense,
      incoming: incoming ?? this.incoming,
      chartDataPie: chartDataPie ?? this.chartDataPie,
      chartDataBar: chartDataBar ?? this.chartDataBar,
      showChart: showChart ?? this.showChart,
      showBarChart: showBarChart ?? this.showBarChart,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
    );
  }

  @override
  List<Object?> get props => [
        lists,
        status,
        expense,
        incoming,
        chartDataPie,
        chartDataBar,
        showBarChart,
        showChart,
        startAt,
        endAt,
      ];
}
