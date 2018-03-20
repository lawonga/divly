package lawonga.finlib.net.url.ms

class UpcomingDividends(ticker: String) : MsAction(ticker) {
    override fun actionString(): String {
        return "upcoming-dividends"
    }
}
