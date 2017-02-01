<%-- 
    Document   : carro
    Created on : 09-abr-2013, 12:05:38
    Author     : CARMEN
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="bd" class="baseDatos.GestionBd" scope="page"/>
<jsp:useBean id="compra" class="compra.ListaCompra" scope="session"/>
<jsp:useBean id="cliente" class="beans.Cliente" scope="session"/>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>carrito</title>
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
              String tabla= bd.pintarTablaPedido(compra.getListacompra());
              
              %>
              
            <%
            if(tabla!="")
            {
               
             %>
  
             <form name="form">                    
                <%=tabla%>
              <br>
              <input type="hidden" name="txttabla" value="<%=tabla%>"/>
              <input type="submit" value="<%=bd.idioma("coenviar")%>"/>
           
        
        </form>
               <%
                //bd.enviarCorreoHTML(cliente.getEmail(), tablarecibida, 4);
            
            }else{
                  %>
                  <br><br>
                  <h1>NO HAY ELEMENTOS EN LA CESTA</h1>
                  <%
            }
              
            
            %>
     
          
        </div>
      </div>
      
    
    <div class="clearfix"></div>
    <div id="footer">
        <br><br>
        <h4><b><a href="contacto.jsp"><%=bd.idioma("contacto")%></a></b></h4>
        <br>
        
      </div>
    
    
       
    </body>
</html>
