import 'package:divly/model/company.dart';
import 'package:flutter/material.dart';

class FinancialChart extends StatefulWidget {
  FinancialChart(this._company);

  final CompanyDetails _company;

  @override
  State<StatefulWidget> createState() => new _FinancialChart(_company);
}

class _FinancialChart extends State<FinancialChart> {

  _FinancialChart(this._company);

  final CompanyDetails _company;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 128.0,
      child: new Center(
        child: new Text("Chart goes here")
      )
    );
  }
}
