import 'dart:async';

import 'package:divly/model/company.dart';
import 'package:divly/network/callback.dart';
import 'package:flutter/services.dart';

class CompanyDetailsRetriever {
  final MethodChannel methodChannel;
  final NetworkResultCallback resultCallback;

  CompanyDetailsRetriever(this.resultCallback, this.methodChannel);

  Future<Null> getCompany(int position, String ticker) async {
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

    resultCallback.updateCompanyDetail(position, company);
  }

  CompanyDetails getTimeSeriesData(Map<String, String> data) {
    CompanyDetails company = new CompanyDetails();
    company.companyName = data["symbol"];
    company.tickerPrice = double.parse(data["recent_close"]);

    return company;
  }

}
