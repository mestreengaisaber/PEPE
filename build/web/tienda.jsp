<%-- 
    Document   : tienda
    Created on : 20-mar-2013, 11:14:34
    Author     : CARMEN
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="bd" class="baseDatos.GestionBd" scope="page"/>
<jsp:useBean id="usuario" class="beans.Cliente" scope="session"/>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Tienda Relojes</title>
<link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
     <%
        
         if(request.getParameter("ses")!=null){
            
            session.invalidate();
            response.sendRedirect("desconectar.jsp");
            //usuario.setEmail("");
            //usuario.setPass("");
             %>
            <h1><%=request.getParameter("ses")%></h1>
            
            <%
                                  
        }
            %>
<div id="wrap">
  
    <div id="header">
      <div id="logo">
          
          <jsp:include page="login.jsp"/>
        
      </div>
      <jsp:include page="menu.jsp"/>
    </div>
    <!-- /header -->
    <div id="content">
      <div class="sidel fl">
         <div class="sideinner">
 
 <%
 
String consultaVariacionReloj="select imagen_reloj,id_reloj from prestamos.reloj"; 
Connection conexion = bd.conectarMYSQL();
Statement st= (Statement)conexion.createStatement();    
ResultSet rs=(ResultSet)st.executeQuery(consultaVariacionReloj);
ArrayList listarelojes = new ArrayList();
ArrayList listidreloj=new ArrayList();
while (rs.next()){
    listarelojes.add(rs.getString(1));
    listidreloj.add(rs.getString(2));
}
   
//le meteriamos de nuestra lista
int unidadesM=listarelojes.size();
int aleatorio=(bd.generarAleatorio(unidadesM)-1);

//al crear el numero aleatorio es importante tener en cuenta que la lista empieza a 0 y la bd a 1 por eso le -1
%>
             
             
<img src='./RELOJES/<%=listarelojes.get(aleatorio) %>'/>
        <!--<img src="RELOJES/velocimetro.jpg" alt="" />-->
        <h3><a href='TiendaDetalle.jsp?id_producto=<%=listidreloj.get(aleatorio)%>'><%=bd.idioma("detalle")%> </a></h3>
        </div> 
      </div>
      <div class="main fr">
        <div id="text">
            <br><br>
            <h2><p><%=bd.idioma("cabecera")%></p></h2>
            
             </div>
        <!--<div class="clearfix"></div>
        <div id="col">
          <div class="first fl">
            <ul>
              <li><a href="#">Latin literature </a></li>
              <li><a href="#">making over years </a></li>
              <li><a href="#">Richard Clintock </a></li>
              <li><a href="#">Virginia looked one</a></li>
              <li><a href="#">Latin professor </a></li>
              <li><a href="#">Hampden Sydney </a></li>
            </ul>
          </div>
          <div class=" fl ">
            <ul>
              <li><a href="#">Latin literature </a></li>
              <li><a href="#">making over years </a></li>
              <li><a href="#">Richard Clintock </a></li>
              <li><a href="#">Latin professor </a></li>
              <li><a href="#">Hampden Sydney </a></li>
              <li><a href="#">Virginia looked one</a></li>
            </ul>
        -->
          
        </div>
      </div>
      <!-- /content -->
    </div>
    <div class="clearfix"></div>
    <div id="footer">
      <br><br>
        <h4><b><a href="contacto.jsp"><%=bd.idioma("contacto")%></a></b></h4>
        <br>
        
      </div>
    
    <!-- /footer -->
  </div>

  
</body>
</html>
