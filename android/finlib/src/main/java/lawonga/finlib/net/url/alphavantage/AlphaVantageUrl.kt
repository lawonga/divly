package lawonga.finlib.net.alphavantage

import lawonga.finlib.net.url.BaseUrl

internal class AlphaVantageUrl(param: String) : BaseUrl(param) {

    override fun url(): String {
        return "https://www.alphavantage.co/query?function="
    }

}
