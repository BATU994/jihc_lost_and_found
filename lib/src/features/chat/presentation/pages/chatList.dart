import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jihc_landf/src/core/datasources.dart';
import 'package:jihc_landf/src/core/item/bloc/item_bloc.dart';
import 'package:jihc_landf/src/core/item/data/repositories/itemRepositoryImpl.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/shared_preferences.dart';
import '../../data/repository/repositoryImpl.dart';
import '../bloc/chat_list_bloc.dart';
import '../bloc/chat_messages_bloc.dart';
import 'chat_detail.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key, required this.currentUserId});

  final int currentUserId;

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  TextEditingController _searchController = TextEditingController();
  bool search = false;
  String username = '';
  void loadUserName() async {
    final profileInfo = ProfileInfo();
    final name = await profileInfo.getUserName();
    setState(() {
      username = name ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  ChatListBloc(ChatRepositoryImpl(ApiClient()))
                    ..add(LoadChats(widget.currentUserId)),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          title:
              !search
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        const Text(
                          'Chats',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 35,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              search = true;
                            });
                          },
                          icon: const Icon(Icons.search, color: Colors.black54),
                        ),
                      ],
                    ),
                  )
                  : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios_new),
                          color: Colors.black87,
                          onPressed: () {
                            setState(() {
                              search = false;
                            });
                          },
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 45,
                                minHeight: 20,
                              ),
                              hintText: 'Search',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              prefixIcon: SvgPicture.asset(
                                'assets/search_black.svg',
                                color: Colors.black,
                                width: 20,
                                height: 20,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                'Suggestions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: BlocBuilder<ChatListBloc, ChatListStateBloc>(
                builder: (context, state) {
                  if (state is ChatListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ChatListError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is! ChatListLoaded) {
                    return const SizedBox.shrink();
                  }
                  if (state.chats.isEmpty) {
                    return const Center(child: Text('No chats'));
                  }
                  return ListView.separated(
                    itemCount: state.chats.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final chat = state.chats[index];
                      // Determine other participant if needed later
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
                                    ],
                                    child: ChatDetailPage(
                                      chatId: chat.id,
                                      title:
                                          username == chat.userNames.first
                                              ? chat.userNames.last
                                              : chat.userNames.first,
                                      currentUserId: widget.currentUserId,
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
                          username == chat.userNames.first
                              ? chat.userNames.last
                              : chat.userNames.first,
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
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
