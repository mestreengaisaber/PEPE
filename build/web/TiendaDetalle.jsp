<%-- 
    Document   : TiendaDetalle
    Created on : 13-feb-2013, 23:58:34
    Author     : ernest
--%>

<%@page import="compra.CompraProducto"%>
<%@page import="java.lang.String"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mysql.jdbc.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.jdbc.Statement"%>

<jsp:useBean id="compra" class="compra.ListaCompra" scope="session"/>
<jsp:useBean id="bd" class="baseDatos.GestionBd" scope="page"/>
<jsp:useBean id="datospagina" class="compra.CompraProducto" scope="session"/>
<jsp:useBean id="usuario" class="beans.Cliente" scope="session"/>
<jsp:useBean id="comentario" class="beans.Comentario" scope="session"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
         
        if(request.getParameter("txttitulo")!=null){
        System.out.println("empiezo a llenar el objeto comentario");
        comentario.setTitulo(request.getParameter("txttitulo"));
        comentario.setNota(Integer.parseInt(request.getParameter("txtradio")));
        comentario.setComentario(request.getParameter("txtacomentario"));
        //String idProducto=request.getParameter("txtidReloj");
        comentario.setLoguinComentario(usuario.getNick());
        System.out.println("el resultado de la insercion es "+bd.insertarComentario(comentario));
        System.out.println("te muestro todos los datosque insertare a comentario al inicio "
                +comentario.getTitulo()+" "+comentario.getNota() +" nota "+comentario.getComentario() +
                "comentario "+comentario.getIdProducto()+"idProducto "+comentario.getLoguinComentario()+
                "loguin");

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
   <!--<div id="content">
      <div class="side fl">
       <div class="sideinner">-->
    <%
     //verificamos si esta o no enviado el parametro
         if(request.getParameter("txtidReloj")!=null){
             //es el parametro para la compra
             %>
             <!--provamos de meter un valor-->
             <jsp:setProperty name="datospagina" property="idRelojComp" param="txtidReloj"/>
             <jsp:setProperty name="datospagina" property="unidades" param="comboUnidades"/>
              
             
             
             <%
             
              
              compra.cargarCompra(datospagina);
              //insertamos nuestra compra 
             
             //compra.insertarCompra();
             ArrayList<String> listaid;
             
             String codigoCompra=request.getParameter("txtidReloj");
              if(session.getAttribute("COMPRA")!=null){
               
                    
               listaid=(ArrayList<String>)session.getAttribute("COMPRA");
            }else{
              listaid= new ArrayList();
            //lo hariamos de nuevo
            }
          //tenemos que meter el id a dicha lista
          System.out.println("codigoCompra es "+codigoCompra);
          listaid.add(codigoCompra);
          session.setAttribute("COMPRA", listaid);
          response.sendRedirect("productos.jsp");
           //fin del tratamiento de la compra
                   } 
    
    %>
    
         <%
        
	   Connection conexion = bd.conectarMYSQL();
          
           Statement st= (Statement)conexion.createStatement();
           //select count(id_reloj) from prestamos.reloj where id_reloj=1
           if(request.getParameter("id_producto")!=null)
           {
               System.out.println("la primera no es nulo "+request.getParameter("id_producto"));
               //iriamos cargando los valores en la pagina del carrito
              
               //lo recojemos del que nos ha enviado el formulario en campo oculto
           String id=request.getParameter("id_producto");
           comentario.setIdProducto(Integer.parseInt(id));
           String consultaUDisponibles="select unidades from prestamos.reloj where id_reloj="+id;
           ResultSet rsa=st.executeQuery(consultaUDisponibles);
           rsa.next();
           int unidades=rsa.getInt("unidades");
           %>          
           
           <%
           //seleccionamos por precio
           String consultaReloj="select * from prestamos.reloj where id_reloj="+id;
           
           ResultSet rs=st.executeQuery(consultaReloj);
           //tenemso que colocarlo a una posicion concreta
          
            %>  
            
            <table border="1">
                <%
                 rs.next();
                 
                 
               %>
           
                <tr align="center">
                    <td><%=rs.getString("desc_reloj")%></td> 
                    <td><%=rs.getString("prec_venta")%></td>
                </tr>
                <tr>
                    <%
                    //formateamos la fecha
                    //SimpleDateFormat formatea = new SimpleDateFormat("dd/MM/yyyy");
                    //String fecha=formatea.format(rs.getString("fecha_venta"));
                    //Date fecha = formatea.parse(rs.getString("fecha_venta"));
                    %>
                    <td rowspan="3"><img src='./RELOJES/<%=rs.getString("imagen_reloj")%>' width="200" height="200"></td>
                    <td><%=rs.getString("fecha_venta")%></td>
                    
                </tr>
                <tr align="center">
                    <td><%=bd.idioma("cunidades")%> <br>
                        <br>

                        <!--carga combo solo de unidades disponibles -->
                       <form name="detalle">  
                        <select name="comboUnidades">
                        <%
                        
                        for(int i=1;i<=unidades;i++){
%>
                            <option value='<%=i%>'><%=i%></option>
  <%                          
                        }
                        //recojemos todos los valores
                 //String precioPagina=rs.getString("prec_venta");
                 datospagina.setPrecioAcalcular(Double.parseDouble(rs.getString("prec_venta")));
                 datospagina.setPrecio(rs.getString("prec_venta"));
                 datospagina.setIdImagen(rs.getString("imagen_reloj"));
                 datospagina.setDescripcion(rs.getString("desc_reloj"));
                       %>
                        </select>
                        <!--<input type="text" name="numReloj" value='1'/></td>-->
                </tr>
                
                 <tr align="center" >
                     
                     <td>
                         <!--enviamos el campo para la compra-->
                         <input type="hidden" name="txtidReloj" value='<%=id%>'/>
                         
                         
                         <input type="submit" value='<%=bd.idioma("ccomprar")%>'><br><br><br>
                     <%=bd.idioma("cvaloracion")%><br><br>
                 <b><%=bd.valoracionProducto(id)%></b> </td>
                         
                       </form>

                </tr>
                </table>
                         <br><br>   
                         
         <%
        
        
      } %>                
        
        <jsp:include page="comentarioproducto.jsp"/>      
        
</div> 
        </div> 
      </div>
      <div class="main fr">
          <h4><%=bd.idioma("comentarios")%></h4>
          <br><br>
          <p> 
            <%=bd.pintarTablaComentarios(comentario.getIdProducto())%> </p>
        
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
   

</body>
</html>
