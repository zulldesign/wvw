<script type="text/javascript" src="fckeditor.js"></script>
<script type="text/javascript">
	function save1(){
	  window.opener.document.forms['FormSorgente'].Testo.value = document.getElementById('EditorVisuale').value;
	  interval = window.setInterval("save2()",500);
	  return false;
	}

	function save2(){
	  window.opener.document.forms['FormSorgente'].Testo.value = document.getElementById('EditorVisuale').value;
	  self.close();
	}

	function FCKeditor_OnComplete( editorInstance )
	{
		var iCounter = 0 ;
		var oCombo = document.getElementById( 'cmbLanguages' ) ;
		for ( code in editorInstance.Language.AvailableLanguages )
		{
			AddComboOption( oCombo, editorInstance.Language.AvailableLanguages[code] + ' (' + code + ')', code ) ;
			iCounter++ ;
		}
		oCombo.value = editorInstance.Language.ActiveLanguage.Code ;
	}	

	function AddComboOption(combo, optionText, optionValue)
	{
		var oOption = document.createElement("OPTION") ;
	
		combo.options.add(oOption) ;
	
		oOption.innerHTML = optionText ;
		oOption.value     = optionValue ;
		
		return oOption ;
	}

	function ChangeLanguage( languageCode )
	{
		window.location.href = window.location.pathname + "?" + languageCode ;
	}
	</script>

<form id="Contenuto" name="Contenuto" method="post" onsubmit="return save1();">
	<select id="cmbLanguages" onchange="ChangeLanguage(this.value);">
	</select>
	<script type="text/javascript">
	var sLang ;
	if ( document.location.search.length > 1 )
		sLang = document.location.search.substr(1) ;
	
	var oFCKeditor = new FCKeditor( 'EditorVisuale' ) ;
	oFCKeditor.BasePath	= '/dblog/admin/fckeditor/' ;
	if ( sLang == null )
	{
		oFCKeditor.Config["AutoDetectLanguage"] = false ;
		oFCKeditor.Config["DefaultLanguage"]    = "it" ;
	}
	else
	{
		oFCKeditor.Config["AutoDetectLanguage"] = false ;
		oFCKeditor.Config["DefaultLanguage"]    = sLang ;
	}
	oFCKeditor.Value	= window.opener.document.forms['FormSorgente'].Testo.value;
	oFCKeditor.Create() ;
	</script>
<div align="right"><input type="submit" value="Importa"></div>
</form>
