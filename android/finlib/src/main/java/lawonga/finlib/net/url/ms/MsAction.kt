package lawonga.finlib.net.url.ms

import lawonga.finlib.net.ms.MsUrl
import lawonga.finlib.net.url.BaseAction

abstract class MsAction(private var ticker: String): BaseAction() {

    override fun paramEnd(): String {
        return ".action?&t=${ticker.replace("-", ".")}&region=ca&culture=en-US&cur=&ops=clear&ndec=10&y=5"
    }

    fun createUrl(): String {
        return MsUrl(createParam()).create()
    }
}
