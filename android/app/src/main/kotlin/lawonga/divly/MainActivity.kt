package lawonga.divly

import android.os.Bundle
import com.github.kittinunf.fuel.core.FuelError
import com.github.kittinunf.fuel.core.Response
import com.github.kittinunf.fuel.httpGet
import com.github.kittinunf.fuel.rx.rx_responseString
import com.github.kittinunf.result.Result
import com.google.gson.Gson
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.schedulers.Schedulers
import lawonga.finlib.models.TimeSeries
import lawonga.finlib.net.url.alphavantage.TimeSeriesDaily

class MainActivity : FlutterActivity() {
    private val disposeBag: CompositeDisposable = CompositeDisposable()

    companion object {
        private const val CHANNEL = "lawonga.divly/time_series"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getTimeSeries" -> {
                    val ticker: String = call.arguments()
                    val url = TimeSeriesDaily(ticker).createUrl()
                    val disposable = url.httpGet()
                        .rx_responseString()
                        .observeOn(Schedulers.io())
                        .subscribeOn(Schedulers.io())
                        .subscribe({ response -> result.success(getTimeSeries(response)) })
                    disposeBag.add(disposable)
                }
            }
        }
    }

    private fun getTimeSeries(response: Pair<Response, Result<String, FuelError>>): HashMap<String, String> {
        return if (response.first.responseMessage == "OK") {
            parseTimeSeries(response.second)
        } else {
            HashMap()
        }
    }

    override fun onDestroy() {
        super.onDestroy()

        if (!disposeBag.isDisposed) {
            disposeBag.dispose()
        }
    }

    private fun parseTimeSeries(result: Result<String, FuelError>): HashMap<String, String> {
        val dataMap: HashMap<String, String> = HashMap()
        val gson = Gson()
        val gsonResult = gson.fromJson(result.component1(), TimeSeries.Data::class.java)

        val metaData = gsonResult?.metaData
        if (metaData != null) {
            val recent = TimeSeries(gsonResult).recent()

            dataMap["information"] = metaData.information
            dataMap["lastRefreshed"] = metaData.lastRefreshed
            dataMap["outputSize"] = metaData.outputSize
            dataMap["symbol"] = metaData.symbol
            dataMap["timeZone"] = metaData.timeZone
            dataMap["recent_open"] = recent.open
            dataMap["recent_close"] = recent.close
            dataMap["recent_high"] = recent.high
            dataMap["recent_low"] = recent.low
            dataMap["recent_volume"] = recent.volume
        }

        return dataMap
    }
}
