import 'package:jihc_landf/src/features/home/domain/entities/itemEntity.dart';

class ItemModel extends ItemEntity {
  ItemModel({
    required String item_id,
    required String user_id,
    required String item_name,
    required bool isLost,
    required String desc,
    required String date,
    required String location,
    required String item_image,
    required bool isResolved,
  }) : super(
         item_id: item_id,
         isResolved: isResolved,
         user_id: user_id,
         item_name: item_name,
         isLost: isLost,
         desc: desc,
         date: date,
         location: location,
         item_image: item_image,
       );

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      user_id: json['userId'].toString(),
      item_name: json['item_name'].toString(),
      isLost: json['isLost'],
      desc: json['desc'].toString(),
      date: json['date'].toString(),
      location: json['location'].toString(),
      item_image: json['image'].toString(),
      isResolved: json['isResolved'],
      item_id: json['id'].toString(), // <-- Fix here
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': item_id,
      'userId': user_id,
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
