package lawonga.finlib.models

import java.util.*

data class Dividend(var declarationDate: Date,
                    var recordDate: Date,
                    var exDividendDate: Date,
                    var paymentDate: Date,
                    var amount: String) // Distribution dollar value per share, in string format (NOT PARSED)
