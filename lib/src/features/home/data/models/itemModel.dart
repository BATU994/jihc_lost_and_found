import 'package:jihc_landf/src/features/home/domain/entities/itemEntity.dart';

class ItemModel extends ItemEntity {
  ItemModel({
    required String item_id,
    required String user_id,
    required String item_name,
    required String postType,
    required String desc,
    required String date,
    required String location,
    required String item_image,
  }) : super(
         item_id: item_id,
         user_id: user_id,
         item_name: item_name,
         postType: postType,
         desc: desc,
         date: date,
         location: location,
         item_image: item_image,
       );

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      item_id: json['item_id'],
      user_id: json['user_id'],
      item_name: json['item_name'],
      postType: json['postType'],
      desc: json['desc'],
      date: json['date'],
      location: json['location'],
      item_image: json['item_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': item_id,
      'user_id': user_id,
      'item_name': item_name,
      'postType': postType,
      'desc': desc,
      'date': date,
      'location': location,
      'item_image': item_image,
    };
  }
}
