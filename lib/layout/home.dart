import 'package:divly/layout/performance_chart.dart';
import 'package:divly/layout/portfolio.dart';
import 'package:divly/model/company.dart';
import 'package:divly/model/enum/main_tabs.dart';
import 'package:divly/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  MainTabs activeTab;
  int index = 0;
  SearchBar _searchBar;
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _searchBar = new SearchBar(
      setState: setState,
      onSubmitted: _performSearch,
      buildDefaultAppBar: buildAppBar
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      appBar: _searchBar.build(context),
      body: new TabBarView(
        controller: _tabController,
        physics: new NeverScrollableScrollPhysics(),
        children: <StatefulWidget>[new MyPortfolio(), new PerformanceChart()]
      )
    );
  }

  /// Hit the network when we perform a search
  void _performSearch(String ticker) {
    CompanyDetails companyDetails = new CompanyDetails(companyTicker: ticker); // Todo hit the network
    Navigator.of(context).push(Routes.financialRoute(companyDetails));
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
