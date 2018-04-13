<%@ page import="com.salesforce.saml.Identity,com.salesforce.util.Bag,java.util.Set,java.util.Iterator,java.util.ArrayList" %>
<%
Identity identity = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
 for (Cookie cookie : cookies) {
   if (cookie.getName().equals("IDENTITY")) {
     identity = new Identity(cookie.getValue(),true);
    }
  }
}

%>

<html>
<head>
<link href="/css/style.css" rel="stylesheet" type="text/css">
</head>

<body>


<% if (identity != null ) { %>
<center>
<h2><%= identity.getSubject() %></h2>
<table border="0" cellpadding="5">
<%
	Bag attributes = identity.getAttributes();
	Set keySet = attributes.keySet();
	Iterator iterator = keySet.iterator();
	while (iterator.hasNext()){
		String key = (String)iterator.next();
		%><tr><td><b><%= key %>:</b></td><td><%
		ArrayList<String> values = (ArrayList<String>)attributes.getValues(key);
		for (String value : values) {
			%><%= value %><br/><%
		}
		%></td></tr><%

	}

%>
</table>
<br>
<a href="/_saml?logout=true" class="button center">Logout</a>
</center>
<% } else {  %>
 <div class="centered">
<div>
	<label for="usuario">Usuario:</label>
	<input type="text" id="usuario" name="usuario">
	<br/>
	<label for="senha">Senha:</label>
	<input type="text" id="senha" name="senha">
	<br/>
	<input type="button" value="Enviar" onclick="ValidaUsuario();">
	<br/>
	<div id="msg"></div>
		
	
</div>
	 <br/><br/>
<script>
	function ValidaUsuario() {
	    var usuario = document.getElementById("usuario").value;
	    var senha  = document.getElementById("senha").value;
	    if(usuario=="usuario" && senha=="senha") {
	    	document.getElementById("msg").innerHTML = "Login autorizado!";
	    } else {
	    	document.getElementById("msg").innerHTML = "Login não autorizado!";
	    }
	}
</script>
 <span class=""><a href="/_saml?RelayState=%2F" class="button center">Login via Salesforce</a></span>
 </div>

<% } %>


</body>
</html>
