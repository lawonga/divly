package lawonga.finlib.models

import com.google.gson.*
import com.google.gson.annotations.SerializedName
import java.lang.reflect.Type
import java.text.SimpleDateFormat
import java.util.*

/**
 * Time series data for stocks indicate daily closing prices
 * Note that because we use gson we can write an extension function to do this
 */
class TimeSeries(private val resultObject: Data) {
    companion object {
        const val dataNotAvailable: String = "Data not available"
    }

    /**
     * Get the last updated data
     */
    fun recent(): Day {
        var mostRecent: Day? = Day()
        var mostRecentDate: Date? = null
        val formatter = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())

        for (entry in resultObject.timeSeriesDaily()) {
            val dateCandidate = formatter.parse(entry.key)
            if (mostRecentDate == null || mostRecentDate.before(dateCandidate)) {
                mostRecentDate = dateCandidate
                mostRecent = entry.value
            }
        }

        return if (mostRecent != null && mostRecentDate != null) {
            mostRecent.withDate(mostRecentDate)
        } else {
            Day()
        }
    }

    /**
     * The actual data class
     */
    data class Data(
        @SerializedName("Meta Data") var metaData: MetaData,
        @SerializedName("Time Series (Daily)") private var timeSeriesDaily: JsonObject? ) : BaseDetails() {
        fun timeSeriesDaily(): Map<String, Day> {
            val map: HashMap<String, Day> = HashMap()
            if (timeSeriesDaily == null || timeSeriesDaily!!.entrySet() == null) return map // This can happen if the server is spammed

            val gsonBuilder = GsonBuilder()
            gsonBuilder.registerTypeAdapter(Day::class.java, DayDeserializer())
            val gson = gsonBuilder.create()
            for ((date, dayObj) in timeSeriesDaily!!.entrySet()) {
                map[date] = gson.fromJson(dayObj, Day::class.java)
            }

            return map
        }
    }

    data class MetaData(
        @SerializedName("1. Information") var information: String,
        @SerializedName("2. Symbol") var symbol: String,
        @SerializedName("3. Last Refreshed") var lastRefreshed: String,
        @SerializedName("4. Output Size") var outputSize: String,
        @SerializedName("5. Time Zone") var timeZone: String
    )

    data class Day(
        @SerializedName("1. open") var open: String = dataNotAvailable,
        @SerializedName("2. high") var high: String = dataNotAvailable,
        @SerializedName("3. low") var low: String = dataNotAvailable,
        @SerializedName("4. close") var close: String = dataNotAvailable,
        @SerializedName("5. volume") var volume: String = dataNotAvailable) {

        lateinit var date: Date

        fun withDate(date: Date): Day {
            this.date = date

            return this
        }
    }

    class DayDeserializer : JsonDeserializer<Day> {
        override fun deserialize(json: JsonElement?, typeOfT: Type?, context: JsonDeserializationContext?): Day {
            if (json == null) return Day()

            val jsonObject = json.asJsonObject

            return Day(
                jsonObject.get("1. open").asString,
                jsonObject.get("2. high").asString,
                jsonObject.get("3. low").asString,
                jsonObject.get("4. close").asString,
                jsonObject.get("5. volume").asString
            )
        }
    }

}
