import 'dart:typed_data';

import 'package:flutter/material.dart';

class ItemEntity {
  final String item_id;
  final String user_id;
  final String item_name;
  final bool isLost;
  final bool isResolved;
  final String desc;
  final String date;
  final String location;
  final String item_image;
  ItemEntity({
    required this.isResolved,
    required this.item_id,
    required this.user_id,
    required this.item_name,
    required this.isLost,
    required this.desc,
    required this.date,
    required this.location,
    required this.item_image,
  });
}

class ItemEntityPost {
  final String user_id;
  final String item_name;
  final bool isLost;
  final bool isResolved;
  final String desc;
  final String date;
  final String location;
  final Uint8List item_image;
  ItemEntityPost({
    required this.isResolved,
    required this.user_id,
    required this.item_name,
    required this.isLost,
    required this.desc,
    required this.date,
    required this.location,
    required this.item_image,
  });
}