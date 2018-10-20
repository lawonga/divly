class CompanyDetails {
  bool valid = false;
  String companyTicker = "Loading...";
  String companyName = "Loading...";
  String tickerPrice = "Loading...";

  CompanyDetails({this.companyName = "Loading...", this.tickerPrice = "Loading...", this.companyTicker = "Loading..."});

  bool get getValid => null;

  set setValid(bool valid) {
    valid = valid;
  }

}
