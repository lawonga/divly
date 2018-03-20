package lawonga.finlib.net.url

abstract class BaseUrl(private var param: String) {
    abstract fun url(): String

    fun create(): String {
        return url() + param
    }
}
