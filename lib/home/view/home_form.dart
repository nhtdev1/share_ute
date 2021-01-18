import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/document/view/document_page.dart';
import 'package:share_ute/home/widgets/widgets.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:share_ute/post/post.dart';
import 'package:share_ute/post_notification/post_notification.dart';
import 'package:share_ute/recent_post/recent_post.dart';
import 'package:share_ute/search/search.dart';
import 'package:share_ute/theme.dart';
import 'package:share_ute/upgrade/upgrade.dart';
import 'package:share_ute/views/folder_page.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeForm());
  }

  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppTheme.nearlyWhite,
        body: BlocListener<NotificationCubit, NotificationState>(
          listener: (context, state) {
            // When a new post is created, NotificationState will notify this
            // to home_dart and it redirect to DocumentPage
            if (state.status == NotificationStatus.newPostCreated) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.blue,
                    behavior: SnackBarBehavior.fixed,
                    elevation: 10.0,
                    content: Text('Tạo bài đăng thành công'),
                    action: SnackBarAction(
                      label: 'Xem',
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(context, DocumentPage.route());
                      },
                    ),
                  ),
                );
            }

            if (state.status == NotificationStatus.premiumRequested) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.blue,
                    behavior: SnackBarBehavior.fixed,
                    elevation: 10.0,
                    content: Text('Chỉ dành cho tài khoản premium'),
                    action: SnackBarAction(
                      label: 'Nâng cấp',
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(context, UpgradePage.route());
                      },
                    ),
                  ),
                );
            }

            if (state.status == NotificationStatus.newReportCreated) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    elevation: 10.0,
                    backgroundColor: Colors.blue,
                    behavior: SnackBarBehavior.fixed,
                    content: Text(
                      'Báo cáo của bạn đã được ghi lại',
                    ),
                  ),
                );
            }

            if (state.status == NotificationStatus.recentPostAdded) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    elevation: 10.0,
                    backgroundColor: Colors.blue,
                    behavior: SnackBarBehavior.fixed,
                    content: Text(
                      'Đã thêm bài viết vào thư mục gần đây',
                    ),
                  ),
                );
            }

            if (state.status == NotificationStatus.currentPostChanged) {
              Navigator.push(context, DocumentPage.route());
            }
          },
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                // SliverAppBar custom SearchBar
                SliverAppBar(
                  iconTheme: IconThemeData(color: Colors.grey),
                  toolbarHeight: 80,
                  pinned: innerBoxIsScrolled == true ? false : true,
                  floating: true,
                  backgroundColor: Colors.white,
                  title: Container(
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      child: Container(
                        height: 45,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: InkWell(
                                child: TextFormField(
                                  enabled: false,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'WorkSans',
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Tìm kiếm tài liệu của bạn",
                                    border: InputBorder.none,
                                  ),
                                ),
                                onTap: () {
                                  final posts = context
                                      .read<PostNotificationCubit>()
                                      .state
                                      .posts;
                                  showSearch(
                                    context: context,
                                    delegate: SearchPage(
                                        searchCubit: context.read<SearchCubit>()
                                          ..fetchedPosts(posts)),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ];
            },
            body: Container(
              child: PageView(
                controller: _pageController,
                children: [
                  PostPage(),
                  RecentPostPage(),
                  MyFolderPage(),
                ],
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppTheme.notWhite,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          currentIndex: currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Trang chủ',
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Gần đây',
              icon: Icon(Icons.history_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Thư mục',
              icon: Icon(Icons.folder_outlined),
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
        ),
        drawer: DrawerWidget(),
        floatingActionButton: FloatingButtonWidget(),
      ),
    );
  }
}
