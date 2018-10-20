package lawonga.finlib

import com.github.kittinunf.fuel.android.extension.responseJson
import com.github.kittinunf.fuel.httpGet
import com.google.gson.Gson
import lawonga.finlib.models.TimeSeries
import lawonga.finlib.net.url.alphavantage.TimeSeriesDaily
import lawonga.finlib.testdata.AwString
import org.junit.Assert.*
import org.junit.Test
import java.util.Calendar.*

class TimeSeriesTest {

    @Test
    fun canGet() {
        val url = TimeSeriesDaily("AW-UN").createUrl()
        val (_, response, result) = url.httpGet().responseJson()

        val gson = Gson()
        val resultObject = gson.fromJson(result.component1()?.content, TimeSeries.Data::class.java)

        assertEquals("OK", response.responseMessage)
        assertNotSame("", result.get().content)
        assertNotNull(resultObject)
    }

    @Test
    fun canParseMetaData() {
        val data = AwString.data

        val gson = Gson()
        val resultObject = gson.fromJson(data, TimeSeries.Data::class.java)

        assertEquals("Daily Prices (open, high, low, close) and Volumes", resultObject.metaData.information)
        assertEquals("TSX:AW-UN", resultObject.metaData.symbol)
        assertEquals("2018-02-23", resultObject.metaData.lastRefreshed)
        assertEquals("Compact", resultObject.metaData.outputSize)
        assertEquals("US/Eastern", resultObject.metaData.timeZone)
    }

    @Test
    fun canParseTimeSeries() {
        val data = AwString.data

        val gson = Gson()
        val resultObject = gson.fromJson(data, TimeSeries.Data::class.java)
        val resultTimeSeries = resultObject.timeSeriesDaily()

        assertNotSame(0, resultTimeSeries.size)

        assertEquals("31.9800", resultTimeSeries["2018-02-14"]?.open)
        assertEquals("32.6000", resultTimeSeries["2018-02-20"]?.close)
        assertEquals("14898", resultTimeSeries["2018-02-08"]?.volume)
    }

    @Test
    fun canCreateTimeSeries() {
        val data = AwString.data

        val gson = Gson()
        val resultObject = gson.fromJson(data, TimeSeries.Data::class.java)
        val resultTimeSeries = TimeSeries(resultObject).recent()

        assertEquals("37853", resultTimeSeries.volume)

        val expectedDate = getInstance()
        expectedDate.set(YEAR, 2018)
        expectedDate.set(MONTH, JANUARY)
        expectedDate.set(DAY_OF_MONTH, 30)
        expectedDate.set(HOUR_OF_DAY, 0)
        expectedDate.set(MINUTE, 0)
        expectedDate.set(SECOND, 0)
        expectedDate.set(MILLISECOND, 0)

        assertEquals(expectedDate.time.time, resultTimeSeries.date.time)
    }

}
