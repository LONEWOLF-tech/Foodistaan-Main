import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/accepted_order.dart';
import 'package:foodistan/customLoadingSpinner.dart';
import 'package:foodistan/profile/your_orders.dart';
import 'package:foodistan/widgets/order_history_widget.dart';
import 'package:sizer/sizer.dart';

class OrderFunction {
  final _firestore = FirebaseFirestore.instance;
  placeOrder(vendorId, vendorName, userNumber, items, totalPrice, paymentId,
      cartId, deliveryAddress, orderType) async {
    String id = _firestore.collection('live-orders').doc().id;
    DateTime time = DateTime.now();
    await _firestore.collection('live-orders').doc(id).set({
      'vendor-id': vendorId,
      'vendor-name': vendorName,
      'order-id': id,
      'items': items,
      'total-bill': totalPrice,
      'order-status': 'preparing',
      'customer-id': userNumber,
      'time': time,
      'payment-id': paymentId,
      'order-type': orderType,
      'delivery-address': deliveryAddress,
    }).then((value) {
      _firestore
          .collection('users')
          .doc(userNumber)
          .collection('orders')
          .doc(id)
          .set({
        'vendor-id': vendorId,
        'vendor-name': vendorName,
        'order-id': id,
        'items': items,
        'total-bill': totalPrice,
        'order-status': 'preparing',
        'time': time,
        'payment-id': paymentId,
        'live-order': true,
        'order-type': orderType,
        'delivery-address': deliveryAddress
      });
    });

    await _firestore
        .collection('cart')
        .doc(cartId)
        .collection('items')
        .get()
        .then((snapshots) {
      for (var item in snapshots.docs) {
        item.reference.delete();
      }
    });

    await _firestore.collection('cart').doc(cartId).update({'coupon-id': ''});
    return id;
  }

  fetchOrderData(orderId) async {
    var orderData;
    await _firestore.collection('live-orders').doc(orderId).get().then((value) {
      orderData = value;
    });
    return orderData;
  }

  Widget fetchAllOrders(userNumber) {
    ScrollController _controller = ScrollController();
    var stream = _firestore
        .collection('users')
        .doc(userNumber)
        .collection('orders')
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                // child: Text('Fetching Orders'),
                child: Container(
                    height: 15.h, width: 15.h, child: CustomLoadingSpinner()),
              );
            default:
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length == 0)
                  return Center(
                    child: Text('No Orders Yet'),
                  );
                else {
                  return ListView.builder(
                      physics: ScrollPhysics(),
                      // scrollDirection: Axis.vertical,
                      controller: _controller,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AcceptedOrder(
                                      orderData:
                                          snapshot.data!.docs[index].data()))),
                          child: OrderHistoryWidget(
                              orderData: snapshot.data!.docs[index].data()),
                        );
                      });
                }
              } else
                return Center(
                  child: Text('Error'),
                );
          }
        });
  }

  orderTime(timeStamp) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    final Timestamp timestamp = timeStamp;
    final date = timestamp.toDate().day.toString();
    final month = monthNames[timestamp.toDate().month - 1];
    final year = timestamp.toDate().year.toString();
    final hour = timestamp.toDate().hour.toString();
    final minutes = timestamp.toDate().minute.toString();

    return '$month $date, $year at $hour : $minutes';
  }

  Widget fetchCurrentOrder(userNumber) {
    var stream = FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .collection('orders')
        .where('live-order', isEqualTo: true)
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center();
            default:
              if (snapshot.hasData) {
                int totalDocs = snapshot.data!.docs.length;
                if (totalDocs > 0)
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        bool onlyOneOrder = totalDocs == 1 ? true : false;
                        var orderData = snapshot.data!.docs.first;
                        return GestureDetector(
                          onTap: () {
                            onlyOneOrder
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AcceptedOrder(
                                            orderData: orderData)))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Orders()));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.025,
                                    ),
                                    CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      backgroundColor: Colors.yellow.shade100,
                                      child: Container(
                                        height: 33,
                                        width: 33,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.circle,
                                          // borderRadius:
                                          //     BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Color(0xffFAC05E),
                                            width: 1,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.hot_tub,
                                            color: Color(0xffFAC05E),
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.025,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        onlyOneOrder
                                            ? Text(
                                                orderData['order-status']
                                                    .toString()
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              )
                                            : Text(
                                                'Preparing Your Orders',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                        if (onlyOneOrder)
                                          Text(orderData['vendor-name'])
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        // height:
                                        //     MediaQuery.of(context).size.height *
                                        //         0.05,
                                        // width:
                                        //     MediaQuery.of(context).size.width *
                                        //         0.3,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5.sp),
                                        ),
                                        child: Center(
                                          child: onlyOneOrder
                                              ? Text(
                                                  'Track your order',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : Text(
                                                  'Track your orders',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                else
                  return Center();
              } else {
                return Center();
              }
          }
        });
  }
}
