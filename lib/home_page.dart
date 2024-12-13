import 'package:flutter/material.dart';

import 'item_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> itemData = List.empty(growable: true);
  TextEditingController itemController = TextEditingController();
  int selectedIndex = -1;
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List filteredItems = itemData
        .where((items) =>
            items.item.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    print("filter ${filteredItems}");
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          // backgroundColor: const Color.fromARGB(149, 225, 190, 231),
          backgroundColor: Colors.purple,
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            const  Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
          const    Text(
                "TODO LIST",
                style: TextStyle(
                    shadows: [
                      Shadow(
                          blurRadius: 5,
                          color: Colors.white,
                          offset: Offset(1.0, 1.0))
                    ],
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              CircleAvatar(radius: 25,
                child: Image.asset('asset/image/profile.png')
                // child: Text("S",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontStyle: FontStyle.normal,
                //       fontSize: 24,
                //     )),
              )
            ],
          )),
      body: Container(
        color: const Color.fromARGB(149, 225, 190, 231),
        width: screenWidth,
        height: screenHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 48,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                ),
                child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    cursorColor: Colors.black.withOpacity(
                      0.5,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none, // Removes default border
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontWeight: FontWeight.w600,
                          fontSize: 19),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Text(
                  "All ToDos",
                  style: TextStyle(
                      shadows: [
                        Shadow(blurRadius: 2, offset: Offset(1.0, 1.0))
                      ],
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal),
                ),
              ),
              itemData.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Center(
                        child: Text(
                          "No Items Yet...",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return addItems(index);
                        },
                      ),
                    ),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      elevation: 10,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                              controller: itemController,
                              cursorColor: Colors.black.withOpacity(
                                0.5,
                              ),
                              decoration: InputDecoration(
                                border:
                                    InputBorder.none, // Removes default border
                                hintText: 'Add new todo item',
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19),
                              )),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  FloatingActionButton(
                    onPressed: () {
                      String name = itemController.text;
                      if (name.isNotEmpty) {
                        setState(() {
                          //add item of list
                          itemData.add(Item(item: name));
                          itemController.text = '';
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              showCloseIcon: true,
                              content: const Text(
                                'Sucessfully added your item',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: Colors.purple.shade400,
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        });
                      }
                    },
                    backgroundColor: Colors.purple.shade400,
                    child: const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 2,
                          color: Colors.black,
                          offset: Offset(1.0, 1.0),
                        )
                      ],
                    ),
                  )
                ],
              ),
              // SizedBox(height: 20,),
              //  Row(mainAxisAlignment: MainAxisAlignment.center,
              //    children: [
              //      Container(
              //       height: 50,width: 90,
              //        decoration: BoxDecoration(
              //             color: Colors.purple.shade400,
              //             borderRadius: BorderRadius.circular(10)),
              //        child: InkWell(
              //             onTap: () {
              //               String name = itemController.text;
              //         if (name.isNotEmpty) {
              //           setState(() {
              //             //add item of list
              //             itemData.add(Item(item: name));
              //             itemController.text = '';
              //             ScaffoldMessenger.of(context).showSnackBar(
              //               SnackBar(
              //                 showCloseIcon: true,
              //                 content: const Text(
              //                   'Sucessfully added your item',
              //                   style: TextStyle(
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.bold),
              //                 ),
              //                 backgroundColor: Colors.purple.shade400,
              //                 duration: const Duration(seconds: 5),
              //               ),
              //             );

              //           });
              //         }
              //       },
              //             // backgroundColor: Colors.purple.shade400,
              //             child:
              //          const   Center(
              //               child: const Text(
              //                 'Save',
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 22,
              //                     fontWeight: FontWeight.bold),
              //               ),
              //             ),
              //           ),
              //      ),
              //         SizedBox(width: 20,),
              //          Container(height: 50,width: 90,
              //            decoration: BoxDecoration(
              //             color: Colors.purple.shade400,
              //             borderRadius: BorderRadius.circular(10)),
              //            child: InkWell(
              //              child: FloatingActionButton(
              //               onPressed: () {
              //                 String name = itemController.text;
              //                 if (name.isNotEmpty) {
              //                   setState(() {
              //                     itemData[selectedIndex].item = name;
              //                     selectedIndex=-1;
              //                     itemController.text = '';
              //                     ScaffoldMessenger.of(context).showSnackBar(
              //                       SnackBar(
              //                         showCloseIcon: true,
              //                         content: const Text(
              //                           'Sucessfully edit your item',
              //                           style: TextStyle(
              //                               color: Colors.white,
              //                               fontWeight: FontWeight.bold),
              //                         ),
              //                         backgroundColor: Colors.purple.shade400,
              //                         duration: const Duration(seconds: 5),
              //                       ),
              //                     );

              //                   });
              //                 }
              //               },
              //               backgroundColor: Colors.purple.shade400,
              //               child:
              //               const Text(
              //               'Edit',
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 22,
              //                   fontWeight: FontWeight.bold),
              //             ),

              //                                    ),
              //            ),
              //          ),
              //    ],
              //  )
            ],
          ),
        ),
      ),
    );
  }

  Widget addItems(int index) {
    List filteredItems = itemData
        .where((items) =>
            items.item.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8), // Spacing between items
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ListTile(
            leading: GestureDetector(
                onTap: () {
                  setState(() {
                    itemData[index].isDone = !itemData[index].isDone;
                    print(itemData[index].isDone);
                  });
                },
                child: Icon(
                  itemData[index].isDone
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  size: 32,
                  color: Colors.purple.shade300,
                )),
            title: Text(
              filteredItems[index].item,
              style: TextStyle(
                decoration:
                    filteredItems[index].isDone ? TextDecoration.lineThrough : null,
                decorationColor: Colors.black.withOpacity(0.7),
                fontSize: 22,
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: SizedBox(
              width: 70,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      itemController.text = itemData[index].item;
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 34,
                      color: Colors.green,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        //delete item
                        itemData.removeAt(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            showCloseIcon: true,
                            content: const Text(
                              'Sucessfully deleted your item',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.purple.shade400,
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      });
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 34,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
