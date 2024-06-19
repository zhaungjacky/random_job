// ignore_for_file: use_build_context_synchronously

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:random_job/screens/screens.dart';
import 'package:random_job/services/services.dart';

class ChatRoomWidget extends StatelessWidget {
  const ChatRoomWidget({
    super.key,
    required this.userInfo,
  });
  final String userInfo;

  @override
  Widget build(BuildContext context) {
    final infos = userInfo.split("&&");
    final reciverId = infos[0];
    final chatRoomId = infos[1];
    final email = infos[2];
    return BlocProvider<ChatBloc>(
      create: (context) => ChatBloc(
        singleton<ChatRepository>(),
        chatRoomId,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(email),
          centerTitle: true,
        ),
        body: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state is ChatErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
              // context.pop();
            }
          },
          builder: (context, state) {
            final width = WidthProvider.setWidthAndHeight(context)['width']!;
            final height = WidthProvider.setWidthAndHeight(context)['height']!;
            switch (state) {
              case ChatInitState():
                return const SizedBox.shrink();
              case ChatLoadingState():
                return const Loader();
              case ChatErrorState():
                return InitTextWidget(
                  text: state.message,
                );
              case ChatSuccessState():
                return Center(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: height,
                      width: width,
                      // color: Colors.white30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ChatRoomListviewWidget(
                            width: width,
                            height: height * 0.78,
                            reciverId: reciverId,
                            lists: state.lists,
                            chatRoomId: chatRoomId,
                          ),
                          ChatRoomInputWidget(
                            width: width,
                            height: height * 0.1,
                            reciverId: reciverId,
                            chatRoomId: chatRoomId,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class ChatRoomInputWidget extends StatefulWidget {
  const ChatRoomInputWidget({
    super.key,
    required this.width,
    required this.height,
    required this.reciverId,
    required this.chatRoomId,
  });

  final double width;
  final double height;
  final String reciverId;
  final String chatRoomId;

  @override
  State<ChatRoomInputWidget> createState() => _ChatRoomInputWidgetState();
}

class _ChatRoomInputWidgetState extends State<ChatRoomInputWidget> {
  final TextEditingController messageController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.teal,
      width: widget.width,
      height: widget.height,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                controller: messageController,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<ChatBloc>().add(
                      ChatAddEvent(
                          reciverId: widget.reciverId,
                          message: messageController.text,
                          chatRoomId: widget.chatRoomId),
                    );
                messageController.clear();
              },
              icon: const Icon(
                Icons.send,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatRoomListviewWidget extends StatelessWidget {
  const ChatRoomListviewWidget({
    super.key,
    required this.width,
    required this.height,
    required this.reciverId,
    required this.lists,
    required this.chatRoomId,
  });

  final double width;
  final double height;
  final String reciverId;
  final List<MessageModel> lists;
  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    final userId = singleton<ChatRepository>().userId;
    final ScrollController scrollController = ScrollController();
    if (userId == null) {
      return const InitTextWidget(
        text: "no user . . .",
      );
    }

    final messages = lists.map(
      (list) {
        final alignment = userId == list.senderId
            ? Alignment.centerRight
            : Alignment.centerLeft;
        final color = userId == list.senderId
            ? Colors.green
            : Theme.of(context).colorScheme.surface;

        return Container(
          alignment: alignment,
          color: Theme.of(context).colorScheme.surface,
          child: GestureDetector(
            child: ChatBubble(
              message: list.message,
              color: color,
              timestamp: list.timestamp,
            ),
            onLongPress: () async {
              final bool res = await handleBool(
                context,
                "Delete chat?",
              );
              if (res) {
                context.read<ChatBloc>().add(
                      ChatDeleteEvent(
                        messageId: list.id!,
                        chatRoomId: chatRoomId,
                      ),
                    );
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text(
                //       'Delete message success . . .',
                //       style: TextStyle(
                //         fontSize: 22,
                //         color: Theme.of(context).colorScheme.background,
                //       ),
                //     ),
                //   ),
                // );
              }
            },
          ),
        );
      },
    ).toList();

    return SizedBox(
      // color: Colors.amberAccent,
      width: width,
      height: height,
      child: Column(
        children: [
          Flexible(
            child: ListView(
              controller: scrollController,
              reverse: true,
              shrinkWrap: true,
              children: UnmodifiableListView(messages),
            ),
          ),
        ],
      ),
      // lists.isEmpty
      //     ? const InitTextWidget(
      //         text: "no item . . .",
      //       )
      //     : ListView.builder(
      //         itemCount: lists.length,
      //         itemBuilder: (context, index) {
      //           final list = lists[index];
      //           return ListTile(
      //             title: Text(list.message),
      //           );
      //         },
      //       ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.color,
    required this.timestamp,
  });

  final String message;
  final Timestamp timestamp;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 6,
        bottom: 6,
      ),
      margin: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 6,
        bottom: 6,
      ),
      child: Column(
        children: [
          Text(
            message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            DateFormat("h:mm a").format(timestamp.toDate()),
            style: TextStyle(
                fontSize: 10, color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
