import 'package:flutter/material.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery_review.dart';
import 'package:foodistan/restuarant_screens/restaurant_overview.dart';
import 'package:foodistan/restuarant_screens/restuarant_delivery_menu.dart';
import 'package:foodistan/restuarant_screens/testRestaurantOverview.dart';
import 'package:foodistan/widgets/options.dart';

class TestRestaurantMain extends StatefulWidget {
  final restaurant_details;
  final vendorId;
  final vendorName;
  TestRestaurantMain({this.restaurant_details, this.vendorId, this.vendorName});

  @override
  _TestRestaurantMainState createState() => _TestRestaurantMainState();
}

class _TestRestaurantMainState extends State<TestRestaurantMain> {
  bool isDeliverySelected = false;
  bool isPickupSelected = false;
  bool isOverviewSelected = false;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    isDeliverySelected = true;
  }

  Widget build(BuildContext context) {
    final List<Widget> _childern = [
      DeliverySelectedWidget(
        // isDeliverySelected: false,
        restaurant_detail: widget.restaurant_details,
        vendorId: widget.vendorId,
        vendorName: widget.vendorName,
      ),
      PickupSelectedWidget(
        isPickupSelected: false,
        restaurant_detail: widget.restaurant_details,
        vendorId: widget.vendorId,
        vendorName: widget.vendorName,
      ),
      OverviewSelectedWidget(
        isOverviewSelected: false,
        restaurant_detail: widget.restaurant_details,
        vendorId: widget.vendorId,
        vendorName: widget.vendorName,
      ),
    ];

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.2,
      ),
      width: MediaQuery.of(context).size.width * 0.97,
      // height: MediaQuery.of(context).size.height * 9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15),
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      "${widget.restaurant_details['Name']}",
                      style: TextStyle(
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      "${widget.restaurant_details['Cuisines']}",
                      style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      "${widget.restaurant_details['Address']}",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.restaurant_details['Stars']}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.044,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              size: MediaQuery.of(context).size.width * 0.05,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Center(
                          child: Text(
                            "10+ Ratings",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.022,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
          Container(
            // margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.attach_money,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Cost for Two ${widget.restaurant_details['Cost']}",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.table_chart,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Seating Available",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            // decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey, width: 1),
            //     borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDeliverySelected = true;
                        isPickupSelected = false;
                        isOverviewSelected = false;
                      });
                      print(widget.restaurant_details);
                      print(widget.vendorId);
                      print(widget.vendorName);
                      onTabTapped(0);
                    },
                    child: Container(
                      // padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: isDeliverySelected == true
                              ? Colors.amber[100]
                              : Colors.white,
                          border: isDeliverySelected == true
                              ? Border.all(color: Colors.amber, width: 1)
                              : Border.all(color: Colors.white, width: 1),
                          borderRadius: isDeliverySelected == true
                              ? BorderRadius.circular(25)
                              : BorderRadius.circular(0)),
                      width: MediaQuery.of(context).size.width * 0.27,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.two_wheeler,
                              size: MediaQuery.of(context).size.width * 0.035,
                              color: isDeliverySelected == true
                                  ? Colors.black
                                  : Colors.grey),
                          Text(" Delivery",
                              style: isDeliverySelected == true
                                  ? TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035)
                                  : TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.033))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDeliverySelected = false;
                        isPickupSelected = true;
                        isOverviewSelected = false;
                      });
                      onTabTapped(1);
                    },
                    child: Container(
                      // padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: isPickupSelected == true
                              ? Colors.amber[100]
                              : Colors.white,
                          border: isPickupSelected == true
                              ? Border.all(color: Colors.amber, width: 1)
                              : Border.all(color: Colors.white, width: 1),
                          borderRadius: isPickupSelected == true
                              ? BorderRadius.circular(25)
                              : BorderRadius.circular(0)),
                      width: MediaQuery.of(context).size.width * 0.27,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.food_bank,
                              size: MediaQuery.of(context).size.width * 0.035,
                              color: isPickupSelected == true
                                  ? Colors.black
                                  : Colors.grey),
                          widget.restaurant_details["Takeaway"]
                              ? Text(" Pickup",
                                  style: isPickupSelected == true
                                      ? TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035)
                                      : TextStyle(
                                          color: Colors.grey,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.033))
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDeliverySelected = false;
                        isPickupSelected = false;
                        isOverviewSelected = true;
                      });
                      onTabTapped(2);
                    },
                    child: Container(
                      // padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: isOverviewSelected == true
                              ? Colors.amber[100]
                              : Colors.white,
                          border: isOverviewSelected == true
                              ? Border.all(color: Colors.amber, width: 1)
                              : Border.all(color: Colors.white, width: 1),
                          borderRadius: isOverviewSelected == true
                              ? BorderRadius.circular(25)
                              : BorderRadius.circular(0)),
                      width: MediaQuery.of(context).size.width * 0.27,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.note_add_outlined,
                              size: MediaQuery.of(context).size.width * 0.035,
                              color: isOverviewSelected == true
                                  ? Colors.black
                                  : Colors.grey),
                          Text(" Overview",
                              style: isOverviewSelected == true
                                  ? TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035)
                                  : TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.033))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.only(top: 10),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.horizontal,
              children: [
                MyOptionListView(
                    iconColor: Colors.green,
                    myIcon: Icons.masks,
                    myText: "Wearing mask at all time"),
                MyOptionListView(
                    iconColor: Colors.pink,
                    myIcon: Icons.wash,
                    myText: "Washing hands at all times"),
                MyOptionListView(
                    iconColor: Colors.red,
                    myIcon: Icons.thermostat,
                    myText: "Temperature measured"),
                MyOptionListView(
                    iconColor: Colors.blue,
                    myIcon: Icons.masks,
                    myText: "Wearing mask at all time"),
                MyOptionListView(
                    iconColor: Colors.orange,
                    myIcon: Icons.masks,
                    myText: "Wearing mask at all time"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            height: MediaQuery.of(context).size.height * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromRGBO(226, 55, 68, 1),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              "OFFER",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.027,
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.white,
                            thickness: 1,
                            width: 1,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "20% OFF UPTO ₹300",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "USE MASTERCARD100 | ABOVE ₹100",
                                style: TextStyle(
                                    fontSize: 5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "Terms and Condition Applies",
                                style: TextStyle(
                                    fontSize: 5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromRGBO(132, 194, 37, 1),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              "OFFER",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.027,
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.white,
                            thickness: 1,
                            width: 1,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "20% OFF UPTO ₹300",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "USE MASTERCARD100 | ABOVE ₹100",
                                style: TextStyle(
                                    fontSize: 5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "Terms and Condition Applies",
                                style: TextStyle(
                                    fontSize: 5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          )
                        ]),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: _childern[_currentIndex],
          )
        ],
      ),
    );
  }

// Fuction to set _Tab Review
  void onTabTapped(int index) {
    if (!mounted) return;
    setState(() {
      print(index);
      _currentIndex = index;
    });
  }
}

class DeliverySelectedWidget extends StatefulWidget {
  final restaurant_detail;
  final vendorId;
  final vendorName;
  DeliverySelectedWidget(
      {Key? key,
      required this.restaurant_detail,
      required this.vendorId,
      required this.vendorName})
      : super(key: key);

  @override
  State<DeliverySelectedWidget> createState() => _DeliverySelectedWidgetState();
}

class _DeliverySelectedWidgetState extends State<DeliverySelectedWidget> {
  var isMenuSelected = true;
  var isReviewSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 11),
            margin: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(7.5),
                      child: Icon(Icons.search),
                    ),
                    hintText: "Search within the menu",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          width: 2.0,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          width: 2.0,
                        )))),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.57,
              // width: MediaQuery.of(context).size.width * 0.9,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.03,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("Menu selected");
                                setState(() {
                                  isReviewSelected = !isReviewSelected;
                                  isMenuSelected = !isMenuSelected;
                                });
                              },
                              child: Text(
                                "Menu",
                                style: isMenuSelected == true
                                    ? TextStyle(
                                        fontSize: 16,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w700,
                                      )
                                    : TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Reviews selected");
                                setState(() {
                                  isReviewSelected = !isReviewSelected;
                                  isMenuSelected = !isMenuSelected;
                                });
                              },
                              child: Text(
                                "Reviews",
                                style: isReviewSelected == true
                                    ? TextStyle(
                                        fontSize: 16,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w700,
                                      )
                                    : TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: isReviewSelected
                          ? Center(child: RestuarantDeliveryReview())
                          : Center(
                              child: RestuarantDeliveryMenu(
                                  vendor_id: widget.vendorId,
                                  vendorName: widget.vendorName),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PickupSelectedWidget extends StatefulWidget {
  final bool isPickupSelected;

  final restaurant_detail;
  final vendorName;
  final vendorId;

  PickupSelectedWidget({
    Key? key,
    required this.isPickupSelected,
    required this.restaurant_detail,
    required this.vendorId,
    required this.vendorName,
  }) : super(key: key);
  @override
  State<PickupSelectedWidget> createState() => _PickupSelectedWidgetState();
}

class _PickupSelectedWidgetState extends State<PickupSelectedWidget> {
  var isMenuSelected = true;
  var isReviewSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 11),
            margin: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(7.5),
                      child: Icon(Icons.search),
                    ),
                    hintText: "Search within the menu",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          width: 2.0,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          width: 2.0,
                        )))),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.57,
              // width: MediaQuery.of(context).size.width * 0.9,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.03,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("Menu selected");
                                setState(() {
                                  isReviewSelected = !isReviewSelected;
                                  isMenuSelected = !isMenuSelected;
                                });
                              },
                              child: Text(
                                "Menu",
                                style: isMenuSelected == true
                                    ? TextStyle(
                                        fontSize: 16,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w700,
                                      )
                                    : TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Reviews selected");
                                setState(() {
                                  isReviewSelected = !isReviewSelected;
                                  isMenuSelected = !isMenuSelected;
                                });
                              },
                              child: Text(
                                "Reviews",
                                style: isReviewSelected == true
                                    ? TextStyle(
                                        fontSize: 16,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w700,
                                      )
                                    : TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: isReviewSelected
                          ? Center(child: RestuarantDeliveryReview())
                          : Center(
                              child: RestuarantDeliveryMenu(
                                  vendor_id: widget.vendorId,
                                  vendorName: widget.vendorName),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OverviewSelectedWidget extends StatefulWidget {
  final bool isOverviewSelected;
  final restaurant_detail;
  final vendorId;
  final vendorName;
  OverviewSelectedWidget({
    Key? key,
    required this.isOverviewSelected,
    required this.restaurant_detail,
    required this.vendorId,
    required this.vendorName,
  }) : super(key: key);

  @override
  State<OverviewSelectedWidget> createState() => _OverviewSelectedWidgetState();
}

class _OverviewSelectedWidgetState extends State<OverviewSelectedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1.5,
      child: TestRestaurantOverview(),
      // RestaurantOverview(),
    );
  }
}