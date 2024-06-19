import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
// import 'package:equatable/equatable.dart';
import 'package:random_job/services/feathers/todo/todo.dart';
// import 'package:family_app/services/todo/todo.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_event.dart';
part 'todo_state.dart';
// part 'todo_bloc.freezed.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;
  late StreamSubscription _subscription;
  TodoBloc(TodoRepository todoRepository)
      : _todoRepository = todoRepository,
        super(TodoInitState()) {
    _subscription = _todoRepository
        .getItems(
      mainCollection: TodoRepositoryImpl.mainCollection(),
      secondartCollection: TodoRepositoryImpl.secondaryCollection(),
      isTodoStreamDescending: TodoRepositoryImpl.isTodoStreamDescending(),
      startAt: _todoRepository.startAt,
      endAt: _todoRepository.endAt,
    )
        .listen((event) {
      final lists = event.docs
          .map(
            ((val) => TodoModel.fromJson(val)
            // TodoModel(
            //       text: val['text'],
            //       uid: val['uid'],
            //       isChecked: val['isChecked'],
            //       date: val['date'],
            //       createdAt: val['createdAt'],
            //       id: val.id,
            //     )
            ),
          )
          .toList();
      // print(lists);
      add(LoadTodoEvent(lists: lists));
    });
    on<TodoEvent>(
      (_, emit) => emit(
        TodoLoadingState(),
      ),
    );
    on<LoadTodoEvent>(_loadSuccess);
    on<UpdateTodoDateEvent>(_updateTodoDate);
    on<ResetTodoDateEvent>(_resetTodoDate);
    on<ErrorTodoEvent>(
      (event, emit) => emit(
        TodoErrorState(event.message),
      ),
    );
  }

  _loadSuccess(LoadTodoEvent event, Emitter emit) {
    emit(
      TodoSuccessState(
        lists: event.lists,
        startAt: _todoRepository.startAt,
        endAt: _todoRepository.endAt,
      ),
    );
  }

  _updateTodoDate(UpdateTodoDateEvent event, Emitter emit) async {
    await _subscription.cancel();
    _todoRepository.updateStartAndEndDate(
      newStartAt: event.startAt,
      newEndAt: event.endAt,
    );

    _subscription = _todoRepository
        .getItems(
      mainCollection: TodoRepositoryImpl.mainCollection(),
      secondartCollection: TodoRepositoryImpl.secondaryCollection(),
      isTodoStreamDescending: TodoRepositoryImpl.isTodoStreamDescending(),
      startAt: _todoRepository.startAt,
      endAt: _todoRepository.endAt,
    )
        .listen((event) {
      final lists = event.docs
          .map(
            ((val) => TodoModel.fromJson(val)),
          )
          .toList();
      // print(lists);
      add(LoadTodoEvent(lists: lists));
    });
  }

  _resetTodoDate(ResetTodoDateEvent event, Emitter emit) async {
    await _subscription.cancel();

    _todoRepository.resetStartAndEndDate();

    _subscription = _todoRepository
        .getItems(
      mainCollection: TodoRepositoryImpl.mainCollection(),
      secondartCollection: TodoRepositoryImpl.secondaryCollection(),
      isTodoStreamDescending: TodoRepositoryImpl.isTodoStreamDescending(),
      startAt: _todoRepository.startAt,
      endAt: _todoRepository.endAt,
    )
        .listen((event) {
      final lists = event.docs
          .map(
            ((val) => TodoModel.fromJson(val)),
          )
          .toList();
      // print(lists);
      add(LoadTodoEvent(lists: lists));
    });
  }

  @override
  Future<void> close() async {
    super.close();
    _subscription.cancel();
  }
}
// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// // import 'package:equatable/equatable.dart';
// import 'package:random_job/services/feathers/todo/todo.dart';
// import 'package:random_job/services/utils/utils.dart';
// // import 'package:family_app/services/todo/todo.dart';
// // import 'package:freezed_annotation/freezed_annotation.dart';

// part 'todo_event.dart';
// part 'todo_state.dart';
// // part 'todo_bloc.freezed.dart';

// class TodoBloc extends Bloc<TodoEvent, TodoState> {
//   final TodoRepository _todoRepository;
//   late StreamSubscription _subscription;
//   TodoBloc(TodoRepository todoRepository)
//       : _todoRepository = todoRepository,
//         super(
//           TodoState(
//             startAt: DateProvider.staticTodoStartAt(),
//             endAt: DateProvider.staticTodoEndAt(),
//           ),
//         ) {
//     _subscription = _todoRepository
//         .getItems(
//       mainCollection: TodoRepositoryImpl.mainCollection(),
//       secondartCollection: TodoRepositoryImpl.secondaryCollection(),
//       isTodoStreamDescending: TodoRepositoryImpl.isTodoStreamDescending(),
//       startAt: _todoRepository.startAt,
//       endAt: _todoRepository.endAt,
//     )
//         .listen((event) {
//       final lists = event.docs
//           .map(
//             ((val) => TodoModel(
//                   text: val['text'],
//                   uid: val['uid'],
//                   isChecked: val['isChecked'],
//                   date: val['date'],
//                   createdAt: val['createdAt'],
//                   id: val.id,
//                 )),
//           )
//           .toList();
//       // print(lists);
//       add(LoadTodoEvent(lists: lists));
//     });

//     on<LoadTodoEvent>(_load);
//     on<UpdateTodoDateEvent>(_updateTodoDate);
//     on<ResetTodoDateEvent>(_resetTodoDate);
//   }

//   _load(LoadTodoEvent event, Emitter emit) {
//     emit(
//       state.copyWith(
//         lists: event.lists,
//         status: EnumTodoStatus.loaded,
//         startAt: _todoRepository.startAt,
//         endAt: _todoRepository.endAt,
//       ),
//     );
//   }

//   _updateTodoDate(UpdateTodoDateEvent event, Emitter emit) async {
//     await _subscription.cancel();
//     _todoRepository.updateStartAndEndDate(
//       newStartAt: event.startAt,
//       newEndAt: event.endAt,
//     );

//     _subscription = _todoRepository
//         .getItems(
//       mainCollection: TodoRepositoryImpl.mainCollection(),
//       secondartCollection: TodoRepositoryImpl.secondaryCollection(),
//       isTodoStreamDescending: TodoRepositoryImpl.isTodoStreamDescending(),
//       startAt: _todoRepository.startAt,
//       endAt: _todoRepository.endAt,
//     )
//         .listen((event) {
//       final lists = event.docs
//           .map(
//             ((val) => TodoModel(
//                   text: val['text'],
//                   uid: val['uid'],
//                   isChecked: val['isChecked'],
//                   date: val['date'],
//                   createdAt: val['createdAt'],
//                   id: val.id,
//                 )),
//           )
//           .toList();
//       // print(lists);
//       add(LoadTodoEvent(lists: lists));
//     });
//   }

//   _resetTodoDate(ResetTodoDateEvent event, Emitter emit) async {
//     await _subscription.cancel();

//     _todoRepository.resetStartAndEndDate();

//     _subscription = _todoRepository
//         .getItems(
//       mainCollection: TodoRepositoryImpl.mainCollection(),
//       secondartCollection: TodoRepositoryImpl.secondaryCollection(),
//       isTodoStreamDescending: TodoRepositoryImpl.isTodoStreamDescending(),
//       startAt: _todoRepository.startAt,
//       endAt: _todoRepository.endAt,
//     )
//         .listen((event) {
//       final lists = event.docs
//           .map(
//             ((val) => TodoModel(
//                   text: val['text'],
//                   uid: val['uid'],
//                   isChecked: val['isChecked'],
//                   date: val['date'],
//                   createdAt: val['createdAt'],
//                   id: val.id,
//                 )),
//           )
//           .toList();
//       // print(lists);
//       add(LoadTodoEvent(lists: lists));
//     });
//   }

//   @override
//   Future<void> close() async {
//     super.close();
//     _subscription.cancel();
//   }
// }
