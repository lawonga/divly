import 'dart:async';

import 'package:divly/layout/list/company_listview.dart';
import 'package:divly/model/company.dart';
import 'package:divly/network/callback.dart';
import 'package:divly/network/timeseries.dart';
import 'package:divly/platform/method_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPortfolio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> implements NetworkResultCallback, PlatformSpecific {
  List<CompanyDetails> _companyList = new List();
  static const methodChannel = const MethodChannel('lawonga.divly/time_series');
  CompanyDetailsRetriever retriever;
  CompanyList companyList;

  @override
  void initState() {
    super.initState();
    retriever = new CompanyDetailsRetriever(this, methodChannel);
    _initCompanyList();

    List<CompanyDetails> readState = PageStorage.of(context)?.readState(context, identifier: "COMPANY_LIST");

    if (readState == null) {
      _getCompanyList();
    } else {
      setState(() {
        _companyList = readState;
      });
    }
  }

  void _initCompanyList() {
    _companyList.add(new CompanyDetails(companyTicker: "AW-UN"));
    _companyList.add(new CompanyDetails(companyTicker: "SJR-B"));
    _companyList.add(new CompanyDetails(companyTicker: "ENF"));
    _companyList.add(new CompanyDetails(companyTicker: "CJT"));

    var reverseIterable = _companyList.reversed;
    var newCompanyList = reverseIterable.toList(growable: true);

    setState(() {
      _companyList = newCompanyList;
    });
  }

  @override
  Widget build(BuildContext context) {
    companyList = new CompanyList(_companyList);

    return new Scaffold(
      body: new RefreshIndicator(
        child: companyList,
        onRefresh: _performRefresh
      )
    );
  }

  Future<Null> _performRefresh() {
    _getCompanyList();

    var completer = new Completer();
    completer.complete();
    return completer.future;
  }

  void _getCompanyList() {
    retriever.getCompany(0, "AW-UN");
    retriever.getCompany(1, "SJR-B");
    retriever.getCompany(2, "ENF");
    retriever.getCompany(3, "CJT");
  }

  @override
  void updateCompanyDetail(int position, CompanyDetails company) {
    companyList.updateCompany(position, company);
    PageStorage.of(context).writeState(context, _companyList, identifier: "COMPANY_LIST");
  }

  @override
  MethodChannel getMethodChannel() {
    return methodChannel;
  }
}
