import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jihc_landf/src/features/home/data/models/itemModel.dart';
import 'package:jihc_landf/src/features/home/domain/entities/itemEntity.dart';
import 'package:jihc_landf/src/features/home/presentation/bloc/item_bloc.dart';
import 'package:jihc_landf/src/features/home/presentation/utils/filter.dart';
import 'package:jihc_landf/src/features/home/presentation/widgets/itemWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool squareLayout = true;
  Filter selectedFilter = Filter.all;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
    // Refresh items whenever HomePage opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ItemBloc>().add(FetchItems());
      }
    });
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
                search(),
                SizedBox(height: 20),
                filter(),
                SizedBox(height: 20),
                BlocBuilder<ItemBloc, ItemState>(
                  builder: (context, state) {
                    if (state is ItemLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ItemLoaded) {
                    } else if (state is ItemError) {
                      return Center(
                        child: Text(
                          'Failed to load items.',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      );
                    }
                    return BlocBuilder<ItemBloc, ItemState>(
                      builder: (context, state) {
                        if (state is ItemError) {
                          Center(child: Text('Error Fetching data'));
                        } else if (state is ItemLoading) {
                          Center(child: CircularProgressIndicator());
                        } else if (state is ItemLoaded) {
                          List<ItemEntity> filteredItems;
                          switch (selectedFilter) {
                            case Filter.lost:
                              filteredItems =
                                  state.items
                                      .where((item) => item.isLost)
                                      .toList();
                              break;
                            case Filter.found:
                              filteredItems =
                                  state.items
                                      .where((item) => !item.isLost)
                                      .toList();
                              break;
                            case Filter.all:
                              filteredItems = state.items;
                          }

                          return GridView.builder(
                            itemCount: filteredItems.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: squareLayout ? 2 : 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: squareLayout ? 0.6 : 3.5,
                                ),
                            itemBuilder: (context, index) {
                              final item = filteredItems[index];
                              return GestureDetector(
                                onTap: () {},
                                child:
                                    squareLayout
                                        ? itemSquare(context, item as ItemModel)
                                        : itemRectangle(
                                          context,
                                          item as ItemModel,
                                        ),
                              );
                            },
                          );
                        }
                        return Text('Something went wrong');
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row filter() {
    return Row(
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
    );
  }

  Row search() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: Row(
              children: [
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
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
    );
  }
}
