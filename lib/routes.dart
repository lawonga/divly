import 'package:divly/layout/financial/financial.dart';
import 'package:divly/model/company.dart';
import 'package:flutter/material.dart';

class Routes {

  static MaterialPageRoute financialRoute(Company company) {
    return new AnimatedPageRoute(builder: (context) {
      return new CompanyFinancial(company);
    });
  }
}

class AnimatedPageRoute extends MaterialPageRoute {

  AnimatedPageRoute({WidgetBuilder builder}) : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> sAnimation,
    Widget child) {

    return new SlideTransition(
      position: new Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(animation),
      child: new FadeTransition(opacity: new Tween(begin: 0.0, end: 1.0).animate(animation), child: child) // child is the value returned by pageBuilder
    );
  }
}
