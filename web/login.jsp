<%-- 
    Document   : login
    Created on : 15-mar-2013, 14:40:00
    Author     : alumno
--%>

<%@page import="beans.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="bd" class="baseDatos.GestionBd" scope="session"/>
<jsp:useBean id="usuario" class="beans.Cliente" scope="session"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Loguin</title>
        
    </head>
    <body>
        <%
         
         
        
         
        
        if(request.getParameter("txtusuario")!=null){
            
           Cliente c =bd.validarLoguin(request.getParameter("txtusuario"),request.getParameter("txtpass"));
           
            boolean usuarioValido=c.isResultados();
            //lo inicializamos a false
             
            System.out.println("usuarioValido"+usuarioValido);
            if(usuarioValido==true){
                //solo si es usuario valido metemos el nick y todos los datos
                usuario.setNick(c.getNick());
                usuario.setRol(c.getRol());
                System.out.println("el rol cargado es"+c.getRol());
                usuario.setMenuAdmin(false);
                usuario.setEmail(c.getEmail());
                usuario.setPass(c.getPass());
                //usuario.setEmail(request.getParameter("txtusuario"));
                //usuario.setPass(request.getParameter("txtpass"));
                usuario.setApellidos(c.getApellidos());
                usuario.setClaveCompra(c.getClaveCompra());
                usuario.setCpostal(c.getCpostal());
                usuario.setDireccion(c.getDireccion());
                usuario.setEstado(c.getEstado());
                usuario.setFecha_nacimiento(c.getFecha_nacimiento());
                usuario.setNombre_cliente(c.getNombre_cliente());
                usuario.setPoblacion(c.getPoblacion());
                usuario.setProvincia(c.getProvincia());
                usuario.setDni(c.getDni());
                usuario.setTelefono(c.getTelefono());
                usuario.setId_cliente(c.getId_cliente());
                
                
                usuario.setEstilo("uvalido");
                usuario.setMensajeBienvenida(bd.idioma("bienvenida") +": "+usuario.getNick()+" ");
                //lo metemos en sesion
                //si no es user
                if(usuario.getRol().equals("user"))
                    {
                    usuario.setMenuAdmin(true);
                    System.out.println("meto a tre el menuadmin");
                }
                
               
                
            }else{
                usuario.setEstilo("uimvalido");
                usuario.setMensajeBienvenida(bd.idioma("invalido"));
                
               
                System.out.println("usuarioNoValido"+usuarioValido);
                //mensaje error
            }
            
            %>
           
            
            <%
            
            
                                  
        }
       
        
        %>
        
        <form name="login" method="POST">
            <%=bd.idioma("usuario")%>: <input type="text" name="txtusuario" value="<%=usuario.getEmail()%>">
            <%=bd.idioma("pass")%>: <input type="password" name="txtpass" value="<%=usuario.getPass()%>"><a href='tienda.jsp?ses=desconectar'><%=bd.idioma("cerrar")%></a><br>
            <div class="<%=usuario.getEstilo()%>"><%=usuario.getMensajeBienvenida()%>&nbsp&nbsp<a href='recuerdausuario.jsp'><%=bd.idioma("recuerda")%></a></div>
            <input type="submit" value=<%=bd.idioma("validarme")%>>&nbsp&nbsp<a href='formularioalta.jsp'><%=bd.idioma("nuevo")%></a><br>               
        </form>
            
      
    </body>
</html>
