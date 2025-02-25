import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/Posts/posts_screen.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/functions/order_functions.dart';
import 'package:foodistan/profile/user_profile.dart';
import 'package:foodistan/providers/user_data_provider.dart';
import 'package:foodistan/sizeConfig.dart';
import 'package:sizer/sizer.dart';
import '../scanner.dart';
import 'HomeScreenFile.dart';
import 'package:provider/provider.dart';

//Main screen contains bottom nav bar
//which contains all the main screens

class MainScreen extends StatefulWidget {
  int currentIndex;
  MainScreen({this.currentIndex = 0});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;

  PageController _pageController = PageController();
  TabController? tabController;

  @override
  void initState() {
    super.initState();

    Provider.of<UserDataProvider>(context, listen: false).getUserData();

    _pageController = PageController(initialPage: widget.currentIndex);
    // tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    //  bottom navbar fix
    tabController = TabController(
        length: 5, vsync: this, initialIndex: widget.currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  var screens = [
    HomeScreen(), //HomeScreenFile
    CartScreenMainLogin(),
    ScannerScreen(),
    UserProfile(),
    PostsScreen(),
  ];

  bottomAppBarController(value) {
    widget.currentIndex = value;
    _pageController.jumpToPage(value);
    tabController!.index = value;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //building context for SizeConfig
    SizeConfig().init(context);
    final Color selected = kYellow;
    final Color unselected = Colors.grey;
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          child: TabBar(
            controller: tabController,
            labelColor: selected,
            unselectedLabelColor: unselected,
            isScrollable: false,
            enableFeedback: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Theme.of(context).primaryColor,
            onTap: (value) {
              bottomAppBarController(value);
            },
            indicator: UnderlineTabIndicator(
              insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 60.0),
              borderSide: BorderSide(color: selected, width: 1.5),
            ),
            tabs: [
              Tab(
                icon: Container(
                  height: 2.8.h,
                  child: widget.currentIndex == 0
                      ? Image.asset('assets/images/home-selectedIcon.png')
                      : Image.asset('assets/images/home-icon.png'),
                ),
                iconMargin: EdgeInsets.only(bottom: 4),
                text: 'Home',
              ),
              Tab(
                // icon: Icon(Icons.shopping_cart),
                icon: Container(
                  height: 2.8.h,
                  child: widget.currentIndex == 1
                      ? Image.asset('assets/images/cart-selectedIcon.png')
                      : Image.asset('assets/images/cart-icon.png'),
                ),

                iconMargin: EdgeInsets.only(bottom: 4),
                text: 'Cart',
              ),
              Tab(
                // icon: Icon(CupertinoIcons.qrcode_viewfinder),
                icon: Container(
                  height: 2.8.h,
                  child: widget.currentIndex == 2
                      ? Image.asset('assets/images/scanner-selectedIcon.png')
                      : Image.asset('assets/images/scanner-icon.png'),
                ),
                iconMargin: EdgeInsets.only(bottom: 4),
                text: 'Scan',
              ),
              Tab(
                // icon: Icon(CupertinoIcons.profile_circled),
                icon: Container(
                  height: 2.8.h,
                  child: widget.currentIndex == 3
                      ? Image.asset('assets/images/profile-selectedIcon.png')
                      : Image.asset('assets/images/profile-icon.png'),
                ),
                iconMargin: EdgeInsets.only(bottom: 4),
                text: 'Profile',
              ),
              Tab(
                // icon: Icon(CupertinoIcons.profile_circled),
                icon: Container(
                  height: 2.8.h,
                  child: widget.currentIndex == 4
                      ? Icon(Icons.person_pin_outlined)
                      : Icon(Icons.person_pin_outlined),
                ),
                iconMargin: EdgeInsets.only(bottom: 4),
                text: 'Posts',
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              bottomAppBarController(value);
            },
            controller: _pageController,
            children: screens,
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: OrderFunction().fetchCurrentOrder(userNumber),
            ),
          )
        ],
      ),
    );
  }
}
