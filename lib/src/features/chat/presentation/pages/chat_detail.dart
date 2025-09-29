import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/chat_messages_cubit.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({
    super.key,
    required this.chatId,
    required this.title,
    required this.currentUserId,
  });
  final int chatId;
  final String title;
  final int currentUserId;

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final _controller = TextEditingController();

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      title: Row(
        children: [
          const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black87),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFE0E0E0),
            child: Icon(Icons.person, size: 18, color: Colors.black54),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.circle, size: 8, color: Colors.green),
                  SizedBox(width: 4),
                  Text(
                    'Online',
                    style: TextStyle(color: Colors.black45, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Water Bottle',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Lost & Found Item',
            style: TextStyle(color: Colors.black54, fontSize: 12),
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
            child: BlocBuilder<ChatMessagesCubit, ChatMessagesState>(
              builder: (context, state) {
                if (state.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.error != null) {
                  return Center(child: Text(state.error!));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final m = state.messages[index];
                    final ts = DateFormat('dd MMM').format(m.timestamp);
                    final isMe = m.senderId == widget.currentUserId;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (index == 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            margin: const EdgeInsets.only(bottom: 8),
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
                        context.read<ChatMessagesCubit>().send(
                          widget.chatId,
                          text,
                        );
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
