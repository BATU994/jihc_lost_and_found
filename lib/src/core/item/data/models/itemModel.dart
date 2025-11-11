import 'package:jihc_landf/src/core/item/domain/entities/itemEntity.dart';

class ItemModel extends ItemEntity {
  ItemModel({
    required super.item_id,
    required super.user_id,
    required super.item_name,
    required super.isLost,
    required super.desc,
    required super.date,
    required super.location,
    required super.item_image,
    required super.isResolved,
    required super.userName,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      userName: json['userName'].toString(),
      user_id: json['userId'],
      item_name: json['item_name'].toString(),
      isLost: json['isLost'],
      desc: json['desc'].toString(),
      date: json['date'].toString(),
      location: json['location'].toString(),
      item_image: json['image'].toString(),
      isResolved: json['isResolved'],
      item_id: json['item_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': item_id,
      'userId': user_id,
      'userName': userName,
      'item_name': item_name,
      'isLost': isLost,
      'desc': desc,
      'date': date,
      'location': location,
      'image': item_image,
      'isResolved': isResolved,
    };
  }
}
