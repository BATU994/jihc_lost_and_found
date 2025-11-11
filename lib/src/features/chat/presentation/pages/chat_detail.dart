import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jihc_landf/src/core/datasources.dart';
import 'package:jihc_landf/src/core/item/bloc/item_bloc.dart';
import 'package:jihc_landf/src/features/chat/data/models/chat_models.dart';
import 'package:jihc_landf/src/features/chat/domain/entities/chat_entities.dart';
import 'package:jihc_landf/src/features/chat/presentation/bloc/chat_list_bloc.dart';
import 'package:jihc_landf/src/features/chat/presentation/pages/congrats.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../bloc/chat_messages_bloc.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({
    super.key,
    required this.chatId,
    required this.title,
    required this.currentUserId,
    required this.item,
    required this.itemImage,
    required this.itemId,
    required this.userName,
    required this.otherUserId,
  });

  final int chatId;
  final String title;
  final int currentUserId;
  final String item;
  final String itemImage;
  final String itemId;
  final String userName;
  final int otherUserId;

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late WebSocketChannel channel;
  final _controller = TextEditingController();
  List<MessageEntity> messages = [];

  @override
  void initState() {
    super.initState();

    // Initialize WebSocket
    channel = WebSocketChannel.connect(
      Uri.parse("ws://127.0.0.1:8000/chats/ws/${widget.chatId}"),
    );

    // Listen to incoming messages
    channel.stream.listen((data) {
      try {
        final jsonData = jsonDecode(data);
        final message = MessageDto.fromJson(jsonData);
        final messageEntity = message.toEntity();
        setState(() {
          messages.add(messageEntity);
        });
      } catch (e) {
        debugPrint('Error parsing WebSocket message: $e');
      }
    });

    final state = context.read<ChatMessagesBloc>().state;
    if (state is ChatMessagesLoaded) {
      messages = List.from(state.messages);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    _controller.dispose();
    context.read<ChatMessagesBloc>().add(DisconnectChat());
    super.dispose();
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      title: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFE0E0E0),
            child: Icon(Icons.person, size: 18, color: Colors.black54),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Icon(Icons.phone, color: Colors.black87),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _contextBanner() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFE7F0FF),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  ApiClient.defaultBaseUrl + widget.itemImage,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                widget.item,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ItemBloc>().add(
                ResolveItem(widget.itemId, false, 0),
              );
              context.read<ChatListBloc>().add(
                DeleteChat(widget.chatId.toString()),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Congrats()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A84FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            child: Row(
              children: const [
                Icon(Icons.done, color: Colors.white, size: 24),
                SizedBox(width: 4),
                Text(
                  'Resolved',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _contextBanner(),
          Expanded(
            child: BlocBuilder<ChatMessagesBloc, ChatMessagesStateBloc>(
              builder: (context, state) {
                if (state is ChatMessagesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ChatMessagesError) {
                  return Center(child: Text(state.message));
                }
                if (state is ChatMessagesLoaded) {
                  if (messages.isEmpty) {
                    messages = List.from(state.messages);
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final m = messages[index];
                      final ts = DateFormat('dd MMM').format(m.timestamp);
                      final isMe = m.senderId == widget.currentUserId;

                      bool showDateHeader =
                          index == 0 ||
                          messages[index - 1].timestamp.day != m.timestamp.day;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (showDateHeader)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              margin: const EdgeInsets.only(bottom: 8, top: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                ts,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                          Align(
                            alignment:
                                isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75,
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    isMe
                                        ? const Color(0xFF0A84FF)
                                        : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                m.content,
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Type a message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF0A84FF),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        final text = _controller.text.trim();
                        if (text.isEmpty) return;

                        final message = MessagePost(
                          senderId: widget.currentUserId,
                          receiverId: widget.otherUserId,
                          content: text,
                        );

                        channel.sink.add(jsonEncode(message.toJson()));

                        _controller.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
