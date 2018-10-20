import 'package:divly/layout/performance_chart.dart';
import 'package:divly/layout/portfolio.dart';
import 'package:divly/model/company.dart';
import 'package:divly/model/enum/main_tabs.dart';
import 'package:divly/network/callback.dart';
import 'package:divly/network/timeseries.dart';
import 'package:divly/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> with SingleTickerProviderStateMixin implements NetworkResultCallback {
  MainTabs activeTab;
  int index = 0;
  SearchBar _searchBar;
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const methodChannel = const MethodChannel('lawonga.divly/time_series');

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _searchBar = new SearchBar(setState: setState, onSubmitted: _performSearch, buildDefaultAppBar: buildAppBar);
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
            children: <StatefulWidget>[new MyPortfolio(), new PerformanceChart()]));
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text(widget.title),
        actions: [_searchBar.getSearchAction(context)],
        bottom: new TabBar(controller: _tabController, tabs: <Tab>[portfolioTab, performanceTab]));
  }

  /// Hit the network when we perform a search
  void _performSearch(String ticker) {
    CompanyDetailsRetriever retriever = new CompanyDetailsRetriever(this, methodChannel);
    retriever.getCompany(ticker);
  }

  @override
  void updateCompanyDetail(CompanyDetails company, {int position}) {
    if (company.valid) {
      Navigator.of(context).push(Routes.financialRoute(company));
    } else {
      
    }
  }

  Tab get performanceTab => new Tab(icon: new Icon(Icons.mail), text: "Performance Chart");

  Tab get portfolioTab => new Tab(icon: new Icon(Icons.loyalty), text: "My Portfolio");
}
