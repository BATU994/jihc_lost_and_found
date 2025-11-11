import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jihc_landf/src/core/datasources.dart';
import 'package:jihc_landf/src/core/item/bloc/item_bloc.dart';
import 'package:jihc_landf/src/core/item/data/repositories/itemRepositoryImpl.dart';
import 'package:jihc_landf/src/features/chat/data/repository/repositoryImpl.dart';
import 'package:jihc_landf/src/features/chat/domain/entities/chat_entities.dart';
import 'package:jihc_landf/src/features/chat/presentation/bloc/chat_list_bloc.dart';
import 'package:jihc_landf/src/features/chat/presentation/bloc/chat_messages_bloc.dart';
import 'package:jihc_landf/src/features/chat/presentation/pages/chat_detail.dart';

class ChatSingle extends StatelessWidget {
  const ChatSingle({super.key, required this.chat, required this.username, required this.currentUserId});
  final ChatEntity chat;
  final String username;
  final int currentUserId;
  @override
  Widget build(BuildContext context) {
    return ListTile(
                        onTap: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (_) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create:
                                            (_) => ChatMessagesBloc(
                                              ChatRepositoryImpl(ApiClient()),
                                            )..add(LoadChatMessages(chat.id)),
                                      ),
                                      BlocProvider(
                                        create:
                                            (_) => ItemBloc(
                                              ItemRepositoryImpl(Dio()),
                                            ),
                                      ),
                                      BlocProvider(
                                        create:
                                            (_) => ChatListBloc(
                                              ChatRepositoryImpl(ApiClient()),
                                            ),
                                      ),
                                    ],
                                    child: ChatDetailPage(
                                      otherUserId: chat.userIds.firstWhere(
                                        (id) => id != currentUserId,
                                      ),
                                      chatId: chat.id,
                                      title:
                                          username == chat.userNames.first
                                              ? chat.userNames.last
                                              : chat.userNames.first,
                                      currentUserId: currentUserId,
                                      item: chat.item ?? '',
                                      itemImage: chat.itemImage ?? '',
                                      itemId: chat.itemId ?? '',
                                      userName: chat.userNames.last,
                                    ),
                                  ),
                            ),
                          );
                        },
                        leading: Stack(
                          children: [
                            const CircleAvatar(
                              radius: 22,
                              backgroundColor: Color(0xFFE0E0E0),
                              child: Icon(Icons.person, color: Colors.black54),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 0,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          " ${chat.item} - ${username == chat.userNames.first ? chat.userNames.last : chat.userNames.first}",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Row(
                          children: const [
                            Icon(Icons.done_all, size: 16, color: Colors.blue),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Placeholder message',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '13:32',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0A84FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
  }
}