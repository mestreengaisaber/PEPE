<%-- 
    Document   : contacto
    Created on : 06-abr-2013, 19:26:22
    Author     : CARMEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="bd" class="baseDatos.GestionBd" scope="page"/>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>contacto</title>
    </head>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <script src="includes/jquery.js"></script>
    <script src="includes/jquery.validate.js"></script>

     <script>
         $(document).ready(function() {
              $("#contacto").validate({
                rules: {
                  txtacomentario: {required: true},
                  txtemail: {required: true,email: true},
                  txtasunto: {required: true}
                },
                messages: {
                     txtacomentario: "Este campo es obligatorio.",
                     txtasunto: "Este campo es obligatorio.",
                     txtemail: "Por favor, escribe una dirección de correo válida"
                  
                }
              });
            });
        </script>
        <style>
            .error-message, label.error {
                color: #ff0000;
                margin:0;
                display: inline;
                font-size: 1em !important;
                font-weight:lighter;
            }
        </style>
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
            <form name="contacto" id="contacto" >
         <%=bd.idioma("email")%>:   <input type="text" name="txtemail"><br><br>
         <%=bd.idioma("asunto")%>: <input type="text" name ="txtasunto"><br><br>
            
            <textarea name="txtacomentario" cols=40 rows=10></textarea> 
            <br><br><br>
            
            <input type="submit" value="<%=bd.idioma("btnenviar")%>"/>
            
        </form> 
            <%
            if(request.getParameter("txtasunto")!=null)
            {
                String cabecera=request.getParameter("txtasunto");
                String comentario=request.getParameter("txtacomentario");
                
                comentario=bd.cabeceraContenido(cabecera, comentario);
                //solo estamos cojiendo el contenido no el asunto ni nada
                //el codigo 4 nos indica la cabecera de el correo
                bd.enviarCorreo(bd.correouser, comentario, 4);
            
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
