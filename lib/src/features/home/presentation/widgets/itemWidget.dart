import 'package:flutter/material.dart';
import 'package:jihc_landf/src/core/datasources.dart';
import 'package:jihc_landf/src/features/home/data/models/itemModel.dart';
import 'package:jihc_landf/src/features/home/presentation/pages/itemDetail.dart';

Widget itemRectangle(BuildContext context,ItemModel itemModel) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => ItemDetailPage(item: itemModel),
      ));
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    ApiClient.defaultBaseUrl + itemModel.item_image,
                    width: 60,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemModel.item_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        itemModel.desc,
                        style: TextStyle(color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 4),
                          Text(itemModel.location),
                          SizedBox(width: 12),
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 4),
                          Text(itemModel.date),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                color:
                    !itemModel.isLost
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color:
                      !itemModel.isLost
                          ? Colors.green.shade500
                          : Colors.red.shade500,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  !itemModel.isLost ? 'Found' : 'Lost',
                  style: TextStyle(
                    color:
                        !itemModel.isLost
                            ? Colors.green
                            : Colors.red,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget itemSquare(BuildContext context, ItemModel itemModel) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => ItemDetailPage(item: itemModel),
      ));
    },
    child: Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  ApiClient.defaultBaseUrl + itemModel.item_image,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color:
                        !itemModel.isLost
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color:
                          !itemModel.isLost
                              ? Colors.green.shade500
                              : Colors.red.shade500,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    !itemModel.isLost ? 'Found' : 'Lost',
                    style: TextStyle(
                      color:
                          !itemModel.isLost
                              ? Colors.green
                              : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemModel.item_name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  itemModel.desc,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.black54),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        itemModel.location,
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                    SizedBox(width: 4),
                    Text(
                      itemModel.date,
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

extension StringCasingExtension on String {
  String capitialize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
