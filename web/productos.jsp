<%-- 
    Document   : productos
    Created on : 06-abr-2013, 23:45:55
    Author     : CARMEN
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.mysql.jdbc.*"%>
<jsp:useBean id="bd" class="baseDatos.GestionBd" scope="page"/>
<!--metemos la lista de la compra-->
<jsp:useBean id="compra" class="compra.ListaCompra" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>productos</title>
    </head>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <body>
        
       <div id="wrap">
  
    <div id="header">
      <div id="logo">
          
          <jsp:include page="login.jsp"/>
        
      </div>
       <jsp:include page="menu.jsp"/>
    </div>
    <!-- /header -->
   
      <div class="sidel fl">
         <div class="sideinner">


        </div> 
      </div>
      <div class="mainerne fr">
          <br><br>
         <%
        
        Connection conexion =bd.conectarMYSQL();
           
            %>
            
            <form name="inicio">
                
               
                <br>
                <br>
                
             <%=bd.idioma("filtro")%>:   <input type="text" name="txtacriterio"/>
            
           <input type="submit" value='<%=bd.idioma("btnmostrar")%>'>
           <br><br>
           <%
           //hacemos una consulta con el where del parametro del value
          
           
       if(request.getParameter("txtacriterio")!=null){
               
        String filtro=request.getParameter("txtacriterio");
        
        //sabemos que solo nos va a dar un unico valor
       
        
        //PAR1 LIKE \'%\'|| ? ||\'%\'
        PreparedStatement pstt= (PreparedStatement)conexion.prepareStatement("select * from prestamos.reloj where desc_reloj like \'%\'|| ? ||\'%\'");
        //pstt.setString(1,"%"+filtro+"%");
        pstt.setString(1,filtro);
        ResultSet rst= (ResultSet) pstt.executeQuery();
        
        if(rst.next()==true){
            %>
             <br>
           <table border="2">
               <tr>
                   <td><%=bd.idioma("imagen")%></td>   
                   <td><%=bd.idioma("descripcion")%></td> 
                   <td><%=bd.idioma("precio")%></td> 
               </tr>
               <%
              while(rst.next()){
                System.out.println("hay resultados");    
                
                %>
           
                <tr>
               <td><img src='./RELOJES/<%=rst.getString("imagen_reloj")%>' width="90" height="100"><br>
                   <a href='TiendaDetalle.jsp?id_producto=<%=rst.getString("id_reloj")%>'><%=bd.idioma("detalle")%></a></td>   
               <td><%=rst.getString("desc_reloj")%> </td> 
               <td><%=rst.getString("prec_venta")%></td> 
               </tr>
               <%
              }
            %>
            
        <%
              
                
        %>
         </table>
         <%
                    
        }else{
            %>
            <h4><%=bd.idioma("sinresult")%></h4>
            <%
        }
        
        
       
                }
           
           %>
          
           
           
            </form>
        
     
          
        </div>
      </div>
      <!-- /content -->
    
    <div class="clearfix"></div>
    <div id="footer">
        <br><br>
        <h4><b><a href="contacto.jsp"><%=bd.idioma("contacto")%></a></b></h4>
        <br>
        
      </div>
    
    <!-- /footer -->
       
    </body>
</html>
