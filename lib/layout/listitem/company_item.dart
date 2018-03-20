import 'package:divly/model/company.dart';
import 'package:divly/routes.dart';
import 'package:flutter/material.dart';

/// This holds the company item for our app. The purpose is to show the ticker, company name and current price
/// (perhaps the ~15 minute delay if there is one)
class CompanyWidgetListItem extends StatelessWidget {

  CompanyWidgetListItem({this.company});

  final CompanyDetails company;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
      child: new SizedBox(
        height: 72.0,
        child: new Card(
          child: new InkWell(
            onTap: () => _performClick(context, company),
            child: new Row(
              children: <Widget>[ // Horizontal
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[ // Vertical
                      new CompanyItemContents(text: company.companyTicker,
                        fontSize: 20.0,
                        edgeInsets: new EdgeInsets.only(left: 10.0, top: 10.0)),
                      new CompanyItemContents(text: company.companyName,
                        fontSize: 15.0,
                        edgeInsets: new EdgeInsets.only(left: 10.0, bottom: 10.0))
                    ]
                  )
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new CompanyItemContents(text: company.tickerPrice.toString(),
                        fontSize: 30.0,
                        edgeInsets: new EdgeInsets.only(right: 10.0, top: 15.0))
                    ]
                  )
                )
              ]
            )
          )
        )
      )
    );
  }

  void _performClick(BuildContext context, CompanyDetails company) {
    Navigator.of(context).push(Routes.financialRoute(company));
  }
}

class CompanyItemContents extends StatelessWidget {

  CompanyItemContents({this.text = "", this.fontSize = 10.0, EdgeInsets edgeInsets})
    : _edgeInsets = edgeInsets != null ? edgeInsets : new EdgeInsets.all(0.0);

  final String text;
  final double fontSize;
  final EdgeInsets _edgeInsets;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: this._edgeInsets,
      child: new Text(
        text,
        style: new TextStyle(
          fontSize: this.fontSize
        ))
    );
  }
}
