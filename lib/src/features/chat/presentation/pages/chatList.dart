import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jihc_landf/src/core/datasources.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/shared_preferences.dart';
import 'package:jihc_landf/src/features/chat/domain/entities/chat_entities.dart';
import 'package:jihc_landf/src/features/chat/presentation/widgets/chat_single.dart';
import 'package:jihc_landf/src/features/chat/presentation/widgets/search.dart';
import '../../data/repository/repositoryImpl.dart';
import '../bloc/chat_list_bloc.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    super.initState();
    loadUserName();
    loadUserId();
  }

  final TextEditingController _searchController = TextEditingController();
  bool search = false;
  String username = '';
  int userId = 8;
  void loadUserName() async {
    final profileInfo = ProfileInfo();
    final name = await profileInfo.getUserName();
    setState(() {
      username = name ?? 'User';
    });
  }

  void loadUserId() async {
    final profileInfo = ProfileInfo();
    final id = await profileInfo.getId();
    print(id);
    setState(() {
      userId = id!;
    });
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  ChatListBloc(ChatRepositoryImpl(ApiClient()))
                    ..add(LoadChats(userId)),
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
                        SearchFieldChat(
                          searchController: _searchController,
                          onChanged: (_) => setState(() {}),
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
                  List<ChatEntity> filteredList;
                  filteredList =
                      _searchController.text.isNotEmpty
                          ? state.chats.where((chat) {
                            return chat.item!.contains(
                              _searchController.text,
                              0,
                            );
                          }).toList()
                          : state.chats;
                  return ListView.separated(
                    itemCount: filteredList.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final chat = filteredList[index];
                      return ChatSingle(
                        chat: chat,
                        username: username,
                        currentUserId: userId,
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
