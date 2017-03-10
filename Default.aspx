<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SubmitDeploymentToNewRelic.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="/css/all.css">
</head>
<body>
    
    <header class="main-header">
        <a href="#" class="logo">Mirabeau</a>
    </header>
    <form id="form1" runat="server" class="main-header">
    <div>
        <asp:Label ID="lblApplication" runat="server" Text="Application" Font-Bold="true" Font-Size="Medium"></asp:Label><br />
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" style="height: 30px; width: 400px">
        </asp:DropDownList><br />
        <asp:XmlDataSource ID="ClientsDataSource" runat="server" DataFile="~/App_Data/Clients.xml"></asp:XmlDataSource>
        <br />
        <asp:Label ID="lblNewRelicApiKey" runat="server" Text="NewRelic apiKey" Font-Bold="true" Font-Size="Medium"></asp:Label><br />
        <asp:TextBox ID="txtNewRelicApiKey" runat="server" Width="400px" Height="30px"></asp:TextBox><br />
        <br />
        <asp:Label ID="lblNewRelicAppName" runat="server" Text="NewRelic ApplicationId" Font-Bold="true" Font-Size="Medium"></asp:Label><br />
        <asp:TextBox ID="txtNewRelicAppName" runat="server" Width="400px" Height="30px"></asp:TextBox><br /><br />
        <asp:Label ID="lblNewRelicUser" runat="server" Text="NewRelic Deployment User" Font-Bold="true" Font-Size="Medium"></asp:Label><br />
        <asp:TextBox ID="txtNewRelicUser" runat="server" Width="400px" Height="30px"></asp:TextBox><br />
        <asp:RequiredFieldValidator runat="server" id="reqUser" controltovalidate="txtNewRelicUser" errormessage="Vul je naam in!" Font-Bold="false" Font-Size="Medium" ForeColor="Red"/>
        <br /><br />
        <asp:Label ID="lblNewRelicDeploymentRevision" runat="server" Text="NewRelic Deployment Revision" Font-Bold="true" Font-Size="Medium"></asp:Label><br />
        <asp:TextBox ID="txtNewRelicDeploymentRevision" runat="server" Height="80px" TextMode="MultiLine" Width="400px"></asp:TextBox><br />
        <asp:RequiredFieldValidator runat="server" id="reqRevision" controltovalidate="txtNewRelicDeploymentRevision" errormessage="Vul een release / deployment omschrijving in!" Font-Bold="false" Font-Size="Medium" ForeColor="Red"/>
        <br /><br />
        <asp:Button ID="btnSubmitNewRelicDeployment" runat="server" Text="Submit deployment to NewRelic" OnClick="btnSubmitNewRelicDeployment_Click" Width="400px" Height="60px" Font-Size="Medium" /><br />
        <br />
        <asp:Label ID="lblError" runat="server" Text="" Font-Bold="true" Font-Size="Medium"></asp:Label>
        <asp:Label ID="lblSuccess" runat="server" Text="" Font-Bold="true" Font-Size="Medium"></asp:Label>
    </div>
    </form>
</body>
</html>
