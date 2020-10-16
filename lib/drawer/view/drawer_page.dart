import 'package:flutter/material.dart';
import 'package:share_ute/drawer/drawer.dart';
import 'package:share_ute/home/home.dart';
import 'package:share_ute/main_screen/main_screen.dart';
import 'package:share_ute/theme.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage(
      {@required this.drawerWidth,
        @required this.homeScreen,
        @required this.listener});

  // Chiều dài của drawer
  final double drawerWidth;

  final Widget homeScreen;

  final Function(DrawerItemIndex) listener;

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage>
    with SingleTickerProviderStateMixin {
  // AnimationController cho avatar icon và arrow icon
  AnimationController iconAnimationController;

  // ScrollController cho SingleChildScrollView
  ScrollController scrollController;

  bool isOpenedDrawer = true;

  @override
  void initState() {
    iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset <= 0.0) {
        // Drawer đang ở trạng thái opened hoàn toàn
        setState(() {
          isOpenedDrawer = true;
        });
        // Animation cho menu icon thành arrow icon
        iconAnimationController.animateTo(0.0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      } else if (scrollController.offset > 0 &&
          scrollController.offset < widget.drawerWidth.floor()) {
        // Drawer đang ở trạng thái cuộn
        iconAnimationController.animateTo(
            scrollController.offset / widget.drawerWidth,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      } else if (scrollController.offset != 0.0) {
        // Drawer đang ở trạng thái closed
        setState(() {
          isOpenedDrawer = false;
        });
        // Animation cho arrow icon thành menu icon
        iconAnimationController.animateTo(1.0,
            duration: const Duration(milliseconds: 0),
            curve: Curves.fastOutSlowIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    iconAnimationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          // Chiều dài = Chiều dài của thiết bị + chiều dài Drawer
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          // Độ cao = Độ cao thiết bị
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              // Drawer
              SizedBox(
                width: widget.drawerWidth,
                height: MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: iconAnimationController,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.translationValues(
                          scrollController.offset, 0, 0),
                      child: DrawerWidget(
                        iconAnimationController: iconAnimationController,
                        listener: (DrawerItemIndex index) {
                          drawerItemClick();
                          try {
                            widget.listener(index);
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                      ),
                    );
                  },
                ),
              ),

              // Phần dành cho màn hình chính
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  decoration: BoxDecoration(color: AppTheme.white,
                      // Hiển thi một shadow tại ranh giới giữa Drawer và Màn hình chính
                      // blurRadius: bán kính mờ cho BoxDecoration
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 24)
                      ]),
                  child: Stack(
                    children: [
                      // Nếu trạng thái drawer đang là opened, ta không cho người dùng tương tác
                      IgnorePointer(
                        ignoring: isOpenedDrawer == true || false,
                        child:  MainPage(
                          animation: iconAnimationController,
                          listener: (){
                            drawerItemClick();
                          },
                        ),
                      ),
                      // Khi drawer đang mở
                      // Chỉ cần người dùng cuộn nhẹ làm cho offset = 1, ta cũng sẽ gọi đóng mở drawer
                      if (isOpenedDrawer == true)
                        InkWell(
                          onTap: () {
                            drawerItemClick();
                          },
                        ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Xử lý sự kiện nhất arrow icon để đóng mở Drawer
  void drawerItemClick() {
    if (scrollController.offset != 0.0) {
      // Lúc này SingleChildScrollView đã cuộn qua bên trái rồi nên offset sẽ != 0
      // ta mở Drawer
      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
    } else {
      // Xem như chưa cuộn SingleChildScrollView  ta sẽ đóng Drawer lại
      scrollController.animateTo(widget.drawerWidth,
          duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
    }
  }
}
