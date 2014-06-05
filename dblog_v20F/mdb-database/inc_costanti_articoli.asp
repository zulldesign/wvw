<%
    'dBlog 2.0 CMS Open Source
    'Versione file 2.0.0
%>
<%
    Dim Num_Max_Articoli, Errore_Articolo_NonTrovato, Testo_Catalogati_Mese, Testo_Ultimi_Commenti, Abilita_Trailer, Tag_Trailer, Link_Trailer, Link_InvertiOrdineCronologia, Num_Max_ArticoliPerPagina, Testo_PlayerFlash_Necessario

'---ARTICOLI
'Numero di articoli da visualizzare in Home Page
Num_Max_Articoli = 15
'Errore articolo non trovato
Errore_Articolo_NonTrovato = "Nessun articolo trovato."
'Testo catalogo per mese
Testo_Catalogati_Mese = "Catalogati per mese:"
'Testo elenco ultimi commenti
Testo_Ultimi_Commenti = "Ultimi commenti:"
'FLAG di abilitazione per i Trailer
Abilita_Trailer = True
'Tag interno per definire la fine del Trailer
Tag_Trailer = "[//]"
'Link per continuare la lettura dopo il Trailer
Link_Trailer = "Continua a leggere..."
'Link per invertire l'ordine della cronologia articoli nello storico
Link_InvertiOrdineCronologia = "inverti l'ordine"
'Numero di articoli da visualizzare per pagina nelle sezioni
Num_Max_ArticoliPerPagina = 10
'Testo di avviso: plug-in Flash necessario per il player Podcast
Testo_PlayerFlash_Necessario = "dBlog Podcast Player richiede il Plug-in Macromedia Flash 7"
%>
