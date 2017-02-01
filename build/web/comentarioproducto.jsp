<%-- 
    Document   : comentarioproducto
    Created on : 25-mar-2013, 9:05:42
    Author     : CARMEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="bd" class="baseDatos.GestionBd" scope="page"/>
<jsp:useBean id="comentario" class="beans.Comentario" scope="session"/>
<jsp:useBean id="usuario" class="beans.Cliente" scope="session"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <script src="includes/jquery.js"></script>
    <script src="includes/jquery.validate.js"></script>

     <script>
         $(document).ready(function() {
              $("#comentario").validate({
                rules: {
                  txtacomentario: {required: true},
                  txttitulo: {required: true},
                  txtradio:{required: true}
                  
                },
                messages: {
                  txtacomentario: "Haz tu comentario",
                  txttitulo:"indica un titulo",
                  txtradio:"puntua tu compra"
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


    <%
    
   
  //faltaria el loguin que si se ejecuta desde aqui no estaria ni el id que al no estar nos pone un 0
   /* if(request.getParameter("txttitulo")!=null){
        System.out.println("empiezo a llenar el objeto comentario");
        comentario.setTitulo(request.getParameter("txttitulo"));
        comentario.setNota(Integer.parseInt(request.getParameter("txtradio")));
        comentario.setComentario(request.getParameter("txtacomentario"));
        int idProducto=Integer.parseInt(request.getParameter("id_producto"));
        System.out.println("te muestro el id producto dentro del comentario");
        comentario.setIdProducto(idProducto);
        comentario.setLoguinComentario(usuario.getNick());
        System.out.println("el resultado de la insercion es "+bd.insertarComentario(comentario));
         System.out.println("te muestro todos los datosque insertare a comentario"
                 + " al inicio "+comentario.getTitulo()+" "+comentario.getNota() +" nota "
                 +comentario.getComentario() + "comentario "+comentario.getIdProducto()+
                 "idProducto "+comentario.getLoguinComentario()+"loguin");

   }
    //en la parte esta superior iriamos recojiendo los comentarios insertados oredenados por fecha con login fecha y des
    
    /*en la bd necesitamos una tabla comentario donde tenga 
    los campos idcomentario(iria relacionada con producto)login y fecha titulo,valoracion ,comentario*/
    
    
    %>
    
    <body>
        <form name="comentario" id="comentario" >
            <%=bd.idioma("cotitulo")%>:<input type="text" name ="txttitulo"><br><br>
            <%=bd.idioma("covaloracion")%>: 
            <%
            for(int i=1;i<=10;i++){
                %>
                <input type="radio" name="txtradio" value='<%=i%>'>
                <%
            }
            %>
            <br><br>
            <textarea name="txtacomentario" id="txtacomentario" cols=40 rows=10></textarea> 
            <br><br>
            <input type="hidden" name ="id_producto" value='<%=comentario.getIdProducto()%>'>
            <input type="submit" value="<%=bd.idioma("coenviar")%>"/>
            
        </form>
    </body>
</html>
