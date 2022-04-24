import 'dart:async';
import 'dart:io';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_trailer/core/enum/movie_type.dart';
import 'package:movie_trailer/features/trailers/presentation/store/movie_store.dart';
import 'package:movie_trailer/helpers/screen_template.dart';
import 'package:movie_trailer/helpers/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:movie_trailer/main.dart';
import 'widgets/movie_body_tab.dart';
import 'widgets/trailer_header.dart';
import 'widgets/bottom_navigation.dart';
import 'widgets/loading_message.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int selectedTopIndex = 0;
  int selectedBottomIndex = 0;
  PageController pageController = PageController();
  late ScrollController parentScrollController;

  late TabController movieTabController;
  DateTime? currentBackPressTime;
  var movieTabBars;

  @override
  void initState() {
    selectedTopIndex = 0;
    parentScrollController = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    movieTabBars = <Widget>[
      Tab(text: 'Top Rated'),
      Tab(text: 'Latest'),
      Tab(text: 'Now Playing'),
      Tab(text: 'UpComing'),
    ];
    var tabLength = movieTabBars.length;
    movieTabController = TabController(
        length: tabLength, vsync: this, initialIndex: selectedTopIndex)
      ..addListener(() => changeTopPageViewIndex(movieTabController.index));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var movieStore = getIt<MovieStore>();
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          return Future.value(false);
        }
        exit(1);
      },
      child: Material(
        child: Stack(
          children: [
            RefreshIndicator(
              color: Colors.white,
              displacement: 200,
              onRefresh: onRefresh,
              child: ScreenTemplate(
                body: Stack(
                  children: [
                    NestedScrollView(
                      controller: parentScrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          if (selectedBottomIndex == 0)
                            SliverAppBar(
                              title: TrailerHeader(),
                              toolbarHeight: 100.h,
                              backgroundColor: Colors.white,
                              pinned: true,
                              floating: true,
                              leadingWidth: 0,
                              forceElevated: innerBoxIsScrolled,
                              leading: Container(),
                              bottom: selectedBottomIndex == 0
                                  ? TabBar(
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.grey,
                                      labelStyle: TextStyle(
                                        fontSize: xSmallTextSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      indicatorColor: Colors.white,
                                      indicatorWeight: 4,
                                      tabs: movieTabBars,
                                      controller: movieTabController,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      isScrollable: true,
                                      unselectedLabelStyle: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  : PreferredSize(
                                      child: Container(),
                                      preferredSize: Size.fromHeight(0),
                                    ),
                            ),
                        ];
                      },
                      body: getBodyByBottomIndex(),
                    ),
                  ],
                ),
                bottomNavigationBar: BottomNavigation(
                  selectedBottomIndex: selectedBottomIndex,
                  changeBottomPageIndex: changeBottomPageIndex,
                ),
              ),
            ),
            Observer(builder: (context) {
              return Visibility(
                visible: movieStore.busy,
                child: LoadingMessage(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> onRefresh() async {}

  MovieType get currMovieType {
    switch (selectedTopIndex) {
      case 0:
        return MovieType.TopRated;
      case 1:
        return MovieType.Latest;
      case 2:
        return MovieType.NowPlaying;
      case 3:
        return MovieType.UpComing;
      default:
        return MovieType.TopRated;
    }
  }

  Widget getBodyByBottomIndex() {
    switch (selectedBottomIndex) {
      case 0:
        return MovieBodyTab(
          movieType: currMovieType,
          tabController: movieTabController,
          parentScrollCtrl: parentScrollController,
        );
      default:
        return Container(
          alignment: Alignment.center,
          child: Text('User screen'),
        );
    }
  }

  void changeTopPageViewIndex(int index) {
    if (index != selectedTopIndex) {
      setState(() {
        selectedTopIndex = index;
        if (pageController.hasClients)
          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
      });
    }
  }

  void changeBottomPageIndex(int index) {
    if (index != selectedBottomIndex) {
      parentScrollController.jumpTo(0);
      setState(() => selectedBottomIndex = index);
    }
  }
}
