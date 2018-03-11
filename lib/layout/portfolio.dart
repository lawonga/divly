import 'package:divly/layout/list/company_listview.dart';
import 'package:divly/model/company.dart';
import 'package:flutter/material.dart';

class MyPortfolio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  List<Company> _companyList;

  @override
  void initState() {
    super.initState();
    updateList(getCompanyList());
  }

  void updateList(List<Company> _companyList) {
    setState(() {
      this._companyList = _companyList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
            child: new Container(
                child: new CompanyList(_companyList)
            )
        )
    );
  }

  List<Company> getCompanyList() {
    return <Company>[
      new Company(companyName: "Hello", companyTicker: "HELO", tickerPrice: 10.09),
      new Company(companyName: "Ajajaja", companyTicker: "BR-H", tickerPrice: 23.46),
      new Company(companyName: "Huhdeauhuehuae", companyTicker: "BR-L", tickerPrice: 23.23),
      new Company(companyName: "asdf", companyTicker: "TEST", tickerPrice: 234.34),
    ];
  }
}
