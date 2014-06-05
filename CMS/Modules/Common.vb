'© By Andrea Bruno
'Open source, but: This source code (or part of this code) is not usable in other applications
Option Explicit On
Option Strict On
Imports System.Security.Permissions

Namespace WebApplication
  Public Class QueryKey
    'log.aspx
    Public Const ActionLog As String = "al"
    'forum.aspx
    Public Const ActionForum As String = "af"
    Public Const ForumId As String = "f"
    Public Const TopicId As String = "t"
    Public Const ReplyId As String = "r"
    Public Const SubCategory As String = "c"
    Public Const PageNumber As String = "p"
    Public Const FindText As String = "q"
    Public Const User As String = "u"
    Public Const Reference As String = "reference"
    'default.aspx
    Public Const ArchiveNumber As String = "ar"
    Public Const ArticleNumber As String = "pn"
    Public Const Show As String = "sw"
    Public Const Url As String = "idx"
    Public Const CryptedUrl As String = "id"
    'earth.aspx
    Public Const City As String = "city"
    Public Const Country As String = "country"
    Public Const Latitude As String = "la"
    Public Const Longitude As String = "lo"
    'messenger.aspx
    Public Const MsgAction As String = "msga"
    Public Const MsgUser As String = "msgu"
    Public Const MsgForumId As String = "msgf"
    Public Const MsgTopicId As String = "msgt"
    Public Const MsgReplyId As String = "msgr"
    Public Const MsgValue As String = "msgv"
    'messenger.aspx
    Public Const ChatRoom As String = "room"
    Public Const ChatJoinUser As String = "ju"
    Public Const ChatAction As String = "ca"
    Public Const ChatUser As String = "cu"
    Public Const ChatForceRefresh As String = "cfr"
    'viewimg.aspx
    Public Const ImageName As String = "n"
    Public Const AlbumName As String = "a"
    Public Const LanguageImage As String = "l"
    Public Const ImageSource As String = "src"
    Public Const Fullsize As String = "fullsize"
    Public Const Size As String = "size"
    Public Const ImageColorTone As String = "tone"
    'showphoto.aspx
    Public Const ShowPhotoAlbumId As String = "album"
    Public Const ShowPhotoId As String = "img"
    Public Const ShowPhotoMode As String = "mode"
    Public Const PhotoOperation As String = "operation"
    Public Const VcardSubject As String = "subject"
    Public Const VcardText As String = "text"
    Public Const VcardFrom As String = "from"
    Public Const VcardFromEmail As String = "fromemail"
    'thumbnails.aspx
    Public Const ViewAlbum As String = "idalbum"
    'viewthumb.aspx
    Public Const ThumbSize As String = "maxsize"
    Public Const ThumbSource As String = "url"
 
  End Class


  Public Module Common

    Enum TextType
      Html
      Text
    End Enum

    Function Href(ByVal Domain As DomainConfiguration, ByVal SubSite As String, ByVal AbsoluteAddress As Boolean, ByVal NamePage As String, ByVal ParamArray Key_Value() As Object) As String
      Dim Url As String = Nothing 'This is the most powerful of the StringBuilder, do not change!
      If AbsoluteAddress Then
        If Domain IsNot Nothing AndAlso (HttpContext.Current Is Nothing OrElse Not Domain.Equals(CurrentDomainConfiguration)) Then
          Url = "http://" & Domain.Name & "/"
        Else
          Url = PathCurrentUrl()
        End If
      End If

      If NamePage = "default.aspx" Then
        NamePage = ""
      End If
      If AbsoluteAddress = False AndAlso String.IsNullOrEmpty(NamePage) Then
        NamePage = "./"
      End If
      Url &= NamePage

      Dim Fl As Boolean = False
      If Not String.IsNullOrEmpty(SubSite) Then
        Dim SubSites As String() = Nothing
        If Domain IsNot Nothing Then
          SubSites = Domain.SubSitesAvailable()
        End If
        If Domain Is Nothing OrElse (SubSites.Length <> 0 AndAlso SubSites(0) <> SubSite) Then
          Fl = True
          Url &= "?ss="
          Url &= SubSite
        End If
      End If
      Dim FlImpair As Boolean = False
      For Each Obj As Object In Key_Value
        Dim Txt As String
        Txt = HttpUtility.UrlEncode(CStr(Obj))
        FlImpair = Not FlImpair
        If FlImpair Then
          If Fl Then
            Url &= "&"
          Else
            Fl = True
            Url &= "?"
          End If
          Url &= Txt
        Else
          Url &= "="
          Url &= Txt
        End If
      Next
      If Url.Length = 0 Then
        Url &= "."
      End If
      Return Url
    End Function

    Function Href(ByVal SubSite As String, ByVal AbsoluteAddress As Boolean, ByVal NamePage As String, ByVal ParamArray Key_Value() As Object) As String
      Return Href(CurrentDomainConfiguration, SubSite, AbsoluteAddress, NamePage, Key_Value)
    End Function

    Function CountryOfNavigator() As String
      Dim Languages() As String = HttpContext.Current.Request.UserLanguages
      If Not Languages Is Nothing Then
        Try
          Dim Language As String = Languages(0).ToUpper
          If Language.StartsWith("IT") Then
            Return "Italy"
          ElseIf Language.StartsWith("EN") Then
            Return "United States"
          ElseIf Language.StartsWith("FR") Then
            Return "France"
          ElseIf Language.StartsWith("SU") Then
            Return "Finland"
          ElseIf Language.StartsWith("ES") Then
            Return "Spain"
          ElseIf Language.StartsWith("DE") Then
            Return "Germany"
          ElseIf Language.StartsWith("RU") Then
            Return "Russian Federation"
          End If
        Catch ex As Exception
        End Try
      End If
      Return Nothing
    End Function

    Private SharedWebCache As System.Web.Caching.Cache
    Public Property WebCache As System.Web.Caching.Cache
      Get
        Return SharedWebCache
      End Get
      Set(ByVal value As System.Web.Caching.Cache)
        SharedWebCache = value
        Pipeline.StartPipelineComunication()
      End Set
    End Property

    Public HtmlCodesToAddingInPage As New Collections.Specialized.HybridDictionary
    'Private RefreshDate = Refresh()
    'Private Function Refresh() As Date
    '	UpdateCodeFile(Nothing, Nothing)
    '	Return Now.ToUniversalTime()
    'End Function
    Public Sub UpdateCodeFile()
      ReloadCodeFile(Nothing, Nothing, CacheItemRemovedReason.DependencyChanged)
    End Sub

    Private Sub ReloadCodeFile(ByVal k As String, ByVal v As Object, ByVal r As CacheItemRemovedReason)
      'Static MonitorCodeFile As System.IO.FileSystemWatcher
      Dim DirName As String = FileManager.MapPath(CodesSubDirectory)
      If r <> CacheItemRemovedReason.Underused Then
        SyncLock HtmlCodesToAddingInPage
          HtmlCodesToAddingInPage.Clear()
          For Each FileName As String In IO.Directory.GetFiles(DirName, "*.html")
            Dim FileInfo As IO.FileInfo = New IO.FileInfo(FileName)
            Dim Content As String = ReadAll(FileInfo.FullName)
            If Not Content Is Nothing Then
              HtmlCodesToAddingInPage.Add(FileInfo.Name, Content)
            End If
          Next
        End SyncLock
      End If

      'Add a watcher change directory
      Dim onRemoveCallback = New CacheItemRemovedCallback(AddressOf ReloadCodeFile)
      WebCache.Add("codesmonitor", True, New Web.Caching.CacheDependency(DirName), Web.Caching.Cache.NoAbsoluteExpiration, Web.Caching.Cache.NoSlidingExpiration, Web.Caching.CacheItemPriority.Default, onRemoveCallback)

    End Sub

    Delegate Sub SaveObjectMethod()

    Public Class EditObjectParameters
      Public ObjectToEdit As Object
      Public SaveObjectMethod As SaveObjectMethod
      Public TitleInPageEditor As String
      Public DescriptionInPageEditor As String
      Public TablePropertyPhraseCorrispondence As StringDictionary
      Public TablePropertyIdPhraseCorrispondence As Collections.Generic.Dictionary(Of String, Integer)
      Public NamePhraseBooks As String = Nothing
      Public BackToCallingPage As Boolean = True
      Public BackPage As String
      Public FilterExcludeProperties() As String
      Public FilterIncludeProperties() As String
      Public FilterArray As Boolean         'True=Disabled edit array	in ObjectToEdit
    End Class

    Public Sub EditObject(ByVal ObjectToEdit As Object, ByVal SaveObjectMethod As Common.SaveObjectMethod, Optional ByVal TitleInPageEditor As String = Nothing, Optional ByVal DescriptionInPageEditor As String = Nothing, Optional ByVal TablePropertyPhraseCorrispondence As StringDictionary = Nothing, Optional ByVal TablePropertyIdPhraseCorrispondence As Collections.Generic.Dictionary(Of String, Integer) = Nothing, Optional ByVal NamePhraseBooks As String = Nothing, Optional ByVal BackToCallingPage As Boolean = True, Optional ByVal FilterExcludeProperties() As String = Nothing, Optional ByVal FilterIncludeProperties() As String = Nothing, Optional ByVal FilterArray As Boolean = False)
      Dim EditObjectParameters As New EditObjectParameters
      EditObjectParameters.ObjectToEdit = ObjectToEdit
      EditObjectParameters.SaveObjectMethod = SaveObjectMethod
      EditObjectParameters.TitleInPageEditor = TitleInPageEditor
      EditObjectParameters.DescriptionInPageEditor = DescriptionInPageEditor
      EditObjectParameters.TablePropertyPhraseCorrispondence = TablePropertyPhraseCorrispondence
      EditObjectParameters.TablePropertyIdPhraseCorrispondence = TablePropertyIdPhraseCorrispondence
      EditObjectParameters.NamePhraseBooks = NamePhraseBooks
      EditObjectParameters.BackToCallingPage = BackToCallingPage
      EditObjectParameters.BackPage = IfStr(BackToCallingPage, AbsoluteUri(HttpContext.Current.Request), Nothing)
      EditObjectParameters.FilterExcludeProperties = FilterExcludeProperties
      EditObjectParameters.FilterIncludeProperties = FilterIncludeProperties
      EditObjectParameters.FilterArray = FilterArray
      SendObjectToOtherPage("configeditor.aspx", CObj(EditObjectParameters))
    End Sub

    Public Function RetriveObjectToEdit() As EditObjectParameters
      Return CType(RetriveObjectFromOtherPage(), EditObjectParameters)
    End Function

    Public Sub SendObjectToOtherPage(ByVal ToPageName As String, ByRef Obj As Object)
      Dim ObjCollection As ArrayList
      If HttpContext.Current.Session("SendObject") Is Nothing Then
        ObjCollection = New ArrayList
        HttpContext.Current.Session("SendObject") = ObjCollection
      Else
        ObjCollection = CType(HttpContext.Current.Session("SendObject"), ArrayList)
      End If
      ObjCollection.Add(Obj)
      Dim GoToPage As String = Href(CurrentSubSiteName, False, ToPageName)
      HttpContext.Current.Response.Redirect(GoToPage, True)
    End Sub

    Public Function RetriveObjectFromOtherPage() As Object
      Dim ObjCollection As ArrayList
      If HttpContext.Current.Session("SendObject") IsNot Nothing Then
        ObjCollection = CType(HttpContext.Current.Session("SendObject"), ArrayList)
        If ObjCollection.Count <> 0 Then
          Return ObjCollection(ObjCollection.Count - 1)
        End If
      End If
      Return Nothing
    End Function

    Public Structure Honors
      Public Medal1 As Integer
      Public Medal2 As Integer
      Public Medal3 As Integer
      Public Medal4 As Integer
    End Structure

    MustInherit Class Attributes
      Public Property Attribute(ByVal Name As String) As Object
        Get
          SyncLock Me
            If AttributesCollections.ContainsKey(Name) Then
              Return AttributesCollections(Name)
            End If
          End SyncLock
          Return Nothing
        End Get
        Set(ByVal Value As Object)
          SyncLock Me
            If Value Is Nothing Then
              AttributesCollections.Remove(Name)
            Else
              AttributesCollections(Name) = Value
            End If
          End SyncLock
        End Set
      End Property

      Private AttributesCollections As New System.Collections.Generic.Dictionary(Of String, Object)

      Public Property AttributeArray As KeyValueElement()
        Get
          'Use to serializze collection Attributes
          SyncLock Me
            Dim Array(AttributesCollections.Count - 1) As KeyValueElement
            Dim n As Integer = 0
            'For Each e As Collections.Generic.KeyValuePair(Of String, Object) In I
            For Each Key As String In AttributesCollections.Keys
              Array(n) = New KeyValueElement(Key, AttributesCollections(Key))
              n += 1
            Next
            Return Array
          End SyncLock
        End Get
        Set(ByVal value As KeyValueElement())
          'Use to deserializze collection Attributes
          SyncLock Me
            AttributesCollections.Clear()
            For Each Element As KeyValueElement In value
              AttributesCollections.Add(Element.Key, Element.Value)
            Next
          End SyncLock
        End Set
      End Property

      Class KeyValueElement
        Public Key As String
        Public Value As Object
        Sub New(ByVal Key As String, ByVal Value As Object)
          Me.Key = Key
          Me.Value = Value
        End Sub
        Sub New()
          'Don't delete this Sub: Is necessary for XML serialization
        End Sub
      End Class
    End Class

    MustInherit Class PluginAttributes

      Function IsTrue(ByVal Attribute As String, Optional ByVal Plugin As String = "General") As Boolean
        Dim Result As Object = Me.Attribute(Attribute, Plugin)
        If TypeOf Result Is Boolean Then
          Return CBool(Result)
        End If
        Return False
      End Function

      Function Int(ByVal Attribute As String, Optional ByVal Plugin As String = "General") As Integer
        Dim Result As Object = Me.Attribute(Attribute, Plugin)
        If TypeOf Result Is Integer Then
          Return CInt(Result)
        End If
        Return 0
      End Function

      Public Property Attribute(ByVal Name As String, Optional ByVal Plugin As String = "General") As Object
        Get
          SyncLock Me
            If Plugins.ContainsKey(Plugin) Then
              Dim Dictyonary = Plugins(Plugin)
              If Dictyonary.ContainsKey(Name) Then
                Return Dictyonary(Name)
              End If
            End If
          End SyncLock
          Return Nothing
        End Get
        Set(ByVal Value As Object)
          SyncLock Me
            If Not Plugins.ContainsKey(Plugin) Then
              Dim Attributes As New System.Collections.Generic.Dictionary(Of String, Object)
              Plugins.Add(Plugin, Attributes)
            End If
            Plugins(Plugin)(Name) = Value
          End SyncLock
        End Set
      End Property

      Private Plugins As New System.Collections.Generic.Dictionary(Of String, System.Collections.Generic.Dictionary(Of String, Object))

      Public Property AttributeArray As KeyValueElement()
        Get
          'Use to serializze collection Attributes
          SyncLock Me
            Dim Elements(-1) As KeyValueElement
            Dim n As Integer = 0
            'For Each e As Collections.Generic.KeyValuePair(Of String, Object) In I
            For Each Plugin As String In Plugins.Keys
              Dim Attributes As System.Collections.Generic.Dictionary(Of String, Object) = Plugins(Plugin)
              ReDim Preserve Elements(UBound(Elements) + Attributes.Count)
              For Each Key As String In Attributes.Keys
                Elements(n) = New KeyValueElement(Plugin, Key, Attributes(Key))
                n += 1
              Next
            Next
            Return Elements
          End SyncLock
        End Get
        Set(ByVal value As KeyValueElement())
          'Use to deserializze collection Attributes
          SyncLock Me
            Plugins.Clear()
            For Each Element As KeyValueElement In value
              If Element.Plugin Is Nothing Then
                Element.Plugin = "General"
              End If
              If Not Plugins.ContainsKey(Element.Plugin) Then
                Dim Attributes As New System.Collections.Generic.Dictionary(Of String, Object)
                Plugins.Add(Element.Plugin, Attributes)
              End If
              Plugins(Element.Plugin).Add(Element.Key, Element.Value)
            Next
          End SyncLock
        End Set
      End Property

      Class KeyValueElement
        Public Plugin As String
        Public Key As String
        Public Value As Object
        Sub New(ByVal Plugin As String, ByVal Key As String, ByVal Value As Object)
          Me.Plugin = Plugin
          Me.Key = Key
          Me.Value = Value
        End Sub
        Sub New()
          'Don't delete this Sub: Is necessary for XML serialization
        End Sub
      End Class
    End Class

    Class GoogleSearch
      Shared Function SearchUrl(ByVal KeyWords As String, ByVal Criterion As GoogleSearchCriterion, Optional ByVal InsideDomain As Boolean = True) As String
        Select Case Criterion
          Case GoogleSearchCriterion.Phrase
            KeyWords = """" & KeyWords & """"
          Case GoogleSearchCriterion.Once
            KeyWords = ReplaceBin(KeyWords, " ", " OR ")
        End Select
        Dim Url As String = "http://google.com/search?access=a&q=" & HttpUtility.UrlEncode(KeyWords)
        If InsideDomain Then
          Dim MyHost As String = CurrentDomain()
          Url &= "&sitesearch=" & MyHost
        End If
        If Not String.IsNullOrEmpty(Setup.Affiliations.Google_Client) Then
          Url &= "&client=" & Setup.Affiliations.Google_Client
        End If
        Return Url
      End Function
      Enum GoogleSearchCriterion
        Phrase
        All
        Once
      End Enum
    End Class

    Public CensoredWords As String() = SetCensoredWords()
    Private Function SetCensoredWords() As String()
      Return ReadAllRows(MapPath(ReadWriteDirectory & "/CensoredWords.txt"))
    End Function

    Public NotContentsFromDomains As String() = SetNotContentsFromDomains()
    Private Function SetNotContentsFromDomains() As String()
      Return ReadAllRows(MapPath(ReadWriteDirectory & "/NotContentsFromDomains.txt"))
    End Function

    Sub PageNotFound(ByVal AbsolutePath As String)
      'Generate robot.txt file
      If AbsolutePath.EndsWith("/robots.txt") Then
        RobotTxtDynamic()
        HttpContext.Current.Response.End()
      ElseIf AbsolutePath.EndsWith(".pdf") Then
        If PdfDocument(AbsolutePath) Then
          HttpContext.Current.Response.End()
        End If
      ElseIf AbsolutePath.EndsWith("/sitemap.xml") Then
        If Setup.SEO.GenerateSitemapDynamically Then
          SiteMapGenerator(TypeOfSitemap.Generic)
          HttpContext.Current.Response.End()
        End If
      ElseIf AbsolutePath.EndsWith("/sitemap-images.xml") Then
        If Setup.SEO.GenerateImagesSitemapDynamically Then
          SiteMapGenerator(TypeOfSitemap.Images)
          HttpContext.Current.Response.End()
        End If
      ElseIf AbsolutePath.EndsWith("/favicon.ico") Then
        HttpContext.Current.Response.End()
      ElseIf AbsolutePath.EndsWith("/8bitboy.xml") Then
        Dim Mods As Array = Split(CurrentSetting().Skin().SkinSetup().Variables.Get("bgsound"), ",")
        Mods = RandomSort(Mods)
        HttpContext.Current.Response.Clear()
        HttpContext.Current.Response.ContentType = "text/xml"
        HttpContext.Current.Response.Write("<8bitboy>" & vbCrLf)
        HttpContext.Current.Response.Write("<parameter>" & vbCrLf)
        HttpContext.Current.Response.Write("<param name=""background"" value=""ff000000"" />" & vbCrLf)
        HttpContext.Current.Response.Write("<param name=""foreground"" value=""00000000"" />" & vbCrLf)
        HttpContext.Current.Response.Write("<param name=""autostart"" value=""true"" />" & vbCrLf)
        HttpContext.Current.Response.Write("<param name=""volume"" value="".5"" />" & vbCrLf)
        HttpContext.Current.Response.Write("</parameter>" & vbCrLf)
        HttpContext.Current.Response.Write("<playlist>" & vbCrLf)
        For Each AmigaMod As String In Mods
          HttpContext.Current.Response.Write("<song url=""" & SoundsResources & "/" & AmigaMod & """ hasCredits=""true"" />" & vbCrLf)
        Next
        HttpContext.Current.Response.Write("</playlist>" & vbCrLf)
        HttpContext.Current.Response.Write("</8bitboy>" & vbCrLf)
        HttpContext.Current.Response.End()
      ElseIf AbsolutePath.EndsWith(".mod") Then
        Dim P As Integer = InStrRev(AbsoluteUri(HttpContext.Current.Request), ":80")
        Dim File As String = New System.Uri(AbsolutePath).AbsolutePath
        File = MapPath(File)
        HttpContext.Current.Response.Clear()
        HttpContext.Current.Response.WriteFile(File)
        HttpContext.Current.Response.End()
      Else
        'Remove xxx in http://website.com/xxx/xxx/page.aspx
        Dim Uri As New Uri(AbsolutePath)
        Dim P As Integer = InStrRev(Uri.AbsolutePath, "/", -1, CompareMethod.Binary)
        If P > 1 Then
          Dim RelPath As String = Uri.AbsolutePath.Substring(P - 1)
          Dim Redirect As String = Uri.Scheme & System.Uri.SchemeDelimiter & Uri.Authority & RelPath & Uri.Query
          Extension.Log("redirect", 1000, AbsolutePath, Redirect, HttpContext.Current.Request.UserHostAddress, HostUser())
          HttpContext.Current.Response.RedirectPermanent(Redirect, True)
        End If
      End If
    End Sub

    Public Function RandomSort(ByRef list As Array) As Array
      Dim rand As New Random()
      For i As Integer = 0 To UBound(list)
        Dim tempValue As Object = list.GetValue(i)
        Dim randIdx As Integer = rand.Next(list.Length - i) + i
        list.SetValue(list.GetValue(randIdx), i)
        list.SetValue(tempValue, randIdx)
      Next
      Return (list)
    End Function



    Function RielaborationTextFromWeb(ByVal Url As String, ByVal Language As LanguageManager.Language, Optional ByRef BackHtml As String = Nothing, Optional ByRef BackMetaTags As MetaTags = Nothing) As WebSiteSummary
      Dim Summary As WebSiteSummary = AcquiringMainTextFromWeb(Url, BackHtml, BackMetaTags)
      If Setup.SEO.ChangeTheContentOfAggregatorsUsingSynonyms Then
        If Language = LanguageManager.Language.Italian Then
          Summary.Title = RielaborationText(Summary.Title, Language)
          For N As Integer = 0 To Summary.Body.Count - 1
            Summary.Body(N).Text = RielaborationText(Summary.Body(N).Text, Language)
          Next
        End If
      End If
      If Summary.Body.Count > 0 Then
        Summary.Description = ShortDescriptionFromText(Summary.Body(0).Text)
      End If
      'rewerse keywords
      If Not String.IsNullOrEmpty(Summary.KeyWords) Then
        Dim KeyWords As String() = Split(Summary.KeyWords, ",")
        Dim NewKeyWords(UBound(KeyWords)) As String
        Dim Nk As Integer = 0
        For Each KeyWord As String In KeyWords
          NewKeyWords(UBound(KeyWords) - Nk) = KeyWord
          Nk += 1
        Next
        Summary.KeyWords = Join(NewKeyWords, ",")
      End If
      Return Summary
    End Function

    Function RielaborationText(ByVal Text As String, ByVal Language As LanguageManager.Language) As String
      If Not String.IsNullOrEmpty(Text) Then
        If Language = LanguageManager.Language.Italian Then
          Static Dictionary As SynonymsDictionary
          If Dictionary Is Nothing Then
            Dictionary = ReadLemmasFromTextFile()
          End If
          Dim Chr As Char
          Dim StringBuilder As New System.Text.StringBuilder(256)
          Dim Result As New System.Text.StringBuilder(100 + CInt(Len(Text) * 1.5))
          Dim LastId As Integer = Len(Text) - 1
          Dim EndPhrase As Boolean
          For N As Integer = 0 To LastId
            Chr = Text.Chars(N)
            If Char.IsLetterOrDigit(Chr) Then
              StringBuilder.Append(Chr)
              EndPhrase = False
            Else
              EndPhrase = True
            End If
            If EndPhrase = True OrElse N = LastId Then
              If StringBuilder.Length > 0 Then
                Dim Word As String = StringBuilder.ToString
                StringBuilder.Remove(0, StringBuilder.Length) 'Reset string builder
                Dim Replaced As Boolean = False
                If Word.Length > 3 Then
                  Dim BestLemma As String = Appropriate(Word, Dictionary)
                  If BestLemma IsNot Nothing Then
                    Replaced = True
                    Result.Append(BestLemma)
                  End If
                End If
                If Replaced = False Then
                  Result.Append(Word)
                End If
              End If
              If EndPhrase = True Then
                Result.Append(Chr)
              End If
            End If
          Next
          Return Result.ToString
        End If
      End If
      Return Nothing
    End Function

    Function Appropriate(ByVal Word As String, ByVal Dictionary As SynonymsDictionary) As String
      'Dim Scores As Collections.Generic.IDictionary(Of String, Integer)
      Dim BestLemma As String = Nothing
      Dim BestScore As Integer = 0
      If Dictionary.Lemmas.ContainsKey(Word) Then
        Dim Lemmas As StringCollection = Dictionary.Lemmas(Word)
        'If Lemmas.Count < 6 Then
        Dim EndChar As Char = Word.Chars(Word.Length - 1)
        For Each Lemma As String In Lemmas
          If Lemma.Last = EndChar Then
            Dim Score As Integer
            Score = 0
            Dim EndN As Integer
            If Len(Lemma) > Len(Word) Then
              EndN = Len(Word) - 1
            Else
              EndN = Len(Lemma) - 1
            End If
            For N As Integer = 0 To EndN
              If Word.Chars(N) = Lemma.Chars(N) Then
                Score += 1
              Else
                Exit For
              End If
            Next
            Dim StartN As Integer
            If Len(Lemma) > Len(Word) Then
              StartN = Len(Word) - 1
            Else
              StartN = Len(Lemma) - 1
            End If
            For N = StartN To 0 Step -1
              If Word.Chars(N) = Lemma.Chars(N) Then
                Score += 1
              Else
                Exit For
              End If
            Next
            If Score > BestScore Then
              BestLemma = Lemma
            End If
          End If
        Next
        'End If
        If Lemmas.Count < 4 OrElse BestScore > 2 Then
          Return BestLemma
        End If
      End If
      Return Nothing
    End Function

    Function CleanText(ByVal Text As String) As String
      Dim StringBuilder As New System.Text.StringBuilder(Text.Length)
      For Each Chr As Char In Text.ToCharArray
        If Not Char.IsControl(Chr) Then
          StringBuilder.Append(Chr)
        ElseIf Chr = ControlChars.Lf Then
          StringBuilder.Append(Chr)
        End If
      Next
      Return Trim(StringBuilder.ToString)
    End Function

    Function SimilarText(ByVal Text1 As String, ByVal Text2 As String) As Boolean
      If Len(Text1) > Len(Text2) Then
        Dim TmpText As String = Text2
        Text2 = Text1
        Text1 = TmpText
      End If
      If Len(Text2) / Len(Text1) < 3 Then
        If CBool(InStr(Text2, Text1, CompareMethod.Text)) Then
          Return True
        End If
        Dim Words1 As String() = Words(LCase(Text1))
        Dim Words2 As String() = Words(LCase(Text2))
        If Words1.Length > 1 AndAlso Words2.Length > 1 Then
          If Words2.Length > Words1.Length Then
            Dim Swap As String()
            Swap = Words2
            Words2 = Words1
            Words1 = Swap
          End If
          Dim Find As Integer = 0
          Dim NoFind As Integer = 0
          For Each Word1 As String In Words1
            Dim Index As Integer = Array.IndexOf(Words2, Word1)
            If Index > -1 Then
              Find += 1
              Words1(Index) = Nothing
            Else
              NoFind += 1
            End If
          Next
          If NoFind = 0 Then
            Return True
          ElseIf Find / NoFind > 1.3 OrElse Find > 6 Then
            Return True
          End If
        End If
      End If
      Return False
    End Function

    Class WebSiteSummary
      Public Title As String
      Public Description As String
      Public KeyWords As String
      Public Body As New System.Collections.Generic.List(Of WebElement)
      Function HaveText() As Boolean
        For Each Element As WebElement In Body
          If Element.Type = TypeWebElement.Text Then
            Return True
          End If
        Next
        Return False
      End Function
      Function Control() As Control
        Dim Setting As Config.SubSite = Config.CurrentSetting()
        'Dim Language As LanguageManager.Language = Setting.Language
        Dim KeyWords As String() = Split(Me.KeyWords, ",")
        SortStringByLength(KeyWords)

        Dim Ctrl As New HtmlGenericControl("article") 'html5
        Ctrl.Attributes.Add("itemscope", "itemscope")
        Ctrl.Attributes.Add("itemtype", "http://schema.org/NewsArticle")

        Dim DomainConfiguration As DomainConfiguration = CurrentDomainConfiguration()
        Dim H1 As New WebControl(HtmlTextWriterTag.H1)
        H1.Controls.Add(GetHtmlControl(Me.Title, KeyWords, Setting, DomainConfiguration))
        H1.Attributes.Add("itemprop", "name")
        Ctrl.Controls.Add(H1)

        Dim ArticleBody As New WebControl(HtmlTextWriterTag.Div)
        ArticleBody.Attributes.Add("itemprop", "articleBody")
        Ctrl.Controls.Add(ArticleBody)

        For Each WebElement As WebElement In Me.Body
          Select Case WebElement.Type
            Case TypeWebElement.Title
              Dim H2 As New WebControl(HtmlTextWriterTag.H2)
              H2.Controls.Add(GetHtmlControl(WebElement.Text, KeyWords, Setting, DomainConfiguration))
              ArticleBody.Controls.Add(H2)
            Case Else
              Dim P As New WebControl(HtmlTextWriterTag.P)
              P.Controls.Add(GetHtmlControl(WebElement.Text, KeyWords, Setting, DomainConfiguration))
              ArticleBody.Controls.Add(P)
          End Select
        Next
        Return Ctrl
      End Function

      Private Function GetHtmlControl(ByVal Text As String, Keywords As String(), Setting As SubSite, DomainConfiguration As DomainConfiguration) As LiteralControl
        Dim Html As String
        Html = HttpUtility.HtmlEncode(Text)
        Html = StrongKeyWords(Html, Keywords, Setting)
        ContextualLink.AddContextualLinks(Html, Setting, Setting.MainArchive)
        Html = ReplaceBin(Html, vbLf, "<br />")
        Return New LiteralControl(Html)
      End Function

      Private Function StrongKeyWords(ByVal Text As String, ByVal KeyWords As String(), Setting As SubSite) As String
        Dim MinLenKeyword As Integer
        Select Case Setting.Language
          Case LanguageManager.Language.Chinese
            MinLenKeyword = 1
          Case Else
            MinLenKeyword = 4
        End Select
        For Each Element As String In KeyWords
          Dim KeyWord As String = Trim(Element)
          If Not String.IsNullOrEmpty(KeyWord) Then
            If Len(KeyWord) >= MinLenKeyword OrElse Char.IsUpper(KeyWord(0)) Then
              Dim P As Integer
              P = 1
              Do
                P = InStr(P, Text, KeyWord, CompareMethod.Text)
                If CBool(P) Then
                  Text = Text.Substring(0, P - 1) & "<strong>" & Text.Substring(P - 1, KeyWord.Length) & "</strong>" & Text.Substring(P - 1 + KeyWord.Length)
                  P = P + 17 + KeyWord.Length
                Else
                  Exit Do
                End If
              Loop
            End If
          End If
        Next
        Return Text
      End Function
    End Class

    Sub InsertWebSiteSummary(ByVal WebSiteSummary As WebSiteSummary, ByVal ApplyToMasterPage As Components.MasterPageEnhanced)
      MetaTagFromWebSiteSummary(WebSiteSummary, ApplyToMasterPage)
      If ApplyToMasterPage.Setting.SEO.CopyPrevention.FromExternalSources Then
        ApplyToMasterPage.ContentPlaceHolder.Controls.Add(ObfuscateHtml(WebSiteSummary.Control, ApplyToMasterPage.Setting))
      Else
        ApplyToMasterPage.ContentPlaceHolder.Controls.Add(WebSiteSummary.Control)
      End If
    End Sub

    Sub MetaTagFromWebSiteSummary(ByVal WebSiteSummary As WebSiteSummary, ByVal ApplyToMasterPage As Components.MasterPageEnhanced)
      ApplyToMasterPage.TitleDocument = WebSiteSummary.Title
      ApplyToMasterPage.Description = WebSiteSummary.Description
      ApplyToMasterPage.KeyWords = WebSiteSummary.KeyWords
    End Sub

    Class WebElement
      Public Type As TypeWebElement
      Public Text As String
      Sub New(ByVal Type As TypeWebElement)
        Me.Type = Type
      End Sub
    End Class
    Enum TypeWebElement
      Title
      Text
    End Enum



    Class SynonymsDictionary
      Public Lemmas As New Collections.Generic.Dictionary(Of String, Collections.Specialized.StringCollection)
      Public Language As LanguageManager.Language
    End Class
    Function ReadLemmasFromTextFile() As SynonymsDictionary
      Dim Stream As New System.IO.StreamReader(MapPath(ReadWriteDirectory & "\SynonymsDictionary.it.txt"))
      Dim Lemmas As New SynonymsDictionary
      Lemmas.Language = LanguageManager.Language.Italian
      Dim NextLineIsNewLemma As Boolean = True
      Dim NewLine As String = Nothing
      Do Until Stream.EndOfStream = True
        Dim Line As String = Stream.ReadLine
        Dim P As Integer = Line.IndexOf(","c)
        If Line.IndexOf(" "c) < P Then
          NextLineIsNewLemma = False
        End If
        If NextLineIsNewLemma Then
          NewLine = ""
        End If
        NewLine &= Trim(Line)
        If NextLineIsNewLemma = False Then
          NextLineIsNewLemma = True
        End If

        If NewLine.Length > 2 Then
          If Not Line.EndsWith(".") Then
            NextLineIsNewLemma = False
          End If

          If NextLineIsNewLemma Then
            Dim Syn As Collections.Specialized.StringCollection

            NewLine = ReplaceBin(NewLine, "||", ",")
            NewLine = ReplaceBin(NewLine, "|", ",")
            Dim Lemma As String = Extension.Left(NewLine, P)
            If Lemmas.Lemmas.ContainsKey(Lemma) Then
              Syn = Lemmas.Lemmas(Lemma)
            Else
              Syn = New Collections.Specialized.StringCollection
            End If

            Dim N As Integer = 0
            For Each SinDot As String In Strings.Split(NewLine, "sin.", -1, CompareMethod.Text)
              If CBool(N) Then
                Dim ContrDot As String() = Strings.Split(SinDot, "contr.", -1, CompareMethod.Text)
                Dim Part As String = ContrDot(0)
                Dim P2 As Integer = Part.IndexOf(".")
                If P2 <> -1 Then
                  Part = Extension.Left(Part, P2)
                End If
                Dim Sins As String() = Strings.Split(Part, ",", -1, CompareMethod.Binary)
                For Each EachSin As String In Sins
                  Dim Sin As String = Trim(EachSin)
                  If Len(Sin) > 2 Then
                    Dim Add As Boolean = True
                    For Each C As Char In Sin
                      If Not Char.IsLetter(C) AndAlso C <> " "c Then
                        Add = False
                        Exit For
                      End If
                    Next
                    If Add Then
                      Syn.Add(Sin)
                    End If
                  End If
                Next
              End If
              N += 1
            Next
            If Not Lemmas.Lemmas.ContainsKey(Lemma) Then
              Lemmas.Lemmas.Add(Lemma, Syn)
            End If
          End If
        Else
          NextLineIsNewLemma = True
        End If
      Loop
      Return Lemmas

    End Function

    Sub IpToCountryFlag(ByVal Ip As String)
      Dim Html As String = ReadHtmlFromWeb("http://madm.dfki.de/demo/ip-countryside/?ip=" & Ip)
      Dim P As Integer = Html.IndexOf("flags/")
      If P > 0 Then
        Dim NameFile As String = Html.Substring(P + 6, 2) & ".gif"
        Dim Response As System.Web.HttpResponse = HttpContext.Current.Response
        Response.Redirect(ImgagesResources & "/flags/" & NameFile)
        'Response.ContentType = "image/gif"
        'Response.Write(ReadAll(MapPath(ImgagesResources & "/flags/" & NameFile)))
        'Response.End()
      End If
    End Sub

    Sub RobotTxtDynamic()
      Dim DomainConfiguration As DomainConfiguration = CurrentDomainConfiguration()
      Dim Response As System.Web.HttpResponse = HttpContext.Current.Response
      Dim Write As New StringBuilder

      Response.Clear()
      Response.ContentType = "text/plain"
      Write.Append("Request-rate: 1/10" & vbCrLf)

      If Setup.SEO.GenerateSitemapDynamically Then
        Write.Append("Sitemap: " & PathCurrentUrl() & "sitemap.xml" & vbCrLf)
      End If

      If Setup.SEO.GenerateImagesSitemapDynamically Then
        Write.Append("Sitemap: " & PathCurrentUrl() & "sitemap-images.xml" & vbCrLf)
      End If

      'http://support.google.com/webmasters/bin/answer.py?hl=it&answer=156449&from=35237&rd=1
      Write.Append("User-agent: *" & vbCrLf)
      Dim Subsities As Collections.Generic.List(Of SubSite) = DomainConfiguration.SubSites()
      If Subsities.Count = 1 Then
        If Subsities(0).SEO.Indexing = SubSite.SeoFunctions.IndexingDirective.Noindex Then
          Write.Append("Disallow: /" & vbCrLf)
        Else
          If Subsities(0).SEO.Indexing = SubSite.SeoFunctions.IndexingDirective.Index Then
            Write.Append("Disallow:" & vbCrLf)
          Else
            Dim Noindex As String = Subsities(0).SEO.Indexing.ToString
            Dim Boot As String = LCase(Noindex.Substring(0, Noindex.Length - 7))
            Write.Append("Disallow:" & vbCrLf)
            Write.Append("User-agent: " & Boot & vbCrLf)
            Write.Append("Disallow: /" & vbCrLf)
          End If
        End If
      Else
        Write.Append("Disallow:" & vbCrLf)
        Dim Id As Integer = 0
        For Each SubSite As SubSite In Subsities
          Dim Indexing As Config.SubSite.SeoFunctions.IndexingDirective = SubSite.SEO.Indexing
          Dim Noindex As String = Indexing.ToString
          If Noindex.EndsWith("Noindex") Then
            Dim Boot As String = LCase(Noindex.Substring(0, Noindex.Length - 7))
            If String.IsNullOrEmpty(Boot) Then Boot = "*"
            Write.Append("User-agent: " & Boot & vbCrLf)
            If Id = 0 Then
              Write.Append("Disallow: /" & vbCrLf)
              For Each SubSite2 In Subsities
                If SubSite2.SEO.Indexing <> SubSite.SEO.Indexing Then
                  Write.Append("Allow: /*?ss=" & SubSite2.Name & "&" & vbCrLf)
                  Write.Append("Allow: /*?ss=" & SubSite2.Name & "$" & vbCrLf)
                End If
              Next
            Else
              Write.Append("Disallow: /*?ss=" & SubSite.Name & "&" & vbCrLf)
              Write.Append("Disallow: /*?ss=" & SubSite.Name & "$" & vbCrLf)
            End If
          End If
          Id += 1
        Next
      End If
      Dim Text As String = Write.ToString
      PluginManager.RaiseRobotsTxtPreRenderEvent(Text, DomainConfiguration)
      Response.Write(Text)
      Response.End()
    End Sub

    Sub UpdateIndexedPagesOnGoogle()
      If Setup.SEO.AtGooglebotExcludeIndexedPagesInSitemap Then
        For Each DomainName As String In AllDomainNames()
          Dim Domain As Config.DomainConfiguration = Config.DomainConfiguration.Load(DomainName)
          If String.IsNullOrEmpty(Domain.Redirect) Then
            UpdateIndexedPagesOnGoogle(DomainName)
          End If
        Next
      End If
    End Sub

    Class GoogleIndexedPages
      Public DateOfUpdate As Date
    End Class

    Sub UpdateIndexedPagesOnGoogle(ByVal Domain As String)
      Extension.Log("UpdateIndexedPagesOnGoogle", 1000, "start", Domain)
      Dim LastUpdate As GoogleIndexedPages = CType(LoadObject(GetType(GoogleIndexedPages), Domain), GoogleIndexedPages)
      If LastUpdate Is Nothing OrElse Math.Abs(DateDiff(DateInterval.Hour, LastUpdate.DateOfUpdate, Now.ToUniversalTime())) > 72 Then
        LastUpdate = New GoogleIndexedPages
        LastUpdate.DateOfUpdate = Now.ToUniversalTime()
        SaveObject(LastUpdate, Domain)
        Dim Pages As StringCollection = CType(LoadObject(GetType(StringCollection), "googleidx_" & Domain), StringCollection)

        If Pages Is Nothing Then
          Pages = New StringCollection
        End If
        Try
          WebApplication.Search.FindAllResults(Pages, Nothing, Domain)
          SaveObject(Pages, "googleidx_" & Domain)
          Extension.Log("UpdateIndexedPagesOnGoogle", 1000, "save", Domain)
        Catch ex As Exception
          Extension.Log("UpdateIndexedPagesOnGoogle", 1000, "error", Domain, ex.Message, Domain)
          SaveObject(Pages, "googleidx_" & Domain)
          Extension.Log("UpdateIndexedPagesOnGoogle", 1000, "save", Domain)
        End Try
        Extension.Log("UpdateIndexedPagesOnGoogle", 1000, "end", Domain)
      Else
        Extension.Log("UpdateIndexedPagesOnGoogle", 1000, "skip", Domain)
      End If
    End Sub

    Sub UpdateBlogAggregator()
      For Each Setup As SubSite In AllSubSite()
        If Not Setup.NotExist Then
          Setup.UpdateBlogAggregator()
        End If
      Next
    End Sub

    Function AlexaTrafficRank(ByVal Domain As String, Optional ByRef Html As String = Nothing) As Double
      Dim Timeout As Integer = 20000

      Dim Url As String
      Url = "http://www.alexa.com/siteinfo/" & Domain

      'Use google proxy
      'Url = "http://98.139.168.220/babelfish/translate_url_content?.intl=us&lp=it_en&trurl=" & System.Web.HttpUtility.HtmlEncode(Url)	'Remove this for non proxy

      Html = ReadHtmlFromWeb(Url, System.Text.Encoding.GetEncoding("windows-1251"), Timeout)

      If InStr(Html, "No Data</li>") <> 0 OrElse InStr(Html, "data up"">No data</a>") <> 0 Then
        Return 0
      Else
        Return Microsoft.VisualBasic.Val(ReplaceBin(AlexaTrafficRankByHtml(Html), ",", ""))
      End If

    End Function

    Private Function AlexaTrafficRankByHtml(ByVal Html As String) As String
      Dim p As Integer
      Dim Find As String = """data down"">"
      p = InStr(Html, Find)
      If p = 0 Then
        Find = """data steady"">"
        p = InStr(Html, Find)
      End If
      If p = 0 Then
        Find = """data up"">"
        p = InStr(Html, Find)
      End If

      If CBool(p) Then
        p = p + Find.Length
        p = InStr(p, Html, ">") + 1
        Dim p2 As Integer = InStr(p, Html, "<")
        Return Mid(Html, p, p2 - p)
      End If
      Return Nothing
    End Function

    Function HostUser() As String
      Try
        Return System.Net.Dns.GetHostEntry(HttpContext.Current.Request.UserHostAddress).HostName.ToString()
      Catch ex As Exception
      End Try
      Return Nothing
    End Function

    Function CurrentDomain(Optional ByVal Context As System.Web.HttpContext = Nothing) As String
      If Context Is Nothing Then Context = HttpContext.Current
      If Context IsNot Nothing Then
        'Dim Domain As String = Context.Request.Url.Host
        Dim Domain As String = DomainName(Context.Request)
        If Domain IsNot Nothing Then
          If Domain.StartsWith("www.") Then
            Domain = Mid(Domain, 5)
          End If
          Return Domain.ToLower()
        End If
      End If
      Return Nothing
    End Function

    Function DomainOfWebsite(Url As String, Optional AddScheme As Boolean = False) As String
      Dim Uri As New System.Uri(Url)
      If AddScheme Then
        Return Uri.Scheme & Uri.SchemeDelimiter & Uri.Host
      Else
        Return Uri.Host
      End If
    End Function

    Function PathUrl(ByVal Url As String) As String
      Dim P As Integer = InStr(Url, "?")
      If CBool(P) Then
        Url = Extension.Left(Url, P)
      End If
      Return Extension.Left(Url, InStrRev(Url, "/"))
    End Function

    Function PathCurrentUrl() As String
      Return PathUrl(AbsoluteUri(HttpContext.Current.Request))
    End Function

    Function HrefGoogleAddBookmarks(ByVal Language As LanguageManager.Language, ByVal Title As String, ByVal Url As String, ByVal Label As String) As String
      Dim Acronym As String
      If Language = LanguageManager.Language.Chinese Then
        Acronym = "zh-CN"
      Else
        Acronym = LanguageManager.Acronym(Language)
      End If
      Return "http://www.google.com/bookmarks/mark?op=add&hl=" & Acronym & "&title=" & HttpUtility.UrlEncode(Title) & "&bkmk=" & HttpUtility.UrlEncode(Url) & "&labels=" & HttpUtility.UrlEncode(Label)
    End Function

    Private Sub ReadCopyright()
      Dim Lines As String() = ReadAllRows(MapPath("readme.txt"))
      CopyrightDescription = Lines(0)
      CopyrightLink = Lines(1)
    End Sub
    Private CopyrightApplication As String
    Private CopyrightLinkApplication As String
    Property CopyrightDescription() As String
      Get
        If CopyrightApplication Is Nothing Then
          ReadCopyright()
        End If
        Return CopyrightApplication
      End Get
      Set(ByVal value As String)
        CopyrightApplication = value
      End Set
    End Property
    Property CopyrightLink() As String
      Get
        If CopyrightLinkApplication Is Nothing Then
          ReadCopyright()
        End If
        Return CopyrightLinkApplication
      End Get
      Set(ByVal value As String)
        CopyrightLinkApplication = value
      End Set
    End Property

    Function Translate(ByVal Text As String, ByVal Source As LanguageManager.Language, ByVal Target As LanguageManager.Language) As String
      'Translation routine via Google Translator
      Dim UrlService As String = "http://translate.google.com/translate_t?ie=UTF-8&text=" & System.Web.HttpUtility.UrlEncode(Text) & "&sl=" & AcronymForOnlineTranslate(Source) & "&tl=" & AcronymForOnlineTranslate(Target) & "#"
      Dim Html As String = ReadHtmlFromWeb(UrlService, System.Text.Encoding.UTF8)
      Dim PositionStart As Integer = InStr(Html, "id=result_box", CompareMethod.Text)
      If CBool(PositionStart) Then
        PositionStart = InStr(PositionStart, Html, ">", CompareMethod.Text)
        Dim PositionEnd = InStr(PositionStart, Html, "</", CompareMethod.Text)
        Html = Html.Substring(PositionStart, PositionEnd - PositionStart - 1)
        Html = ReplaceBin(Html, "<br> ", "<br />")
        Return InnerText(Html)
      End If
      Return Nothing
    End Function

    Private Function AcronymForOnlineTranslate(Language As Language) As String
      Select Case Language
        Case LanguageManager.Language.Czech
          Return "CS"
        Case LanguageManager.Language.Vietnamese
          Return "VI"
        Case Else
          Return Acronym(Language)
      End Select
    End Function

    Function IsProxy(ByVal IP As String) As Boolean
      Try
        Dim Html As String = ReadHtmlFromWeb("http://whatismyipaddress.com/staticpages/index.php/lookup-results?ip=" & IP, System.Text.Encoding.GetEncoding("windows-1251"), 10000)
        If Not String.IsNullOrEmpty(Html) AndAlso InStr(Html, "Confirmed proxy server") > 0 Then
          Return True
        End If
      Catch ex As Exception
      End Try
      Return False
    End Function

    Function CssBigInput() As String
      Return "<style type=""text/css"">" & _
      ".BigInput" & _
      "{font-size: 1.8em;}" & _
      "</style>"
    End Function

    Function RedirectDomain() As Boolean
      Dim DomainConfiguration As DomainConfiguration = CurrentDomainConfiguration()
      'Redirect if redirect is setting for this host
      If Not String.IsNullOrEmpty(DomainConfiguration.Redirect) Then
        Dim Redirect As String = DomainConfiguration.Redirect
        Dim Url As String = AbsoluteUri(HttpContext.Current.Request)
        If InStr(Redirect, "://") = 0 Then
          If InStr(Url, "://www.") <> 0 AndAlso Not Redirect.StartsWith("www.", StringComparison.InvariantCultureIgnoreCase) Then
            Dim Counter As Integer = CountChar(Redirect, "."c)
            If Counter <= 1 Then 'Exclude third-level domains
              Redirect = "www." & Redirect
            End If
          End If
          Redirect = "http://" & Redirect
        End If
        If Not Redirect.Last = "/"c Then
          Redirect &= "/"
        End If
        HttpContext.Current.Response.RedirectPermanent(Redirect & CurrentPage(), True)
      End If

      'Redirect to another host if this is not correct for this setting
      If HttpContext.Current.Request.QueryString("ss") IsNot Nothing Then
        Dim Domain As Config.DomainConfiguration = DomainConfiguration
        If Domain IsNot Nothing Then
          If Not IsLocal() Then
            Dim SubSiteName As String = CurrentSubSiteName()
            Dim SubSiteValid As Boolean = False
            For Each SubSite As String In Domain.SubSitesAvailable()
              If StrComp(SubSiteName, SubSite, CompareMethod.Text) = 0 Then
                SubSiteValid = True
                Exit For
              End If
            Next
            If Not SubSiteValid Then
              'This subsite is not valid for this host! Then make a REDIRECT
              Dim TryDomain As Config.DomainConfiguration
              Dim SubSitesAvailable As String()
              For Each DomainName As String In AllDomainNames()
                TryDomain = Config.DomainConfiguration.Load(DomainName)
                If TryDomain IsNot Nothing Then
                  SubSitesAvailable = TryDomain.SubSitesAvailable()
                Else
                  SubSitesAvailable = Nothing
                End If
                If TryDomain IsNot Nothing AndAlso SubSitesAvailable.Length <> 0 Then
                  If String.IsNullOrEmpty(TryDomain.Redirect) Then
                    For Each SubSite As String In SubSitesAvailable
                      If StrComp(SubSiteName, SubSite, CompareMethod.Text) = 0 Then
                        'redirect
                        RedirectToDomain(TryDomain, SubSiteName)
                        Return True
                      End If
                    Next
                  End If
                End If
              Next
              Error404()
            End If
          End If
        End If
      End If
      Return False
    End Function

    Sub Error404()
      Dim Response As HttpResponse = HttpContext.Current.Response
      Response.Clear()
      Response.Status = "404 PageNotFound"
      Response.StatusCode = 404
      Response.StatusDescription = "Page not found."
      Response.Flush()
      Response.End()
    End Sub

    Sub Error410()
      Dim Response As HttpResponse = HttpContext.Current.Response
      Response.Clear()
      Response.Status = "410 PageNotFound"
      Response.StatusCode = 410
      Response.StatusDescription = "The resource requested is no longer available and will not be available again."
      Response.Flush()
      Response.End()
    End Sub


    Sub RedirectToDomain(ByVal DomainConfiguration As DomainConfiguration, SubSite As String)
      Dim Uri As System.Uri
      Dim PathAndQuery As String = HttpContext.Current.Request.Url.PathAndQuery
      Dim Position As Integer = InStr(PathAndQuery, "?404;")
      If CBool(Position) Then
        Uri = New System.Uri(ReplaceBin(PathAndQuery.Substring(Position + 4), ":80/", "/"))
      Else
        Uri = HttpContext.Current.Request.Url
      End If
      Dim Params() As String = Nothing
      Dim NameValueCollection = System.Web.HttpUtility.ParseQueryString(Uri.Query)
      For Each Key In NameValueCollection.AllKeys
        If Key <> "ss" Then
          AddElement(Params, Key)
          AddElement(Params, NameValueCollection(Key))
        End If
      Next
      Dim Redirect As String
      If Params Is Nothing Then
        Redirect = Href(DomainConfiguration, SubSite, True, System.IO.Path.GetFileName(Uri.AbsolutePath))
      Else
        Redirect = Href(DomainConfiguration, SubSite, True, System.IO.Path.GetFileName(Uri.AbsolutePath), Params)
      End If
      Extension.Log("redirect", 1000, AbsoluteUri(HttpContext.Current.Request), Redirect)
      HttpContext.Current.Response.RedirectPermanent(Redirect, True)
    End Sub

    'Sub RedirectToDomain(ByVal DomainName As String, Optional ByVal RemoveSubSiteName As String = Nothing, Optional ByVal RemoveSubSiteInformation As Boolean = False)
    '  Dim AddUrl As String = HttpContext.Current.Request.Url.PathAndQuery
    '  Dim Position As Integer = InStr(AddUrl, "?404;")
    '  If CBool(Position) Then
    '    Dim Uri As New System.Uri(ReplaceBin(AddUrl.Substring(Position + 4), ":80/", "/"))
    '    AddUrl = Uri.PathAndQuery
    '  End If

    '  If RemoveSubSiteInformation Then
    '    RemoveSubSiteName = HttpContext.Current.Request.QueryString("ss")
    '  End If
    '  If RemoveSubSiteName IsNot Nothing Then
    '    Dim ss As String = "ss=" & RemoveSubSiteName
    '    AddUrl = ReplaceText(AddUrl, ss & "&", "")
    '    AddUrl = ReplaceText(AddUrl, "?" & ss, "")
    '    AddUrl = ReplaceText(AddUrl, "&" & ss, "")
    '  End If
    '  Dim Redirect As String = HttpContext.Current.Request.Url.Scheme & "://" & DomainName & AddUrl
    '  Dim DomainUser As String = HostUser()
    '  Extension.Log("redirect", 1000, AbsoluteUri(HttpContext.Current.Request), Redirect, HttpContext.Current.Request.UserHostAddress, DomainUser)
    '  HttpContext.Current.Response.RedirectPermanent(Redirect, True)
    'End Sub

    Function CurrentUri() As String
      Return PathCurrentUrl() & CurrentPage()
    End Function

    Function CurrentPage() As String
      Dim PageUrl As String
      If HttpContext.Current.Request.Url.Query.StartsWith("?404;") Then
        PageUrl = ReplaceBin(HttpContext.Current.Request.Url.Query.Substring(5), ":80/", "/")
        Dim Uri As New System.Uri(PageUrl)
        PageUrl = Uri.PathAndQuery.Substring(1)
      Else
        PageUrl = HttpContext.Current.Request.Url.PathAndQuery.Substring(1)
      End If
      If PageUrl.StartsWith("default.aspx", StringComparison.InvariantCultureIgnoreCase) Then
        If StrComp(PageUrl, "default.aspx", CompareMethod.Text) = 0 Then
          PageUrl = ""
        Else
          PageUrl = PageUrl.Substring(12)
        End If
      End If
      Return PageUrl
    End Function

    Sub RedirectToHomePage(Optional Setting As SubSite = Nothing, Optional Permanent As Boolean = True)
      If Setting Is Nothing Then
        Setting = CurrentSetting()
      End If
      If Permanent Then
        HttpContext.Current.Response.RedirectPermanent(Href(Setting.Name, False, "default.aspx"), True)
      Else
        HttpContext.Current.Response.Redirect(Href(Setting.Name, False, "default.aspx"), True)
      End If
    End Sub

    Function HomePage() As String
      Return PathUrl(AbsoluteUri(HttpContext.Current.Request))
    End Function

    Class Attribute
      Public Name As String
      Public Value As Object
      Public Sub New(ByVal Name As String, ByVal Value As Object)
        Me.Name = Name
        Me.Value = Value
      End Sub
    End Class
    Public Function StringToDate(ByVal Text As String) As Date
      Dim Text2 As String = Nothing
      For Each C As Char In Text.ToCharArray
        If Char.IsDigit(C) Then
          Text2 &= C
        Else
          Text2 &= " "
        End If
      Next
      Text2 = Trim(Text2)
      Dim Datas() As String = Split(Trim(Text2))
      Return DateSerial(CInt(Datas(2)), CInt(Datas(1)), CInt(Datas(0)))
    End Function

    Public SubSiteToDomain As Collections.Specialized.StringDictionary
    Public ArchiveToDomain As Collections.Generic.Dictionary(Of Language, Collections.Generic.Dictionary(Of Integer, String))

    Function DomaniForThisArchive(Archive As Integer, Language As Language) As String
      Return ArchiveToDomain(Language)(Archive)
    End Function

    Function UrlPointToThisNetwork(ByVal url As String) As Boolean
      Dim Domain As String = ExtrapolateDomainName(url)
      For Each DomainInNetwork As String In AllDomainNames()
        If Domain = DomainInNetwork Then
          Return True
        End If
      Next
      Return False
    End Function


    Function UrlToLink(ByVal Html As String, ByVal Setting As SubSite, ByVal DomainConfiguration As DomainConfiguration, Optional ByVal TargetInNewPage As Boolean = False) As String
      'Note:
      'If Setting is Nothing then ignore setting configuration and permit the externals links

      'No permit external out of this network
      If Setting Is Nothing OrElse Setting.SEO.TransformationOfTheUrlInTheText <> SubSite.SeoFunctions.UrlTransformation.NoTransformation Then
        Dim Timeout As Date = Now.AddMilliseconds(100)
        If Not String.IsNullOrEmpty(Html) Then
          Dim MapHtml() As Boolean
          Dim Prefixs() As String = {"https://", "http://", "www."}
          For Each Prefix As String In Prefixs
            MapHtml = CheckHtml(Html)
            Dim Position As Integer = Html.Length
            Do
              Position = InStrRev(Html, Prefix, Position)
              If CBool(Position) AndAlso (Position = 1 OrElse Not Char.IsLetterOrDigit(Html(Position - 2))) Then
                If Not MapHtml(Position) Then
                  Position -= 1 '(Convert base 1 to base 0)
                  Dim C As Char
                  Dim StringBuilder As New StringBuilder(1024)
                  For N As Integer = Position To Html.Length - 1
                    C = Html(N)
                    If C = " "c OrElse Char.IsControl(C) OrElse MapHtml(N) Then
                      Exit For
                    Else
                      StringBuilder.Append(C)
                    End If
                  Next
                  'Remove last caracters not for link
                  For RevN As Integer = StringBuilder.Length - 1 To 0 Step -1
                    C = StringBuilder(RevN)
                    If Not Char.IsLetterOrDigit(C) AndAlso C <> "/"c Then
                      StringBuilder.Remove(RevN, 1)
                    Else
                      'Verify if the link point to this network
                      Dim Href As String = StringBuilder.ToString
                      Dim OpenInFrame As Boolean
                      Dim Link As New HyperLink
                      If Setting Is Nothing Then
                        OpenInFrame = False
                      Else
                        If Setting.SEO.TransformationOfTheUrlInTheText <> SubSite.SeoFunctions.UrlTransformation.ExternalLinksInFrames Then
                          OpenInFrame = False
                        Else
                          OpenInFrame = Not UrlPointToThisNetwork(Href)
                        End If
                        If Setting.SEO.TransformationOfTheUrlInTheText = SubSite.SeoFunctions.UrlTransformation.RelNofollowLinksToPage Then
                          Link.Attributes.Add("rel", "nofollow")
                        End If
                      End If
                      If TargetInNewPage Then
                        Link.Target = "_blank"
                      End If
                      Dim LenHref As Integer = Len(Href)
                      Link.Text = HttpUtility.HtmlEncode(TruncateText(HttpUtility.HtmlDecode(Href), 50))
                      If Not Href.StartsWith("http") Then
                        If InStr(5, Href, ".") = 0 Then
                          'Exclude url like www.siteexemple (without firs level domine)
                          Href = Nothing
                        End If
                        Href = "http://" & HttpUtility.HtmlDecode(Href) 'This is the most powerful of the StringBuilder, do not change!
                      Else
                        Href = HttpUtility.HtmlDecode(Href)
                      End If
                      If Href.Length > 7 AndAlso Uri.IsWellFormedUriString(Href, UriKind.Absolute) Then
                        Link.ToolTip = EncodingAttribute(Href)
                        If OpenInFrame Then
                          Link.NavigateUrl = Common.Href(DomainConfiguration, Setting.Name, False, "default.aspx", QueryKey.Show, DefaultPageShowType.ExternalPage, QueryKey.Url, Href.Substring(Href.IndexOf("/"c) + 2))
                        Else
                          Link.NavigateUrl = Href
                        End If
                        Dim ControlHtml As String = ControlToText(Link)
                        Html = Mid(Html, 1, Position) & ControlHtml & Mid(Html, Position + 1 + LenHref) 'This is the most powerful of the StringBuilder, do not change!
                      End If
                      Exit For
                    End If
                  Next
                End If
              End If
            Loop Until Position = 0 OrElse Now > Timeout
          Next
        End If
      End If
      Return Html
    End Function

    Function ExtrapolateDomainName(ByVal Url As String, Optional ByVal NoWWW As Boolean = True) As String
      Url = LCase(Url)
      Dim Div As Integer = InStr(Url, "://", CompareMethod.Binary)
      If Div > 0 Then
        Url = Mid(Url, Div + 3)
      End If
      If NoWWW Then
        If Url.StartsWith("www.", StringComparison.InvariantCulture) Then
          Url = Mid(Url, 5)
        End If
      End If
      If Not String.IsNullOrEmpty(Url) Then
        Dim Position = InStr(Url, "/")
        If Position = 0 Then
          Position = Url.Length + 1
        End If
        Return Extension.Left(Url, Position - 1)
      End If
      Return Nothing
    End Function

    Function SplitCorrelateWords(ByVal Text As String) As String()
      Dim Words() As String = Split(Text, ",")
      Dim Result() As String = Nothing
      For Each EachWord As String In Words
        Dim Word As String = Trim(EachWord)
        If Not String.IsNullOrEmpty(Word) Then
          If Result Is Nothing Then
            ReDim Result(0)
          Else
            ReDim Preserve Result(Result.GetUpperBound(0) + 1)
          End If
          Result(Result.GetUpperBound(0)) = Word
        End If
      Next
      If Not Result Is Nothing Then
        Array.Sort(Result, New LenWordsComparer)
      End If
      Return Result
    End Function

    Public Class LenWordsComparer
      Implements IComparer(Of String)
      Public Function Compare(ByVal Text1 As String, ByVal Text2 As String) As Integer Implements IComparer(Of String).Compare
        Dim L1 As Integer = Len(Text1)
        Dim L2 As Integer = Len(Text2)
        If L1 = L2 Then
          Return 0
        ElseIf L1 > L2 Then
          Return 1
        Else
          Return -1
        End If
      End Function 'Compare
    End Class 'SizeComparer

    Class MetaTags
      Public Title As String

      Public Property KeyWords() As String
        Get
          If Collection.ContainsKey("keywords") Then
            Return Collection("keywords")
          End If
          Return Nothing
        End Get
        Set(ByVal value As String)
          AddMetaTag("keywords", value)
        End Set
      End Property
      Public Property Description() As String
        Get
          If Collection.ContainsKey("description") Then
            Return Collection("description")
          End If
          Return Nothing
        End Get
        Set(ByVal value As String)
          AddMetaTag("description", value)
        End Set
      End Property

      Public Property Author() As String
        Get
          If Collection.ContainsKey("author") Then
            Return Collection("author")
          End If
          Return Nothing
        End Get
        Set(ByVal value As String)
          AddMetaTag("author", value)
        End Set
      End Property
      Public Sub New()
      End Sub
      Public Sub New(ByVal Language As LanguageManager.Language, Optional ByVal TitlePhraseId As Integer = 0, Optional ByVal DescriptionPhraseId As Integer = 0, Optional ByVal KeyWordsPhraseId As Integer = 0, Optional ByVal Author As String = Nothing)
        Dim Title As String = Nothing
        If CBool(TitlePhraseId) Then
          Title = Phrase(Language, TitlePhraseId)
        End If
        Dim Description As String = Nothing
        If CBool(DescriptionPhraseId) Then
          Description = Phrase(Language, DescriptionPhraseId)
        End If
        Dim KeyWords As String = Nothing
        If CBool(KeyWordsPhraseId) Then
          KeyWords = Phrase(Language, KeyWordsPhraseId)
        End If
        Inizialize(Title, Description, KeyWords, Author)
      End Sub
      Public Sub New(ByVal Title As String, ByVal Description As String, ByVal KeyWords As String, Optional ByVal Author As String = Nothing)
        Inizialize(Title, Description, KeyWords, Author)
      End Sub
      Private Sub Inizialize(ByVal Title As String, ByVal Description As String, ByVal KeyWords As String, Optional ByVal Author As String = Nothing)
        Me.Title = Title
        If Not String.IsNullOrEmpty(Description) Then
          AddMetaTag("description", Description)
          Me.Description = Description
        End If
        If Not String.IsNullOrEmpty(KeyWords) Then
          AddMetaTag("keywords", KeyWords)
          Me.KeyWords = KeyWords
        End If
        If Not String.IsNullOrEmpty(Author) Then
          AddMetaTag("author", Author)
          Me.Author = Author
        End If
      End Sub
      Public Sub New(ByVal Html As String)
        Load(Html)
      End Sub
      Public Sub Load(ByRef Html As String)
        Me.Title = Common.Title(Html)
        Dim p1 As Integer = InStr(Html, "<head", CompareMethod.Text)
        If CBool(p1) Then
          p1 = InStr(p1, Html, ">", CompareMethod.Text)
          If CBool(p1) Then
            Dim p2 As Integer = InStr(p1, Html, "</head", CompareMethod.Text)
            If CBool(p2) Then
              Dim Head As String = Mid(Html, p1 + 1, p2 - p1 - 1)
              Dim p3 As Integer = 0
              Do
                p3 = InStr(p3 + 1, Head, "name=""", CompareMethod.Text)
                If CBool(p3) Then
                  p1 = p3 + 5
                  p3 = InStr(p1 + 1, Head, """", CompareMethod.Text)
                  Dim Name As String = System.Web.HttpUtility.HtmlDecode(Mid(Head, p1 + 1, p3 - p1 - 1))
                  p3 = InStr(p3, Head, "content=""", CompareMethod.Text)
                  If CBool(p3) Then
                    p1 = p3 + 8
                    p3 = InStr(p1 + 1, Head, """", CompareMethod.Text)
                    Dim Content As String = System.Web.HttpUtility.HtmlDecode(Mid(Head, p1 + 1, p3 - p1 - 1))
                    If CBool(p3) Then
                      AddMetaTag(Name, Content)
                    End If
                  End If
                End If
              Loop Until p3 = 0
            End If
          End If
        End If
      End Sub
      Public Collection As New System.Collections.Specialized.StringDictionary
      Public Function Html() As String
        Dim Code As String = Nothing
        If Not String.IsNullOrEmpty(Me.Title) Then
          Code &= "<title>" & System.Web.HttpUtility.HtmlEncode(Me.Title) & "</title>" & vbCrLf
        End If
        For Each Key As String In Me.Collection.Keys
          Code &= "<meta name=""" & System.Web.HttpUtility.HtmlEncode(Key) & """ content=""" & System.Web.HttpUtility.HtmlEncode(Collection(Key)) & """ />" & vbCrLf
        Next
        Return Code
      End Function
      Sub AddMetaTag(ByVal Name As String, ByVal Content As String)
        SyncLock Me
          If Collection.ContainsKey(Name) Then
            Collection.Remove(Name)
          End If
          Collection.Add(Name, Content)
        End SyncLock
      End Sub

      Sub RemoveMetaTag(ByVal Name As String)
        SyncLock Me
          If Collection.ContainsKey(Name) Then
            Collection.Remove(Name)
          End If
        End SyncLock
      End Sub

      Function MetaTag(ByVal Name As String) As String
        Return Collection(Name)
      End Function

      Sub Join(ByVal MetaTags As MetaTags)
        If Not String.IsNullOrEmpty(Me.Title) Then
          Me.Title &= ":" & MetaTags.Title
        Else
          Me.Title = MetaTags.Title
        End If
        If Not String.IsNullOrEmpty(Me.Description) Then
          Me.Description &= ":" & MetaTags.Description
        Else
          Me.Description = MetaTags.Description
        End If
        If Not String.IsNullOrEmpty(Me.KeyWords) Then
          Me.KeyWords &= "," & MetaTags.KeyWords
        Else
          Me.KeyWords = MetaTags.KeyWords
        End If
      End Sub
    End Class
    'Class MetaTag
    'Public Name As String
    'Public Content As String
    'Public Sub New(ByVal Name As String, ByVal Content As String)
    '    Me.Name = Name
    '    Me.Content = Content
    'End Sub
    'End Class

    Class HtmlDocument
      Public Url As String
      Public MetaTags As MetaTags
      Public Body As String
      Public Language As LanguageManager.Language
      Public Sub New()
      End Sub
      Public Sub New(ByVal File As String)
        Load(File)
      End Sub
      Public Sub New(ByVal MetaTags As MetaTags, Optional ByVal Body As String = Nothing, Optional ByVal Language As LanguageManager.Language = LanguageManager.Language.NotDefinite)
        Me.Language = Language
        Me.MetaTags = MetaTags
        Me.Body = Body
      End Sub
      Sub Load(ByVal File As String)
        Url = File
        Dim Code As String
        Code = ReadAll(File, True)
        Me.MetaTags = New MetaTags(Code)
        Dim Find As String = "HTTP-EQUIV=content-language"
        Dim p1 As Integer = InStr(Find, Code, CompareMethod.Text)
        If CBool(p1) Then
          p1 = p1 + Len(Find)
          Dim p2 = InStr(p1, ">", Code, CompareMethod.Text)
          If CBool(p2) Then
            Dim lng As String = Mid(Code, p1 + 1, p2 - p1 - 1)
            Me.Language = LanguageManager.Acronym2Enum(lng)
          End If
        End If
        Me.Body = Common.Body(Code)
      End Sub
      Sub Save(ByVal File As String, Optional ByVal Full As Boolean = True)
        WriteAll(Me.Html(Full), File)
      End Sub
      Function Html(Optional ByVal Full As Boolean = True) As String
        Dim Code As String = Nothing
        If Full Then
          Code = "<!doctype html>" & vbCrLf
        End If
        Code &= _
        "<html>" & vbCrLf & _
        "<head>" & vbCrLf
        If Not Me.MetaTags Is Nothing Then
          Code &= MetaTags.Html
        End If
        If Me.Language <> LanguageManager.Language.NotDefinite Then
          Code &= "<meta http-equiv=""content-language"" content=""" & Acronym(Language) & """ />" & vbCrLf
        End If
        Code &= _
        "</head>" & vbCrLf & _
        "<body>" & vbCrLf & _
        Body & vbCrLf & _
        "</body>" & vbCrLf & _
        "</html>" & vbCrLf
        Return Code
      End Function
      Property InnerText() As String
        Get
          Return Common.InnerText(Body)
        End Get
        Set(ByVal Value As String)
          Body = Value
        End Set
      End Property
    End Class

    Public Function Inner(ByVal Html As String, Optional TextOutput As Boolean = True) As String
      'Convert Html To Text
      Dim Tag As Boolean = False
      Dim EndTagName As Boolean = False
      Dim NoInner As Boolean = False
      If Not Html Is Nothing Then
        Dim StringBuilder As New System.Text.StringBuilder(Html.Length)
        Dim Chr As Char
        Dim TagName As String = Nothing
        For N As Integer = 0 To Html.Length - 1
          Chr = Html.Chars(N)
          Select Case Chr
            Case "<"c
              Tag = True
              EndTagName = False
              TagName = ""
            Case ">"c
              Tag = False
              Select Case TagName
                Case "script", "style"
                  NoInner = True
                Case "br"
                  StringBuilder.Append(vbCrLf)
                  NoInner = False
                Case Else
                  NoInner = False
              End Select
            Case Else
              If Tag Then
                If EndTagName = False Then
                  If Char.IsLetter(Chr) Then
                    TagName &= Char.ToLower(Chr)
                  Else
                    EndTagName = True
                  End If
                End If
              ElseIf NoInner = False AndAlso Char.IsControl(Chr) = False Then
                StringBuilder.Append(Chr)
              End If
          End Select
        Next
        If TextOutput Then
          Return HttpUtility.HtmlDecode(StringBuilder.ToString)
        Else
          Return StringBuilder.ToString
        End If
      End If
      Return Nothing
    End Function

    Public Function InnerText(ByVal Html As String) As String
      Return Inner(Html)
    End Function

    Public Function InnerHtml(ByVal Html As String) As String
      Return Inner(Html, False)
    End Function

    Private Function Meta(ByRef Html As String, ByRef Name As String) As String
      Dim p1 As Integer = 0
      Dim p2 As Integer = 0
      Dim p3 As Integer = 0
      p1 = InStr(Html, "<head", CompareMethod.Text)
      If CBool(p1) Then
        p2 = InStr(p1, Html, "</head", CompareMethod.Text)
        If CBool(p2) Then
          p3 = InStr(p1, Html, "name=""" & Name & """", CompareMethod.Text)
          If p3 < p2 Then
            p1 = InStrRev(Html, "<meta", p3, CompareMethod.Text)
            If CBool(p1) Then
              p1 = InStr(p1, Html, "content=""") + 9
              p2 = InStr(p1, Html, """") - 1
              Return System.Web.HttpUtility.HtmlDecode(Mid(Html, p1, p2 - p1 + 1))
            End If
          End If
        End If
      End If
      Return Nothing
    End Function

    Private Function Title(ByRef Html As String) As String
      Dim p1, p2 As Integer
      p1 = InStr(Html, "<head", CompareMethod.Text)
      If CBool(p1) Then
        p2 = InStr(p1, Html, "</head", CompareMethod.Text)
        If CBool(p2) Then
          p1 = InStr(p1, Html, "<title>", CompareMethod.Text)
          If p1 > 0 AndAlso p1 < p2 Then
            p2 = InStr(p1, Html, "</title>", CompareMethod.Text)
            If CBool(p2) Then
              Return System.Web.HttpUtility.HtmlDecode(Mid(Html, p1 + 7, p2 - p1 - 7))
            End If
          End If
        End If
      End If
      Return Nothing
    End Function

    Public Function Body(ByRef Html As String) As String
      Dim p1, p2 As Integer
      p1 = InStr(Html, "<body", CompareMethod.Text)
      If CBool(p1) Then
        p1 = InStr(p1, Html, ">", CompareMethod.Text)
      Else
        Return Html
      End If
      p2 = InStrRev(Html, "</body", -1, CompareMethod.Text)
      If CBool(p2) Then
        Return Mid(Html, p1 + 1, p2 - p1 - 1)
      End If
      Return Nothing
    End Function

    'Private Function FindHead(ByRef Controls As ControlCollection) As Control
    '  If StrComp(TypeName(Controls(0)), "ResourceBasedLiteralControl", CompareMethod.Text) = 0 Then
    '    Return Controls(0)
    '  ElseIf TypeOf Controls(1) Is System.Web.UI.HtmlControls.HtmlHead Then
    '    Return Controls(1)
    '  ElseIf StrComp(TypeName(Controls(0)), "LiteralControl", CompareMethod.Text) = 0 Then
    '    Dim ctrl As LiteralControl = Controls(0)
    '    If InStr(ctrl.Text, "<head", CompareMethod.Text) Then
    '      Return Controls(0)
    '    End If
    '  End If
    'End Function

    Public Function Url2NoQueryUrl(ByRef Url As String) As String
      Dim p1 As Integer = InStrRev(Url, "/")
      Dim p2 As Integer = InStrRev(Url, "?")
      Dim Query As String
      Dim File As String
      If CBool(p2) Then
        Query = Mid(Url, p2)
        File = Mid(Url, p1 + 1, p2 - p1 - 1)
      Else
        Query = ""
        File = Mid(Url, p1 + 1)
      End If
      Dim Domain As String = Nothing
      If CBool(p1) Then
        Domain = Extension.Left(Url, p1 - 1)
      End If

      Dim NewUrl As String = Domain & Query & "/" & File

      NewUrl = ReplaceBin(NewUrl, " ", "_")
      NewUrl = ReplaceBin(NewUrl, "?", "/")
      NewUrl = ReplaceBin(NewUrl, "=", "/")
      NewUrl = ReplaceBin(NewUrl, "&", "/")
      Return NewUrl
    End Function

    Function NoQueryUrl2Url(ByRef NoQueryUrl As String) As String
      Dim p1 As Integer = InStrRev(NoQueryUrl, "/")
      Dim file As String = Mid(NoQueryUrl, p1 + 1)
      Dim p2 As Integer = InStr(NoQueryUrl, ":")
      If CBool(p2) Then
        p2 = InStr(p2 + 3, NoQueryUrl, "/")
      Else
        p2 = InStr(NoQueryUrl, "/")
      End If
      Dim Domain As String = Extension.Left(NoQueryUrl, p2)
      Dim Query As String = Mid(NoQueryUrl, p2 + 1, p1 - p2 - 1)
      Dim NewQuery As String = Nothing
      If Not String.IsNullOrEmpty(Query) Then
        Dim Spl As String() = Split(Query, "/")
        For n As Integer = 0 To UBound(Spl)
          If n = 0 Then
            NewQuery = "?" & Spl(0)
          ElseIf CBool(n Mod 2) Then
            NewQuery = NewQuery & "=" & Spl(n)
          Else
            NewQuery = NewQuery & "&" & Spl(n)
          End If
        Next
      End If
      Dim NewUrl As String = Domain & file & NewQuery
      NewUrl = ReplaceBin(NewUrl, "_", " ")
      Return NewUrl
    End Function


    Public Function IsDay(ByVal Day As String) As Boolean
      Dim v As Integer = ValInt(Day)
      If Day = CStr(v) Then
        If v >= 1 AndAlso v <= 31 Then
          Return True
        End If
      End If
      Return False
    End Function
    Public Function IsMonth(ByVal Month As String) As Boolean
      Dim v As Integer = ValInt(Month)
      If Month = CStr(v) Then
        If v >= 1 AndAlso v <= 12 Then
          Return True
        End If
      End If
      Return False
    End Function
    Public Function IsYear(ByVal Year As String) As Boolean
      Dim v As Integer = ValInt(Year)
      If Year = CStr(v) Then
        If v >= 1900 AndAlso v <= 2100 Then
          Return True
        End If
      End If
      Return False
    End Function

    Public Function IsEmail(ByVal Email As String) As Boolean
      Try
        Dim Obj As New System.Net.Mail.MailAddress(Email)
        Return True
      Catch ex As Exception
      End Try
      Return False
    End Function

    Enum ButtonsStandard As Integer
      NewPage = 1
      PageManager = 2
    End Enum

    Function ImageNotFound() As Drawing.Bitmap
      Dim imgOutput As New Drawing.Bitmap(100, 100, System.Drawing.Imaging.PixelFormat.Format24bppRgb)
      Dim g As Drawing.Graphics = Drawing.Graphics.FromImage(imgOutput)  ' create a New graphic object from the above bmp
      g.Clear(Drawing.Color.Yellow)  ' blank the image
      g.DrawString(Chr(&HA3).ToString, New Drawing.Font("webdings", 54, Drawing.FontStyle.Bold), Drawing.SystemBrushes.WindowText, New Drawing.PointF(2, 12))
      g.Dispose()
      Return imgOutput
    End Function

    Function SetPageDefault(Page As System.Web.UI.Page, PlaceHolder As Control, Optional Setting As SubSite = Nothing, Optional MetaTags As MetaTags = Nothing, Optional ForumPreview As Boolean = False, Optional NewsPreview As Boolean = False, Optional ChatPreview As Boolean = False, Optional AddTitleAndDescription As Boolean = False) As ContentPlaceHolder
      If Setting Is Nothing Then
        Setting = CurrentSetting()
      End If

      Dim MasterPage As MasterPageEnhanced = SetMasterPage(Page, MetaTags, True)

      If AddTitleAndDescription Then
        'Dim Hgroup As New HtmlGenericControl("hgroup")
        'PlaceHolder.Controls.Add(Hgroup)
        Dim Title As New Literal
        Title.Text = "<h1>" & HttpUtility.HtmlEncode(Setting.Title) & "</h1><h2>" & HttpUtility.HtmlEncode(Setting.Description) & "</h2>"
        'Hgroup.Controls.Add(Title)
        PlaceHolder.Controls.Add(Title)
        PlaceHolder.Controls.Add(New LiteralControl("<hr />"))   'horizontal line
      End If

      Dim Places(3) As ContentPlaceHolder
      For N = 0 To 3
        Places(N) = New ContentPlaceHolder
        PlaceHolder.Controls.Add(Places(N))
      Next

      'FORUM PREVIEW
      If ForumPreview AndAlso Setting.Aspect.ShowElementsOnTheMainPage.ForumPreview Then
        If Setting.Forums IsNot Nothing Then
          Dim ForumPlaceHolder As ContentPlaceHolder = Places(CInt(Setting.Aspect.OrderOfTheElementsOnTheMainPage.ForumPreview))
          'Add Forum preview
          For Each ForumId As Integer In Setting.Forums
            Dim Forum As Forum = CType(ForumManager.Forum.Load.GetItem(ForumId), Forum)
            Dim Preview As Control
            If Setting.Aspect.ForumPreviewInMainPage.TypeOfForumPreview = SubSite.AspectConfiguration.ForumPreviewInMainPageConfiguration.ForumPreviewType.LastTopics Then
              Dim CurrentUser As User = Authentication.CurrentUser(Nothing)
              Preview = ForumManager.ShowTopicsList(CurrentUser, Setting, ForumId, New ForumManager.UserPreferences(CurrentUser).ShowCensored, 0, Setting.Aspect.ForumPreviewInMainPage.TopicsOfForumInPreview, -1, ActionType.Show, Nothing, Page, False)
            Else
              Preview = Forum.Summary(Setting)
            End If
            If Preview IsNot Nothing Then
              ForumPlaceHolder.Controls.Add(Preview)
              'Form1.Controls.Add(Fieldset(Forum.Name, Preview))
            End If
          Next
        End If
      End If

      'NEWS PREVIEW
      If NewsPreview AndAlso Setting.Aspect.ShowElementsOnTheMainPage.NewsPreview Then
        If Not Setting.News Is Nothing Then
          'Add news preview
          Dim News As Collections.Generic.List(Of Notice) = NewsManager.News(Setting.News)
          If News IsNot Nothing AndAlso News.Count <> 0 Then
            Dim NewsPlaceHolder As ContentPlaceHolder = Places(CInt(Setting.Aspect.OrderOfTheElementsOnTheMainPage.NewsPreview))
            NewsPlaceHolder.Controls.Add(Components.NewsPreview(Setting, News, 3))
          End If
        End If
      End If

      If ChatPreview AndAlso Setting.Aspect.ShowElementsOnTheMainPage.ChatPreview AndAlso PluginManager.IsEnabled(Setting, "Chat") Then
        'CHAT PREVIEW
        Dim ChatPlaceHolder As ContentPlaceHolder = Places(CInt(Setting.Aspect.OrderOfTheElementsOnTheMainPage.ChatPreview))
        ChatPlaceHolder.Controls.Add(ChatManager.ChatPreview(DefaultChatRoom, Setting))
      End If
      Dim ContentPlaceHolder As ContentPlaceHolder = Places(CInt(Setting.Aspect.OrderOfTheElementsOnTheMainPage.Content))
      Return ContentPlaceHolder

    End Function

    Enum DefaultPageShowType
      Standard
      ListPhotoAlbum
      News
      OnlineUsers
      ExternalPage
      Sitemap
      FeedRSS
      RedirectToSearchEngine
      SitemapImages
      Ip 'Ping and response the IP
    End Enum

    Function NewSubDirectoryId(ByVal Root As String, Optional ByVal IdSTartFrom As Integer = 1) As Integer
      'Create a new sub folder, name of the folder is a integer number
      Dim dir As New System.IO.DirectoryInfo(Root)
      Dim Folders As System.IO.FileSystemInfo() = dir.GetFileSystemInfos()
      Dim Last, Current As Integer
      Last = IdSTartFrom - 1
      For Each Folder As System.IO.FileSystemInfo In Folders
        Current = ValInt(Folder.Name)
        If Current > Last Then
          Last = Current
        End If
      Next
      NewSubDirectoryId = Last + 1
      dir = New System.IO.DirectoryInfo(Root & "/" & NewSubDirectoryId)
      If dir.Exists = False Then
        dir.Create()
      End If
    End Function

    Public Enum TypeOfServices
      None
      Flight
      Hotel
      Travel
    End Enum

    Function CodeUser(ByVal ExtraData As String) As String
      Dim Code As String = Extension.Left(Hex(Val(HttpContext.Current.Request.UserHostAddress)) & "0", 2)
      Dim Base As String = HttpContext.Current.Request.Browser.Platform
      Base &= HttpContext.Current.Request.UserAgent
      Base &= ExtraData
      If Not HttpContext.Current.Request.UserLanguages Is Nothing Then
        Base &= Join(HttpContext.Current.Request.UserLanguages, " ")
      End If
      Dim Arr As Char() = Base.ToCharArray
      Const Bytes As Integer = 5
      For NB As Integer = 0 To Bytes - 1
        If Not Arr Is Nothing Then
          Dim Result As Integer = 0
          For N As Integer = NB To Arr.Length - 1 Step Bytes
            Result = Result Xor Asc(Arr(N))
          Next
          Code &= Extension.Left(Hex(Result) & "0", 2)
        End If
      Next
      Return Code
    End Function

    Sub AddEmoticonsTool(ByVal Where As Control, ByVal TextArea As WebControl)

      Dim NameControl As String = TextArea.ClientID

      'New wersion
      Dim ScriptText As String = ReadAll(MapPath(ScriptsResources & "/" & "InsertText.js"))
      Where.Controls.Add(Components.Script(ScriptText, ScriptLanguage.javascript))
      Dim Emoticons As New Control

      For Each NIco As Emoticons In [Enum].GetValues(GetType(Emoticons))
        Dim Link As New HyperLink
        'Link.NavigateUrl = "Javascript:insertAtCursor(document.forms(0)." & NameControl & ",""" & AbjustForJavascriptString(Common.EmoticonShortcut(NIco)) & """)"
        Link.Attributes.Add("onclick", "insertAtCursor('" & NameControl & "',""" & AbjustForJavascriptString(Common.EmoticonShortcut(NIco)) & """);return false;")
        Dim Emoticon As WebControls.Image = Components.Emoticon(NIco)
        Link.Controls.Add(Emoticon)
        Link.ToolTip = Common.EmoticonShortcut(NIco)
        Emoticons.Controls.Add(Link)
        AddLiteral(Emoticons, " ")
      Next
      Where.Controls.Add(Emoticons)
    End Sub

    Function Stars(ByVal User As User) As Integer
      Select Case User.Rating
        Case Is >= 4.5
          Return 5
        Case Is >= 4
          Return 4
        Case Is >= 3.5
          Return 3
        Case Is >= 3
          Return 2
        Case Is >= 2.5
          Return 1
      End Select
      Return 0
    End Function

    Function ConvertSnitz(ByVal Code As String) As String
      Dim Lpart As String = "<img src="
      Dim Rpart As String = ".gif border=0 align=middle>"
      Dim Icons(19, 1) As String
      Icons(0, 0) = "ICON_SMILE_WINK" : Icons(0, 1) = EmoticonShortcut(Emoticons.smile_wink) ' ";-)"
      Icons(1, 0) = "ICON_SMILE_8BALL" : Icons(1, 1) = EmoticonShortcut(Emoticons.smile_eyeroll) ' "8-)"
      Icons(2, 0) = "ICON_SMILE_ANGRY" : Icons(2, 1) = EmoticonShortcut(Emoticons.smile_angry) ' ":-@"
      Icons(3, 0) = "ICON_SMILE_APPROVE" : Icons(3, 1) = EmoticonShortcut(Emoticons.smile_wink) ' ";-)"
      Icons(4, 0) = "ICON_SMILE_BIG" : Icons(4, 1) = EmoticonShortcut(Emoticons.smile_teeth) ' ":-D"
      Icons(5, 0) = "ICON_SMILE_BLACKEYE" : Icons(5, 1) = EmoticonShortcut(Emoticons.smile_confused) ' ":-S"
      Icons(6, 0) = "ICON_SMILE_BLUSH" : Icons(6, 1) = EmoticonShortcut(Emoticons.smile_embaressed) ' ":-$"
      Icons(7, 0) = "ICON_SMILE_CLOWN" : Icons(7, 1) = EmoticonShortcut(Emoticons.smile_party) ' "<:o)"
      Icons(8, 0) = "ICON_SMILE_COOL" : Icons(8, 1) = EmoticonShortcut(Emoticons.smile_shades) ' "(H)"
      Icons(9, 0) = "ICON_SMILE_DEAD" : Icons(9, 1) = EmoticonShortcut(Emoticons.rose_wilted) ' "(W)"
      Icons(10, 0) = "ICON_SMILE_DISSAPPROVE" : Icons(10, 1) = EmoticonShortcut(Emoticons.smile_whatchutalkingabout)
      Icons(11, 0) = "ICON_SMILE_EVIL" : Icons(11, 1) = EmoticonShortcut(Emoticons.smile_devil) ' "(6)"
      Icons(12, 0) = "ICON_SMILE_KISSES" : Icons(12, 1) = EmoticonShortcut(Emoticons.kiss) ' "(K)"
      Icons(13, 0) = "ICON_SMILE_QUESTION" : Icons(13, 1) = EmoticonShortcut(Emoticons.smile_thinking) ' "*-)"
      Icons(14, 0) = "ICON_SMILE_SAD" : Icons(14, 1) = EmoticonShortcut(Emoticons.smile_sad) ' ":-("
      Icons(15, 0) = "ICON_SMILE_SHOCK" : Icons(15, 1) = EmoticonShortcut(Emoticons.smile_confused) ' ":-S"
      Icons(16, 0) = "ICON_SMILE_SHY" : Icons(16, 1) = EmoticonShortcut(Emoticons.smile_embaressed) ' ":-$"
      Icons(17, 0) = "ICON_SMILE_SLEEPY" : Icons(17, 1) = EmoticonShortcut(Emoticons.smile_yawn) ' "|-)"
      Icons(18, 0) = "ICON_SMILE_TONGUE" : Icons(18, 1) = EmoticonShortcut(Emoticons.smile_tongue) ' ":-P"
      Icons(19, 0) = "ICON_SMILE" : Icons(19, 1) = EmoticonShortcut(Emoticons.smile_regular) ' ":-)"

      For N As Integer = Icons.GetLowerBound(0) To Icons.GetUpperBound(0)
        Code = ReplaceText(Code, Lpart & LCase(Icons(N, 0)) & Rpart, Icons(N, 1))
      Next
      Return ReplaceBin(Code, vbCr, "<br />")
    End Function
    'Private EmoticonsShortcut() As String = {":-)", ":-D", ":-O", ":-P", ";-)", ":-(", ":-S", ":-|", ":'(", ":-$", "(H)", ":-@", "(A)", "(6)", ":-#", "8o|", "8-|", "^o)", ":-*", "+o(", ":^)", "*-)", "<:o)", "8-)", "|-)", "(C)", "(Y)", "(N)", "(B)", "(D)", "(X)", "(Z)", "({)", "(})", ":-[", "(^)", "(L)", "(U)", "(K)", "(G)", "(F)", "(W)", "(P)", "(~)", "(@)", "(&)", "(T)", "(I)", "(8)", "(S)", "(*)", "(E)", "(O)", "(M)", "(sn)", "(bah)", "(pl)", "(||)", "(pi)", "(so)", "(au)", "(ap)", "(um)", "(ip)", "(co)", "(mp)", "(st)", "(li)", "(mo)"}
    Private EmoticonsShortcut() As String = {":-)", ":-D", ";-)", ":-O", ":-P", "(H)", ":-@", ":-$", ":-S", ":-(", ":'(", ":-|", "(6)", "(A)", "(I)", "(U)", "(M)", "(@)", "(&)", "(S)", "(*)", "(~)", "(8)", "(E)", "(F)", "(W)", "(O)", "(K)", "(G)", "(^)", "(P)", "(L)", "(C)", "(T)", "({)", "(})", "(B)", "(D)", "(X)", "(Z)", "(Y)", "(N)", ":-[", "(#)", "(r)", ":-#", "8o|", "8-|", "^o)", ":-*", "+o(", "(sn)", "(tu)", "(pl)", "(||)", "(pi)", "(so)", "(au)", "(ap)", "(um)", "(ip)", "(co)", "(mp)", "(brb)", "(st)", "(h5)", "(mo)", "(bah)", ":^)", "*-)", "(li)", "<:o)", "8-)", "|-)", "(bo)", "@-|", "(o¨)", "(ha)", "hb)", "(yy)", "(tr)", "(nb)"}
    Enum Emoticons
      smile_regular
      smile_teeth
      smile_wink
      smile_omg
      smile_tongue
      smile_shades
      smile_angry
      smile_embaressed
      smile_confused
      smile_sad
      smile_cry
      smile_whatchutalkingabout
      smile_devil
      smile_angel
      heart
      heart_broken
      messenger
      cat
      dog
      moon
      star
      film
      music_note
      envelope
      rose
      rose_wilted
      clock
      kiss
      present
      cake
      camera
      lightbulb
      coffee
      phone
      hug_dude
      hug_girl
      beer
      martini
      guy_handsacrossamerica
      girl_handsacrossamerica
      thumbs_up
      thumbs_down
      bat
      sun
      rainbow
      smile_zipit
      smile_baringteeth
      smile_nerd
      smile_sarcastic
      smile_secret
      smile_sick
      snail
      turtle
      plate
      bowl
      pizza
      soccerball
      car
      airplane
      umbrella
      island
      computer
      mobile
      smile_speedy
      cloud_rain
      clap
      money
      blacksheep
      smile_sniff
      smile_thinking
      cloud_lightning
      smile_party
      smile_eyeroll
      smile_yawn
      bombe
      arbre
      fume
      halloween
      hamburger
      yinyang
      terre
      newbie
    End Enum
    Function EmoticonShortcut(ByVal Emoticon As Emoticons) As String
      Return EmoticonsShortcut(CInt(Emoticon))
    End Function

    Function AddEmoticons(ByVal Html As String) As String
      If Not String.IsNullOrEmpty(Html) AndAlso Html.IndexOfAny("()-|".ToCharArray) <> -1 Then
        Dim MapHtml() As Boolean
        Dim Width As Integer = 0
        Dim Height As Integer = 0
        Dim ImageUrl As String = Nothing
        For Each N As Emoticons In [Enum].GetValues(GetType(Emoticons))
          MapHtml = Nothing
          Dim Shortcut As String = HttpUtility.HtmlEncode(EmoticonShortcut(N))
          Dim Position As Integer = Len(Html)
          Do
            'Position = Html.LastIndexOf(Shortcut, Position, CompareMethod.Binary)
            Position = InStrRev(Html, Shortcut, Position, CompareMethod.Binary) - 1
            If Position <> -1 Then
              If MapHtml Is Nothing Then
                MapHtml = CheckHtml(Html)
                ImageUrl = ImgagesResources & "/Emoticons/" & EmoticonFileName(N)
                CacheImageSize.LoadWidthHeight(ImageUrl, Width, Height)
              End If
              If MapHtml(Position) = False Then
                Html = Extension.Left(Html, Position) & Replace(Html, HttpUtility.HtmlEncode(EmoticonShortcut(N)), "<img src=""" & ImageUrl & """ alt=""" & N.ToString & """ style=""height:" & Height & "px;width:" & Width & "px;"" />", Position + 1, 1, True)
              End If
            End If
          Loop Until Position <= 0
        Next
      End If
      Return Html
    End Function

    Public Function EmoticonFileName(ByVal Emoticon As Emoticons) As String
      Return Emoticon.ToString & ".gif"
    End Function

    Private BannedCodeUsersNameFile As String = FileManager.MapPath(ReadWriteDirectory & "\BannedCodeUsers.txt")
    Function BannedCodeUsers() As Collections.Specialized.StringCollection
      Dim CodesBanned As Collections.Specialized.StringCollection = CType(HttpContext.Current.Cache("BannedCodeUsers"), StringCollection)
      If CodesBanned Is Nothing Then
        CodesBanned = New Collections.Specialized.StringCollection
        Dim Records As String() = ReadAllRows(BannedCodeUsersNameFile)
        If Records IsNot Nothing Then
          For Each Record As String In Records
            CodesBanned.Add(Record)
          Next
        End If
        Dim Dependency As New CacheDependency(BannedCodeUsersNameFile)
        Try
          HttpContext.Current.Cache.Add("BannedCodeUsers", CodesBanned, Dependency, DateTime.MaxValue, New TimeSpan(1, 0, 0), CacheItemPriority.Default, Nothing)
        Catch ex As Exception
          'Is added from other task
        End Try
      End If
      Return CodesBanned
    End Function

    Sub AddBannedCodeUsers(ByVal CodeUser As String)
      Dim CodesBanned As Collections.Specialized.StringCollection = CType(HttpContext.Current.Cache("BannedCodeUsers"), StringCollection)
      If CodesBanned Is Nothing Then
        CodesBanned = New Collections.Specialized.StringCollection
      End If
      If Not CodesBanned.Contains(CodeUser) Then
        CodesBanned.Add(CodeUser)
      End If

      While CodesBanned.Count > Setup.Security.MaxBannedCodeUser
        CodesBanned.RemoveAt(0)
      End While

      Dim Data As String = Nothing
      For Each Record As String In CodesBanned
        Data &= Record & vbCrLf
      Next
      WriteAll(Data, BannedCodeUsersNameFile) 'Write this file and reser cache
    End Sub

    Public Sub RedirectBannedUser(ByVal Setting As SubSite)
      Dim CodesBanned As Collections.Specialized.StringCollection = BannedCodeUsers()
      If CodesBanned IsNot Nothing AndAlso CodesBanned.Contains(CurrentUser(Nothing).CodeUser) Then
        HttpContext.Current.Response.Redirect(Href(Setting.Name, False, "contact.aspx"))
      End If
    End Sub

    Public IPBlockeds As Collections.Specialized.StringDictionary = LoadIPBlockedCollection("IPBlockeds")

    Public Function LoadIPBlockedCollection(ByVal Key As String) As Collections.Specialized.StringDictionary
      Dim IPBlockeds As Collections.Specialized.StringDictionary = Nothing
      LoadCollection(IPBlockeds, Key)
      If IPBlockeds IsNot Nothing Then
        Return IPBlockeds
      Else
        Return New Collections.Specialized.StringDictionary
      End If
    End Function

    Public Sub SaveIpIPBlockedCollection()
      SaveCollection(IPBlockeds, "IPBlockeds")
      SaveCollection(IPBlockedsInChat, "IPBlockedsInChat")
    End Sub

    Sub BlockIP(ByVal IP As String, ByVal Time As TimeSpan, Optional ByVal Collection As Collections.Specialized.StringDictionary = Nothing)
      If Not String.IsNullOrEmpty(IP) Then
        If Collection Is Nothing Then
          Collection = IPBlockeds
        End If
        If Not IP Is Nothing Then
          Dim ExpiredBlock As Date = Now.Add(Time)
          If Collection.ContainsKey(IP) Then
            Collection.Remove(IP)
          End If
          Collection.Add(IP, CStr(ExpiredBlock))
        End If
      End If
    End Sub

    Function IPIsBlocked(ByVal IP As String, Optional ByVal Collection As Collections.Specialized.StringDictionary = Nothing) As Boolean
      If Not String.IsNullOrEmpty(IP) Then
        If Collection Is Nothing Then
          Collection = IPBlockeds
        End If
        If Collection.ContainsKey(IP) Then
          Dim ExpiredBlock As Date = CDate(Collection(IP))
          If Now < ExpiredBlock Then
            Return True
          Else
            Collection.Remove(IP)
          End If
        End If
      End If
      Return False
    End Function

    Public Function ContainCensoredWord(ByVal Text As String) As Boolean
      Dim CensoredWords As String() = Nothing
      For Steps As Integer = 0 To 1
        Select Case Steps
          Case 0
            CensoredWords = Common.CensoredWords
          Case 1
            CensoredWords = ReadAllRows(MapPath(ForumSubDirectory & "\CensoredWords.txt"))
        End Select
        If CensoredWords IsNot Nothing Then
          For Each CensoreWord As String In CensoredWords
            If Not String.IsNullOrEmpty(CensoreWord) Then
              If CBool(FindWord(Text, CensoreWord)) OrElse CheckCensoredWord(Text, CensoreWord) Then
                'text contain a Censore word!
                Extension.Log("CensoredWord", 1000, Authentication.CurrentUser(Nothing).Username, Authentication.CurrentUser(Nothing).IP, CensoreWord)
                Return True
              End If
            End If
          Next
        End If
      Next
      Return False
    End Function

    Public Sub BlockIPAddress()
      Const IPListNameFile As String = "BlockIPAddresses.txt"
      Static BlockIPAddresses As Collections.Specialized.StringCollection
      If BlockIPAddresses Is Nothing Then
        BlockIPAddresses = New Collections.Specialized.StringCollection
        Dim Data As String = ReadAll(MapPath(ReadWriteDirectory & "\" & IPListNameFile))
        Dim Records() As String = Split(Data, vbLf)
        Dim NewData As String = Nothing
        For Each EachRecord As String In Records
          Dim Record As String = ReplaceBin(EachRecord, vbCr, "")
          Record = Trim(Record)
          If Not String.IsNullOrEmpty(Record) Then
            NewData &= Record & vbCrLf
            Select Case Config.Setup.Security.BlockIPAddresses
              Case Configuration.BlockIPMode.BlockIp
                Dim AddIP As String
                Dim Separator As Integer = InStr(Record, ":", CompareMethod.Binary)
                If Separator > 0 Then
                  AddIP = Extension.Left(Record, Separator - 1)
                Else
                  AddIP = Record
                End If
                If Not BlockIPAddresses.Contains(AddIP) Then
                  BlockIPAddresses.Add(AddIP)
                End If
              Case Configuration.BlockIPMode.BlockIpPort
                If Not BlockIPAddresses.Contains(Record) Then
                  BlockIPAddresses.Add(Record)
                End If
            End Select
          End If
        Next
        WriteAll(NewData, MapPath(ReadWriteDirectory & "\" & IPListNameFile))
      End If
      If HttpContext.Current.Session("CheckedIp") Is Nothing Then
        HttpContext.Current.Session("CheckedIp") = True
        Dim Find As String = Nothing
        Select Case Config.Setup.Security.BlockIPAddresses
          Case Configuration.BlockIPMode.BlockIp
            Find = HttpContext.Current.Request.UserHostAddress
          Case Configuration.BlockIPMode.BlockIpPort
            Find = HttpContext.Current.Request.UserHostAddress & ":" & HttpContext.Current.Request.Url.Port
        End Select

        Try
          If BlockIPAddresses.Contains(Find) Then
            Extension.Log("AccessBlocked", 1000, Find)
            BlockUser()
          End If
        Catch ex As Exception
        End Try
      End If
    End Sub

    Function SetMasterPage(ByRef Page As System.Web.UI.Page, Optional ByRef AddMetaTags As Common.MetaTags = Nothing, Optional ByRef LeftBar As Boolean = False, Optional ByRef RightBar As Boolean = True, Optional ByRef TopBar As Boolean = True, Optional ByRef BottomBar As Boolean = True) As Components.MasterPageEnhanced
      LoadPlugunsAspx(Reflection.Assembly.GetCallingAssembly)

      Dim CurrentMasterPage As Components.MasterPageEnhanced = CType(Page.Master, Components.MasterPageEnhanced)
      CurrentMasterPage.ShowElement(LeftBar, RightBar, TopBar, BottomBar)
      'Set document
      Dim Setting As SubSite = CurrentMasterPage.Setting
      Dim AddTitle As String = Nothing, AddDescription As String = Nothing, AddKeyWords As String = Nothing
      If Not IsNothing(AddMetaTags) Then
        If Not AddMetaTags.Title Is Nothing Then
          AddTitle = AddMetaTags.Title
        End If
        If Not AddMetaTags.Description Is Nothing Then
          AddDescription = AddMetaTags.Description
        End If
        If Not AddMetaTags.KeyWords Is Nothing Then
          AddKeyWords = AddMetaTags.KeyWords
        End If

        'Optimize
        If String.IsNullOrEmpty(AddDescription) Then
          AddDescription = AddTitle
        End If
        If String.IsNullOrEmpty(AddTitle) Then
          AddTitle = AddDescription
        End If
        If InStr(AddKeyWords, AddDescription, CompareMethod.Text) = 0 Then
          AddKeyWords &= "," & AddDescription
        End If
        If InStr(AddKeyWords, AddTitle, CompareMethod.Text) = 0 Then
          AddKeyWords &= "," & AddTitle
        End If

        'Join
        If Not String.IsNullOrEmpty(AddTitle) AndAlso Not String.IsNullOrEmpty(Setting.Title) Then
          AddTitle = ": " & AddTitle
        End If
        If Not String.IsNullOrEmpty(AddDescription) AndAlso Not String.IsNullOrEmpty(Setting.Description) Then
          AddDescription = " - " & AddDescription
        End If
        If Not String.IsNullOrEmpty(AddKeyWords) AndAlso Not String.IsNullOrEmpty(Setting.KeyWords) Then
          AddKeyWords = "," & AddKeyWords
        End If
      End If

      Dim SkinSetup As SkinSetup = Nothing
      Try
        Dim SkinOfSetting As WebApplication.Config.Skin = Setting.Skin()
        SkinSetup = SkinOfSetting.SkinSetup()
      Catch ex As Exception
      End Try
      If Not SkinSetup Is Nothing Then
        If Not String.IsNullOrEmpty(SkinSetup.Variables("Favicon")) Then
          Dim HrefFavicon As String = SkinSetup.Variables("Favicon")
          If Not HrefFavicon.StartsWith("http://", StringComparison.InvariantCulture) Then
            HrefFavicon = PathCurrentUrl() & Page.ResolveUrl("") & HrefFavicon
          End If
          CurrentMasterPage.ShortcutIcon = HrefFavicon
        End If
      End If

      CurrentMasterPage.TitleDocument = Setting.Title & AddTitle
      CurrentMasterPage.Description = Setting.Description & AddDescription
      CurrentMasterPage.KeyWords = Setting.KeyWords & AddKeyWords
      CurrentMasterPage.Author = Setting.Title
      CurrentMasterPage.Language = LanguageManager.Acronym(Setting.Language)
      Return CurrentMasterPage
    End Function

    Enum ProfileType
      Card
      Full
    End Enum

    Function FirstUpper(ByVal Text As String) As String
      If Text IsNot Nothing Then
        Dim StringBuilder As New System.Text.StringBuilder(Text)
        Dim C As Char
        Dim NextUpper As Boolean = True
        For Index As Integer = 0 To Text.Length - 1
          C = StringBuilder.Chars(Index)
          If Char.IsLetter(C) Then
            Select Case NextUpper
              Case True
                StringBuilder.Chars(Index) = UCase(C)
              Case False
                StringBuilder.Chars(Index) = LCase(C)
            End Select
            NextUpper = False
          Else
            StringBuilder.Chars(Index) = C
            NextUpper = True
          End If
        Next
        Return StringBuilder.ToString
      End If
      Return Nothing
    End Function

    Function ReportError(Optional ByVal Err As System.Exception = Nothing) As Control
      Dim Ctrl As New Control

      Dim Context As Web.HttpContext = HttpContext.Current
      If Err Is Nothing Then
        If Context.Server IsNot Nothing Then
          Err = Context.Server.GetLastError
        End If
      End If

      If Err IsNot Nothing Then
        'http://msdn.microsoft.com/library/aa378137(VS.85).aspx
        Dim HResult As Integer
        Try
          HResult = Runtime.InteropServices.Marshal.GetHRForException(Err)
        Catch ex As Exception
        End Try
        Ctrl.Controls.Add(Fieldset("HResult", Hex(HResult)))
      End If

      Ctrl.Controls.Add(Fieldset("Date & Time (Utc)", Now.ToUniversalTime().ToString))
      Ctrl.Controls.Add(Fieldset("User", CurrentUser(Nothing).Username))

      Try
        If Context IsNot Nothing Then
          Dim HttpException As System.Web.HttpException = Nothing
          Try
            HttpException = CType(Context.Error, Web.HttpException)
          Catch ex As Exception
          End Try
          If HttpException IsNot Nothing Then
            Ctrl.Controls.Add(Fieldset("Status Code", HttpException.GetHttpCode.ToString & "<br />" & HttpException.Message))
          End If

          If Context.Request IsNot Nothing Then
            If Context.Request.Url IsNot Nothing Then
              Ctrl.Controls.Add(Fieldset("URL", Context.Request.Url.ToString))
            End If
            If Context.Request.UrlReferrer IsNot Nothing Then
              Ctrl.Controls.Add(Fieldset("Referer", Context.Request.UrlReferrer.ToString))
            End If
            If Context.Request.UserAgent IsNot Nothing Then
              Ctrl.Controls.Add(Fieldset("Browser", Context.Request.UserAgent))
            End If
            If Context.Request.Form IsNot Nothing Then
              Ctrl.Controls.Add(Fieldset("Form", ElementsToHtml(Context.Request.Form)))
            End If
            If Context.Request.QueryString IsNot Nothing Then
              Ctrl.Controls.Add(Fieldset("QueryString", ElementsToHtml(Context.Request.QueryString)))
            End If
            If Context.Request.ServerVariables IsNot Nothing Then
              Ctrl.Controls.Add(Fieldset("ServerVariables", ElementsToHtml(Context.Request.ServerVariables)))
            End If
          End If
        End If
      Catch ex As Exception

      End Try

      If Err IsNot Nothing Then
        Ctrl.Controls.Add(Fieldset("Error", Err.ToString))
      End If

      Return Ctrl
    End Function
    Private Function ElementsToHtml(ByVal Collection As Collections.Specialized.NameValueCollection) As String
      Dim Html As String = Nothing
      For Each Key As String In Collection.AllKeys
        Html &= Key & "=" & System.Web.HttpUtility.HtmlEncode(System.Web.HttpUtility.UrlDecode(Collection(Key))) & "<br />"
      Next
      Return Html
    End Function

    Sub ReportErrorByEmail(Optional ByVal Err As System.Exception = Nothing)
      If Setup Is Nothing OrElse Setup.ReportErrorsByEmail.Enabled Then
        SendEmail("ERROR REPORT: ", ControlToText(ReportError(Err)), Setup.Email.Email.Email, True, True, False, Configuration.EmailSender.Supervisor)
      End If
    End Sub

    Function TextToSpeekClientCode(ByVal Language As LanguageManager.Language, Optional ByVal Character As TtsCharacter = TtsCharacter.Merlin) As Control
      Dim CharacterName As String = Character.ToString().ToLower()
      Dim LanguageID As String = Nothing
      Select Case Language
        Case LanguageManager.Language.Arab
          LanguageID = "0401"
        Case LanguageManager.Language.Chinese
          LanguageID = "0404"
        Case LanguageManager.Language.Dutch
          LanguageID = "0413"
        Case LanguageManager.Language.English
          LanguageID = "0409"
        Case LanguageManager.Language.French
          LanguageID = "040C"
        Case LanguageManager.Language.Greek
          LanguageID = "0408"
        Case LanguageManager.Language.Italian
          LanguageID = "0410"
        Case LanguageManager.Language.Japanese
          LanguageID = "0411"
        Case LanguageManager.Language.Korean
          LanguageID = "0412"
        Case LanguageManager.Language.Portuguese
          LanguageID = "0416"
        Case LanguageManager.Language.Russian
          LanguageID = "0419"
        Case LanguageManager.Language.Spanish
          LanguageID = "0C0A"
      End Select

      Dim XML As New Literal
      XML.Text = "<xml id=""XmlSpeech"" src=""""></xml>"
      Dim XmlCompleteEvent As Control = Components.Script("SpeechXml", ScriptLanguage.vbscript, "XmlSpeech", "ondatasetcomplete")

      Dim Agent As New HtmlGenericControl("object")
      Agent.Attributes.Add("classid", "clsid:D45FD31B-5C6E-11D1-9EC1-00C04FD7081F")
      Agent.Attributes.Add("id", "agent")
      Agent.Attributes.Add("codebase", "#VERSION=2,0,0,0")

      Dim TruVoice As New HtmlGenericControl("object")
      TruVoice.Attributes.Add("classid", "clsid:B8F2846E-CE36-11D0-AC83-00C04FD97575")
      TruVoice.Attributes.Add("id", "TruVoice")
      TruVoice.Attributes.Add("codebase", "#VERSION=6,0,0,0")

      Dim Source As String = ReadAll(MapPath(Config.ScriptsResources & "/TextToSpeech.vbs"))
      Source = ReplaceText(Source, "$LanguageID", "&H" & LanguageID)
      Source = ReplaceText(Source, "$character", CharacterName)
      Dim ScriptCtrl As Control = Components.Script(Source, Components.ScriptLanguage.vbscript)

      Dim Ctrl As New Control
      Ctrl.Controls.Add(XML)
      Ctrl.Controls.Add(Agent)
      Ctrl.Controls.Add(TruVoice)
      Ctrl.Controls.Add(ScriptCtrl)
      Ctrl.Controls.Add(XmlCompleteEvent)
      Return Ctrl
    End Function
    Enum TtsCharacter
      Genie
      Merlin
      Peedy
      Robby
    End Enum

    Sub ResponseImage(ByRef Image As System.Drawing.Image)
      ' Set the contenttype
      Dim Response As System.Web.HttpResponse = HttpContext.Current.Response
      Response.Clear()
      If Image.Equals(System.Drawing.Imaging.ImageFormat.Gif) Then
        Response.ContentType = "image/gif"
      Else
        Response.ContentType = "image/jpeg"
      End If
      Try
        Image.Save(Response.OutputStream, Image.RawFormat)
      Catch ex As Exception
        Call ResponseImageError()
      End Try
    End Sub

    Sub ResponseImageError()
      Dim imgOutput = ImageNotFound()
      Dim Response As System.Web.HttpResponse = HttpContext.Current.Response

      Response.Clear()
      ' Set the contenttype
      Response.ContentType = "image/gif"

      ' send mage to the viewer
      imgOutput.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Gif)    ' output to the user

      ' tidy up
      imgOutput.Dispose()

    End Sub


    Function TextContainCensored(ByVal Text As String, Optional ByRef RerurnWordFinded As String = Nothing) As Boolean
      If CensoredWords IsNot Nothing Then
        Return CBool(FindWord(Text, CensoredWords, TextType.Text, Nothing, CompareMethod.Text, RerurnWordFinded))
      End If
      Return False
    End Function

    Function SiteIsCensored(ByVal Url As String, ByVal Setting As SubSite, ByRef MasterPage As MasterPageEnhanced) As Boolean
      Try
        Dim Html As String = ReadHtmlFromWeb(Url, System.Text.Encoding.GetEncoding("windows-1251"))
        Dim Word As String = Nothing
        Dim Check As Boolean = TextContainCensored(Html, Word)
        If Check AndAlso MasterPage IsNot Nothing Then
          MasterPage.AddMessage(Phrase(Setting.Language, 2015) & " (" & Word & ":" & Url & ")", Setting, Nothing, Nothing, MessageType.ErrorAlert)
        End If
        Return Check
      Catch ex As Exception
        If MasterPage IsNot Nothing Then
          MasterPage.AddMessage(Phrase(Setting.Language, 2016) & ": " & Url, Setting, Nothing, Nothing, MessageType.ErrorAlert)
        End If
        Return True
      End Try
    End Function

    Sub RedirectToAppropriateSubSite(ByVal User As User, ByVal Setting As SubSite)
      If User IsNot Nothing AndAlso Setting IsNot Nothing Then

        '======================================= REMOVE THIS LINE
        'If User.SubSite = "esteuropa" Then User.SubSite = "komunalka" : User.Save()
        'If User.SubSite = "" Then User.SubSite = "pietroburgo" : User.Save()
        '=======================================

        If User.SubSite = Setting.Name Then
          'The home subsite of user is equal current setting
          Exit Sub
        End If

        'User subsite is not corrent subsite
        If Array.IndexOf(CurrentDomainConfiguration.SubSitesAvailable(), User.SubSite) <> -1 Then
          Exit Sub
        End If

        Dim UserSubSite As SubSite = CType(Config.SubSite.Load.GetItem(User.SubSite), SubSite)
        If UserSubSite IsNot Nothing Then

          'Verify if subsite of user and Setting have a common Forum
          If UserSubSite.Forums IsNot Nothing Then
            For Each ForumUserId As Integer In UserSubSite.Forums
              If Setting.Forums IsNot Nothing Then
                If Array.IndexOf(Setting.Forums, ForumUserId) <> -1 Then
                  Exit Sub
                End If
              End If
            Next
          End If

          'Verify if subsite of user and Setting have a common Archive
          If UserSubSite.Archive IsNot Nothing Then
            For Each ArchiveUserId As Integer In UserSubSite.Archive
              If Setting.Archive IsNot Nothing Then
                If Array.IndexOf(Setting.Archive, ArchiveUserId) <> -1 Then
                  Exit Sub
                End If
              End If
            Next
          End If

        End If

        'Verify if user is administrator
        If User.Role(Setting.Name) >= Authentication.User.RoleType.AdministratorJunior Then
          Exit Sub
        End If

        'Redirect to appropriate subsite
        Dim TryDomain As Config.DomainConfiguration
        For Each DomainName As String In AllDomainNames()
          TryDomain = Config.DomainConfiguration.Load(DomainName)
          If String.IsNullOrEmpty(TryDomain.Redirect) Then
            For Each SiteConfiguration As String In TryDomain.SubSitesAvailable()
              'Find if subsite of user is setting for current domain
              If User.SubSite = SiteConfiguration Then
                'Finded: This Domain have the same configuration of user. Go to this domain
                RedirectToDomain(TryDomain, SiteConfiguration)
              End If
            Next
          End If
        Next
        Error404()
      End If
    End Sub

    Sub RedirectToSubSiteWithAppropriateForum(ByVal ForumPhotoAlbum As String, ByVal Setting As SubSite)
      If ForumPhotoAlbum.StartsWith("forum") Then

        Dim ForumId As Integer = CInt(Mid(ForumPhotoAlbum, 7))
        If Not ForumForInsideUse(ForumId) Then
          If Setting.Forums IsNot Nothing Then
            If Array.IndexOf(Setting.Forums, ForumId) <> -1 Then
              Exit Sub
            End If
          End If

          'Redirect to appropriate subsite
          Dim TryDomain As DomainConfiguration
          For Each DomainName As String In AllDomainNames()
            TryDomain = Config.DomainConfiguration.Load(DomainName)
            If String.IsNullOrEmpty(TryDomain.Redirect) Then
              For Each SubSite As SubSite In TryDomain.SubSites
                'Find if subsite have a specify forum
                If SubSite.Forums IsNot Nothing Then
                  For Each Id As Integer In SubSite.Forums
                    If ForumId = Id Then
                      'Finded: This Domain e Subsite have the forum required
                      RedirectToDomain(TryDomain, SubSite.Name)
                    End If
                  Next
                End If
              Next
            End If
          Next
          Error404()
        End If
      End If
    End Sub

    Sub RedirectToSubSiteWithAppropriatePhotoAlbum(ByVal PhotoAlbum As String, ByVal Setting As SubSite)

      If PhotoAlbum.StartsWith("default") Then
        If Setting.Photoalbums IsNot Nothing Then
          If Setting.Photoalbums.Contains(PhotoAlbum) Then
            Exit Sub
          End If
          For Each Album As String In Setting.Photoalbums
            If PhotoAlbum.StartsWith(Album & "/") Then
              'Is a sub photo album valid for this website
              Exit Sub
            End If
          Next
        End If

        'Redirect to appropriate subsite
        Dim TryDomain As DomainConfiguration
        For Each DomainName As String In AllDomainNames()
          TryDomain = Config.DomainConfiguration.Load(DomainName)
          If String.IsNullOrEmpty(TryDomain.Redirect) Then
            For Each SubSite As SubSite In TryDomain.SubSites
              'Find if subsite have a specify forum
              If SubSite.Photoalbums IsNot Nothing Then
                For Each Album As String In SubSite.Photoalbums
                  If Album = PhotoAlbum OrElse PhotoAlbum.StartsWith(Album & "/") Then
                    'Finded: This Domain e Subsite have the album required
                    RedirectToDomain(TryDomain, SubSite.Name)
                  End If
                Next
              End If
            Next
          End If
        Next
        Error404()
      End If
    End Sub

    Function RandomIntNumber(ByVal Max As Integer) As Integer
      Return CInt(Rnd() * Max)
    End Function

    Function Stack(Optional ByVal Delimiter As String = vbTab, Optional AddFileName As Boolean = True) As String
      Dim Thread As System.Threading.Thread = Threading.Thread.CurrentThread
      Dim StackTrace As System.Diagnostics.StackTrace = New System.Diagnostics.StackTrace(Thread, False)
      Dim Source As String = Nothing
      If StackTrace.GetFrames IsNot Nothing Then
        For Each StackFrame In StackTrace.GetFrames
          Dim FileName As String = Nothing
          If AddFileName Then
            FileName = "(" & StackFrame.GetFileName & ")"
          End If
          Source += StackFrame.GetMethod.Name & FileName & Delimiter
        Next
      End If
      Return Source
    End Function

    Public Class TextValue
      Public text As String
      Public value As String
    End Class

    Public Function EncodingAttribute(Text As String) As String
      Return ReplaceBin(Text, """", "˝")
    End Function

    Function IsFirstRunning(Setting As SubSite) As TypeOfFirstRunning
      'The first user registered is a Supervisor
      If Setting.Name = Config.SubSite.DefaultSiteConfiguration() AndAlso Config.CurrentDomainConfiguration().SubSites().Count = 0 Then
        Dim Directory As New IO.DirectoryInfo(MapPath(UsersSubDirectory))
        If Directory.GetFiles.Length = 0 Then
          Return TypeOfFirstRunning.Application
        Else
          Return TypeOfFirstRunning.Site
        End If
      End If
      Return TypeOfFirstRunning.NotIsFirstRunning
    End Function
    Enum TypeOfFirstRunning
      NotIsFirstRunning
      Application
      Site
    End Enum

    Public Function ObfuscateHtml(ByVal Control As Control, Setting As SubSite) As Control
      Select Case Setting.Language
        Case LanguageManager.Language.Chinese
          Return Control
        Case Else
          Return New LiteralControl(ObfuscateHtml(ControlToText(Control), Setting))
      End Select
    End Function

    Public Function ObfuscateHtml(ByVal Html As String, Setting As SubSite) As String
      If Not String.IsNullOrEmpty(Html) Then
        Select Case Setting.Language
          Case LanguageManager.Language.Chinese
            Return Html
          Case Else
            Dim R As Random = StringToRandom(Setting.Name)
            Dim StringBuilder As New System.Text.StringBuilder(200 + Html.Length * 3)
            Dim Text As New System.Text.StringBuilder(Html.Length)
            Dim Tag As Boolean = False
            If Not String.IsNullOrEmpty(Html) Then
              For Each C As Char In Html
                Select Case C
                  Case "<"c
                    Tag = True
                    StringBuilder.Append(ObfuscateEncodedText(Text, R))
                    StringBuilder.Append(C)
                  Case ">"c
                    Tag = False
                    StringBuilder.Append(C)
                  Case Else
                    If Tag Then
                      StringBuilder.Append(C)
                    Else
                      Text.Append(C)
                    End If
                End Select
              Next
              StringBuilder.Append(ObfuscateEncodedText(Text, R))
              Return StringBuilder.ToString
            End If
        End Select
      End If
      Return Nothing
    End Function

    Private Function ObfuscateEncodedText(Text As System.Text.StringBuilder, R As Random) As String
      Dim Output As New System.Text.StringBuilder(200 + Text.Length * 3)
      Dim Word1 As New System.Text.StringBuilder(200 + Text.Length * 3)
      Dim Word2 As New System.Text.StringBuilder(200 + Text.Length * 3)
      Dim SwappingWord As System.Text.StringBuilder
      Dim Tryes As Integer = 0
      Dim Words As Integer = 0
      For Each C As Char In HttpUtility.HtmlDecode(Text.ToString)
        Word1.Append(C)
        If C = " "c Then
          Words += 1
          If Word2.Length > 0 Then
            If R.Next(2) = 0 OrElse Tryes >= 3 Then
              Output.Append("<bdo class=""NW"" dir=""rtl""><bdo dir=""ltr"">" & HttpUtility.HtmlEncode(Word1.ToString(0, Word1.Length - 1)) & "</bdo>&nbsp;<bdo dir=""ltr"">" & HttpUtility.HtmlEncode(Word2.ToString(0, Word2.Length - 1)) & "</bdo></bdo> ")
              Word1.Clear() : Word2.Clear()
              Tryes = 0
            Else
              Output.Append(HttpUtility.HtmlEncode(Word2.ToString)) : Word2.Clear()
              Tryes += 1
              'Swap words
              SwappingWord = Word1
              Word1 = Word2
              Word2 = SwappingWord
            End If
          ElseIf Words = 1 Then
            Output.Append(HttpUtility.HtmlEncode(Word1.ToString))
            Word1.Clear()
          Else
            'Swap words
            SwappingWord = Word1
            Word1 = Word2
            Word2 = SwappingWord
          End If
        End If
      Next
      Text.Clear()
      Output.Append(HttpUtility.HtmlEncode(Word2.ToString))
      Output.Append(HttpUtility.HtmlEncode(Word1.ToString))
      Return Output.ToString
    End Function

    Public Class MalwareWebsiteCheck
      Public DateOfVerification As Date
      Public MalwareDetected As Boolean
    End Class

    Function MalwareDomain(Url As String) As Boolean
      'Return True if a website contains Malware
      Dim Domain As String = DomainOfWebsite(Url, True)
      Dim MalwareVerification As MalwareWebsiteCheck = CType(LoadObject(GetType(MalwareWebsiteCheck), Domain), MalwareWebsiteCheck)
      If MalwareVerification IsNot Nothing Then
        Dim Days As New TimeSpan(30, 0, 0, 0)
        If Recent(MalwareVerification.DateOfVerification, Now, Days) Then
          Return MalwareVerification.MalwareDetected
        End If
      End If

      MalwareVerification = New MalwareWebsiteCheck
      MalwareVerification.DateOfVerification = Now.ToLocalTime
      Dim Html As String = ReadHtmlFromWeb("http://www.google.com/safebrowsing/diagnostic?site=" & HttpUtility.UrlEncode(Domain))
      MalwareVerification.MalwareDetected = Not String.IsNullOrEmpty(Html) AndAlso (Html.Contains("this site has hosted malicious software") OrElse Html.Contains("Malicious software is hosted"))

      SaveObject(MalwareVerification, Domain)

      Return MalwareVerification.MalwareDetected
    End Function

    Public Sub CleanCacheMalwareWebsiteCheck()
      Dim Dir As System.IO.DirectoryInfo = ObjectDirectoryLocation(GetType(MalwareWebsiteCheck))
      If Dir.Exists Then
        For Each Info As System.IO.FileInfo In Dir.GetFileSystemInfos
          If Not Recent(Info.LastAccessTimeUtc, Now.ToUniversalTime(), New TimeSpan(30, 0, 0, 0)) Then
            Delete(Info.FullName)
          End If
        Next
      End If
    End Sub

    Sub SetNextMessage(Text As String)
      HttpContext.Current.Session("NextMessage") = Text
    End Sub

    Sub SetNextMessage(ID As Integer)
      SetNextMessage(Phrase(CurrentSetting().Language, ID))
    End Sub

    Function NextProgressive(Name As String) As Integer
      Dim Tabindex As Integer = 0
      If HttpContext.Current.Items.Contains(Name) Then
        Tabindex = CInt(HttpContext.Current.Items(Name))
      End If
      Tabindex += 1
      HttpContext.Current.Items(Name) = Tabindex
      Return Tabindex
    End Function

  End Module

End Namespace
