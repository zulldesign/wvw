

function sub1() {
    var d = document.getElementById("submn1");
    if (d.innerHTML == "") {
        var s = "<a href='managenews.aspx'>Insert News</a>";
        s += "<br/><a href='admdeletenews.aspx'>Delete or Change News</a>";
        d.innerHTML = s;
        document.getElementById("immexcp").src = "../images/nav-collapse.gif";
    }
    else {
        document.getElementById("immexcp").src = "../images/nav-expand.gif";
        d.innerHTML = "";
        
    }
}
function inscat() {
    var sel = document.fin.selcat;
    var tn = document.fin.selcat.selectedIndex;
    var t = sel.options[tn].value;
    document.fin.txtcat.value = t;
}
function valida() {
    var a = document.fin.txt.value;
    var b = document.fin.tit.value;
    if (a == "") {
        document.getElementById("attz").innerHTML = "<b style='color: red;'>write the text</b>";
        return false;
    }
    if (b == "") {
        document.getElementById("attztit").innerHTML = "<b style='color: red;'>write the title</b>";
        return false;
    }
    return true;
}
function boldfin() {
    //var t = window.prompt("Insert Text");
    var tb = document.getElementById("txtnews");

    if (document.selection) {
        var st = document.selection.createRange().text;
        var sel = document.selection.createRange();
        sel.text = "[B]" + st + "[/B]";
    } else if (typeof tb.selectionStart != 'undefined') {
        var before, after, selection;
        before = tb.value.substring(0, tb.selectionStart)
        selection = tb.value.substring(tb.selectionStart, tb.selectionEnd)
        after = tb.value.substring(tb.selectionEnd, tb.value.length)

        tb.value = String.concat(before, "[B]", selection, "[/B]", after)
    }
    tb.focus();
}
function sottolinfin() {
    // var t = window.prompt("Insert Text");
    var tb = document.getElementById("txtnews");

    if (document.selection) {
        var st = document.selection.createRange().text;
        var sel = document.selection.createRange();
        sel.text = "[U]" + st + "[/U]";
    } else if (typeof tb.selectionStart != 'undefined') {
        var before, after, selection;
        before = tb.value.substring(0, tb.selectionStart)
        selection = tb.value.substring(tb.selectionStart, tb.selectionEnd)
        after = tb.value.substring(tb.selectionEnd, tb.value.length)

        tb.value = String.concat(before, "[U]", selection, "[/U]", after)
    }
    tb.focus();
}
function italicfin() {
    // var t = window.prompt("Insert Text");
    var tb = document.getElementById("txtnews");

    if (document.selection) {
        var st = document.selection.createRange().text;
        var sel = document.selection.createRange();
        sel.text = "[I]" + st + "[/I]";
    } else if (typeof tb.selectionStart != 'undefined') {
        var before, after, selection;
        before = tb.value.substring(0, tb.selectionStart)
        selection = tb.value.substring(tb.selectionStart, tb.selectionEnd)
        after = tb.value.substring(tb.selectionEnd, tb.value.length)

        tb.value = String.concat(before, "[I]", selection, "[/I]", after)
    }
    tb.focus();
}

function imgfin() {
    //var t = window.prompt("Insert Text");
    //var u = window.prompt("Insert url");
    var tb = document.getElementById("txtnews");

    if (document.selection) {
        var st = document.selection.createRange().text;
        var sel = document.selection.createRange();
        sel.text = document.fcomm.txt.value += "[IMG SRC= ]";
    } else if (typeof tb.selectionStart != 'undefined') {
        var before, after, selection;
        before = tb.value.substring(0, tb.selectionStart)
        selection = tb.value.substring(tb.selectionStart, tb.selectionEnd)
        after = tb.value.substring(tb.selectionEnd, tb.value.length)

        tb.value = String.concat(before, "[IMG SRC= ]", selection, "", after)
    }
    tb.focus();

}

function httpfin() {
    //var t = window.prompt("Insert Text");
    //var u = window.prompt("Insert url");
    var tb = document.getElementById("txtnews");

    if (document.selection) {
        var st = document.selection.createRange().text;
        var sel = document.selection.createRange();
        sel.text = document.fcomm.txt.value += "[URL= ] [/URL]";
    } else if (typeof tb.selectionStart != 'undefined') {
        var before, after, selection;
        before = tb.value.substring(0, tb.selectionStart)
        selection = tb.value.substring(tb.selectionStart, tb.selectionEnd)
        after = tb.value.substring(tb.selectionEnd, tb.value.length)

        tb.value = String.concat(before, "[URL= ]", selection, "[/URL]", after)
    }
    tb.focus();

}