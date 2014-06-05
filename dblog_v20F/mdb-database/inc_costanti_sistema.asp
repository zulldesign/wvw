<%
    'dBlog 2.0 CMS Open Source
    'Versione file 2.0.0
%>
<%
    Dim Nome_DataBase, Path_DirScrittura, Path_DirPublic, Path_Editor, Path_Template, Path_Skin, Abilita_LinkLog, Abilita_Commenti, Abilita_AvvisoCommenti, Abilita_Ricerca, Abilita_Sondaggio, Abilita_UtentiOnLine, Abilita_PiuLetti, Abilita_UltimiCommenti, Abilita_Citazione, Abilita_Fotografie, Server_SMTP, Mail_Ufficiale, Componente_Mail, Data_Prima_Pubblicazione

'---SISTEMA
'Nome del file database
Nome_DataBase = "dblog.mdb"
'PATH completo della directory in scrittura
Path_DirScrittura = "/mdb-database/"
'PATH completo dei file pubblici (immagini, documenti, zip, etc)
Path_DirPublic = "/public/"
'PATH completo dell'editor
Path_Editor = "/dblog/admin/fckeditor/"
'PATH completo del template HTML
Path_Template = "/dblog/template/standard/"
'PATH completo delle immagini che compongono il template
Path_Skin = "/dblog/template/standard/gfx/"
'FLAG di abilitazione per il Linklog
Abilita_LinkLog = True
'FLAG di abilitazione per i commenti
Abilita_Commenti = True
'FLAG di abilitazione per la notifica di ricezione di un commento
Abilita_AvvisoCommenti = False
'FLAG di abilitazione ricerca articoli/fotografie
Abilita_Ricerca = True
'FLAG di abilitazione sondaggio
Abilita_Sondaggio = True
'FLAG di abilitazione utenti online
Abilita_UtentiOnLine = True
'FLAG di abilitazione articoli/foto più letti
Abilita_PiuLetti = True
'FLAG di abilitazione ultimi commenti inseriti
Abilita_UltimiCommenti = True
'FLAG di abilitazione citazioni nell'intestazione
Abilita_Citazione = True
'FLAG di abilitazione fotografie nell'intestazione
Abilita_Fotografie = True
'Server SMTP
Server_SMTP = "mail.iltuodominioqui.it"
'Mittente delle mail automatiche
Mail_Ufficiale = "info@iltuodominioqui.it"
'Componente per l'invio delle mail (aspemail, cdonts, cdosys)
Componente_Mail = ""
'Data della prima pubblicazione del Blog (AAAAMMGG)
Data_Prima_Pubblicazione = "20051101"
%>