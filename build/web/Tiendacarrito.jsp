<%-- 
    Document   : Tiendacarrito
    Created on : 14-feb-2013, 1:36:18
    Author     : ernest
--%>

<%@page import="compra.CompraProducto"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@page import="java.util.ArrayList"%>

<jsp:useBean id="bd" class="baseDatos.GestionBd" scope="session"/>
<jsp:useBean id="datospagina" class="compra.CompraProducto" scope="session"/>
<jsp:useBean id="compra" class="compra.ListaCompra" scope="session"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
         
	   
           
           if(request.getParameter("ideE")!=null){
                int idArt=Integer.parseInt(request.getParameter("ideE"));
                //pendiente de controlar cuando los eliminamos todos   
                CompraProducto pr =compra.getListacompra().get(idArt);
                
                System.out.println("el producto a eliminar es "+pr.getIdRelojComp());
                          
          
            }
           
         %>
         <form name="form">

              
              <%
              String tabla= bd.pintarTablaPedido(compra.getListacompra());
              %>
              
           <%=tabla%>
        
        </form>
    </body>
</html>
