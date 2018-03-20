import 'package:flutter/material.dart';
import 'package:divly/model/company.dart';

class FinancialSummary extends StatefulWidget {
  FinancialSummary(this._company);

  final CompanyDetails _company;

  @override
  State<StatefulWidget> createState() => new _FinancialSummary(_company);
}

class _FinancialSummary extends State<FinancialSummary> {

  _FinancialSummary(this._company);

  final CompanyDetails _company;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 256.0,
      child: new Center(
        child: new Text("Financial details goes here")
      )
    );
  }
}
