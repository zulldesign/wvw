<%
    'dBlog 2.0 CMS Open Source
%>
<%
    Dim Abilita_PopupCommenti, Errore_Commenti_NonAbilitati, Errore_Commento_NonTrovato, Testo_Disclaimer_Commenti, Testo_Campo_Commento, Testo_Campo_Nome, Testo_Campo_EMailLink, Testo_Titolo_Conferma, Conferma_Commento_ricevuto, Testo_Commento_Visualizza, Errore_Commento_CampoObbligatorio_e_AutoreLoggato, Errore_Commento_Parametri, Testo_Commento_Riprova, Testo_Titolo_AreaCommenti, Testo_Parole_NonAmmesse, Abilita_NoFollow, Num_Max_UltimiCommenti, Num_Max_UltimiCommentiCaratteri, Num_Max_CaratteriCommento

'---COMMENTI
'FLAG di abilitazione popup commenti
Abilita_PopupCommenti = False
'Errore commenti non abilitati
Errore_Commenti_NonAbilitati = "I commenti sono disabilitati."
'Errore commento non trovato
Errore_Commento_NonTrovato = "Nessun commento trovato."
'Testo Disclaimer per l'invio
Testo_Disclaimer_Commenti = "<strong>Disclaimer</strong><br />L'indirizzo IP del mittente viene registrato, in ogni caso si raccomanda la buona educazione."
'Testo del campo Commento
Testo_Campo_Commento = "Testo (max 1000 caratteri)"
'Testo del campo Nome
Testo_Campo_Nome = "Nome"
'Testo del campo e-Mail / Link
Testo_Campo_EMailLink = "e-Mail / Link"
'Titolo pagina di conferma invio
Testo_Titolo_Conferma = "Conferma"
'Testo di conferma ricezione del commento
Conferma_Commento_ricevuto = "Il commento è stato inserito,"
'Testo Visualizza (nella conferma di ricezione)
Testo_Commento_Visualizza = "visualizza"
'Errore campo Commento obbligatorio
Errore_Commento_CampoObbligatorio_e_AutoreLoggato = "Il campo 'Commento' è obbligatorio e il suo mittente, se fa parte degli Autori di questo blog, deve essere autenticato,"
'Errore nel passaggio di parametri
Errore_Commento_Parametri = "Errore nel passaggio dei parametri,"
'Testo Riprova (nella conferma di invio)
Testo_Commento_Riprova = "riprova"
'Testo Titolo area commenti negli Articoli e Fotografie
Testo_Titolo_AreaCommenti = "Commenti"
'Elenco parole non ammesse (filtro) separate da virgole e senza spazi
Testo_Parole_NonAmmesse = "cazzo,figa,vaffanculo,stronzo,stronza,puttana,bastardo,minchia,troia"
'FLAG di abilitazione tag nofollow (per evitare lo spam nei commenti)
Abilita_NoFollow = True
'Numero di commenti da visualizzare tra gli ultimi commenti
Num_Max_UltimiCommenti = 3
'Numero di caratteri nel testo trailer degli ultimi commenti
Num_Max_UltimiCommentiCaratteri = 20
'Numero di caratteri confentiti nel testo del commento
Num_Max_CaratteriCommento = 1000
%>