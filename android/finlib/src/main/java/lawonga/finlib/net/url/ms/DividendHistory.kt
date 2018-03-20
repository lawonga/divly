package lawonga.finlib.net.url.ms

import lawonga.finlib.net.url.ms.MsAction

class DividendHistory(ticker: String): MsAction(ticker) {
    override fun actionString(): String {
        return "dividend-history"
    }
}
