package lawonga.finlib.testdata

class UpcomingDividendsString {
    companion object {
        const val data = "<html>\n" +
            " <head></head>\n" +
            " <body>\n" +
            "  <table class=\"r_table1 only text2\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\"> \n" +
            "   <colgroup> \n" +
            "    <col width=\"18%\" span=\"4\"> \n" +
            "    <col width=\"18%\"> \n" +
            "    <col width=\"10%\"> \n" +
            "   </colgroup> \n" +
            "   <thead> \n" +
            "    <tr class=\"gry\"> \n" +
            "     <th class=\"str\" align=\"left\" scope=\"col\">Ex-Dividend Date</th> \n" +
            "     <th class=\"str\" align=\"left\" scope=\"col\">Declaration Date</th> \n" +
            "     <th class=\"str\" align=\"left\" scope=\"col\">Record Date</th> \n" +
            "     <th class=\"str\" align=\"left\" scope=\"col\">Payable Date</th> \n" +
            "     <th class=\"str\" align=\"left\" scope=\"col\">Dividend Type</th> \n" +
            "     <th class=\"str\" align=\"right\" scope=\"col\">Amount</th> \n" +
            "    </tr> \n" +
            "   </thead> \n" +
            "   <tfoot> \n" +
            "    <tr class=\"gry\"> \n" +
            "     <td colspan=\"6\">Dividends in CAD unless otherwise noted</td> \n" +
            "    </tr> \n" +
            "   </tfoot> \n" +
            "   <tbody> \n" +
            "    <tr class=\"hr\"> \n" +
            "     <td colspan=\"6\"></td> \n" +
            "    </tr> \n" +
            "    <tr> \n" +
            "     <td>02/14/2018</td> \n" +
            "     <td>02/06/2018</td> \n" +
            "     <td>02/15/2018</td> \n" +
            "     <td>02/28/2018</td> \n" +
            "     <td>Cash Dividends</td> \n" +
            "     <td align=\"right\">CAD 0.136</td> \n" +
            "    </tr> \n" +
            "    <tr class=\"hr\"> \n" +
            "     <td colspan=\"6\"></td> \n" +
            "    </tr> \n" +
            "   </tbody> \n" +
            "  </table> \n" +
            "  <script type=\"text/javascript\">\n" +
            "  \n" +
            "function onPageLoad(){\t\t\n" +
            "\t\t\$('tbody.tableaccordion').each(\n" +
            "\t\t\tfunction() { \n" +
            "\t\t\t//\$(this).children('tr:first').addClass(\"selected\");\n" +
            "\t\t\t\$(this).children('tr').not(\".selected, .thdr\").css('display', 'none');\n" +
            "\t\t\t}\n" +
            "\t\t);\n" +
            "\t\t\n" +
            "\t}\n" +
            "\n" +
            "var theIndex = \$.browser.msie&&\$.browser.version<=8?1:2;\n" +
            "var nodeIndex = \$.browser.msie&&\$.browser.version<=8?0:1;\n" +
            "\n" +
            "//var theIndex = 2;\n" +
            "//var nodeIndex =1;\n" +
            "function onSinClick(obj){\n" +
            "\t\tvar t = obj.getAttribute(\"opened\");\t\t\n" +
            "\t\tvar parent = obj.parentNode;\t\t\n" +
            "\t\tvar elements = parent.childNodes;\t\t\t\n" +
            "\t\tif(t=='true'){\n" +
            "\t\t\tobj.setAttribute(\"opened\",\"false\");\t\t\t\t\n" +
            "\t\t\tobj.childNodes[nodeIndex].childNodes[0].setAttribute('src','//performance.morningstar.com/perform/static/common/img/acc_close.gif');\n" +
            "\t\t\tvar position=0;\t\t\n" +
            "\t\t\tfor(var i=theIndex;i<elements.length;i++){\t\t\t\t\t\n" +
            "\t\t\t\t\tif(elements[i].nodeType=='1'){\t\t\t\t\t\n" +
            "\t\t\t\t\t\telements[i].style.display=\"none\";\t\t\t\t\t\t\t\t\t\t\n" +
            "\t\t\t\t\t}\t\n" +
            "\t\t\t}\t\t\n" +
            "\t\t}else{\n" +
            "\t\t\tobj.setAttribute(\"opened\",\"true\");\n" +
            "\t\t\tobj.childNodes[nodeIndex].childNodes[0].setAttribute('src','//performance.morningstar.com/perform/static/common/img/acc_open.gif');\t\t\t\n" +
            "\t\t\tvar position=0;\t\t\n" +
            "\t\t\tfor(var i=theIndex;i<elements.length;i++){\t\t\t\t\t\n" +
            "\t\t\t\t\tif(elements[i].nodeType=='1'){\t\t\t\t\t\n" +
            "\t\t\t\t\t\telements[i].style.display=\"\";\t\t\t\t\n" +
            "\t\t\t\t\n" +
            "\t\t\t\t\t}\n" +
            "\t\t\t\t\t\n" +
            "\t\t\t}\t\n" +
            "\t\t}\t\t\n" +
            "}\n" +
            "\t\t\t\t\t\n" +
            "\$(document).ready(function(){\t\n" +
            "\tonPageLoad();\n" +
            "\t//setTimeout(function(){ onPageLoad();},1200);\n" +
            "\t//event.preventDefault();\t\t\t\t\t  \t\t    \t \n" +
            "});\n" +
            "</script>\n" +
            " </body>\n" +
            "</html>"
    }
}
