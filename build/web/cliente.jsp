<%-- 
    Document   : cliente
    Created on : 09-abr-2013, 11:33:22
    Author     : CARMEN
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="usuario" class="beans.Cliente" scope="session"/>
<jsp:useBean id="bd" class="baseDatos.GestionBd" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>cliente</title>
    </head>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <script src="includes/jquery.js"></script>
    <script src="includes/jquery.validate.js"></script>

     <script>
$(document).ready(function() {
$.validator.addMethod("pa",function(value,element)
{
return (element) || /^[A-Za-z0-9!@#$%^&*()_]{6,16}$/i.test(value); 
},"Passwords are 6-16 characters");
$("#form").validate({
                rules: {
                nombre_cliente:{required:true},
                apellidos: {required:true},
                dni: {required:true,rangelength: [9,9]},
                email: {required: true,email: true},
                pass:{required:true,rangelength: [6,8]},
                copass:{required:true,equalTo:"#pass"},
                fecha_nacimiento:{required: true,date: true},
                direccion:{required:true},
                poblacion:{required:true},
                cpostal:{required:true,number:true,rangelength: [5,5]},
                provincia:{required:true},
                telefono:{required:true,number:true,rangelength: [9,9]},
                nick:{required:true,rangelength: [6,12]}
                },
                messages: {
                     nombre_cliente: {required: "Este campo es obligatorio."},
                     apellidos:{required: "Este campo es obligatorio."},
                     dni:{required: "Este campo es obligatorio.",rangelength:"el campo tiene que tener 9 caracteres"},
                     email:{required: "Este campo es obligatorio.",email:"Por favor, escribe una dirección de correo válida"},
                     pass:{required: "Este campo es obligatorio.",rangelength:"el campo tiene que tener entre 6 y 8 caracteres"},
                     copass:{required:"Este campo es obligatorio.",minlength:"ingrese al menos 5 caracteres",equalTo:"ingrese el password igual al anterior"},
                     fecha_nacimiento:{required:"Este campo es obligatorio.",date:"introduce un formato fecha correcto"},
                     direccion:{required:"Este campo es obligatorio."},
                    poblacion:{required:"Este campo es obligatorio."},
                    cpostal:{required:"Este campo es obligatorio.",rangelength:"introduce un codigo postal valido de 5 digitos"},
                    provincia:{required:"Este campo es obligatorio."},
                    telefono:{required:"Este campo es obligatorio.",number:"introduce un numero",rangelength:"introduce un numero de tel de 9 digitos sin espacios"},
                    nick:{required: "Este campo es obligatorio.",rangelength:"el campo tiene que tener entre 6 y 12 caracteres"}
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
          
             <%
    
        if((request.getParameter("nombre_cliente")!=null)&&(request.getParameter("email")!=null))
        {
           //actualizamos todos los datos del bean 
        %> 
        <jsp:setProperty name="usuario" property="*" />
        <h4><%=bd.actualizarUsuario(usuario)%></h4>
        <%
        

}%>    
             
          
          
    <br><br>
    <form name="form" id="form">
            
    
    <%=bd.idioma("nombre")%> : <input type="text" name="nombre_cliente" value="<%=usuario.getNombre_cliente()%>"/><br><br>
    <%=bd.idioma("apellidos")%> : <input type="text" name="apellidos" value="<%=usuario.getApellidos()%>"/><br><br>
    <%=bd.idioma("dni")%> : <input type="text" name="dni" value="<%=usuario.getDni()%>"/><br><br>
    <%=bd.idioma("email")%> : <input type="text" name="email" value="<%=usuario.getEmail()%>"/><br><br>
    <%=bd.idioma("nick")%> : <input type="text" name="nick" value="<%=usuario.getNick()%>"/><br><br>
    <%=bd.idioma("pass")%> : <input type="text" name="pass" id="pass" value="<%=usuario.getPass()%>" maxlength="8"/><br><br>
    <%=bd.idioma("fecha")%>: <input type="date" name="fecha_nacimiento" value="<%=usuario.getFecha_nacimiento()%>"/><br><br>
    <%=bd.idioma("direccion")%> : <input type="text" name="direccion" value="<%=usuario.getDireccion()%>"/><br><br>
    <%=bd.idioma("poblacion")%> : <input type="text" name="poblacion" value="<%=usuario.getPoblacion()%>"/><br><br>
    <%=bd.idioma("cpostal")%> : <input type="text" name="cpostal" value="<%=usuario.getCpostal()%>"/><br><br>
    <%=bd.idioma("provincia")%> : <input type="text" name="provincia" value="<jsp:getProperty name="usuario" property="provincia"/>"/><br><br>
    <%=bd.idioma("telefono")%> : <input type="text" name="telefono" value="<jsp:getProperty name="usuario" property="telefono"/>"/><br><br>
   
    
    <input type="submit" value=<%=bd.idioma("actualizar")%>/><br><br>        
    </form>
 
      
             
           
             
    </body>
        
     
          
        </div>
      </div>
      
    
    <div class="clearfix"></div>
    <div id="footer">
        <br><br>
        <h4><b><a href="contacto.jsp"><%=bd.idioma("contacto")%></a></b></h4>
        <br>
        
      </div>
    
   
       

</html>
