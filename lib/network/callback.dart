import 'package:divly/model/company.dart';

abstract class NetworkResultCallback {

  void updateCompanyDetail(CompanyDetails company, {int position});

}
