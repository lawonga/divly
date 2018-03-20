package lawonga.finlib.net.ms

import lawonga.finlib.net.url.BaseUrl

internal class MsUrl(param: String) : BaseUrl(param) {

    override fun url(): String {
        return "http://performance.morningstar.com/perform/Performance/stock/"
    }

}
