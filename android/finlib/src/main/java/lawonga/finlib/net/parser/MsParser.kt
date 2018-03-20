package lawonga.finlib.net.parser

import lawonga.finlib.models.Dividend
import lawonga.finlib.models.DividendDetails
import org.jsoup.nodes.Document
import org.jsoup.select.Elements
import java.text.SimpleDateFormat
import java.util.*
import kotlin.collections.ArrayList

/**
<td>02/14/2018</td>
<td>02/06/2018</td>
<td>02/15/2018</td>
<td>02/28/2018</td>
<td>Cash Dividends</td>
<td  align="right">CAD 0.136</td>
 */
class MsParser {
    private val formatter = SimpleDateFormat("MM/dd/yyyy", Locale.getDefault())

    /**
     * Individual dividend element
     */
    fun parseCurrentDividendFromMs(doc: Document): Dividend {
        val elements = doc.select("table > tbody > tr:not(.hr) > td")

        return parseElement(elements)
    }

    /**
     * A list of dividend elements
     */
    fun parsePastDividendsFromMs(doc: Document): List<Dividend> {
        val array = ArrayList<Dividend>()

        doc.getElementsByClass("tableaccordion")
            ?.forEach { element ->
                val e = element
                    ?.allElements
                    ?.get(0)
                    ?.select("tbody > tr > td")

                if (e != null) {
                    array.addAll(parseElements(e))
                }
            }

        return array
    }

    /**
     * Get company dividend info
     */
    fun getCompanyDividendInfo(current: Document, past: Document): DividendDetails {
        val currentDividends = parseCurrentDividendFromMs(current)
        val pastDividends = parsePastDividendsFromMs(past)

        val dividendList: MutableList<Dividend> = mutableListOf(currentDividends)
        dividendList.addAll(pastDividends)

        return DividendDetails(dividendList)
    }

    /**
     * Handy function for 1 element
     */
    private fun parseElement(elements: Elements): Dividend {
        return createDividend(elements, 0)
    }

    private fun parseElements(elements: Elements): List<Dividend> {
        val dividends: ArrayList<Dividend> = ArrayList()

        (elements.indices step 6).mapTo(dividends) {
            createDividend(elements, it)
        }

        return dividends
    }

    private fun createDividend(elements: Elements, it: Int): Dividend {
        return Dividend(
            formatter.parse(elements[it + 1].text()),
            formatter.parse(elements[it].text()),
            formatter.parse(elements[it + 2].text()),
            formatter.parse(elements[it + 3].text()),
            elements[it + 5].text()
        )
    }

}
