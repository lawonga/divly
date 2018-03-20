import 'package:divly/layout/listitem/company_item.dart';
import 'package:divly/model/company.dart';
import 'package:flutter/material.dart';

class CompanyList extends StatefulWidget {
  final List<CompanyDetails> _companyList;
  final companyListState;

  CompanyList(_companyList)
    :_companyList = _companyList,
      companyListState = new _CompanyListState(_companyList);

  void updateCompany(int position, CompanyDetails newCompany) {
    createState().updateCompany(position, newCompany);
  }

  @override
  _CompanyListState createState() => companyListState;
}

class _CompanyListState extends State<CompanyList> {
  List<CompanyDetails> _companyList;

  _CompanyListState(this._companyList);

  @override
  Widget build(BuildContext context) {
    var companyWidgetList = _getCompanyWidgetList(_companyList);
    return new ListView(
      children: companyWidgetList
    );
  }

  void updateCompany(int position, CompanyDetails newCompany) {
    setState(() {
      _companyList[position] = newCompany;
    });
  }

  List<Widget> _getCompanyWidgetList(List<CompanyDetails> companyList) {
    List<Widget> widgets = new List();

    for (var company in companyList) {
      var newCompanyWidget = new CompanyWidgetListItem(company: company);
      widgets.add(newCompanyWidget);
    }

    return widgets;
  }
}
