import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/shared_preferences.dart';

import 'package:jihc_landf/src/features/home/domain/entities/itemEntity.dart';
import 'package:jihc_landf/src/features/home/data/repositories/itemRepositoryImpl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jihc_landf/src/features/home/presentation/bloc/item_bloc.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool isLost = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _imagePath;
  bool _isLoading = false;
  Uint8List bytes = Uint8List(0);

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      child: BlocListener<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state is ItemLoading) {
            setState(() {
              _isLoading = true;
            });
          } else {
            setState(() {
              _isLoading = false;
            });
          }
          if (state is ItemError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is ItemPosted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Item posted successfully!')),
            );
            
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text('Post Item')),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('What happened?', style: TextStyle(fontSize: 18)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLost = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 25,
                            ),
                            backgroundColor:
                                isLost ? Colors.red : Colors.grey[300],
                            foregroundColor: isLost ? Colors.white : Colors.black,
                          ),
                          child: Text(
                            'I Lost Something',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLost = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 25,
                            ),
                            backgroundColor:
                                !isLost ? Colors.green : Colors.white,
                            foregroundColor:
                                !isLost ? Colors.white : Colors.black,
                          ),
                          child: Text(
                            'I Found Something',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Add Photo',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        bytes = await image.readAsBytes();
                      }
                      print(bytes);
                    },
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Center(
                        child:
                            _imagePath == null
                                ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Tap to add photo',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                )
                                : Text('Image selected: $_imagePath'),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text('Item Name'),
                  SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'e.g., iPhone 14 Pro',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Description'),
                  SizedBox(height: 8),
                  TextField(
                    controller: _descController,
                    maxLength: 500,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText:
                          'Describe the item, when and where you lost/found it...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Location'),
                  SizedBox(height: 8),
                  TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      hintText: 'e.g., Library, Classroom 205',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(isLost ? 'Date Lost' : 'Date Found'),
                  SizedBox(height: 8),
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'dd.mm.yyyy',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      suffixIcon: Icon(Icons.calendar_today_outlined),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        _dateController.text =
                            "${picked.day.toString().padLeft(2, '0')}.${picked.month.toString().padLeft(2, '0')}.${picked.year}";
                      }
                    },
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed:
                          _isLoading
                              ? null
                              : () async {
                                // Validate fields
                                if (_nameController.text.isEmpty ||
                                    _descController.text.isEmpty ||
                                    _locationController.text.isEmpty ||
                                    bytes.isEmpty ||
                                    _dateController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please fill all fields.'),
                                    ),
                                  );
                                  return;
                                }
                                ProfileInfo profileInfo = ProfileInfo();
                                String? userId = await profileInfo.getId();
                                context.read<ItemBloc>().add(
                                  PostItemRequested(
                                    item: ItemEntityPost(
                                      user_id: userId ?? '',
                                      item_name: _nameController.text,
                                      desc: _descController.text,
                                      location: _locationController.text,
                                      item_image:
                                          bytes, // <-- Pass bytes, not string
                                      date: _dateController.text,
                                      isLost: isLost,
                                      isResolved: false,
                                    ),
                                  ),
                                );
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child:
                          _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                isLost ? 'POST LOST ITEM' : 'POST FOUND ITEM',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
