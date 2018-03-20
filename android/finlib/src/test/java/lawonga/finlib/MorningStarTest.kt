package lawonga.finlib

import junit.framework.Assert.*
import lawonga.finlib.testdata.UpcomingDividendsString
import lawonga.finlib.net.url.ms.DividendHistory
import lawonga.finlib.net.url.ms.UpcomingDividends
import lawonga.finlib.net.parser.MsParser
import lawonga.finlib.testdata.PastDividendsString
import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import org.junit.Test
import java.io.IOException


/**
 * We have to test if the endpoints this library is hitting actually works!
 * MorningStar gives us the dividends in this format, from left to right:
 *
 * Ex-Dividend Date	Declaration Date	Record Date	Payable Date	Dividend Type	Amount
 * 14/02/2018   	06/02/2018	        15/02/2018	28/02/2018	    Cash Dividends	$0.136
 */
class MorningStarTest {

    @Test
    fun canGetUpcomingDividends() {
        val url = UpcomingDividends("AW.UN").createUrl()

        var doc: Document? = null

        try {
            doc = Jsoup.connect(url).get()
        } catch (e: IOException) {
            e.printStackTrace()
        }

        val elements = doc?.select("table > tbody > tr:not(.hr) > td")

        val cashDividends = elements!!.count { it.text() == "Cash Dividends" }

        assertNotSame(0, cashDividends)
    }

    @Test
    fun canGetDividendHistory() {
        val url = DividendHistory("AW.UN").createUrl()

        var doc: Document? = null

        try {
            doc = Jsoup.connect(url).get()
        } catch (e: IOException) {
            e.printStackTrace()
        }

        assertNotNull(doc)

        val elements = doc
                ?.getElementsByClass("tableaccordion")
                ?.get(0)
                ?.allElements
                ?.get(0)
                ?.select("tbody > tr > td")

        val cashDividends = elements!!.count { it.text() == "Cash Dividends" }

        assertNotSame(0, cashDividends)
    }

    @Test
    fun canParseUpcomingDividends(){
        val data = UpcomingDividendsString.data

        val doc = Jsoup.parse(data)

        val dividendData = MsParser().parseCurrentDividendFromMs(doc)

        assertNotNull(dividendData.recordDate)
        assertNotNull(dividendData.declarationDate)
        assertNotNull(dividendData.exDividendDate)
        assertNotNull(dividendData.paymentDate)
        assertNotNull(dividendData.amount)
    }

    @Test
    fun canParseDividendHistory(){
        val data = PastDividendsString.data

        val doc = Jsoup.parse(data)

        val dividendData = MsParser().parsePastDividendsFromMs(doc)

        assertEquals(61, dividendData.size)
    }

    @Test
    fun canCreateDividendDetails(){
        val past = PastDividendsString.data
        val upcoming = UpcomingDividendsString.data

        val companyDividendInfo = MsParser().getCompanyDividendInfo(Jsoup.parse(upcoming), Jsoup.parse(past))

        assertEquals(62, companyDividendInfo.dividends.size)
        assertEquals("CAD 0.136", companyDividendInfo.upcoming().amount)
        assertEquals(61, companyDividendInfo.past().size)
    }
}
