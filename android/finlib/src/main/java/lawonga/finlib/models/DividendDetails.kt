package lawonga.finlib.models

data class DividendDetails(private var div: List<Dividend>): BaseDetails() { // Sorted by new --> old
    var dividends = div.sortedWith(Comparator { d1, d2 -> d2.declarationDate.compareTo(d1.declarationDate) })

    fun upcoming(): Dividend {
        return dividends.first()
    }

    fun past(): List<Dividend> {
        return dividends.subList(1, dividends.size)
    }

    class Deserializable {

    }
}
