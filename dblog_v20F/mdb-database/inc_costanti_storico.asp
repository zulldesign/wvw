<%
    'dBlog 2.0 CMS Open Source
%>
<%
    Dim Testo_Seguono_TuttiContributi_Sito, Testo_Seguono_TuttiContributi_Sezione, Testo_Paginazione, Testo_Seguono_TuttiLink_LinkLog, Num_Max_LinkPerPagina, Errore_Link_NonTrovato

'---STORICO
'Introduzione a tutti i contributi del sito
Testo_Seguono_TuttiContributi_Sito = "Di seguito tutti gli interventi pubblicati sul sito, in ordine cronologico.<br /> <br /> "
'Introduzione a tutti i contributi della sezione
Testo_Seguono_TuttiContributi_Sezione = "Di seguito gli interventi pubblicati in questa sezione, in ordine cronologico.<br /> <br /> "
'Testo paginazione
Testo_Paginazione = "Pagine"
'Introduzione a tutti i Link del LinkLog
Testo_Seguono_TuttiLink_LinkLog = "Di seguito tutti i Link pubblicati sul LinkLog, in ordine cronologico."
'Numero di link da visualizzare per pagina nello storico
Num_Max_LinkPerPagina = 20
'Errore link non trovato
Errore_Link_NonTrovato = "Nessun link trovato."
%>