import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool isLost = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        backgroundColor: isLost ? Colors.red : Colors.grey[300],
                        foregroundColor: isLost ? Colors.white : Colors.black,
                      ),
                      child: Text(
                        'I Lost Something',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                        backgroundColor: !isLost ? Colors.green : Colors.white,
                        foregroundColor: !isLost ? Colors.white : Colors.black,
                      ),
                      child: Text(
                        'I Found Something',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text('Add Photo', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // TODO: Implement photo picker
                },
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.5,
                      style:
                          BorderStyle
                              .solid, // No dashed, but solid for simplicity
                    ),
                  ),
                  child: Center(
                    child: Column(
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
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text('Item Name'),
              SizedBox(height: 8),
              TextField(
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
                onTap: () {
                  // TODO: Implement date picker
                },
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement submit
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Text(
                    isLost ? 'POST LOST ITEM' : 'POST FOUND ITEM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
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
    );
  }
}
