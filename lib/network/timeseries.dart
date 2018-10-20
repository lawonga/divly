import 'dart:async';

import 'package:divly/model/company.dart';
import 'package:divly/network/callback.dart';
import 'package:flutter/services.dart';

class CompanyDetailsRetriever {
  final MethodChannel methodChannel;
  final NetworkResultCallback resultCallback;

  CompanyDetailsRetriever(this.resultCallback, this.methodChannel);

  Future<Null> getCompany(String ticker, {int position}) async {
    CompanyDetails company;

    try {
      final Map<String, String> data = await methodChannel
        .invokeMethod("getTimeSeries", ticker);

      company = getTimeSeriesData(data);
      company.companyTicker = ticker; // This goes away later
    } on PlatformException catch (e) {
      company = new CompanyDetails();
      company.companyName = e.toString();
    }

    resultCallback.updateCompanyDetail(company, position: position);
  }

  CompanyDetails getTimeSeriesData(Map<String, String> data) {
    CompanyDetails company = new CompanyDetails();
    if (data.length > 0) {
      company.companyName = data["symbol"];
      company.tickerPrice = double.parse(data["recent_close"]).toString();
      company.setValid = false;
    } else {
      company.setValid = true;
    }

    return company;
  }
}
