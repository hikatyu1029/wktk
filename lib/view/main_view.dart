import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wktk/view/component/bottom_navigation_bar.dart';
import 'package:wktk/view/component/timeline_tile.dart';
import 'package:wktk/view/favorite_view.dart';
import 'package:wktk/view/post_view.dart';
import 'package:wktk/view/profile_view.dart';
import 'package:wktk/view/timeline_view.dart';
import 'package:wktk/view_model/time_line_view_model.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('wktk'),
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications),
                tooltip: '通知です')
          ],
          automaticallyImplyLeading: false,
        ),
        body: MultiProvider(providers: [
          ChangeNotifierProvider(create: (context) => TimeLineViewModel())
        ], child: MainViewBody()),
        floatingActionButton: Visibility(
          visible:
              Provider.of<BottomNavigationBarProvider>(context).currentIndex ==
                  0,
          child: FloatingActionButton(
            onPressed: () => showBarModalBottomSheet(
                context: context, builder: (context) => PostView()),
            child: const Icon(Icons.post_add, size: 32),
          ),
        ),
        bottomNavigationBar: const WktkBottomNavigationBar());
  }
}

class MainViewBody extends StatelessWidget {
  var currentTab = [const TimeLineView(), FavoriteView(), ProfileView()];

  MainViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return currentTab[
        Provider.of<BottomNavigationBarProvider>(context).currentIndex];
  }
}
