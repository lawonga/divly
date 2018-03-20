package lawonga.finlib.net.alphavantage

import lawonga.finlib.BuildConfig
import lawonga.finlib.net.url.BaseAction

abstract class AlphaVantageAction(private var ticker: String): BaseAction() {

    override fun paramEnd(): String {
        return "&symbol=TSX:${ticker.replace(".", "-")}&apikey=${BuildConfig.ALPHAVANTAGE_API_KEY}"
    }

    fun createUrl(): String {
        return AlphaVantageUrl(createParam()).create()
    }
}
