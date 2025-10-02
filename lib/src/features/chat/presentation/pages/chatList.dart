import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jihc_landf/src/core/datasources.dart';
// Removed UsernameBloc usage for now; fallback titles are used
import '../../data/repository/repositoryImpl.dart';
import '../bloc/chat_list_cubit.dart';
import '../bloc/chat_messages_cubit.dart';
import 'chat_detail.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key, required this.currentUserId});

  final int currentUserId;

  @override
  Widget build(BuildContext context) {
    // No eager username fetching here; resolve names lazily or display a fallback
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  ChatListCubit(ChatRepositoryImpl(ApiClient()))
                    ..load(currentUserId),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          title: Row(
            children: [
              const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.black87,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.black54),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Search',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
              child: BlocBuilder<ChatListCubit, ChatListState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.error != null) {
                    return Center(child: Text(state.error!));
                  }
                  if (state.chats.isEmpty) {
                    return const Center(child: Text('No chats'));
                  }
                  return ListView.separated(
                    itemCount: state.chats.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final chat = state.chats[index];
                      final other = chat.userIds.firstWhere(
                        (id) => id != currentUserId,
                        orElse: () => chat.userIds.first,
                      );
                      return ListTile(
                        onTap:
                            () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (_) => BlocProvider(
                                      create:
                                          (_) => ChatMessagesCubit(
                                            ChatRepositoryImpl(ApiClient()),
                                          )..load(chat.id),
                                      child: ChatDetailPage(
                                        chatId: chat.id,
                                        title: 'User $other',
                                        currentUserId: currentUserId,
                                      ),
                                    ),
                              ),
                            ),
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
                          'User $other',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Row(
                          children: const [
                            Icon(Icons.done_all, size: 16, color: Colors.blue),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'That matches! I found them y...',
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
