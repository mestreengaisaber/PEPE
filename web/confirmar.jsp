<%-- 
    Document   : confirmar
    Created on : 16-mar-2013, 19:55:52
    Author     : CARMEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="bd" class="baseDatos.GestionBd" scope="page"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
    if(request.getParameter("activacion")!=null){
        int cod=Integer.parseInt(request.getParameter("activacion"));
        
        System.out.println("recibo de la pagina "+cod);
       if(request.getParameter("id")!=null){
            int idClien=Integer.parseInt(request.getParameter("id"));
            String resultado="";
            resultado=bd.activacionDesUsuario(cod, idClien);
           System.out.println(resultado); 
           
            
        
        if(resultado!=""){
            %>
            <jsp:forward page="tienda.jsp"/>
        
        <%
        }
        
        
              } 
    }
    %>
    
    
</html>
