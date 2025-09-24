import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jihc_landf/src/features/home/data/models/itemModel.dart';
import 'package:jihc_landf/src/features/home/presentation/utils/filter.dart';
import 'package:jihc_landf/src/features/home/presentation/widgets/itemWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool squareLayout = true;
  Filter selectedFilter = Filter.all;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: InkWell(
                                onTap: () => {},
                                child: SvgPicture.asset(
                                  'assets/search.svg',
                                  width: 37,
                                  height: 37,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 25),
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage('assets/jihc_logo.png'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                squareLayout = true;
                              });
                            },
                            child: SvgPicture.asset(
                              squareLayout
                                  ? 'assets/square_layOut_act.svg'
                                  : 'assets/square_layOut.svg',
                              width: 30,
                              height: 30,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                squareLayout = false;
                              });
                            },
                            child: SvgPicture.asset(
                              !squareLayout
                                  ? 'assets/rectangle_layOut_act.svg'
                                  : 'assets/rectangle_layOut.svg',
                              width: 30,
                              height: 30,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(236, 237, 238, 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedFilter = Filter.all;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              width: 80,
                              decoration: BoxDecoration(
                                color:
                                    selectedFilter == Filter.all
                                        ? Color.fromRGBO(36, 138, 255, 1)
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),

                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        selectedFilter == Filter.all
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedFilter = Filter.lost;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              width: 80,
                              decoration: BoxDecoration(
                                color:
                                    selectedFilter == Filter.lost
                                        ? Color.fromRGBO(36, 138, 255, 1)
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),

                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  'Lost',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        selectedFilter == Filter.lost
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedFilter = Filter.found;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              width: 80,
                              decoration: BoxDecoration(
                                color:
                                    selectedFilter == Filter.found
                                        ? Color.fromRGBO(36, 138, 255, 1)
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),

                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                child: Text(
                                  'Found',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        selectedFilter == Filter.found
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GridView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: squareLayout ? 2 : 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: squareLayout ? 0.6 : 3,
                  ),
                  itemBuilder:
                      (context, index) =>
                          squareLayout
                              ? itemSquare(
                                ItemModel(
                                  item_id: '22',
                                  user_id: '22',
                                  item_name: 'Backpack',
                                  postType: 'lost',
                                  desc: 'Black Backpack with stripes',
                                  date: 'Jan 2 ',
                                  location: 'Canteen',
                                  item_image: 'assets/jihc_logo.png',
                                ),
                              )
                              : itemRectangle(
                                ItemModel(
                                  item_id: '22',
                                  user_id: '22',
                                  item_name: 'Backpack',
                                  postType: 'lost',
                                  desc: 'Black Backpack with stripes',
                                  date: 'Jan 2 ',
                                  location: 'Canteen',
                                  item_image: 'assets/jihc_logo.png',
                                ),
                              ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
