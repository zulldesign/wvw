<%
    'dBlog 2.0 CMS Open Source
%>
<%
    Dim Testo_Path_Pannello, Testo_Introduzione_Login, Testo_Campo_UserID, Testo_Campo_Password, Testo_Pulsante_Login, Testo_UserID_Gia_Autenticata, Testo_Pannello_Benvenuto_UserID, Testo_Pannello_Benvenuto_Funzioni, Testo_Pannello_LinkMenu_Articoli, Testo_Pannello_LinkMenu_Fotografie, Testo_Pannello_LinkMenu_LinkLog, Testo_Pannello_LinkMenu_Upload, Testo_Pannello_LinkMenu_ElencoFile, Testo_Pannello_LinkMenu_Sondaggi, Testo_Pannello_LinkMenu_Citazioni, Testo_Pannello_LinkMenu_Stuff, Testo_Pannello_LinkMenu_Link, Testo_Pannello_LinkMenu_Configurazione, Testo_Pannello_LinkMenu_Manutenzione, Testo_Pannello_LinkMenu_Autori, Testo_Pannello_LinkMenu_Statistiche, Testo_Pannello_LinkMenu_HomePage, Testo_Pannello_LinkMenu_Logout, Testo_Sezione_Calendario, Testo_Sezione_Manutenzione, Testo_Sezione_Conversioni, Testo_Sezione_Upload, Testo_Sezione_Configurazione, Testo_Sezione_Articoli, Testo_Sezione_Autori, Testo_Sezione_Blog, Testo_Sezione_Classifica, Testo_Sezione_Citazioni, Testo_Sezione_Colori, Testo_Sezione_Commenti, Testo_Sezione_Condivise, Testo_Sezione_Fotografie, Testo_Sezione_LinkLog, Testo_Sezione_Homepage, Testo_Sezione_Immagini, Testo_Sezione_Intestazione, Testo_Sezione_Navigazione, Testo_Sezione_Pubblicazioni, Testo_Sezione_Ricerca, Testo_Sezione_Sistema, Testo_Sezione_Sondaggio, Testo_Sezione_Storico, Testo_Sezione_Statistiche, Testo_Sezione_Pannello, Testo_Sezione_ModeraCommenti, Testo_Sezione_Preview, Testo_Sezione_Link, Testo_Sezione_Orologio, Testo_Sezione_Stuff, Testo_Sezione_FileElenco, Testo_Sezione_FileCancella, Testo_Sezione_PreviewFotografia, Testo_Sezione_ElencoSezioni, Testo_Sezione_RinominaSezioni, Testo_Introduzione_Calendario, Testo_TornaAlMese, Testo_LinkChiudi, Testo_Introduzione_Manutenzione, Testo_DimensioniDB, Testo_Link_Compatta, Testo_Conferma_Compattazione, Testo_Conferma_BackupDatabase, Testo_Spiegazione_Compattazione, Testo_NomeFile_TabellaDBBackup, Testo_KbFile_TabellaDBBackup, Testo_EliminaFile_Conferma, Testo_Conferma_CancellazioneFileJavascript, Testo_Introduzione_Conversioni, Testo_RelazioneSmile, Testo_IntroduzioneTesti_Configurazione, Testo_Introduzione_Configurazione, Testo_Errore_FileCostanti_NonTrovato, Testo_Errore_FunzioneRiservataAdmin, Testo_SezioniDisponibili_Configurazione, Testo_Errore_PassaggioParametri, Testo_Conferma_ConfigurazioneModificata, Testo_Introduzione_ElencoFile, Testo_Scelta_FiltroFile, Testo_FiltroFile_Tutti, Testo_FiltroFile_Immagini, Testo_FiltroFile_Documenti, Testo_FiltroFile_Podcast, Testo_FiltroFile_ColonnaNome, Testo_FiltroFile_ColonnaKb, Testo_FiltroFile_TotaleFile, Testo_FiltroFile_IntroduzioneCancellazione, Testo_FiltroFile_ConfermaCancellazione, Testo_FiltroFile_NonConfermaCancellazione, Testo_Commenti_ConfermaCancellazione, Testo_Link_PaginaPrecedente, Testo_Introduzione_LinkAmici, Testo_Modulo_CampoContenuto, Testo_Modulo_SpiegazioneCampoContenuto, Testo_Modulo_SpiegazioneEditorHTML, Testo_Modulo_LinkEditorHTML, Testo_Modulo_PulsanteModifica, Testo_Modulo_PulsanteCancella, Testo_Modulo_PulsanteRicerca, Testo_Modulo_PulsanteAggiungi, Testo_Introduzione_Stuff, Testo_Stuff_ModificaABuonFine, Testo_LinkAmici_ModificaABuonFine, Testo_Stuff_LinkTornaIndietro, Testo_LinkAmici_LinkTornaIndietro, Testo_Introduzione_Orologio, Testo_Orologio_CampoOra, Testo_Orologio_CampoMinuti, Testo_Orologio_CampoSecondi, Testo_LinkSalva, Testo_Orologio_LinkOraAttuale, Testo_Introduzione_Upload, Testo_Modulo_FileDaCaricare, Testo_Modulo_PulsanteUpload, Testo_Spiegazione_Upload, Testo_Errore_Upload, Testo_Upload_EstensioniNonAbilitate, Testo_Link_RiprovaAzione, Testo_SceltaOppure, Testo_SceltaComplementare, Testo_Link_AccediElencoFile, Testo_Upload_Conferma, Testo_Link_NuovoUpload, Testo_LinkTornaElenco, Testo_Modulo_CampoDescrizione, Testo_Modulo_SpiegazioneCampoDescrizione, Testo_Modulo_CampoSezione, Testo_Modulo_SpiegazioneCampoSezione, Testo_Modulo_CampoIntroduzione, Testo_Modulo_SpiegazioneCampoIntroduzione, Testo_Modulo_LinkPopupCampoSezione, Testo_Modulo_LinkPopupCampoFileFotografia, Testo_Modulo_LinkPopupCampoFilePodcast, Testo_Modulo_LinkPopupPreviewFotografia, Testo_Modulo_CampoAutore, Testo_Modulo_SpiegazioneCampoAutore, Testo_Modulo_CampoNomeFileFotografia, Testo_Modulo_CampoNomeFileFotografiaSpiegazione, Testo_Modulo_CampoNomeFileFotografiaSpiegazioneConResizeASPNET, Testo_Modulo_CampoTitolo, Testo_Modulo_CampoPodcast, Testo_Modulo_SpiegazioneCampoTitolo, Testo_Modulo_SpiegazioneCampoPodcast, Testo_Modulo_SpiegazioneConversioneSmile, Testo_Modulo_LinkPopupConversioneSmile, Testo_Modulo_CampoData, Testo_Modulo_SpiegazioneCampoData, Testo_Modulo_LinkPopupCampoData, Testo_Modulo_CampoOra, Testo_Modulo_SpiegazioneCampoOra, Testo_Modulo_LinkPopupCampoOra, Testo_Modulo_CampoLetture, Testo_Modulo_SpiegazioneCampoLetture, Testo_Modulo_CampoBozze, Testo_Modulo_SpiegazioneCampoBozze, Testo_Modulo_CampoBozzeSi, Testo_Modulo_CampoBozzeNo, Testo_Articoli_IntroduzioneAggiungi, Testo_Articoli_AggiuntaABuonFine, Testo_Articoli_LinkTornaIndietro, Testo_Articoli_LinkVaiElenco, Testo_Link_AvviaUploadFile, Testo_Legenda_CampiObbligatori, Testo_Articoli_ErroreInserimento, Testo_Articoli_CancellazioneABuonFine, Testo_Articoli_IntroduzioneElenco, Testo_Articoli_IntroduzioneTotaleArticoli, Testo_TabellaArticoli_RigaTitolo, Testo_TabellaArticoli_RigaAutore, Testo_TabellaArticoli_RigaSezione, Testo_TabellaArticoli_RigaOperazioni, Testo_TabellaArticoli_CaratteristicaBozza, Testo_TabellaArticoli_CaratteristicaHit, Testo_TabellaArticoli_LinkModeraCommenti, Testo_TabellaArticoli_LinkModifica, Testo_TabellaArticoli_LinkCancella, Testo_TabellaArticoli_LinkVisualizza, Testo_TabellaArticoli_LinkPreview, Testo_TabellaArticoli_Paginazione, Testo_TabellaArticoli_FiltriPer, Testo_TabellaArticoli_FiltroPerAutori, Testo_TabellaArticoli_FiltroPerAutoriNessunaScelta, Testo_TabellaArticoli_FiltroANDOR, Testo_TabellaArticoli_FiltroPerSezioniNessunaScelta, Testo_TabellaArticoli_FiltroPerSezioni, Testo_TabellaArticoli_ErroreNessunArticoloTrovato, Testo_Introduzione_ModeraCommenti, Testo_TabellaCommenti_RigaAutore, Testo_TabellaCommenti_AutoreLinkNonDisponibile, Testo_TabellaCommenti_RigaInviato, Testo_TabellaCommenti_RigaInviatoIndirizzoIP, Testo_TabellaCommenti_RigaOperazioni, Testo_TabellaCommenti_Paginazione, Testo_TabellaCommenti_ErroreNessunCommentoTrovato, Testo_Articoli_IntroduzioneModifica, Testo_Articoli_ModificaABuonFine, Testo_Articoli_ErroreModifica, Testo_Articoli_IntroduzioneSezioniDisponibili, Testo_Sezioni_IntroduzioneRinominaSezioni, Testo_Sezioni_TitoloNomeSezioniDisponibili, Testo_Sezioni_TitoloNuovoNomeSezione, Testo_Fotografie_IntroduzioneSezioniDisponibili, Testo_SezioniDisponibili_ErroreNessunaTrovata, Testo_Sezioni_LinkRinomina, Testo_SezioniModifica_ErroreNonABuonFine, Testo_SezioniModifica_Conferma, Testo_Autori_IntroduzioneAggiungi, Testo_Autori_AggiuntaABuonFine, Testo_Autori_LinkTornaIndietro, Testo_Autori_LinkVaiElenco, Testo_Autori_ErroreInserimento, Testo_Modulo_CampoUserID, Testo_Modulo_SpiegazioneCampoUserID, Testo_Modulo_CampoPassword, Testo_Modulo_CampoPasswordConferma, Testo_Modulo_SpiegazioneCampoPassword, Testo_Modulo_SpiegazioneCampoPasswordConferma, Testo_Modulo_CampoNick, Testo_Modulo_SpiegazioneCampoNick, Testo_Modulo_CampoMail, Testo_Modulo_SpiegazioneCampoMail, Testo_Modulo_CampoSito, Testo_Modulo_SpiegazioneCampoSito, Testo_Modulo_CampoICQ, Testo_Modulo_SpiegazioneCampoICQ, Testo_Modulo_CampoMSN, Testo_Modulo_SpiegazioneCampoMSN, Testo_Modulo_CampoProfilo, Testo_Modulo_SpiegazioneCampoProfilo, Testo_Modulo_CampoImmagine, Testo_Modulo_SpiegazioneCampoImmagine, Testo_Modulo_CampoAdmin, Testo_Modulo_SpiegazioneCampoAdmin, Testo_Modulo_CampoAdminSi, Testo_Modulo_CampoAdminNo, Testo_Modulo_CampoCitazione, Testo_Modulo_SpiegazioneCampoCitazione, Testo_Modulo_CampoHeader, Testo_Modulo_SpiegazioneCampoHeader, Testo_Errore_PermessiMancanti, Testo_Autore_CancellazioneABuonFine, Testo_Autore_CancellazioneNonABuonFine, Testo_Autori_IntroduzioneElenco, Testo_Autori_IntroduzioneTotaleAutori, Testo_TabellaAutori_RigaMail, Testo_TabellaAutori_RigaOperazioni, Testo_TabellaAutori_LinkModifica, Testo_TabellaAutori_LinkCancella, Testo_TabellaAutori_LinkVisualizzazione, Testo_TabellaAutori_Paginazione, Testo_TabellaAutori_FiltriPer, Testo_TabellaAutori_FiltroPerAutori, Testo_TabellaAutori_FiltroPerAutoriNessunaScelta, Testo_TabellaAutori_ErroreNessunAutoreTrovato, Testo_Autori_IntroduzioneModifica, Testo_Autori_ModificaABuonFine, Testo_TabellaAutori_eMailNonDisponibile, Testo_TabellaAutori_IdentificaAdmin, Testo_Citazioni_IntroduzioneAggiungi, Testo_Modulo_CampoHeaderSi, Testo_Modulo_CampoHeaderNo, Testo_Citazioni_IntroduzioneModifica, Testo_Citazioni_ModificaABuonFine, Testo_Citazioni_ErroreModifica, Testo_TabellaCitazioni_ErroreNessunaCitazioneTrovataPassaggioParametri, Testo_Citazioni_AggiuntaABuonFine, Testo_Citazioni_LinkTornaIndietro, Testo_Citazioni_LinkVaiElenco, Testo_Citazioni_ErroreInserimento, Testo_Citazioni_CancellazioneABuonFine, Testo_Citazioni_IntroduzioneElenco, Testo_Citazioni_IntroduzioneTotaleCitazioni, Testo_TabellaCitazioni_RigaAutore, Testo_TabellaCitazioni_RigaTesto, Testo_TabellaCitazioni_RigaOperazioni, Testo_TabellaCitazioni_LinkModifica, Testo_TabellaCitazioni_LinkCancella, Testo_TabellaCitazioni_IdentificaRotazioneHeader, Testo_TabellaCitazioni_Paginazione, Testo_TabellaCitazioni_ErroreNessunaCitazioneTrovata, Testo_Fotografie_IntroduzioneAggiungi, Testo_Fotografie_AggiuntaABuonFine, Testo_Fotografie_LinkTornaIndietro, Testo_Fotografie_LinkVaiElenco, Testo_Fotografie_ErroreInserimento, Testo_Fotografie_CancellazioneABuonFine, Testo_Fotografie_IntroduzioneElenco, Testo_Fotografie_IntroduzioneTotaleFotografie, Testo_TabellaFotografie_RigaAutore, Testo_TabellaFotografie_RigaSezione, Testo_TabellaFotografie_CaratteristicaHit, Testo_TabellaFotografie_RigaOperazioni, Testo_TabellaFotografie_LinkModeraCommenti, Testo_TabellaFotografie_LinkModifica, Testo_TabellaFotografie_LinkCancella, Testo_TabellaFotografie_IdentificaRotazioneHeader, Testo_TabellaFotografie_Paginazione, Testo_TabellaFotografie_FiltriPer, Testo_TabellaFotografie_FiltroPerAutori, Testo_TabellaFotografie_FiltroPerAutoriNessunaScelta, Testo_TabellaFotografie_FiltroANDOR, Testo_TabellaFotografie_FiltroPerSezioni, Testo_TabellaFotografie_FiltroPerSezioniNessunaScelta, Testo_Fotografie_IntroduzioneModifica, Testo_Fotografie_ModificaABuonFine, Testo_Fotografie_ErroreModifica, Testo_TabellaFotografie_ErroreNessunaFotografiaTrovata, Testo_Sondaggi_IntroduzioneAggiungi, Testo_Sondaggi_AggiuntaABuonFine, Testo_Sondaggio_LinkTornaIndietro, Testo_Sondaggi_LinkVaiElenco, Testo_Sondaggi_ErroreInserimento, Testo_Modulo_CampoDomanda, Testo_Modulo_SpiegazioneCampoDomanda, Testo_Modulo_CampoRisposta, Testo_Modulo_SpiegazioneCampoRisposta, Testo_Sondaggi_CancellazioneABuonFine, Testo_Sondaggi_IntroduzioneElenco, Testo_Sondaggi_IntroduzioneTotaleSondaggi, Testo_TabellaSondaggi_RigaDomanda, Testo_TabellaSondaggi_RigaOperazioni, Testo_TabellaSondaggi_LinkModifica, Testo_TabellaSondaggi_LinkCancella, Testo_TabellaSondaggi_Paginazione, Testo_TabellaSondaggi_ErroreNessunSondaggioTrovato, Testo_Sondaggi_IntroduzioneModifica, Testo_Sondaggi_ModificaABuonFine, Testo_Sondaggi_ErroreModifica, Testo_TabellaSondaggi_ErroreNessunSondaggioTrovatoPassaggioParametri, Testo_Commenti_TotaleCommentiRicevuti, Testo_Sondaggi_TotaleSondaggiProposti, Testo_Sondaggi_TotaleVotiRicevuti, Testo_Citazioni_TotalePerAutore, Testo_Citazioni_TotaleCitazioni, Testo_Autori_TotaleAutori, Testo_LinkLog_IntroduzioneElenco, Testo_LinkLog_IntroduzioneTotaleLink, Testo_TabellaLinkLog_RigaIntroduzione, Testo_TabellaLinkLog_RigaData, Testo_TabellaLinkLog_RigaOperazioni, Testo_TabellaLinkLog_LinkModifica, Testo_TabellaLinkLog_LinkCancella, Testo_TabellaLinkLog_LinkVisualizza, Testo_TabellaLinkLog_Paginazione, Testo_TabellaLinkLog_ErroreNessunLinkTrovato, Testo_LinkLog_CancellazioneABuonFine, Testo_LinkLog_LinkTornaIndietro, Testo_LinkLog_IntroduzioneAggiungi, Testo_LinkLog_AggiuntaABuonFine, Testo_LinkLog_LinkVaiElenco, Testo_Modulo_CampoTestoLinkato, Testo_Modulo_SpiegazioneCampoTestoLinkato, Testo_Modulo_CampoURL, Testo_Modulo_SpiegazioneCampoURL, Testo_LinkLog_ErroreInserimento, Testo_LinkLog_IntroduzioneModifica, Testo_LinkLog_ModificaABuonFine, Testo_LinkLog_ErroreModifica, Testo_TabellaLinkLog_FiltriPer, Testo_TabellaLinkLog_FiltroPerAutori, Testo_TabellaLinkLog_FiltroPerAutoriNessunaScelta, Testo_LinkLog_IntroduzioneTotaleLinkLog

'---PANNELLO
'Titolo sezione principale del Pannello
Testo_Path_Pannello = "Pannello di Controllo"
'Testo di introduzione al login per il Pannello
Testo_Introduzione_Login = "Per accedere alla gestione della piattaforma &egrave; necessario autenticarsi fornendo UserID e Password."
'Testo del campo UserID nel login
Testo_Campo_UserID = "UserID"
'Testo nome del campo Password nel login
Testo_Campo_Password = "Password"
'Testo pulsante Login
Testo_Pulsante_Login = "Login"
'Testo di avviso per utente già autenticato
Testo_UserID_Gia_Autenticata = "Il tuo computer risulta gi&agrave; autenticato: puoi accedere direttamente"
'Testo di benvenuto per la UserID
Testo_Pannello_Benvenuto_UserID = "Benvenuto"
'Testo introduttivo delle funzionalità disponibili nel pannello
Testo_Pannello_Benvenuto_Funzioni = " di seguito le funzioni abilitate:"
'Menu del Pannello, link per gestire gli Articoli 
Testo_Pannello_LinkMenu_Articoli = "Articoli"
'Menu del Pannello, link per gestire le Fotografie
Testo_Pannello_LinkMenu_Fotografie = "Fotografie"
'Menu del Pannello, link per gestire il LinkLog
Testo_Pannello_LinkMenu_LinkLog = "LinkLog"
'Menu del Pannello, link per eseguire l'Upload di file
Testo_Pannello_LinkMenu_Upload = "Upload"
'Menu del Pannello, link per accedere all'Elenco file caricati
Testo_Pannello_LinkMenu_ElencoFile = "Elenco"
'Menu del Pannello, link per gestire i Sondaggi
Testo_Pannello_LinkMenu_Sondaggi = "Sondaggi"
'Menu del Pannello, link per gestire le Citazioni
Testo_Pannello_LinkMenu_Citazioni = "Citazioni"
'Menu del Pannello, link per gestire l'area Stuff
Testo_Pannello_LinkMenu_Stuff = "Stuff"
'Menu del Pannello, link per gestire l'area Link
Testo_Pannello_LinkMenu_Link = "Link amici"
'Menu del Pannello, link per accedere alla Configurazione del blog
Testo_Pannello_LinkMenu_Configurazione = "Configurazione"
'Menu del Pannello, link per avviare la Manutenzione sul database
Testo_Pannello_LinkMenu_Manutenzione = "Manutenzione"
'Menu del Pannello, link per gestire gli Autori
Testo_Pannello_LinkMenu_Autori = "Autori"
'Menu del Pannello, link per visualizzare le Statistiche
Testo_Pannello_LinkMenu_Statistiche = "Statistiche"
'Menu del Pannello, link alla Home page pubblica del blog
Testo_Pannello_LinkMenu_HomePage = "Home Page"
'Menu del Pannello, link per scollegarsi dal Pannello
Testo_Pannello_LinkMenu_Logout = "Logout"
'Testo della sezione Calendario
Testo_Sezione_Calendario = "Calendario"
'Testo di introduzione alla sezione Manutenzione
Testo_Sezione_Manutenzione = "Manutenzione"
'Testo di introduzione alla sezione Conversioni
Testo_Sezione_Conversioni = "Conversioni"
'Testo della sezione Upload
Testo_Sezione_Upload = "Upload"
'Testo della sezione Configurazione
Testo_Sezione_Configurazione = "Configurazione"
'Testo della sezione Articoli
Testo_Sezione_Articoli = "Articoli"
'Testo della sezione Autori
Testo_Sezione_Autori = "Autori"
'Testo della sezione Blog
Testo_Sezione_Blog = "Blog"
'Testo della sezione Classifica
Testo_Sezione_Classifica = "Classifica"
'Testo della sezione Citazioni
Testo_Sezione_Citazioni = "Citazioni"
'Testo della sezione Colori
Testo_Sezione_Colori = "Colori"
'Testo della sezione Commenti
Testo_Sezione_Commenti = "Commenti"
'Testo della sezione Condivise
Testo_Sezione_Condivise = "Condivise"
'Testo della sezione Fotografie
Testo_Sezione_Fotografie = "Fotografie"
'Testo della sezione LinkLog
Testo_Sezione_LinkLog = "LinkLog"
'Testo della sezione Homepage
Testo_Sezione_Homepage = "Homepage"
'Testo della sezione Immagini
Testo_Sezione_Immagini = "Immagini"
'Testo della sezione Intestazione
Testo_Sezione_Intestazione = "Intestazione"
'Testo della sezione Navigazione
Testo_Sezione_Navigazione = "Navigazione"
'Testo della sezione Pubblicazioni
Testo_Sezione_Pubblicazioni = "Pubblicazioni"
'Testo della sezione Ricerca
Testo_Sezione_Ricerca = "Ricerca"
'Testo della sezione Sistema
Testo_Sezione_Sistema = "Sistema"
'Testo della sezione Sondaggio
Testo_Sezione_Sondaggio = "Sondaggi"
'Testo della sezione Storico
Testo_Sezione_Storico = "Storico"
'Testo della sezione Statistiche
Testo_Sezione_Statistiche = "Statistiche"
'Testo della sezione Pannello di controllo
Testo_Sezione_Pannello = "Pannello di controllo"
'Testo della sezione Moderazione commenti
Testo_Sezione_ModeraCommenti = "Modera commenti"
'Testo della sezione Preview
Testo_Sezione_Preview = "Preview"
'Testo della sezione Link
Testo_Sezione_Link = "Link"
'Testo della sezione Orologio
Testo_Sezione_Orologio = "Orologio"
'Testo della sezione Stuff
Testo_Sezione_Stuff = "Stuff"
'Testo della sezione Elenco file
Testo_Sezione_FileElenco = "Elenco file"
'Testo della sezione Cancella file
Testo_Sezione_FileCancella = "Cancella file"
'Testo della sezione che Visualizza una preview della fotografia
Testo_Sezione_PreviewFotografia = "Visualizza"
'Testo della sezione che Elenca le sezioni disponibili
Testo_Sezione_ElencoSezioni = "Sezioni attive"
'Testo della sezione che Rinomina una delle sezioni disponibili
Testo_Sezione_RinominaSezioni = "Sezioni modifica"
'Testo di introduzione al Calendario
Testo_Introduzione_Calendario = "Naviga nei mesi e clicca sul giorno che desideri:"
'Testo per tornare al mese in corso nel calendario
Testo_TornaAlMese = "Torna a"
'Testo link per chiudere il popup
Testo_LinkChiudi = "Chiudi"
'Testo link per cancellare l'oggetto
Testo_LinkCancella = "Cancella"
'Testo della sezione Manutenzione
Testo_Introduzione_Manutenzione = "La compattazione del database, oltre che ridurne le dimensioni ne ottimizza le prestazioni. Per poter compattare il database occorre semplicemente cliccare su ""Compatta""."
'Testo per indicare la dimensione in Kb del database
Testo_DimensioniDB = "Dimensioni database"
'Testo del link per avviare la compressione del database
Testo_Link_Compatta = "Compatta"
'Testo di conferma compressione del database
Testo_Conferma_Compattazione = "Compattato!"
'Testo di conferma creazione del database di backup
Testo_Conferma_BackupDatabase = "E' stato creato il file"
'Testo di spiegazione sul processo di compressione del database
Testo_Spiegazione_Compattazione = "Nota: la compattazione del database pu&ograve; richiedere qualche secondo, una volta cliccato su ""Compatta"" attendere quindi la conferma senza chiudere la finestra."
'Testo titolo colonna file nella tabella di elenco dei database di backup
Testo_NomeFile_TabellaDBBackup = "Database backup"
'Testo titolo colonna kb nella tabella di elenco dei database di backup
Testo_KbFile_TabellaDBBackup = "Kb"
'Testo conferma di eliminazione del file
Testo_EliminaFile_Conferma = "Eliminazione del file"
'Testo di conferma per la cancellazione di un file (javascript)
Testo_Conferma_CancellazioneFileJavascript = "Confermi la richiesta di eliminare il file/oggetto"
'Testo della sezione Conversioni
Testo_Introduzione_Conversioni = "Di seguito la tabella di conversione tra gli smile in formato testuale e quelli in formato grafico:"
'Testo di relazione tra uno smile testuale e quello grafico
Testo_RelazioneSmile = "corrisponde a"
'Testo di introduzione alla modifica dei testi del sistema
Testo_IntroduzioneTesti_Configurazione = "Di seguito i parametri e le stringhe configurabili. E' consigliabile effettuare le modifiche con la massima <b>attenzione</b> poich&eacute; un semplice errore potrebbe causare gravi problemi all'intera piattaforma.<br /><br /><b>Nota:</b> i path vanno inseriti esattamente come mostrati nella versione standard, ad esempio ""gfx/"" non pu&ograve; diventare ""/prova/"", ma dovr&agrave; essere ""prova/"". Allo stesso modo gli URL presenti dovranno sempre iniziare con ""http://"" e terminare con ""/""."
'Testo di introduzione alla sezione Configurazione
Testo_Introduzione_Configurazione = "Di seguito i parametri e le stringhe configurabili nella piattaforma dBlog, per accedere all'elenco &egrave; sufficiente selezionare la sezione relativa."
'Testo di errore file di costanti/testi non trovato
Testo_Errore_FileCostanti_NonTrovato = "File costanti non trovato."
'Testo di errore funzione riservata all'Admin
Testo_Errore_FunzioneRiservataAdmin = "Funzione disponibile solo ad utenti Admin."
'Testo di scelta tra le sezioni disponibili da configurare
Testo_SezioniDisponibili_Configurazione = "Configura la sezione"
'Testo di errore nel passaggio dei parametri nella Configurazione
Testo_Errore_PassaggioParametri = "Errore nel passaggio dei parametri."
'Testo di conferma Configurazione modificata con successo
Testo_Conferma_ConfigurazioneModificata = "La configurazione &egrave; stata modificata con successo, torna alla"
'Testo di introduzione all'Elenco dei file
Testo_Introduzione_ElencoFile = "Di seguito l'elenco dei file presenti sul blog."
'Testo per la scelta del filtro sui file
Testo_Scelta_FiltroFile = "Visualizza"
'Testo del filtro file per tutti i file
Testo_FiltroFile_Tutti = "tutti i file"
'Testo del filtro file per le immagini
Testo_FiltroFile_Immagini = "solo immagini (gif, jpg, png)"
'Testo del filtro file per i documenti
Testo_FiltroFile_Documenti = "solo documenti"
'Testo del filtro file per i podcast (mp3)
Testo_FiltroFile_Podcast = "solo podcast (mp3)"
'Testo titolo della colonna nome nella tabella di elenco file
Testo_FiltroFile_ColonnaNome = "Scegli..."
'Testo titolo della colonna Kb nella tabella di elenco file
Testo_FiltroFile_ColonnaKb = "Kb"
'Testo frase totale file trovati nel sistema
Testo_FiltroFile_TotaleFile = "file trovati."
'Testo introduzione alla cancellazione di un file
Testo_FiltroFile_IntroduzioneCancellazione = "Confermi la cancellazione del file"
'Testo di conferma per la cancellazione di un file
Testo_FiltroFile_ConfermaCancellazione = "Si, confermo"
'Testo di negazione per la cancellazione di un file
Testo_FiltroFile_NonConfermaCancellazione = "No, annullo"
'Testo di conferma della cancellazione di un commento
Testo_Commenti_ConfermaCancellazione = "Il commento &egrave; stato cancellato con successo, torna alla"
'Testo link alla pagina precedente
Testo_Link_PaginaPrecedente = "pagina precedente"
'Testo di introduzione alla sezione Link
Testo_Introduzione_LinkAmici = "Per inserire un nuovo testo in Link modifica il box seguente."
'Testo pulsante e link di Modifica oggetto
Testo_Modulo_PulsanteModifica = "Modifica"
'Testo pulsante e link di Cancellazione oggetto
Testo_Modulo_PulsanteCancella = "Cancella"
'Testo pulsante e link di Ricerca
Testo_Modulo_PulsanteRicerca = "Cerca"
'Testo pulsante e link di Aggiunta oggetto
Testo_Modulo_PulsanteAggiungi = "Aggiungi"
'Testo di introduzione alla sezione Stuff
Testo_Introduzione_Stuff = "Per inserire un nuovo testo in Stuff modifica il box seguente."
'Testo di conferma modifica sezione Stuff a buon fine
Testo_Stuff_ModificaABuonFine = "<b>Conferma</b>: modifica effettuata con successo."
'Testo di conferma modifica sezione Link amici a buon fine
Testo_LinkAmici_ModificaABuonFine = "<b>Conferma</b>: modifica effettuata con successo."
'Testo del link per tornare indietro alla pagina precedente
Testo_Stuff_LinkTornaIndietro = "Torna Indietro"
'Testo del link per tornare indietro alla pagina precedente
Testo_LinkAmici_LinkTornaIndietro = "Torna Indietro"
'Testo di introduzione alla sezione Orologio
Testo_Introduzione_Orologio = "Scegli ora, minuti e secondi che desideri:"
'Testo campo Ora dell'orario
Testo_Orologio_CampoOra = "Ore:"
'Testo campo Minuti dell'orario
Testo_Orologio_CampoMinuti = "Min:"
'Testo campo Secondi dell'orario
Testo_Orologio_CampoSecondi = "Sec:"
'Testo link di salvataggio
Testo_LinkSalva = "Salva"
'Testo link per selezionare l'orario attuale
Testo_Orologio_LinkOraAttuale = "Oppure imposta l'ora attuale"
'Testo di introduzione alla sezione Upload
Testo_Introduzione_Upload = "Per pubblicare un file (.zip, .gif, .doc, etc) sul Blog occorre semplicemente selezionare il file dal proprio disco e confermare cliccando su ""Upload""."
'Testo titolo del campo File da caricare
Testo_Modulo_FileDaCaricare = "<b>File</b> (da pubblicare sul sito)"
'Testo pulsante di Upload
Testo_Modulo_PulsanteUpload = "Upload"
'Testo di spiegazione del funzionamento dell'Upload
Testo_Spiegazione_Upload = "Nota: la pubblicazione di file di grosse dimensioni pu&ograve; richiedere qualche secondo, una volta cliccato su ""Upload"" attendere quindi la conferma senza chiudere la finestra."
'Testo di errore durante l'Upload
Testo_Errore_Upload = "<b>Errore</b>: il nome del file &egrave; obbligatorio.<br /><br />Se hai inserito correttamente il nome del file allora significa che esiste gi&agrave; un file con questo nome o che il file contiene caratteri non ammessi o che non sei autorizzato a caricare questo tipo di file."
'Elenco di estensioni per cui non è permesso l'upload (senza separatori)
Testo_Upload_EstensioniNonAbilitate = ".asp.aspx.php.cfm.js.vbs"
'Testo Link Riprova azione
Testo_Link_RiprovaAzione = "Riprova"
'Testo scelta alternativa
Testo_SceltaOppure = " o "
'Testo scelta complementare
Testo_SceltaComplementare = " e "
'Testo Link per accedere ai file già caricati
Testo_Link_AccediElencoFile = "Controlla i file gi&agrave; presenti"
'Testo di conferma per un file correttamente caricato
Testo_Upload_Conferma = "<b>Conferma</b>: i file sono stati correttamente salvati:"
'Testo link per avviare una nuova procedura di Upload
Testo_Link_NuovoUpload = "Esegui l'upload di un nuovo file"
'Testo del link per tornare all'elenco degli oggetti
Testo_LinkTornaElenco = "torna all'elenco"
'Testo titolo del campo Contenuto
Testo_Modulo_CampoContenuto = "Testo"
'Testo spiegazione del campo Contenuto
Testo_Modulo_SpiegazioneCampoContenuto = "(testo contenuto, massimo 64.000 caratteri)"
'Testo spiegazione del link all'Editor HTML visuale
Testo_Modulo_SpiegazioneEditorHTML = "<b>HTML Editor</b> per modificare il testo in maniera"
'Testo titolo del link all'Editor HTML visuale
Testo_Modulo_LinkEditorHTML = "visuale (WYSIWYG)"
'Testo titolo del campo Descrizione
Testo_Modulo_CampoDescrizione = "Descrizione"
'Testo spiegazione del campo Descrizione
Testo_Modulo_SpiegazioneCampoDescrizione = "(descrizione dell'immagine, no html)"
'Testo titolo del campo Sezione
Testo_Modulo_CampoSezione = "Sezione"
'Testo spiegazione del campo Sezione
Testo_Modulo_SpiegazioneCampoSezione = "(sezione nella quale inserire l'oggetto)"
'Testo titolo del campo Introduzione
Testo_Modulo_CampoIntroduzione = "Introduzione"
'Testo spiegazione del campo Introduzione
Testo_Modulo_SpiegazioneCampoIntroduzione = "(testo introduttivo dell'oggetto)"
'Testo link per aprire il popup di scelta della Sezione
Testo_Modulo_LinkPopupCampoSezione = "scegli"
'Testo link per aprire il popup di scelta del file della Fotografia
Testo_Modulo_LinkPopupCampoFileFotografia = "scegli"
'Testo link per aprire il popup di scelta del file del file MP3 Podcast
Testo_Modulo_LinkPopupCampoFilePodcast = "scegli"
'Testo link per aprire il popup di preview del file della Fotografia
Testo_Modulo_LinkPopupPreviewFotografia = "vedi"
'Testo titolo del campo Autore
Testo_Modulo_CampoAutore = "Autore"
'Testo spiegazione del campo Autore
Testo_Modulo_SpiegazioneCampoAutore = "(autore dell'oggetto)"
'Testo titolo del campo Nome file (fotografia)
Testo_Modulo_CampoNomeFileFotografia = "Nome file"
'Testo spiegazione del campo Nome file (fotografia)
Testo_Modulo_CampoNomeFileFotografiaSpiegazione = "(no link, larghezza max 450 pixel. In seguito eseguire l'upload della thumbnail relativa nominandola T-nomefile.jpg)"
'Testo spiegazione del campo Nome file (fotografia) quando è attivo il resize automatico con ASP.NET
Testo_Modulo_CampoNomeFileFotografiaSpiegazioneConResizeASPNET = "(no link, larghezza definita dalla Configurazione)"
'Testo titolo del campo Titolo
Testo_Modulo_CampoTitolo = "Titolo"
'Testo titolo del campo Podcast
Testo_Modulo_CampoPodcast = "Podcast"
'Testo spiegazione del campo Titolo
Testo_Modulo_SpiegazioneCampoTitolo = "(titolo dell'articolo)"
'Testo spiegazione del campo Podcast
Testo_Modulo_SpiegazioneCampoPodcast = "(no link, file mp3 audio del Podcast)"
'Testo spiegazione per la conversione di smile da testuali a grafici
Testo_Modulo_SpiegazioneConversioneSmile = "<b>Tabella</b> di conversione da smile testuali a"
'Testo link per aprire il popup di conversione degli smile da tesuali a grafici
Testo_Modulo_LinkPopupConversioneSmile = "smile grafici"
'Testo titolo del campo Data
Testo_Modulo_CampoData = "Data"
'Testo spiegazione del campo Data
Testo_Modulo_SpiegazioneCampoData = "(data di pubblicazione, formato AAAAMMGG)"
'Testo link per aprire il popup di scelta della Data
Testo_Modulo_LinkPopupCampoData = "scegli"
'Testo titolo del campo Ora
Testo_Modulo_CampoOra = "Ora"
'Testo spiegazione del campo Ora
Testo_Modulo_SpiegazioneCampoOra = "(ora di pubblicazione, formato OOMMSS)"
'Testo link per aprire il popup di scelta dell'Ora
Testo_Modulo_LinkPopupCampoOra = "scegli"
'Testo titolo del campo Letture
Testo_Modulo_CampoLetture = "Letture"
'Testo spiegazione del campo Letture
Testo_Modulo_SpiegazioneCampoLetture = "(numero di accessi)"
'Testo titolo del campo Bozze
Testo_Modulo_CampoBozze = "Bozza"
'Testo spiegazione del campo Bozze
Testo_Modulo_SpiegazioneCampoBozze = "(gli articoli Bozza non compaiono online)"
'Testo scelta Si nel campo Bozze (articolo in bozza)
Testo_Modulo_CampoBozzeSi = "S&igrave;"
'Testo scelta No nel campo Bozze (articolo non in bozza)
Testo_Modulo_CampoBozzeNo = "No"
'Testo introduzione all'inserimento di un nuovo articolo
Testo_Articoli_IntroduzioneAggiungi = "Di seguito le informazioni necessarie per il nuovo articolo, dopo aver inserito i dati occorre cliccare sul pulsante ""Aggiungi"" per salvare."
'Testo di conferma inserimento articolo a buon fine
Testo_Articoli_AggiuntaABuonFine = "<b>Conferma</b>: inserimento effettuato con successo"
'Testo del link per tornare indietro alla pagina precedente
Testo_Articoli_LinkTornaIndietro = "Torna Indietro"
'Testo del link per tornare all'elenco degli articoli
Testo_Articoli_LinkVaiElenco = "vai all'Elenco"
'Testo del link per avviare il popup di upload di un file
Testo_Link_AvviaUploadFile = "esegui un Upload"
'Testo spiegazione legenda per campi obbligatori
Testo_Legenda_CampiObbligatori = "* = il campo indicato &egrave; obbligatorio."
'Testo di errore per l'inserimento di un articolo non a buon fine
Testo_Articoli_ErroreInserimento = "<b>Errore</b>: mancano alcuni campi obbligatori o qualche formato non &egrave; corretto."
'Testo di conferma cancellazione articolo a buon fine
Testo_Articoli_CancellazioneABuonFine = "L'articolo &egrave; stato cancellato con successo"
'Testo introduzione all'elenco degli articoli disponibili
Testo_Articoli_IntroduzioneElenco = "Per inserire un nuovo Articolo clicca su"
'Testo introduzione al totale degli articoli disponibili
Testo_Articoli_IntroduzioneTotaleArticoli = "Totale Articoli trovati"
'Testo titolo riga Titolo nella tabella di elenco degli articoli
Testo_TabellaArticoli_RigaTitolo = "Titolo"
'Testo titolo riga Autore nella tabella di elenco degli articoli
Testo_TabellaArticoli_RigaAutore = "Autore"
'Testo titolo riga Sezione nella tabella di elenco degli articoli
Testo_TabellaArticoli_RigaSezione = "Sezione"
'Testo titolo riga Operazioni nella tabella di elenco degli articoli
Testo_TabellaArticoli_RigaOperazioni = "Operazioni"
'Testo indicativo riguardo un articolo in stato di Bozza
Testo_TabellaArticoli_CaratteristicaBozza = "Bozza"
'Testo indicativo riguardo al numero di visualizzazioni dell'articolo
Testo_TabellaArticoli_CaratteristicaHit = "letture"
'Testo link alla Moderazione dei commenti di un articolo
Testo_TabellaArticoli_LinkModeraCommenti = "Modera"
'Testo link alla Modifica del contenuto di un articolo
Testo_TabellaArticoli_LinkModifica = "Modifica"
'Testo link alla Cancellazione di un articolo
Testo_TabellaArticoli_LinkCancella = "Cancella"
'Testo link alla Visualizzazione online (sul blog) di un articolo
Testo_TabellaArticoli_LinkVisualizza = "Visualizza"
'Testo link alla Preview (in popup) di un articolo
Testo_TabellaArticoli_LinkPreview = "Preview"
'Testo introduttivo all'indice delle pagine in cui sono suddivisi gli articoli
Testo_TabellaArticoli_Paginazione = "Pagine"
'Testo introduttivo ai filtri di visualizzazione nell'elenco degli articoli
Testo_TabellaArticoli_FiltriPer = "Filtri"
'Testo filtro Articoli per Autori
Testo_TabellaArticoli_FiltroPerAutori = "per Autore"
'Testo opzione del filtro per Autori con nessuna scelta
Testo_TabellaArticoli_FiltroPerAutoriNessunaScelta = "Nessuno"
'Testo AND/OR sui due filtri per la visualizzazione degli articoli
Testo_TabellaArticoli_FiltroANDOR = "e/o"
'Testo opzione del filtro per Sezioni con nessuna scelta
Testo_TabellaArticoli_FiltroPerSezioniNessunaScelta = "Nessuno"
'Testo filtro Articoli per Sezioni
Testo_TabellaArticoli_FiltroPerSezioni = "per Sezione"
'Testo errore nessun Articolo trovato
Testo_TabellaArticoli_ErroreNessunArticoloTrovato = "Nessun Articolo trovato"
'Testo introduttivo alla moderazione dei Commenti
Testo_Introduzione_ModeraCommenti = "Di seguito i commenti relativi all'oggetto richiesto."
'Testo titolo riga Autore nella tabella di elenco dei Commenti
Testo_TabellaCommenti_RigaAutore = "Autore"
'Testo link dell'Autore non disponibile
Testo_TabellaCommenti_AutoreLinkNonDisponibile = "Link n.d."
'Testo titolo riga Inviato nella tabella di elenco dei Commenti
Testo_TabellaCommenti_RigaInviato = "<b>Inviato</b> il"
'Testo indirizzo IP registrato nella tabella di elenco dei Commenti
Testo_TabellaCommenti_RigaInviatoIndirizzoIP = "con IP"
'Testo titolo riga Operazioni nella tabella di elenco dei Commenti
Testo_TabellaCommenti_RigaOperazioni = "Operazioni"
'Testo introduttivo all'indice delle pagine in cui sono suddivisi i Commenti
Testo_TabellaCommenti_Paginazione = "Pagine"
'Testo errore nessun Commento trovato
Testo_TabellaCommenti_ErroreNessunCommentoTrovato = "Nessun Commento trovato"
'Testo introduzione alla modifica di un articolo
Testo_Articoli_IntroduzioneModifica = "Di seguito le informazioni disponibili per l'oggetto richiesto, dopo aver apportato le modifiche necessarie occorre cliccare sul pulsante ""Modifica"" per salvare."
'Testo di conferma modifica articolo a buon fine
Testo_Articoli_ModificaABuonFine = "<b>Conferma</b>: modifica effettuata con successo."
'Testo di errore per la modifica di un articolo non a buon fine
Testo_Articoli_ErroreModifica = "<b>Errore</b>: mancano alcuni campi obbligatori o qualche formato non &egrave; corretto."
'Testo introduzione alla scelta tra le sezioni disponibili per l'articolo
Testo_Articoli_IntroduzioneSezioniDisponibili = "Clicca sul Nome di una delle sezioni disponibili per inserire l'articolo al suo interno oppure su Rinomina per rinominarla:"
'Testo introduzione alla procedura per rinominare una tra le sezioni disponibili per l'articolo
Testo_Sezioni_IntroduzioneRinominaSezioni = "Scegli una tra le Sezioni disponibili ed inserisci il suo nuovo nome, poi conferma per salvare:"
'Titolo della colonna Nome per le Sezioni disponibili per l'articolo
Testo_Sezioni_TitoloNomeSezioniDisponibili = "Nome"
'Titolo della colonna del nuovo Nome per la Sezione selezionata
Testo_Sezioni_TitoloNuovoNomeSezione = "Nuovo nome"
'Testo introduzione alla scelta tra le sezioni disponibili per la fotografia
Testo_Fotografie_IntroduzioneSezioniDisponibili = "Clicca su una delle sezioni disponibili per inserire la fotografia al suo interno:"
'Testo di errore per nessuna Sezione trovata tra quelle disponibili
Testo_SezioniDisponibili_ErroreNessunaTrovata = "Nessuna Sezione trovata."
'Testo del link per iniziare la procedura per rinominare una Sezione
Testo_Sezioni_LinkRinomina = "Rinomina"
'Testo di errore per rinomina Sezione non a buon fine
Testo_SezioniModifica_ErroreNonABuonFine = "La Sezione non &egrave; stata rinominata perch&eacute; il Nome precedente non esiste nel DataBase oppure il Nuovo Nome &egrave; vuoto oppure il Nuovo Nome coincide con il Nome precedente."
'Testo di conferma rinomina Sezione a buon fine
Testo_SezioniModifica_Conferma = "La Sezione &egrave; stata rinominata con successo."
'Testo introduzione all'inserimento di un nuovo Autore
Testo_Autori_IntroduzioneAggiungi = "Di seguito le informazioni necessarie per il nuovo Autore, dopo aver inserito i dati occorre cliccare sul pulsante ""Aggiungi"" per salvare."
'Testo di conferma inserimento Autore a buon fine
Testo_Autori_AggiuntaABuonFine = "<b>Conferma</b>: inserimento effettuato con successo"
'Testo del link per tornare indietro alla pagina precedente
Testo_Autori_LinkTornaIndietro = "Torna Indietro"
'Testo del link per tornare all'elenco degli Autori
Testo_Autori_LinkVaiElenco = "vai all'Elenco"
'Testo di errore per l'inserimento di un Autore non a buon fine
Testo_Autori_ErroreInserimento = "<b>Errore</b>: mancano alcuni campi obbligatori oppure UserID/Nick sono gi&agrave; presenti nel database oppure la Password non &egrave; stata confermata correttamente oppure la UserID contiene un carattere non ammesso (%, [, ], _, #)."
'Testo titolo del campo UserID
Testo_Modulo_CampoUserID = "UserID"
'Testo spiegazione del campo UserID
Testo_Modulo_SpiegazioneCampoUserID = "(identificativo per il Login)"
'Testo titolo del campo Password
Testo_Modulo_CampoPassword = "Password"
'Testo titolo del campo Password di conferma
Testo_Modulo_CampoPasswordConferma = "Password conferma"
'Testo spiegazione del campo Password
Testo_Modulo_SpiegazioneCampoPassword = "(parola segreta per il Login)"
'Testo spiegazione del campo Password di conferma
Testo_Modulo_SpiegazioneCampoPasswordConferma = "(digita nuovamente per verifica)"
'Testo titolo del campo Nick
Testo_Modulo_CampoNick = "Nick"
'Testo spiegazione del campo Nick
Testo_Modulo_SpiegazioneCampoNick = "(soprannome dell'autore)"
'Testo titolo del campo Mail
Testo_Modulo_CampoMail = "Mail"
'Testo spiegazione del campo Mail
Testo_Modulo_SpiegazioneCampoMail = "(indirizzo e-Mail)"
'Testo titolo del campo Sito
Testo_Modulo_CampoSito = "Sito"
'Testo spiegazione del campo Sito
Testo_Modulo_SpiegazioneCampoSito = "(indirizzo sito Web)"
'Testo titolo del campo ICQ
Testo_Modulo_CampoICQ = "ICQ"
'Testo spiegazione del campo ICQ
Testo_Modulo_SpiegazioneCampoICQ = "(UIN # ICQ)"
'Testo titolo del campo MSN
Testo_Modulo_CampoMSN = "MSN"
'Testo spiegazione del campo MSN
Testo_Modulo_SpiegazioneCampoMSN = "(indirizzo MSN Messenger)"
'Testo titolo del campo Profilo
Testo_Modulo_CampoProfilo = "Profilo"
'Testo spiegazione del campo Profilo
Testo_Modulo_SpiegazioneCampoProfilo = "(profilo personale)"
'Testo titolo del campo Immagine
Testo_Modulo_CampoImmagine = "Immagine"
'Testo spiegazione del campo Immagine
Testo_Modulo_SpiegazioneCampoImmagine = "(nome file immagine descrittiva, dentro cartella Public)"
'Testo titolo del campo Admin
Testo_Modulo_CampoAdmin = "Admin"
'Testo spiegazione del campo Admin
Testo_Modulo_SpiegazioneCampoAdmin = "(permessi di Amministratore)"
'Testo scelta Si nel campo Admin (utente amministratore)
Testo_Modulo_CampoAdminSi = "S&igrave;"
'Testo scelta No nel campo Admin (utente amministratore)
Testo_Modulo_CampoAdminNo = "No"
'Testo titolo del campo Citazione
Testo_Modulo_CampoCitazione = "Citazione"
'Testo spiegazione del campo Citazione
Testo_Modulo_SpiegazioneCampoCitazione = "(testo integrale)"
'Testo titolo del campo Header
Testo_Modulo_CampoHeader = "Header"
'Testo spiegazione del campo Header
Testo_Modulo_SpiegazioneCampoHeader = "(presenza a rotazione nell'intestazione di ogni pagina)"
'Testo di errore permessi mancanti
Testo_Errore_PermessiMancanti = "<b>Errore</b>: mancano i permessi necessari per eseguire questa operazione."
'Testo di conferma cancellazione Autore a buon fine
Testo_Autore_CancellazioneABuonFine = "L'Autore &egrave; stato cancellato con successo"
'Testo di conferma cancellazione Autore non a buon fine
Testo_Autore_CancellazioneNonABuonFine = "Non &egrave; possibile cancellare un Autore di livello Admin, porta l'Autore ad un livello inferiore e prova nuovamente"
'Testo introduzione all'elenco degli Autori disponibili
Testo_Autori_IntroduzioneElenco = "Per inserire un nuovo Autore clicca su"
'Testo introduzione al totale degli Autori disponibili
Testo_Autori_IntroduzioneTotaleAutori = "Totale Autori trovati"
'Testo titolo riga Mail nella tabella di elenco degli Autori
Testo_TabellaAutori_RigaMail = "Mail"
'Testo titolo riga Operazioni nella tabella di elenco degli Autori
Testo_TabellaAutori_RigaOperazioni = "Operazioni"
'Testo link alla Modifica dei dati dell'Autore
Testo_TabellaAutori_LinkModifica = "Modifica"
'Testo link alla Cancella dell'Autore
Testo_TabellaAutori_LinkCancella = "Cancella"
'Testo link alla Visualizzazione online della scheda Autore
Testo_TabellaAutori_LinkVisualizzazione = "Visualizza"
'Testo introduttivo all'indice delle pagine in cui sono suddivisi gli Autori
Testo_TabellaAutori_Paginazione = "Pagine"
'Testo introduttivo ai filtri di visualizzazione nell'elenco degli Autori
Testo_TabellaAutori_FiltriPer = "Filtri"
'Testo filtro Autori per l'elenco degli Autori
Testo_TabellaAutori_FiltroPerAutori = "per Autore"
'Testo opzione del filtro per Autori con nessuna scelta
Testo_TabellaAutori_FiltroPerAutoriNessunaScelta = "Nessuno"
'Testo errore nessun Autore trovato
Testo_TabellaAutori_ErroreNessunAutoreTrovato = "Nessun Autore trovato"
'Testo introduzione alla modifica di un Autore
Testo_Autori_IntroduzioneModifica = "Di seguito le informazioni disponibili per l'oggetto richiesto, dopo aver apportato le modifiche necessarie occorre cliccare sul pulsante ""Modifica"" per salvare."
'Testo di conferma modifica Autore a buon fine
Testo_Autori_ModificaABuonFine = "<b>Conferma</b>: modifica effettuata con successo."
'Testo errore nessun Autore trovato
Testo_TabellaAutori_ErroreNessunAutoreTrovatoPassaggioParametri = "<b>Nessun Autore trovato</b>: errore nel passaggio dei parametri."
'Testo eMail non disponibile per l'Autore
Testo_TabellaAutori_eMailNonDisponibile = "n.d."
'Testo per identificare un utente Amministratore
Testo_TabellaAutori_IdentificaAdmin = "Admin"
'Testo introduzione all'inserimento di una nuova Citazione
Testo_Citazioni_IntroduzioneAggiungi = "Di seguito le informazioni necessarie per la nuova citazione, dopo aver inserito i dati occorre cliccare sul pulsante ""Aggiungi"" per salvare."
'Testo scelta Si nel campo Header (a rotazione nell'intestazione)
Testo_Modulo_CampoHeaderSi = "S&igrave;"
'Testo scelta No nel campo Header (a rotazione nell'intestazione)
Testo_Modulo_CampoHeaderNo = "No"
'Testo introduzione alla modifica di una Citazione
Testo_Citazioni_IntroduzioneModifica = "Di seguito le informazioni disponibili per l'oggetto richiesto, dopo aver apportato le modifiche necessarie occorre cliccare sul pulsante ""Modifica"" per salvare."
'Testo di conferma modifica Citazione a buon fine
Testo_Citazioni_ModificaABuonFine = "<b>Conferma</b>: modifica effettuata con successo."
'Testo di errore per la modifica di una Citazione non a buon fine
Testo_Citazioni_ErroreModifica = "<b>Errore</b>: mancano alcuni campi obbligatori."
'Testo errore nessuna Citazione trovata
Testo_TabellaCitazioni_ErroreNessunaCitazioneTrovataPassaggioParametri = "<b>Nessuna citazione trovata</b>: errore nel passaggio dei parametri."
'Testo di conferma inserimento Citazione a buon fine
Testo_Citazioni_AggiuntaABuonFine = "<b>Conferma</b>: inserimento effettuato con successo"
'Testo del link per tornare indietro alla pagina precedente
Testo_Citazioni_LinkTornaIndietro = "Torna Indietro"
'Testo del link per tornare all'elenco delle Citazioni
Testo_Citazioni_LinkVaiElenco = "vai all'Elenco"
'Testo di errore per l'inserimento di una Citazione non a buon fine
Testo_Citazioni_ErroreInserimento = "<b>Errore</b>: mancano alcuni campi obbligatori."
'Testo di conferma cancellazione Citazione a buon fine
Testo_Citazioni_CancellazioneABuonFine = "La citazione &egrave; stata cancellata con successo"
'Testo introduzione all'elenco delle Citazioni disponibili
Testo_Citazioni_IntroduzioneElenco = "Per inserire una nuova citazione clicca su"
'Testo introduzione al totale delle Citazioni disponibili
Testo_Citazioni_IntroduzioneTotaleCitazioni = "Totale Citazioni trovate"
'Testo titolo riga Autore nella tabella di elenco delle Citazioni
Testo_TabellaCitazioni_RigaAutore = "Autore"
'Testo titolo riga Testo nella tabella di elenco delle Citazioni
Testo_TabellaCitazioni_RigaTesto = "Testo"
'Testo titolo riga Operazioni nella tabella di elenco delle Citazioni
Testo_TabellaCitazioni_RigaOperazioni = "Operazioni"
'Testo link alla modifica della Citazione
Testo_TabellaCitazioni_LinkModifica = "Modifica"
'Testo link alla cancellazione della Citazione
Testo_TabellaCitazioni_LinkCancella = "Cancella"
'Testo per identificare una Citazione che compare a rotazione nell'intestazione
Testo_TabellaCitazioni_IdentificaRotazioneHeader = "Header"
'Testo introduttivo all'indice delle pagine in cui sono suddivise le Citazioni
Testo_TabellaCitazioni_Paginazione = "Pagine"
'Testo errore nessuna Citazione trovata
Testo_TabellaCitazioni_ErroreNessunaCitazioneTrovata = "Nessuna citazione trovata"
'Testo introduzione all'inserimento di una nuova Fotografia
Testo_Fotografie_IntroduzioneAggiungi = "Di seguito le informazioni necessarie per la nuova immagine, dopo aver inserito i dati occorre cliccare sul pulsante ""Aggiungi"" per salvare."
'Testo di conferma inserimento Fotografia a buon fine
Testo_Fotografie_AggiuntaABuonFine = "<b>Conferma</b>: inserimento effettuato con successo."
'Testo del link per tornare indietro alla pagina precedente
Testo_Fotografie_LinkTornaIndietro = "Torna Indietro"
'Testo del link per tornare all'elenco delle Fotografie
Testo_Fotografie_LinkVaiElenco = "vai all'Elenco"
'Testo di errore per l'inserimento di un articolo non a buon fine
Testo_Fotografie_ErroreInserimento = "<b>Errore</b>: mancano alcuni campi obbligatori o qualche formato non &egrave; corretto."
'Testo di conferma cancellazione Fotografia a buon fine
Testo_Fotografie_CancellazioneABuonFine = "La Fotografia &egrave; stata cancellata con successo"
'Testo introduzione all'elenco delle Fotografie disponibili
Testo_Fotografie_IntroduzioneElenco = "Per inserire una nuova Fotografia clicca su"
'Testo introduzione al totale delle Fotografie disponibili
Testo_Fotografie_IntroduzioneTotaleFotografie = "Totale fotografie trovate"
'Testo titolo riga Autore nella tabella di elenco delle Fotografie
Testo_TabellaFotografie_RigaAutore = "Autore"
'Testo titolo riga Sezione nella tabella di elenco delle Fotografie
Testo_TabellaFotografie_RigaSezione = "Sezione"
'Testo indicativo riguardo al numero di visualizzazioni della Fotografia
Testo_TabellaFotografie_CaratteristicaHit = "letture"
'Testo titolo riga Operazioni nella tabella di elenco delle Fotografie
Testo_TabellaFotografie_RigaOperazioni = "Operazioni"
'Testo link alla Moderazione dei commenti di una Fotografia
Testo_TabellaFotografie_LinkModeraCommenti = "Modera"
'Testo link alla Modifica di una Fotografia
Testo_TabellaFotografie_LinkModifica = "Modifica"
'Testo link alla Cancellazione di una Fotografia
Testo_TabellaFotografie_LinkCancella = "Cancella"
'Testo per identificare una Fotografia che compare a rotazione nell'intestazione
Testo_TabellaFotografie_IdentificaRotazioneHeader = "Header"
'Testo introduttivo all'indice delle pagine in cui sono suddivise le Fotografie
Testo_TabellaFotografie_Paginazione = "Pagine"
'Testo introduttivo ai filtri di visualizzazione nell'elenco delle Fotografie
Testo_TabellaFotografie_FiltriPer = "Filtri"
'Testo filtro Fotografie per Autori
Testo_TabellaFotografie_FiltroPerAutori = "per Autore"
'Testo opzione del filtro per Autori con nessuna scelta
Testo_TabellaFotografie_FiltroPerAutoriNessunaScelta = "Nessuno"
'Testo AND/OR sui due filtri per la visualizzazione delle Fotografie
Testo_TabellaFotografie_FiltroANDOR = "e/o"
'Testo filtro Fotografie per Sezioni
Testo_TabellaFotografie_FiltroPerSezioni = "per Sezione"
'Testo opzione del filtro per Sezioni con nessuna scelta
Testo_TabellaFotografie_FiltroPerSezioniNessunaScelta = "Nessuno"
'Testo errore nessuna Fotografie trovata
Testo_TabellaFotografie_ErroreNessunaFotografiaTrovata = "Nessuna Fotografia trovata"
'Testo introduzione alla modifica di una Fotografia
Testo_Fotografie_IntroduzioneModifica = "Di seguito le informazioni disponibili per l'oggetto richiesto, dopo aver apportato le modifiche necessarie occorre cliccare sul pulsante ""Modifica"" per salvare."
'Testo di conferma modifica Fotografia a buon fine
Testo_Fotografie_ModificaABuonFine = "<b>Conferma</b>: modifica effettuata con successo."
'Testo di errore per la modifica di una Fotografia non a buon fine
Testo_Fotografie_ErroreModifica = "<b>Errore</b>: mancano alcuni campi obbligatori o qualche formato non &egrave; corretto."
'Testo introduzione all'inserimento di un nuovo Sondaggio
Testo_Sondaggi_IntroduzioneAggiungi = "Di seguito le informazioni necessarie per il nuovo Sondaggio, dopo aver inserito i dati occorre cliccare sul pulsante ""Aggiungi"" per salvare."
'Testo di conferma inserimento Sondaggio a buon fine
Testo_Sondaggi_AggiuntaABuonFine = "<b>Conferma</b>: inserimento effettuato con successo."
'Testo del link per tornare indietro alla pagina precedente
Testo_Sondaggio_LinkTornaIndietro = "Torna Indietro"
'Testo del link per tornare all'elenco dei Sondaggi
Testo_Sondaggi_LinkVaiElenco = "vai all'Elenco"
'Testo di errore per l'inserimento di un Sondaggio non a buon fine
Testo_Sondaggi_ErroreInserimento = "<b>Errore</b>: mancano alcuni campi obbligatori."
'Testo titolo del campo Domanda
Testo_Modulo_CampoDomanda = "Domanda"
'Testo spiegazione del campo Domanda
Testo_Modulo_SpiegazioneCampoDomanda = "(il testo della domanda)"
'Testo titolo del campo Risposta
Testo_Modulo_CampoRisposta = "Risposta"
'Testo spiegazione del campo Risposta
Testo_Modulo_SpiegazioneCampoRisposta = "(il testo della risposta, almeno uno &egrave; obbligatorio)"
'Testo di conferma cancellazione Sondaggio a buon fine
Testo_Sondaggi_CancellazioneABuonFine = "Il Sondaggio &egrave; stato cancellato con successo"
'Testo introduzione all'elenco dei Sondaggi disponibili
Testo_Sondaggi_IntroduzioneElenco = "Per inserire un nuovo Sondaggio clicca su"
'Testo introduzione al totale dei Sondaggi disponibili
Testo_Sondaggi_IntroduzioneTotaleSondaggi = "Totale Sondaggi trovati"
'Testo titolo riga Domanda nella tabella di elenco dei Sondaggi
Testo_TabellaSondaggi_RigaDomanda = "Domanda"
'Testo titolo riga Operazioni nella tabella di elenco dei Sondaggi
Testo_TabellaSondaggi_RigaOperazioni = "Operazioni"
'Testo link alla Modifica di un Sondaggio
Testo_TabellaSondaggi_LinkModifica = "Modifica"
'Testo link alla Cancellazione di un Sondaggio
Testo_TabellaSondaggi_LinkCancella = "Cancella"
'Testo introduttivo all'indice delle pagine in cui sono suddivisi i Sondaggi
Testo_TabellaSondaggi_Paginazione = "Pagine"
'Testo errore nessun Sondaggio trovato
Testo_TabellaSondaggi_ErroreNessunSondaggioTrovato = "Nessun Sondaggio trovato"
'Testo introduzione alla modifica di un Sondaggio
Testo_Sondaggi_IntroduzioneModifica = "Di seguito le informazioni disponibili per l'oggetto richiesto, dopo aver apportato le modifiche necessarie occorre cliccare sul pulsante ""Modifica"" per salvare."
'Testo di conferma modifica Sondaggio a buon fine
Testo_Sondaggi_ModificaABuonFine = "<b>Conferma</b>: modifica effettuata con successo."
'Testo di errore per la modifica di un Sondaggio non a buon fine
Testo_Sondaggi_ErroreModifica = "<b>Errore</b>: mancano alcuni campi obbligatori."
'Testo errore nessun Sondaggio trovato
Testo_TabellaSondaggi_ErroreNessunSondaggioTrovatoPassaggioParametri = "<b>Nessun Sondaggio trovato</b>: errore nel passaggio dei parametri."
'Testo per il totale dei commenti nel blog a fini statistici
Testo_Commenti_TotaleCommentiRicevuti = "Totale commenti trovati"
'Testo per il totale dei Sondaggi proposti nel blog a fini statistici
Testo_Sondaggi_TotaleSondaggiProposti = "Totale sondaggi proposti"
'Testo per il totale dei Voti ricevuti ai sondaggi nel blog a fini statistici
Testo_Sondaggi_TotaleVotiRicevuti = "Voti ricevuti"
'Testo per il totale delle Citazioni di un preciso autore
Testo_Citazioni_TotalePerAutore = "citazioni"
'Testo per il totale delle Citazioni nel blog a fini statistici
Testo_Citazioni_TotaleCitazioni = "Totale citazioni trovate"
'Testo per il totale degli Autori nel blog a fini statistici
Testo_Autori_TotaleAutori = "Totale autori trovati"




'Testo introduzione all'elenco dei link disponibili
Testo_LinkLog_IntroduzioneElenco = "Per inserire un nuovo Link clicca su"
'Testo introduzione al totale degli articoli disponibili
Testo_LinkLog_IntroduzioneTotaleLink = "Totale Link trovati"
'Testo titolo riga Introduzione nella tabella di elenco dei link
Testo_TabellaLinkLog_RigaIntroduzione = "Introduzione"
'Testo titolo riga Data nella tabella di elenco dei link
Testo_TabellaLinkLog_RigaData = "Data"
'Testo titolo riga Operazioni nella tabella di elenco dei link
Testo_TabellaLinkLog_RigaOperazioni = "Operazioni"
'Testo link alla Modifica del contenuto di un link
Testo_TabellaLinkLog_LinkModifica = "Modifica"
'Testo link alla Cancellazione di un link
Testo_TabellaLinkLog_LinkCancella = "Cancella"
'Testo link alla Visualizzazione online di un link
Testo_TabellaLinkLog_LinkVisualizza = "Visualizza"
'Testo introduttivo all'indice delle pagine in cui sono suddivisi i link
Testo_TabellaLinkLog_Paginazione = "Pagine"
'Testo errore nessun Link trovato
Testo_TabellaLinkLog_ErroreNessunLinkTrovato = "Nessun Link trovato"
'Testo di conferma cancellazione link a buon fine
Testo_LinkLog_CancellazioneABuonFine = "Il link &egrave; stato cancellato con successo"
'Testo del link per tornare indietro alla pagina precedente
Testo_LinkLog_LinkTornaIndietro = "Torna Indietro"
'Testo introduzione all'inserimento di un nuovo link
Testo_LinkLog_IntroduzioneAggiungi = "Di seguito le informazioni necessarie per il nuovo link, dopo aver inserito i dati occorre cliccare sul pulsante ""Aggiungi"" per salvare."
'Testo di conferma inserimento link a buon fine
Testo_LinkLog_AggiuntaABuonFine = "<b>Conferma</b>: inserimento effettuato con successo"
'Testo del link per tornare all'elenco dei link
Testo_LinkLog_LinkVaiElenco = "vai all'Elenco"
'Testo titolo del campo Testo Linkato
Testo_Modulo_CampoTestoLinkato = "Testo linkato"
'Testo spiegazione del campo Testo Linkato
Testo_Modulo_SpiegazioneCampoTestoLinkato = "(testo cliccabile collegato al link)"
'Testo titolo del campo URL
Testo_Modulo_CampoURL = "URL"
'Testo spiegazione del campo URL
Testo_Modulo_SpiegazioneCampoURL = "(URL del sito a cui far puntare il link; inizia per ""http://"")"
'Testo di errore per l'inserimento di un link non a buon fine
Testo_LinkLog_ErroreInserimento = "<b>Errore</b>: mancano alcuni campi obbligatori o qualche formato non &egrave; corretto."
'Testo introduzione alla modifica di un link
Testo_LinkLog_IntroduzioneModifica = "Di seguito le informazioni disponibili per l'oggetto richiesto, dopo aver apportato le modifiche necessarie occorre cliccare sul pulsante ""Modifica"" per salvare."
'Testo di conferma modifica link a buon fine
Testo_LinkLog_ModificaABuonFine = "<b>Conferma</b>: modifica effettuata con successo."
'Testo di errore per la modifica di un link non a buon fine
Testo_LinkLog_ErroreModifica = "<b>Errore</b>: mancano alcuni campi obbligatori o qualche formato non &egrave; corretto."
'Testo introduttivo ai filtri di visualizzazione nell'elenco dei link
Testo_TabellaLinkLog_FiltriPer = "Filtri"
'Testo filtro Link per Autori
Testo_TabellaLinkLog_FiltroPerAutori = "per Autore"
'Testo opzione del filtro per Autori con nessuna scelta
Testo_TabellaLinkLog_FiltroPerAutoriNessunaScelta = "Nessuno"
'Testo introduzione al totale dei link disponibili
Testo_LinkLog_IntroduzioneTotaleLinkLog = "Totale Link trovati"
%>