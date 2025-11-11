import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchFieldChat extends StatefulWidget {
  SearchFieldChat({
    super.key,
    required this.searchController,
    required this.onChanged,
  });
  final ValueChanged<String?> onChanged;
  TextEditingController searchController = TextEditingController();
  @override
  State<SearchFieldChat> createState() => _SearchFieldChatState();
}

class _SearchFieldChatState extends State<SearchFieldChat> {
  late TextEditingController searchController;
  late ValueChanged<String?> onChanged;
  @override
  void initState() {
    super.initState();
    searchController = widget.searchController;
    onChanged = widget.onChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: searchController,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIconConstraints: BoxConstraints(minWidth: 45, minHeight: 20),
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade300),
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
    );
  }
}
