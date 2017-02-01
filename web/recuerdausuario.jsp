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
        <title>recuerda</title>
    </head>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <script src="includes/jquery.js"></script>
    <script src="includes/jquery.validate.js"></script>
    <script>
         $(document).ready(function() {
              $("#form").validate({
                rules: {
                  txtcorreo: {required: true,email: true}
                  
                },
                messages: {
                  
                  txtcorreo : "Email no Valido"
                  
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
          <h4><%=bd.idioma("mensajeinicial")%></h4>
          <br>
            <form name="form" id="form" >
         <%=bd.idioma("correo")%> <input type="text" name="txtcorreo">
            <br><br><br>
            
            <input type="submit" value="<%=bd.idioma("btnenviar")%>"/>
            
        </form> 
            <br><br>
            <% 
           if(request.getParameter("txtcorreo")!=null)
              {
            String destinatarioCorreo=request.getParameter("txtcorreo");
            boolean resultado =bd.validaremailValidoenBD(destinatarioCorreo);
            
            if(resultado==false){
                %>
                 <h1><%=bd.idioma("novalidor")%></h1>
                 <%
            }
                       else{
                             %>
                        <h1><%=bd.idioma("emailcorrecto")%></h1>
                 <%
                       }
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
