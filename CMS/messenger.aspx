<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" Inherits="CMS.messenger" EnableViewState="false" EnableViewStateMac="false" Codebehind="messenger.aspx.vb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	<script type="text/javascript">
		focus()
	</script>
	<asp:Panel ID="ConfirmPanel" runat="server" HorizontalAlign="Center" Visible="False"
		Width="100%">
		<asp:PlaceHolder ID="MessageInConfirmPanel" runat="server"></asp:PlaceHolder>
		<br />
		<br />
		<asp:Panel ID="ConfirmCancelButtons" runat="server" Width="100%">
			<asp:Button ID="ConfirmButton" runat="server" Text="#57" />
			<asp:Button ID="CancelButton" runat="server" Text="#118" /></asp:Panel>
	</asp:Panel>
</asp:Content>
