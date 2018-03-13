import 'dart:async';

import 'package:divly/layout/financial/financial_chart.dart';
import 'package:divly/layout/financial/financial_summary.dart';
import 'package:divly/model/company.dart';
import 'package:flutter/material.dart';

class CompanyFinancial extends StatefulWidget {
  final Company _company;

  CompanyFinancial(this._company);

  @override
  State<StatefulWidget> createState() => new _CompanyFinancial(_company);
}

class _CompanyFinancial extends State<CompanyFinancial> {
  final Company _company;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _CompanyFinancial(this._company);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(_company.companyName)
      ),
      body: new RefreshIndicator(
        onRefresh: _handleRefresh,
        child: new ListView(
          children: <Widget>[
            topRow,
            new FinancialChart(_company),
            new FinancialSummary(_company)
          ]
        )
      ));
  }

  Row get topRow {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            companyTicker,
            tickerPrice
          ],
        ),
        new Container(
          padding: const EdgeInsets.only(bottom: 13.0),
          child: new RaisedButton.icon(
            label: const Text('Portfolio'),
            icon: new Icon(Icons.add),
            onPressed: _handleAddCompany
          )
        )
      ]
    );
  }

  Container get companyTicker {
    return new Container(
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 5.0),
      child: new Text(_company.companyTicker,
        textAlign: TextAlign.left,
        style: new TextStyle(
          fontSize: 20.0
        ))
    );
  }

  Container get tickerPrice {
    return new Container(
      padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 10.0),
      child: new Text(_company.tickerPrice.toString(),
        textAlign: TextAlign.left,
        style: new TextStyle(
          fontSize: 30.0
        ))
    );
  }

  Future<Null> _handleRefresh() {
    final Completer<Null> completer = new Completer<Null>();

    // Network call goes here
    new Timer(const Duration(milliseconds: 500), () {
      completer.complete(null);
    });

    return completer.future.then((_) {
      _scaffoldKey.currentState?.showSnackBar(new SnackBar(content: const Text('Refresh Complete')));
    });
  }

  void _handleAddCompany() {
    String companyName = _company.companyName;
    _scaffoldKey.currentState?.showSnackBar(new SnackBar(content: new Text("$companyName added to stock portfolio")));
  }
}
