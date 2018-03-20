package lawonga.finlib.net.url.alphavantage

import lawonga.finlib.net.alphavantage.AlphaVantageAction

class TimeSeriesDaily(ticker: String): AlphaVantageAction(ticker) {

    override fun actionString(): String {
        return "TIME_SERIES_DAILY"
    }

}
