

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="bd" class="baseDatos.GestionBd" scope="session"/>
<jsp:useBean id="usuario" class="beans.Cliente" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>menu</title>
        
    </head>
    <body>
        
        
<ul id="nav">
        <li class="first"><a href="tienda.jsp"><%=bd.idioma("home")%></a></li>
        <li><a href='productos.jsp'><%=bd.idioma("ver")%></a></li>
	<li><a href='carro.jsp'><%=bd.idioma("carrito")%></a></li>
        <li><a href='cliente.jsp'><%=bd.idioma("micuenta")%></a></li>
        
        
        
        
        <%
        if(usuario.getEmail()!=""){
           
            
        }else{
            
            
        }%>
        
        
      </ul>
    </body>
</html>