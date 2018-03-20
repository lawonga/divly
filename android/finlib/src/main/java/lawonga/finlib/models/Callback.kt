package lawonga.finlib.models

interface Callback<in T> {
    fun onSuccess(details: T?)
    fun onFailure()
}
