<!--#include virtual="/mdb-database/inc_costanti.asp"-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
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
 * File Name: fck_flash.html
 * 	Flash Properties dialog window.
 * 
 * File Authors:
 * 		Frederico Caldeira Knabben (fredck@fckeditor.net)
-->
<html>
	<head>
		<title>Flash Properties</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta content="noindex, nofollow" name="robots">
		<script src="common/fck_dialog_common.js" type="text/javascript"></script>
		<script src="fck_flash/fck_flash.js" type="text/javascript"></script>
		<link href="common/fck_dialog_common.css" type="text/css" rel="stylesheet">
	</head>
	<body scroll="no" style="OVERFLOW: hidden">
		<div id="divInfo">
			<table cellSpacing="1" cellPadding="1" width="100%" border="0">
				<tr>
					<td>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td width="100%"><span fckLang="DlgImgURL">URL</span>
								</td>
								<td id="tdBrowse" style="DISPLAY: none" noWrap rowSpan="2">&nbsp; <input id="btnBrowse" onclick="BrowseServer();" type="button" value="Browse Server" fckLang="DlgBtnBrowseServer">
								</td>
							</tr>
							<tr>
                  <select id="txtUrl" style="width: 100%" type="text" onchange="UpdatePreview();">
                    <option id="scelta0" value=">Seleziona file"</option>
                    <%
                      Dim Fso, Folder, File, DirName, I, FolderNow
                      DirName = Server.MapPath(Path_DirPublic)
                      Set Fso = CreateObject("Scripting.FileSystemObject")
                      Set Folder = fso.GetFolder(DirName)
                    
                      I = 0
                      For Each File In Folder.Files
                        If Mid(File.Name, Len(File.Name) - 3, 4) = ".swf" Then
                          I = I + 1
                    %>
                    <option id="scelta<%=I%>" value="<%=Path_DirPublic & File.Name%>"><%=File.Name%></option>
                    <%
                        End If
                      Next

                      For Each SubFld In Folder.Subfolders
                        FolderNow = SubFld.Name & "\"
                        For Each File In SubFld.Files
                          If Mid(File.Name, Len(File.Name) - 3, 4) = ".swf" Then
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
				<TR>
					<TD>
						<table cellSpacing="0" cellPadding="0" border="0">
							<TR>
								<TD nowrap>
									<span fckLang="DlgImgWidth">Width</span><br>
									<input id="txtWidth" class="FCK__FieldNumeric" type="text" size="3">
								</TD>
								<TD>&nbsp;</TD>
								<TD>
									<span fckLang="DlgImgHeight">Height</span><br>
									<input id="txtHeight" class="FCK__FieldNumeric" type="text" size="3">
								</TD>
							</TR>
						</table>
					</TD>
				</TR>
				<tr>
					<td vAlign="top">
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td valign="top" width="100%">
									<table cellSpacing="0" cellPadding="0" width="100%">
										<tr>
											<td><span fckLang="DlgImgPreview">Preview</span></td>
										</tr>
										<tr>
											<td id="ePreviewCell" valign="top" class="FlashPreviewArea">&nbsp;</td>
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
		<div id="divAdvanced" style="DISPLAY: none">
			<TABLE cellSpacing="0" cellPadding="0" border="0">
				<TR>
					<TD nowrap>
						<span fckLang="DlgFlashScale">Scale</span><BR>
						<select id="cmbScale">
							<option value="" selected></option>
							<option value="showall" fckLang="DlgFlashScaleAll">Show all</option>
							<option value="noborder" fckLang="DlgFlashScaleNoBorder">No Border</option>
							<option value="exactfit" fckLang="DlgFlashScaleFit">Exact Fit</option>
						</select></TD>
					<TD>&nbsp;&nbsp;&nbsp; &nbsp;
					</TD>
					<td valign="bottom">
						<table>
							<tr>
								<td><input id="chkAutoPlay" type="checkbox" checked></td>
								<td><label for="chkAutoPlay" nowrap fckLang="DlgFlashChkPlay">Auto Play</label>&nbsp;&nbsp;</td>
								<td><input id="chkLoop" type="checkbox" checked></td>
								<td><label for="chkLoop" nowrap fckLang="DlgFlashChkLoop">Loop</label>&nbsp;&nbsp;</td>
								<td><input id="chkMenu" type="checkbox" checked></td>
								<td><label for="chkMenu" nowrap fckLang="DlgFlashChkMenu">Enable Flash Menu</label></td>
							</tr>
						</table>
					</td>
				</TR>
			</TABLE>
			<br>
			&nbsp;
			<table cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">
				<tr>
					<td vAlign="top" width="50%"><span fckLang="DlgGenId">Id</span><br>
						<input id="txtAttId" style="WIDTH: 100%" type="text">
					</td>
					<td>&nbsp;&nbsp;</td>
					<td vAlign="top" nowrap><span fckLang="DlgGenClass">Stylesheet Classes</span><br>
						<input id="txtAttClasses" style="WIDTH: 100%" type="text">
					</td>
					<td>&nbsp;&nbsp;</td>
					<td vAlign="top" nowrap width="50%">&nbsp;<span fckLang="DlgGenTitle">Advisory Title</span><br>
						<input id="txtAttTitle" style="WIDTH: 100%" type="text">
					</td>
				</tr>
			</table>
			<span fckLang="DlgGenStyle">Style</span><br>
			<input id="txtAttStyle" style="WIDTH: 100%" type="text">
		</div>
	</body>
</html>
