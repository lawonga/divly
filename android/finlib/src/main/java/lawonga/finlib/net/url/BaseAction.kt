package lawonga.finlib.net.url

abstract class BaseAction {
    abstract fun actionString(): String
    abstract fun paramEnd(): String

    fun createParam(): String {
        return actionString() + paramEnd()
    }
}
