<%
    'dBlog 2.0 CMS Open Source
%>
<%
    Dim Abilita_ResizeASPNET, Num_ResizeASPNET_LarghezzaFotoThumbnail, Num_ResizeASPNET_LarghezzaFotoIntestazione, Num_ResizeASPNET_LarghezzaFotoGrande, Errore_Fotografia_NonTrovata, Testo_Seguono_Fotografie, Errore_Fotografie_NonTrovate, Errore_Categorie_NonTrovate, Num_Max_FotografiePerPagina

'---FOTOGRAFIE
'FLAG di abilitazione resize automatico delle foto thumbnail (diapositive), solo se l'hosting supporta ASP.NET
Abilita_ResizeASPNET = False
'Se il FLAG di abilitazione è attivo indica la larghezza della foto thumbnail (in pixel)
Num_ResizeASPNET_LarghezzaFotoThumbnail = 110
'Se il FLAG di abilitazione è attivo indica la larghezza della foto grande (in pixel)
Num_ResizeASPNET_LarghezzaFotoGrande = 450
'Se il FLAG di abilitazione è attivo indica la larghezza della foto nell'intestazione (in pixel)
Num_ResizeASPNET_LarghezzaFotoIntestazione = 450
'Errore fotografia non trovata
Errore_Fotografia_NonTrovata = "Nessuna fotografia trovata."
'Introduzione alle fotografie nella sezione
Testo_Seguono_Fotografie = "Di seguito le fotografie pubblicate in questa sezione, clicca sull'anteprima per visualizzare l'immagine ingrandita e la descrizione completa.<br /> <br /> "
'Errore fotografie non trovate
Errore_Fotografie_NonTrovate = "Nessuna fotografia nella categoria selezionata, sono invece disponibili:"
'Errore categoria non trovate
Errore_Categorie_NonTrovate = "Nessuna categoria trovata."
'Numero di fotografie da visualizzare per pagina nelle sezioni
Num_Max_FotografiePerPagina = 10
%>