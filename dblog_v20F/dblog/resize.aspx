<%@ Page Language="VB"%>
<%@ import Namespace="System.Drawing"%>
<%@ import Namespace="System.Drawing.Imaging"%>
<%@ import Namespace="System.Text.RegularExpressions"%>

<script runat="server">
'	dBlog 2.0 CMS Open Source
'	Versione file 2.0.0
'	FUNZIONE: questo script si occupa di effettuare in automatico (streaming) il ridimensionamento delle immagini sulla MyBase della larghezza

'	Codice di Peter Ray e Visuddhi

'	Costanti predefinite per gestire eventuali problemi di sicurezza
	Dim LarghezzaMassima As Integer = 800
	Dim PercorsoConsentito As String = "/public/"

	Dim Larghezza As Integer
	Dim oldImage As System.Drawing.Image,NewImage As System.Drawing.Image

	Private  Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		If Not Request.QueryString("img") Is Nothing Then
			Dim strimg As String =  Convert.ToString(Request.QueryString("img"))
			Larghezza = Convert.ToInt32(Request.QueryString("opx"))

			If Larghezza > LarghezzaMassima Then Larghezza = LarghezzaMassima
				If strimg <> "" And strimg.Trim().StartsWith(PercorsoConsentito) Then
				Try
					oldImage = System.Drawing.Image.FromFile(Server.MapPath(strimg))
					NewImage = oldImage.GetThumbnailImage((Larghezza), (Larghezza*oldImage.Height/oldImage.Width), Nothing, IntPtr.Zero)
					Response.ContentType = "image/jpeg"
					newImage.Save(Response.OutputStream,System.Drawing.Imaging.ImageFormat.Jpeg)
					oldImage.Dispose()
					newImage.Dispose()
					oldImage = Nothing
					Catch ex As Exception
					Response.Write(ex.Message)
				End Try
			End If
		End If
	End Sub
</script>