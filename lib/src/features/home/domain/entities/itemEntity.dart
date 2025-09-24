import 'package:flutter/material.dart';

class ItemEntity {
  final String item_id;
  final String user_id;
  final String item_name;
  final String postType;
  final String desc;
  final String date;
  final String location;
  final String item_image;
  ItemEntity({
    required this.item_id,
    required this.user_id,
    required this.item_name,
    required this.postType,
    required this.desc,
    required this.date,
    required this.location,
    required this.item_image,
  });
}
