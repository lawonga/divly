import 'package:divly/layout/listitem/company_item.dart';
import 'package:divly/model/company.dart';
import 'package:flutter/material.dart';

class CompanyList extends StatelessWidget {
  final List<Company> _companyList;

  CompanyList(this._companyList);

  @override
  Widget build(BuildContext context) {
    return new ListView(
        children: getCompanyWidgetList(_companyList)
    );
  }

  List<Widget> getCompanyWidgetList(List<Company> companyList) {
    List<Widget> widgets = new List();

    for (var company in companyList) {
      var newCompanyWidget = new CompanyWidgetListItem(company: company);
      widgets.add(newCompanyWidget);
    }

    return widgets;
  }
}
