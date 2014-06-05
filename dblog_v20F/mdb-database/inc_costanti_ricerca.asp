<%
    'dBlog 2.0 CMS Open Source
%>
<%
    Dim Testo_Cerca, Errore_Ricerca_NonAbilitata, Errore_Ricerca_Minimo3car, Testo_Seguono_risultati, Ricerca_Articoli_per, Ricerca_Fotografie_per, Abilita_Evidenziatore

'---RICERCA
'Testo del form di ricerca
Testo_Cerca = "Cerca per parola chiave"
'Errore ricerca non abilitata
Errore_Ricerca_NonAbilitata = "La funzione di ricerca non è abilitata."
'Errore ricerca con minimo 3 caratteri
Errore_Ricerca_Minimo3car = "La parola cercata deve contenere almeno 3 caratteri, riprova."
'Introduzione ai risultati della ricerca
Testo_Seguono_risultati = "Di seguito gli articoli e le fotografie che contengono le parole richieste."
'Introduzione sezione di ricerca (articoli)
Ricerca_Articoli_per = "Ricerca articoli per"
'Introduzione sezione di ricerca (fotografie)
Ricerca_Fotografie_per = "Ricerca fotografie per"
'FLAG di abilitazione evidenziatore per le parole ricercate
Abilita_Evidenziatore = True
%>