import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:random_job/services/services.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  final String _chatRoomId;
  late final StreamSubscription _subscription;
  ChatBloc(
    ChatRepository chatRepository,
    String chatRoomId,
  )   : _chatRepository = chatRepository,
        _chatRoomId = chatRoomId,
        super(ChatInitState()) {
    _subscription = _chatRepository
        .getMessages(
      chatRoomId: _chatRoomId,
      isChatStreamDescending: ChatDatasourceImpl.isChatStreamDescending(),
      startAt: _chatRepository.startAt,
      endAt: _chatRepository.endAt,
    )
        .listen(
      (event) {
        final lists = event.docs
            .map(
              (e) => MessageModel.fromJson(e),
            )
            .toList();
        // final lists = event.docs
        //     .map(
        //       (val) => MessageModel(
        //         senderId: val['senderId'],
        //         senderEmail: val['senderEmail'],
        //         reciverId: val['reciverId'],
        //         message: val['message'],
        //         timestamp: val['timestamp'],
        //         id: val.id,
        //       ),
        //     )
        //     .toList();
        add(
          ChatLoadEvent(lists),
        );
      },
    );
    on<ChatEvent>(
      (_, emit) => emit(
        ChatLoadingState(),
      ),
    );
    on<ChatLoadEvent>(_loadMessages);
    on<ChatAddEvent>(_addMessage);
    on<ChatDeleteEvent>(_deleteMessage);
    on<ChatErrorEvent>(
      (event, emit) => emit(
        ChatErrorState(event.message),
      ),
    );
    on<ChatUpdateDateEvent>(_updateDate);
    on<ChatResetDateEvent>(_resetDate);
  }
  _loadMessages(ChatLoadEvent event, Emitter emit) {
    emit(
      ChatSuccessState(event.lists),
    );
  }

  _updateDate(ChatUpdateDateEvent event, Emitter emit) async {
    await _subscription.cancel();
    _chatRepository.updateStartAndEndDate(
      newStartAt: event.startAt,
      newEndAt: event.endAt,
    );
    _subscription = _chatRepository
        .getMessages(
      chatRoomId: _chatRoomId,
      isChatStreamDescending: ChatDatasourceImpl.isChatStreamDescending(),
      startAt: _chatRepository.startAt,
      endAt: _chatRepository.endAt,
    )
        .listen(
      (event) {
        final lists = event.docs
            .map(
              (e) => MessageModel.fromJson(e),
            )
            .toList();
        add(
          ChatLoadEvent(lists),
        );
      },
    );
  }

  _resetDate(ChatResetDateEvent event, Emitter emit) async {
    await _subscription.cancel();
    _chatRepository.resetStartAndEndDate();
    _subscription = _chatRepository
        .getMessages(
      chatRoomId: _chatRoomId,
      isChatStreamDescending: ChatDatasourceImpl.isChatStreamDescending(),
      startAt: _chatRepository.startAt,
      endAt: _chatRepository.endAt,
    )
        .listen(
      (event) {
        final lists = event.docs
            .map(
              (e) => MessageModel.fromJson(e),
            )
            .toList();
        add(
          ChatLoadEvent(lists),
        );
      },
    );
  }

  _deleteMessage(ChatDeleteEvent event, Emitter emit) async {
    try {
      await _chatRepository.deleteMessage(
        event.messageId,
        event.chatRoomId,
      );
    } on FirebaseException catch (err) {
      emit(
        ChatErrorState(err.code),
      );
    }
  }

  _addMessage(ChatAddEvent event, Emitter emit) async {
    try {
      await _chatRepository.sendMessage(
        event.reciverId,
        event.message,
        event.chatRoomId,
      );
    } on FirebaseException catch (err) {
      emit(
        ChatErrorState(err.code),
      );
    }
  }

  @override
  Future<void> close() async {
    super.close();

    await _subscription.cancel();
  }
}
