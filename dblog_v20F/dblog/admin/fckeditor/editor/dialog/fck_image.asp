<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!--
 * FCKeditor - The text editor for internet
 * Copyright (C) 2003-2005 Frederico Caldeira Knabben
 * 
 * Licensed under the terms of the GNU Lesser General Public License:
 * 		http://www.opensource.org/licenses/lgpl-license.php
 * 
 * For further information visit:
 * 		http://www.fckeditor.net/
 * 
 * File Name: fck_image.html
 * 	Image Properties dialog window.
 * 
 * File Authors:
 * 		Frederico Caldeira Knabben (fredck@fckeditor.net)
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Image Properties</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="robots" content="noindex, nofollow">
		<script src="common/fck_dialog_common.js" type="text/javascript"></script>
		<script src="fck_image/fck_image.js" type="text/javascript"></script>
		<link href="common/fck_dialog_common.css" rel="stylesheet" type="text/css" />
	</head>
	<body scroll="no" style="OVERFLOW: hidden">
		<div id="divInfo">
			<table cellspacing="1" cellpadding="1" border="0" width="100%" height="100%">
				<tr>
					<td>
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td width="100%">
									<span fckLang="DlgImgURL">URL</span>
								</td>
								<td id="tdBrowse" style="DISPLAY: none" nowrap rowspan="2">
									&nbsp; <input id="btnBrowse" onclick="BrowseServer();" type="button" value="Browse Server" fckLang="DlgBtnBrowseServer">
								</td>
							</tr>
							<tr>
								<td valign="top">
                  <select id="txtUrl" style="width: 100%" type="text" onchange="UpdatePreview();">
                    <option id="scelta0" value=">Seleziona file"</option>
                    <%
                      Dim Fso, Folder, File, DirName, I, FolderNow
                      DirName = Server.MapPath(Path_DirPublic)
                      Set Fso = CreateObject("Scripting.FileSystemObject")
                      Set Folder = fso.GetFolder(DirName)
                    
                      I = 0
                      For Each File In Folder.Files
                        If LCase(Mid(File.Name, Len(File.Name) - 3, 4)) = ".jpg" OR LCase(Mid(File.Name, Len(File.Name) - 3, 4)) = ".gif" OR LCase(Mid(File.Name, Len(File.Name) - 3, 4)) = ".png" Then
                          I = I + 1
                    %>
                    <option id="scelta<%=I%>" value="<%=Path_DirPublic & File.Name%>"><%=File.Name%></option>
                    <%
                        End If
                      Next

                      For Each SubFld In Folder.Subfolders
                        FolderNow = SubFld.Name & "\"
                        For Each File In SubFld.Files
                          If Mid(File.Name, Len(File.Name) - 3, 4) = ".jpg" OR Mid(File.Name, Len(File.Name) - 3, 4) = ".gif" OR Mid(File.Name, Len(File.Name) - 3, 4) = ".png" Then
                            I = I + 1
                      %>
                      <option id="scelta<%=I%>" value="<%=Path_DirPublic & FolderNow & File.Name%>"><%=FolderNow & File.Name%></option>
                      <%
                          End If
                        Next
                      Next
                      
                      Set SubFld = Nothing
                      Set Folder = Nothing
                      Set Fso = Nothing
                      Set File = Nothing
                    %>
                  </select>
                  <% If true = false Then %>
                  <input id="txtUrl" style="WIDTH: 100%" type="text" onblur="UpdatePreview();">
                  <% End If %>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<span fckLang="DlgImgAlt">Short Description</span><br />
						<input id="txtAlt" style="WIDTH: 100%" type="text"><br />
					</td>
				</tr>
				<tr height="100%">
					<td valign="top">
						<table cellspacing="0" cellpadding="0" width="100%" border="0" height="100%">
							<tr>
								<td valign="top">
									<br />
									<table cellspacing="0" cellpadding="0" border="0">
										<tr>
											<td nowrap><span fckLang="DlgImgWidth">Width</span>&nbsp;</td>
											<td>
												<input type="text" size="3" id="txtWidth" onkeyup="OnSizeChanged('Width',this.value);"></td>
											<td nowrap rowspan="2">
												<div id="btnLockSizes" class="BtnLocked" onmouseover="this.className = (bLockRatio ? 'BtnLocked' : 'BtnUnlocked' ) + ' BtnOver';"
													onmouseout="this.className = (bLockRatio ? 'BtnLocked' : 'BtnUnlocked' );" title="Lock Sizes"
													onclick="SwitchLock(this);"></div>
												<div id="btnResetSize" class="BtnReset" onmouseover="this.className='BtnReset BtnOver';"
													onmouseout="this.className='BtnReset';" title="Reset Size" onclick="ResetSizes();"></div>
											</td>
										</tr>
										<tr>
											<td nowrap><span fckLang="DlgImgHeight">Height</span>&nbsp;</td>
											<td>
												<input type="text" size="3" id="txtHeight" onkeyup="OnSizeChanged('Height',this.value);"></td>
										</tr>
									</table>
									<br />
									<table cellspacing="0" cellpadding="0" border="0">
										<tr>
											<td nowrap><span fckLang="DlgImgBorder">Border</span>&nbsp;</td>
											<td>
												<input type="text" size="2" value="" id="txtBorder" onkeyup="UpdatePreview();"></td>
										</tr>
										<tr>
											<td nowrap><span fckLang="DlgImgHSpace">HSpace</span>&nbsp;</td>
											<td>
												<input type="text" size="2" id="txtHSpace" onkeyup="UpdatePreview();"></td>
										</tr>
										<tr>
											<td nowrap><span fckLang="DlgImgVSpace">VSpace</span>&nbsp;</td>
											<td>
												<input type="text" size="2" id="txtVSpace" onkeyup="UpdatePreview();"></td>
										</tr>
										<tr>
											<td nowrap><span fckLang="DlgImgAlign">Align</span>&nbsp;</td>
											<td><select id="cmbAlign" onchange="UpdatePreview();">
													<option value="" selected></option>
													<option fckLang="DlgImgAlignLeft" value="left">Left</option>
													<option fckLang="DlgImgAlignAbsBottom" value="absBottom">Abs Bottom</option>
													<option fckLang="DlgImgAlignAbsMiddle" value="absMiddle">Abs Middle</option>
													<option fckLang="DlgImgAlignBaseline" value="baseline">Baseline</option>
													<option fckLang="DlgImgAlignBottom" value="bottom">Bottom</option>
													<option fckLang="DlgImgAlignMiddle" value="middle">Middle</option>
													<option fckLang="DlgImgAlignRight" value="right">Right</option>
													<option fckLang="DlgImgAlignTextTop" value="textTop">Text Top</option>
													<option fckLang="DlgImgAlignTop" value="top">Top</option>
												</select>
											</td>
										</tr>
									</table>
								</td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td width="100%" valign="top">
									<table cellpadding="0" cellspacing="0" width="100%" style="TABLE-LAYOUT: fixed">
										<tr>
											<td><span fckLang="DlgImgPreview">Preview</span></td>
										</tr>
										<tr>
											<td valign="top">
												<div class="ImagePreviewArea">
													<a id="lnkPreview" onclick="return false;" style="CURSOR: default"><img id="imgPreview" style="DISPLAY: none"></a>Magnus 
													es, domine, et laudabilis valde: magna virtus tua, et sapientiae tuae non est 
													numerus. et laudare te vult homo, aliqua portio creaturae tuae, et homo 
													circumferens mortalitem suam, circumferens testimonium peccati sui et 
													testimonium, quia superbis resistis: et tamen laudare te vult homo, aliqua 
													portio creaturae tuae.tu excitas, ut laudare te delectet, quia fecisti nos ad 
													te et inquietum est cor nostrum, donec requiescat in te. da mihi, domine, scire 
													et intellegere, utrum sit prius invocare te an laudare te, et scire te prius 
													sit an invocare te. sed quis te invocat nesciens te? aliud enim pro alio potest 
													invocare nesciens. an potius invocaris, ut sciaris? quomodo autem invocabunt, 
													in quem non crediderunt? aut quomodo credent sine praedicante? et laudabunt 
													dominum qui requirunt eum. quaerentes enim inveniunt eum et invenientes 
													laudabunt eum. quaeram te, domine, invocans te, et invocem te credens in te: 
													praedicatus enim es nobis. invocat te, domine, fides mea, quam dedisti mihi, 
													quam inspirasti mihi per humanitatem filii tui, per ministerium praedicatoris 
													tui.
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div id="divUpload" style="DISPLAY: none">
			<form id="frmUpload" method="post" target="UploadWindow" enctype="multipart/form-data" action="" onsubmit="return CheckUpload();">
				<span fckLang="DlgLnkUpload">Upload</span><br />
				<input id="txtUploadFile" style="WIDTH: 100%" type="file" size="40" name="NewFile" /><br />
				<br />
				<input id="btnUpload" type="submit" value="Send it to the Server" fckLang="DlgLnkBtnUpload" />
				<iframe name="UploadWindow" style="DISPLAY: none"></iframe> 
			</form>
		</div>
		<div id="divLink" style="DISPLAY: none">
			<table cellspacing="1" cellpadding="1" border="0" width="100%">
				<tr>
					<td>
						<div>
							<span fckLang="DlgLnkURL">URL</span><br />
							<input id="txtLnkUrl" style="WIDTH: 100%" type="text" onblur="UpdatePreview();" />
						</div>
						<div id="divLnkBrowseServer" align="right">
							<input type="button" value="Browse Server" fckLang="DlgBtnBrowseServer" onclick="LnkBrowseServer();" />
						</div>
						<div>
							<span fckLang="DlgLnkTarget">Target</span><br />
							<select id="cmbLnkTarget">
								<option value="" fckLang="DlgGenNotSet" selected="selected">&lt;not set&gt;</option>
								<option value="_blank" fckLang="DlgLnkTargetBlank">New Window (_blank)</option>
								<option value="_top" fckLang="DlgLnkTargetTop">Topmost Window (_top)</option>
								<option value="_self" fckLang="DlgLnkTargetSelf">Same Window (_self)</option>
								<option value="_parent" fckLang="DlgLnkTargetParent">Parent Window (_parent)</option>
							</select>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="divAdvanced" style="DISPLAY: none">
			<table cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
				<tr>
					<td valign="top" width="50%">
						<span fckLang="DlgGenId">Id</span><br />
						<input id="txtAttId" style="WIDTH: 100%" type="text">
					</td>
					<td width="1">&nbsp;&nbsp;</td>
					<td valign="top">
						<table cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
							<tr>
								<td width="60%">
									<span fckLang="DlgGenLangDir">Language Direction</span><br />
									<select id="cmbAttLangDir" style="WIDTH: 100%">
										<option value="" fckLang="DlgGenNotSet" selected>&lt;not set&gt;</option>
										<option value="ltr" fckLang="DlgGenLangDirLtr">Left to Right (LTR)</option>
										<option value="rtl" fckLang="DlgGenLangDirRtl">Right to Left (RTL)</option>
									</select>
								</td>
								<td width="1%">&nbsp;&nbsp;</td>
								<td nowrap>
									<span fckLang="DlgGenLangCode">Language Code</span><br />
									<input id="txtAttLangCode" style="WIDTH: 100%" type="text">&nbsp;
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="3">
						<span fckLang="DlgGenLongDescr">Long Description URL</span><br />
						<input id="txtLongDesc" style="WIDTH: 100%" type="text">
					</td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td valign="top">
						<span fckLang="DlgGenClass">Stylesheet Classes</span><br />
						<input id="txtAttClasses" style="WIDTH: 100%" type="text">
					</td>
					<td></td>
					<td valign="top">&nbsp;<span fckLang="DlgGenTitle">Advisory Title</span><br />
						<input id="txtAttTitle" style="WIDTH: 100%" type="text">
					</td>
				</tr>
			</table>
			<span fckLang="DlgGenStyle">Style</span><br />
			<input id="txtAttStyle" style="WIDTH: 100%" type="text">
		</div>
	</body>
</html>
