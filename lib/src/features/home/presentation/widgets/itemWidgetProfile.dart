import 'package:flutter/material.dart';
import 'package:jihc_landf/src/core/datasources.dart';
import 'package:jihc_landf/src/features/home/domain/entities/itemEntity.dart';
import 'package:jihc_landf/src/features/home/presentation/bloc/item_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget itemProfile(BuildContext context, ItemEntity itemModel) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey.shade400),
      color: Colors.white,
    ),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
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
              SizedBox(height: 8),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 3),
              Row(
                children: [
                  !itemModel.isResolved
                      ? InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.check, color: Colors.blue.shade100),
                              Text(
                                'Mark as Resolved',
                                style: TextStyle(
                                  color: Colors.blue.shade100,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      : SizedBox.shrink(),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      context.read<ItemBloc>().add(
                        DeleteItem(itemModel.item_id),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red.shade100),
                          Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red.shade100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                  color: !itemModel.isLost ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
