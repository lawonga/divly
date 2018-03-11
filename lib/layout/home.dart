import 'package:divly/layout/performance_chart.dart';
import 'package:divly/layout/portfolio.dart';
import 'package:divly/model/enum/main_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  SearchBar _searchBar;
  MainTabs activeTab;
  int index = 0;
  TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _searchBar = new SearchBar(setState: setState, buildDefaultAppBar: buildAppBar);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: _searchBar.build(context),
        body: new TabBarView(
            controller: _tabController,
            children: <StatefulWidget>[new MyPortfolio(), new PerformanceChart()]
        )
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text(widget.title),
        actions: [_searchBar.getSearchAction(context)],
        bottom: new TabBar(
            controller: _tabController,
            tabs: <Tab>[portfolioTab, performanceTab]
        )
    );
  }

  Tab get performanceTab => new Tab(icon: new Icon(Icons.mail), text: "Performance Chart");

  Tab get portfolioTab => new Tab(icon: new Icon(Icons.loyalty), text: "My Portfolio");
}
