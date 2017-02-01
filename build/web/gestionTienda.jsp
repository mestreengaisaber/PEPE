<%-- 
    Document   : pJavascript
    Created on : 02-mar-2013, 18:35:13
    Author     : ernest
--%>

<%@page import="java.util.Properties"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="jstl"%>
<%@taglib uri="http://java.sun.com/jstl/sql_rt" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="idioma" %>
<jsp:useBean id="html" class="beans.HtmlBean" scope="page"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>administracion reloj</title>
        
        <!--tratamos la accion con javascript-->
        <script language="javascript" type="text/javascript">
            function cojerparametro(accion)
            {
                document.gestion.txtaccion.value=accion;
            }
            
        </script>
    </head>
    
     <!--nos conectamos a la bd desde jstl sin usar bean-->
    
      <sql:setDataSource
          driver="com.mysql.jdbc.Driver"
          url="jdbc:mysql://localhost:3306/prestamos"
          user="root" password="troski"/>  
      <!--tenemos que ver como hacer el properties-->
      <idioma:setBundle basename="bundle.text"/>
    
    <body>
        <!-- consulta combo select id_reloj,desc_reloj from prestamos.reloj-->
        <form name="gestion" method="GET">
            <!--prueba para lo del combo no tengo marcado lo de la seleccion-->
            
            
            <sql:query var="rscombo">
                             
                             select id_reloj,desc_reloj from prestamos.reloj
                             
                              
                             
             </sql:query>
                             <jstl:set var="selected" value="${param.combojstl}"/>
                       RELOJ A BUSCAR:  <select name='combojstl'>
                             <jstl:forEach items="${rscombo.rows}"
                                           var="fila">
                             <jstl:set var="seleccionado" value="${fila.id_reloj}"/>
                             
                             
                            <jstl:if test="${selected ==seleccionado}">
                                <option value='${fila.id_reloj}'SELECTED>
                                 <jstl:out value='${fila.desc_reloj}'/>
                                </option>
                             </jstl:if>
                            
                            <jstl:if test="${selected !=seleccionado}">
                                <option value="${fila.id_reloj}">
                                 <jstl:out value="${fila.desc_reloj}"/></option>
                             </jstl:if>
                            
                            
                             </jstl:forEach>
                         </select>
                       
            
<!--fin de prueba de lo del combo-->
            
            <!--ID RELOJBUSCAR: <input type="text" name="txtbidreloj" value="${param.txtbidreloj}">-->
            <input type='submit' value="buscar" onclick="cojerparametro('buscar')"/><br>
            <input type="hidden" name="txtaccion"><br>
           <!--tenemos que hacer la consulta en ambito general para poder tener el id disponible-->
            
        <jstl:if test="${not empty param.combojstl}">
            
            
            
                
           
            
             <sql:query var="r">
                
                select * from prestamos.reloj where id_reloj=?
                
                 
                <sql:param value="${param.combojstl}"/>
                
            </sql:query>
            
                
                
            <jstl:set var="fila" value="${r.rows[0]}"/>
            <jstl:set var="id" value="${fila.id_reloj}"/>
                       <h1><jstl:out value="${id}"/></h1><br/>
                       
            <sql:query var="uni">
                
                select unidades from prestamos.reloj where id_reloj=?
                
                 
                <sql:param value="${id}"/>
                
           </sql:query>
                
                    
            <jstl:set var="fil" value="${uni.rows[0]}"/>
            <jstl:set var="ud" value="${fil.unidades}"/>
                UNIDADES: <h1><jstl:out value="${ud}"/></h1><br/>           
                       
                      
            <!--nos creamos una variable que contiene los registos a mostrar para definir si mostramos form o no-->
             <jstl:set var="numreg" value="${r.rowCount}"/>
            
        
          <jstl:choose>
                
                <jstl:when test="${numreg==0}">
                    <h1>NO HAY REGISTROS</h1>
                    
                </jstl:when>
         <jstl:otherwise> 
         
            <jstl:if test="${param.txtaccion.equals('buscar')}">
                
                <h1>BUSCAR</h1>
               
           
            ID; <input type="text" name="txtaduanas" value="${param.combojstl}">
            ADUANAS: <input type="text" name="txtaduanas" value="${fila.aduanas}"><br>
            COMISIONES: <input type="text" name="txtcomisiones" value="${fila.comisiones_pm}"><br>
            DESCRIPCION: <input type="text" name="txtdescripcion" value="${fila.desc_reloj}"><br>
            FECHA VENTA: <input type="text" name="txtfecha" value="${fila.fecha_venta}"><br>
            GASTOS CORREOS: <input type="text" name="txtgastoscorreos" value="${fila.gastos_correos}"><br>
            PRECIO COMPRA: <input type="text" name="txtpreccompra" value="${fila.prec_compra}"><br>
            PRECIO VENTA: <input type="text" name="txtprecventa" value="${fila.prec_venta}"><br>
            
            ID RELOJ: <input type="text" name="txtbidreloj" value="${fila.id_reloj}"><br>
            <!--{aduanas=0.0, comisiones_pm=0.0, desc_cod_inversion=RELOJ, desc_reloj=Reloj Cuentakilometros Ultimo Diseño
            fecha_venta=2012-01-09 00:00:00.0, gastos_correos=0.0,
            id_cod__inversion=2, id_reloj=1, imagen_reloj=velocimetro.jpg, prec_compra=9.19, prec_venta=19.99}-->
            
            </jstl:if>  
            
            
            <jstl:if test="${param.txtaccion.equals('insertar')}">
                 <h1>INSERTAR</h1>
                VALOR INSERTAR: <input type="text" name="txtbidreloj" value="${id}">
                <!--inicializamos a uno los que insertariamos-->
                NUM UNIDADES: <input type="text" name="txtunidades" value="1"><br>
                <!--<h1>ID: <jstl:out value="${id}"/></h1>-->
                
                
               <jstl:if test="${param.txtunidades!=null}">
                
                   
                <sql:update var="in">
                    
                    insert into prestamos.reloj(unidades) values(?,?)
                    <sql:param value="${id}"/>
                    <sql:param value="${param.txtunidades}"/>
                </sql:update>
                    
                       <h1>REGISTROS INSERTADOS: <jstl:out value="${in}"/></h1>
                    
                  
                    
                    
               </jstl:if> 
                       
            </jstl:if>
                
               
            <jstl:if test="${param.txtaccion.equals('eliminar')}">
                
                <h1>ELIMINAR</h1>
               
            <sql:query var="relem">
                
                delete from prestamos.reloj where id_reloj=?
                
                <sql:param value="${param.combojstl}"/>
                
            </sql:query>
            
            <jstl:set var="filad" value="${relem.rows[0]}"/>
                
            </jstl:if>
                
             <jstl:if test="${param.txtaccion.equals('actualizar')}">   
                
                <h1>ACTUALIZAR</h1>
                
                <!--VALOR ACTUALIZAR: <input type="text" name="txtbidreloj" value="${id}">-->
                <!--inicializamos a uno los que insertariamos-->
                NUM UNIDADES: <input type="text" name="txtunidades" value="${ud}"><br>
                <h1>ID: <jstl:out value="${param.combojstl}"/></h1>
               <jstl:if test="${param.txtunidades!=null}">
                <sql:update var="in">
                    
                    update prestamos.reloj  set unidades=? where id_reloj=?
                    <sql:param value="${param.txtunidades}"/>
                    <sql:param value="${id}"/>
                    
                </sql:update>
                    
                       <h1>REGISTROS ACTUALIZADOS: <jstl:out value="${in}"/></h1>
                    
               </jstl:if>  
                    
                    
               </jstl:if> 
                
           <input type='submit' value="actualizar" onclick="cojerparametro('actualizar')"/><br>
            <input type='submit' value="eliminar" onclick="cojerparametro('eliminar')"/>
            <!--<input type='submit' value="insertar" onclick="cojerparametro('insertar')"/>-->
       
            
          </jstl:otherwise> 
         </jstl:choose>
         </jstl:if>
    </form>     
    </body>
</html>
