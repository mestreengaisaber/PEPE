/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package baseDatos;

import com.mysql.jdbc.*;
import java.util.Date;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import beans.Cliente;
import beans.Comentario;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.ResultSet;
import compra.*;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 *
 * @author alumno
 */
public class GestionBd {
    private ArrayList<Comentario> listacomentarios= new ArrayList<Comentario>();
    final public String USUARIOACTIVO="update prestamos.clientes set estado=? where id_cliente=?";
    final public String ACTUALIZARPASSPROV="update prestamos.clientes set pass=? where dni=?";
    //activacion usuario update prestamos.clientes set estado= 0 where email='Mestreengaisaber@yahoo.es';
     final public String CONSULTACOMBO="select distinct prec_venta from prestamos.reloj";
     final public String INSERTAR_USUARIO_NUEVO="insert into prestamos.clientes(nombre_cliente,apellidos,dni,email,pass,estado,fecha_nacimiento,rol,nick,direccion,poblacion,cpostal,provincia,telefono)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
     final public String ACTUALIZAR_USUARIO="update prestamos.clientes set nombre_cliente=?,apellidos=?,dni=?,email=?,pass=?,estado=?,fecha_nacimiento=?,rol=?,nick=?,direccion=?,poblacion=?,cpostal=?,provincia=?,telefono=? where id_cliente=? ";
     //final public String ACTUALIZAR_USUARIO="update prestamos.clientes(nombre_cliente,apellidos,dni,email,pass,estado,fecha_nacimiento,rol,nick,direccion,poblacion,cpostal,provincia,telefono) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
     //insert into prestamos.clientes(nombre_cliente,apellidos,dni,email,pass,estado,fecha_nacimiento,rol)values('Pepe','Saiz','47791794R','MestreDeJuglaria@yahoo.es','tros',0,'15/02/1986','user');
     final public String CONSULTAIDDNI="select id_cliente from prestamos.clientes where dni=?";
     final public String CONSULTALOGIN="select * from clientes where email=? and pass=? and estado=?";
     final public String EMAILVALIDO="select * from clientes where email=? and estado=?";
     final public String CONSULTA_LISTA_COMENTARIO="select * from prestamos.comentario where id_reloj=? order by fecha_publicacion desc limit 6";
     final public String VALORACION_MEDIA_RELOJES="select avg(valoracion) as media from prestamos.comentario where id_reloj=?";
     final public String NUMERO_COMENTARIOS_PROD="select count(titulo) as numcomentarios from prestamos.comentario where id_reloj=?";
     final public String INSERTAR_COMENTARIO_NUEVO="insert into prestamos.comentario(id_reloj,titulo,descripcion,valoracion,loguin,fecha_publicacion)values(?,?,?,?,?,?)";
     final public String RELOJ_LIKE="select * from prestamos.reloj where desc_reloj like \'%\'|| ? ||\'%\'";
     //insert into prestamos.comentario(id_reloj,titulo,descripcion,valoracion,loguin,fecha_publicacion) values(01,'reloj','un reloj muy bonito',5,'pepe','15/02/1986') ;
     //insert into prestamos.clientes()values
     //(null,'Carmen','cristobal','47791795A','Menchu_venus@hotmail.com','pass','claveCompra',default,'15/02/1981',default)
    final  String rutaFichero="test2";
    final public String correouser="Mestreengaisaber@yahoo.es";
    
      public String idioma(String cadena){
        //ResourceBundle.getBundle("co.com.app.lang.MiArchivo");
         //Locale l = Locale.US;
        //ResourceBundle.getBundle(rutaFichero).getString(cadena);
        
        String en= ResourceBundle.getBundle(rutaFichero,Locale.US).getString(cadena);
        
        //return ResourceBundle.getBundle(rutaFichero).getString(cadena);
        return en;
    }
     
      public String valoracionProducto(String idProd){
          
          String valoracion="";
          try {
            
        Connection cn=this.conectarMYSQL();
        PreparedStatement pst= (PreparedStatement)cn.prepareStatement(VALORACION_MEDIA_RELOJES);
        pst.setInt(1, Integer.parseInt(idProd));
        ResultSet rs= (ResultSet) pst.executeQuery();
        //sabemos que solo nos va a dar un unico valor
        rs.next();
        String mediaProducto = rs.getString("media");
        System.out.println("La media del producto es "+mediaProducto);
        //tenemos que saber cuantos comentarios tenemos para ese producto.
        /*podriamos tirar de la consulta comentarios haciendole un count o bien
        la lista de los comentarios en principo serian de ese producto*/
        pst= (PreparedStatement)cn.prepareStatement(NUMERO_COMENTARIOS_PROD);
        pst.setInt(1, Integer.parseInt(idProd));
        rs= (ResultSet) pst.executeQuery();
        //sabemos que solo nos va a dar un unico valor
        rs.next();
        int numcomentarios=Integer.parseInt(rs.getString("numcomentarios"));
        System.out.println("el numero de comentarios para ese producto es "+numcomentarios);
        //validamos si no hay comentarios que no ponga 0
              if(numcomentarios==0){
                  
                  valoracion=this.idioma("csincomentarios");
              }
              else{
                  mediaProducto=mediaProducto.substring(0,3);
                  valoracion=mediaProducto+"  "+this.idioma("cde")+"  "+numcomentarios;
              }
        return valoracion;
          }
         catch (SQLException ex) {
             System.out.println("Error al procesar la media "+ex.toString());
        }
           
          
          
          return valoracion;
      }
      
     public String pintarTablaComentarios(int idProducto){
        String tabla="";
        ArrayList<Comentario> coment=new ArrayList();
        //al estar en otra clase en la de pintar htm por ejemplo tendriamos que hacer un new d ela clase gestion BD
        coment=dameComentariosProducto(idProducto);
        //Recuperamos los datos como queremos hacerlos
     
        for(Comentario comentario:coment){
        //String fecha=comentario.getFecha();
            tabla+="<ul>"+comentario.getFecha() +" "+comentario.getLoguinComentario()+"<ul>";
             
            
              tabla+="<ul>"+comentario.getTitulo()+"</ul>";
             
             tabla+="<ul>"+comentario.getComentario()+"</ul>"; 
            
               
               tabla+="<ul>"+comentario.getNota()+"</ul>";
               tabla+="<br><br>";
        }
        
        return tabla;
    }
     
     
     
     
    public Connection conectarMYSQL() throws SQLException{
       
           DriverManager.registerDriver(new com.mysql.jdbc.Driver());
           String user="root";
	   String password="troski";
	   String url="jdbc:mysql://localhost:3306/prestamos";
	   Connection conexion = (Connection) DriverManager.getConnection(url,user,password);
           //System.out.println("conectado como usduario "+url+user+password);
        return conexion;
        
    }
    
    
    
    /*
     * para poder aprovechar el metodo vamos a definir unos parametros
     * si es 1 .. es activacion o desactivacion  de usuario
     * si es 2 es enviar password
     */
    
    public String tipoMensaje(int codMensaje){
        String cabeceraTitulo="";
        if(codMensaje==1){
           System.out.println("se trata de una activacion de usuario");
           //contenido seria la url tal cual .
           cabeceraTitulo="ACTIVACION DE USUARIO";
       }else if(codMensaje==2){
           cabeceraTitulo="ENVIO DE PASSWORD";
       }else if(codMensaje==3) {
           //contenido seria la url tal cual .
           cabeceraTitulo="DESACTIVACION DE USUARIO";
       }else if(codMensaje==4){
           cabeceraTitulo="INFORMACION CONTACTO";
       }
        return cabeceraTitulo;
    }
    
    public void enviarCorreo(String destinatarioCorreo,String contenido,int codMensaje){
        String cabeceraTitulo="";
        try{
            //contenido seria =urlActivacion
        //podemos tratar bien la cadena de urlActivacion y cambiarle ña url
         
       cabeceraTitulo=tipoMensaje(codMensaje);
            System.out.println("voy a enviar tipo cabecera "+cabeceraTitulo);    
            
       String SERVIDOR_CORREO="smtp.mail.yahoo.com";
       String USER_CORREO="Mestreengaisaber@yahoo.es";
       int PUERTO=587;
       String USER_PASS="MrBob2004";
       
       Properties prop = new Properties();
       prop.put("mail.transport.protocol", "smtp");
       prop.put("mail.transport.port", "587");
       
       //metemos una autentificacion
       prop.put("mail.smtp.auth", "true");
       
       //prop.setProperty("mail.user", "Mestreengaisaber@yahoo.es");
       //prop.setProperty("mail.password", "troski29");
       //Authenticator au = new Authenticator() {};
       
       Session mailSession = Session.getDefaultInstance(prop, null);
       MimeMessage msg = new MimeMessage(mailSession);
       //configuramos los campos
       Date d=new Date();
       String mensajeFromCorreo=cabeceraTitulo;
       String direccionFrom="Mestreengaisaber@yahoo.es";
       
       msg.setFrom(new InternetAddress(direccionFrom,mensajeFromCorreo));
       
       msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatarioCorreo));
       msg.setSentDate(new Date());
       msg.setSubject(cabeceraTitulo);
       //cuerpo
       msg.setText(contenido);
       Transport t = mailSession.getTransport();
       //pc,puerrto,correo,pass
       t.connect(SERVIDOR_CORREO, PUERTO, USER_CORREO, USER_PASS);
       t.sendMessage(msg, msg.getAllRecipients());
       
            
        } catch(Exception e ){
            System.out.println("no he podido enviar el coreo "+e.toString());
        }
        // TODO code application logic here
    }
    
    
    public void enviarCorreoHTML(String destinatarioCorreo,String contenido,int codMensaje){
        String cabeceraTitulo="";
        try{
            //contenido seria =urlActivacion
        //podemos tratar bien la cadena de urlActivacion y cambiarle ña url
         
       cabeceraTitulo=tipoMensaje(codMensaje);
            System.out.println("voy a enviar tipo cabecera "+cabeceraTitulo);    
            
       String SERVIDOR_CORREO="smtp.mail.yahoo.com";
       String USER_CORREO="Mestreengaisaber@yahoo.es";
       int PUERTO=587;
       String USER_PASS="troski31";
       
       Properties prop = new Properties();
       prop.put("mail.transport.protocol", "smtp");
       prop.put("mail.transport.port", "587");
       
       //metemos una autentificacion
       prop.put("mail.smtp.auth", "true");
       
       //prop.setProperty("mail.user", "Mestreengaisaber@yahoo.es");
       //prop.setProperty("mail.password", "troski29");
       //Authenticator au = new Authenticator() {};
       
       Session mailSession = Session.getDefaultInstance(prop, null);
       MimeMessage msg = new MimeMessage(mailSession);
       //configuramos los campos
       Date d=new Date();
       String mensajeFromCorreo=cabeceraTitulo;
       String direccionFrom="Mestreengaisaber@yahoo.es";
       
       msg.setFrom(new InternetAddress(direccionFrom,mensajeFromCorreo));
       
       msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatarioCorreo));
       msg.setSentDate(new Date());
       msg.setSubject(cabeceraTitulo);
       //cuerpo
       //msg.setContent(contenido,"text/html");
       msg.setText("contenido");
       Transport t = mailSession.getTransport();
       //pc,puerrto,correo,pass
       t.connect(SERVIDOR_CORREO, PUERTO, USER_CORREO, USER_PASS);
       t.sendMessage(msg, msg.getAllRecipients());
       
            
        } catch(Exception e ){
            System.out.println("no he podido enviar el coreo "+e.toString());
        }
        // TODO code application logic here
    }
    
    
    
    
    public boolean validaremailValidoenBD(String email) {
        Cliente c = new Cliente();
        try{
        Connection conexion =this.conectarMYSQL();
           PreparedStatement pst= (PreparedStatement)conexion.prepareStatement(EMAILVALIDO);
           pst.setString(1, email);
           pst.setInt(2,1);
           ResultSet rs=(ResultSet)pst.executeQuery(); 
           
           c.setResultados(false);
           if(rs==null){
               System.out.println("el email no es valido");
               return c.isResultados();
           }
           
          
           if(rs.next()){
               //otro metodo donde cargamos los datos del cliente y devuelve un cliente 
               //en este punto cargariamos el password ,en el cliente no le pondrimaos 
               //el password real sino que generariamos uno 
               c.setNombre_cliente(rs.getString("nombre_cliente"));
               c.setApellidos(rs.getString("apellidos"));
               c.setDni(rs.getString("dni"));
               
              //hemos introducido ya el pass cambiado 
               c.setPass(generaPasswordProv(c.getNombre_cliente(), c.getApellidos(), c.getDni()));
             
             System.out.println("email valido es email"+email);
            /*desde aqui hariamos 2 cosas:
             actualizamos en la BD el pass nuevo
             * 
             * enviamos al correo el password generado
             */
             boolean actualizado= this.actualizacionpassProv(c.getPass(), c.getDni());
             if(actualizado ){
                 //en ese caso ha iddo bien la insercion .. ya podriamos mandar el correo
                 enviarCorreo(email, c.getPass(), 2);
                 c.setResultados(true);
                 return c.isResultados();
             }
             
            }
           
        }
           catch(Exception e){
               System.out.println("error al procesar el amil,no es valido"+e.toString());
               c.setResultados(false);
               
           }
          
         return c.isResultados();  

    }
    
    
    //pendiente d ever si realmente lo vamos a usar
    public Cliente cargarCliente(boolean resultados){
        //hay resultados de ese cliente 
        if(resultados){
            //cargamos todos los datos del cliente 
          
        }
        
        return new Cliente();
    }
    
    public Cliente validarLoguin(String email,String pass) {
       //boolean existe=false;
        try{
        
        Connection conexion =this.conectarMYSQL();
           //seleccionamos por precio    
           PreparedStatement pst= (PreparedStatement)conexion.prepareStatement(CONSULTALOGIN);
           pst.setString(1, email);
           pst.setString(2, pass);
           pst.setInt(3,1);
           ResultSet rs=(ResultSet)pst.executeQuery(); 
           if(rs==null){
               System.out.println("me da nulo el resultset");
           }
        //si tenemos resultados existe sino no
           Cliente c = new Cliente();
           //inizializamos a false
           c.setResultados(false);
           System.out.println("inicializamos con valor "+c.isResultados());
           if(rs.next()){
               //otro metodo donde cargamos los datos del cliente y devuelve un cliente 
               c.setApellidos(rs.getString("apellidos"));
               //insertamos una definida
               c.setClaveCompra("A0123");
               c.setCpostal(String.valueOf(rs.getInt("cpostal")));
               c.setDireccion(rs.getString("direccion"));
               c.setDni(rs.getString("dni"));
               c.setEmail(rs.getString("email"));
               c.setEstado(String.valueOf(rs.getInt("estado")).toString());
               c.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
               c.setId_cliente(rs.getInt("id_cliente"));
               c.setMenuAdmin(false);
               c.setNick(rs.getString("nick"));
               c.setNombre_cliente(rs.getString("nombre_cliente"));
               c.setPoblacion(rs.getString("poblacion"));
               c.setProvincia(rs.getString("provincia"));
               c.setTelefono(String.valueOf(rs.getInt("telefono")).toString());
               c.setRol(rs.getString("rol"));
               c.setPass(rs.getString("pass"));
               //String usuario=rs.getString("email");
            //String nick=rs.getString("nick");
            
             System.out.println("usuario introducido"+email);
                    
            String password=rs.getString("pass");
             System.out.println("password introducido"+password);
           //aqui metemos todos los datos del objeto cliente en sesion
             //recuperamos el alias por ejemplo
           c.setResultados(true);
            System.out.println("como hemos tenido resultados el valor es  "+c.isResultados());
            
            }
           return c;
        }
           catch(Exception e){
               System.out.println("error al procesar loguin"+e.toString());
               return null; 
           }
          
           

    }
    public static String getFechaActual() {
        Date ahora = new Date();
        SimpleDateFormat formateador = new SimpleDateFormat("dd-MM-yyyy");
        return formateador.format(ahora);
    }
    
    public boolean insertarComentario(Comentario com) {
        boolean salida=false;
        String mensaje="";
        
        if (com.getLoguinComentario()==null){
            System.out.println("es necesario estar logado para poder hacer un comentario");
        }
        //el loguin de la sesion.
        //el id de la pagina producto
        //los otros datos de la pagina
      try{  
        Connection conexion =this.conectarMYSQL();
           //seleccionamos por precio    
           PreparedStatement pst= (PreparedStatement)conexion.prepareStatement(INSERTAR_COMENTARIO_NUEVO);
//values(01,'reloj','un reloj muy bonito',5,'pepe','15/02/1986') ;
           System.out.println("meto el ident"+com.getIdProducto());
           pst.setInt(1, com.getIdProducto());
           pst.setString(2, com.getTitulo());
           pst.setString(3, com.getComentario());
           pst.setInt(4, com.getNota());
           pst.setString(5, com.getLoguinComentario());
           java.util.Date fecha = new java.util.Date();
           java.sql.Timestamp fechaactual = new java.sql.Timestamp(fecha.getTime());
           pst.setTimestamp(6, fechaactual);
           pst.executeUpdate();
      }
      catch(SQLException ex){
          System.out.println("error en "+ex);
          return false;
      }
        return true;
    }
    
     public boolean actualizacionpassProv(String passProv,String dni){
        boolean activacion=false;
        try{
            
           
        Connection con =this.conectarMYSQL();
        PreparedStatement pst = (PreparedStatement) con.prepareStatement(ACTUALIZARPASSPROV);
        pst.setString(1, passProv);
        pst.setString(2, dni);  
        int reg =pst.executeUpdate();  
            activacion=true;
        }
        catch(Exception e){
            System.out.println("no se ha podido actualizar el password del usuario"+e.toString());
        }
        System.out.println("actualizado el pass");
        return activacion;
        
    }
    
    
    public String activacionDesUsuario(int codActDes,int idUsuario){
        String activacion="";
        try{
            if(codActDes ==1){
                activacion="activar usuario";
            }else{
                 activacion="desactivar usuario";
            }
        Connection con =this.conectarMYSQL();
        PreparedStatement pst = (PreparedStatement) con.prepareStatement(USUARIOACTIVO);
        pst.setInt(1, codActDes);
        pst.setInt(2, idUsuario);  
        int reg =pst.executeUpdate();  
            
        }
        catch(Exception e){
            System.out.println("no se ha podido activar o desactivar el usuario"+e.toString());
        }
        System.out.println("activacion");
        return activacion;
        
    }
    
    public String insertarUsuario(Cliente c,String urlActivacion){
        String Salida="";
        try{
      
        Connection con =this.conectarMYSQL();
        PreparedStatement pst = (PreparedStatement) con.prepareStatement(INSERTAR_USUARIO_NUEVO);
        pst.setString(1, c.getNombre_cliente());
        pst.setString(2, c.getApellidos());
        pst.setString(3, c.getDni());
        pst.setString(4, c.getEmail());
        pst.setString(5, c.getPass());
          //insertamos una clave de compra 
        pst.setInt(6, 0);
        pst.setString(7, c.getFecha_nacimiento());
        pst.setString(8, "user");
        pst.setString(9,c.getNick());
        pst.setString(10,c.getDireccion());
        pst.setString(11, c.getPoblacion());
        pst.setInt(12,Integer.parseInt(c.getCpostal()));
        pst.setString(13, c.getProvincia());
        pst.setInt(14,Integer.parseInt(c.getTelefono() ));
        int reg =pst.executeUpdate();
        Salida="<h1>REGISTRO ACTUALIZADO</h1>";
        //es necesario castearlo por lo que queremos
        //es necesario que recuperamos el id que ha insertado a la bd y lo metamos al bean lo buscamos por el dni 
        
        pst = (PreparedStatement) con.prepareStatement(CONSULTAIDDNI);
        pst.setString(1, c.getDni());
        ResultSet rs=(ResultSet) pst.executeQuery();
        if(rs.next()){
            int idCodigo=Integer.parseInt(rs.getString("id_cliente"));
            c.setId_cliente(idCodigo);
            System.out.println("codigo es "+idCodigo);
            //solo queremos enviar un correo una vez haya un registro insertado
            //String destinatarioCorreo,String cabeceraTitulo,String contenido,int codMensaje
            this.enviarCorreo(c.getEmail(),dameUrlAmostrar(urlActivacion, "confirmar.jsp", 1,c.getId_cliente()),1);
            System.out.println("email enviado a "+c.getEmail());
        }
        
       
        }catch(SQLException e){
            System.out.println("error insertando en "+e.toString());
             Salida="<h1>EL USUARIO YA EXISTE EN EL SISTEMA</h1>";
        }
        return Salida;
    }
     
    public String actualizarUsuario(Cliente c){
        String Salida="";
        try{
      
        Connection con =this.conectarMYSQL();
        PreparedStatement pst = (PreparedStatement) con.prepareStatement(ACTUALIZAR_USUARIO);
        pst.setString(1, c.getNombre_cliente());
        pst.setString(2, c.getApellidos());
        pst.setString(3, c.getDni());
        pst.setString(4, c.getEmail());
        pst.setString(5, c.getPass());
          //insertamos una clave de compra 
        pst.setInt(6, 1);
        pst.setString(7, c.getFecha_nacimiento());
        pst.setString(8, "user");
        pst.setString(9,c.getNick());
        pst.setString(10,c.getDireccion());
        pst.setString(11, c.getPoblacion());
        pst.setInt(12,Integer.parseInt(c.getCpostal()));
        pst.setString(13, c.getProvincia());
        pst.setInt(14,Integer.parseInt(c.getTelefono()));
        pst.setInt(15, c.getId_cliente());
        int reg =pst.executeUpdate();
        Salida="<h1>REGISTRO ACTUALIZADO</h1>";
        //es necesario castearlo por lo que queremos
        //es necesario que recuperamos el id que ha insertado a la bd y lo metamos al bean lo buscamos por el dni 
        }catch(SQLException e){
            System.out.println("error insertando en "+e.toString());
             Salida="<h1>EL USUARIO YA EXISTE EN EL SISTEMA</h1>";
        }
        return Salida;
    }
    
    
    public int generarAleatorio(int digConNueves){
        int numAleatorio = (int) (Math.random()*digConNueves+1);
        System.out.println("nuestro la posicion"+numAleatorio);
        return numAleatorio;
    }
    public String dameUrlAmostrar(String urlModif,String pagina,int valor,int id){
        urlModif=urlModif.substring(0,urlModif.lastIndexOf("/"));
        //String paginaRegistro="/confirmar.jsp";
        
        String urlNueva=urlModif+"/"+pagina+"?"+"activacion="+valor+"&"+"id="+id;
        System.out.println("urlnueva es"+urlNueva);
        return urlNueva;
    }
    
    public String dameEstilo(String tipo){
        return tipo;
    }
 
    public ArrayList<Comentario> dameComentariosProducto(int idProducto){
        try {
            Connection conexion =this.conectarMYSQL();
            PreparedStatement pst= (PreparedStatement)conexion.prepareStatement(CONSULTA_LISTA_COMENTARIO);
            pst.setInt(1, idProducto);
            ResultSet rs =(ResultSet) pst.executeQuery();
            
            while(rs.next()){
                Comentario com = new Comentario();
                com.setComentario(rs.getString("descripcion"));
                com.setFecha(rs.getString("fecha_publicacion"));
                com.setLoguinComentario(rs.getString("loguin"));
                com.setIdProducto(idProducto);
                com.setNota(rs.getInt("valoracion"));
                com.setTitulo(rs.getString("titulo"));
                System.out.println("el id comentario es"+com.getTitulo());
                listacomentarios.add(com);
            }
            
            
        } catch (SQLException ex) {
            System.out.println("error recuperando los comentarios"+ex.toString());
        }
        
        return listacomentarios;
    }
    
    public String generaPasswordProv(String nombre,String apellidos,String dni){
        String passGenerado="";
        passGenerado=nombre.substring(2)+apellidos.substring(2)+dni.substring(7, 9);
        
        return passGenerado;
    }
    
    public String pintarTablaPedido(ArrayList<CompraProducto> listacompra){
        String tabla="";
        if(!listacompra.isEmpty())
        {
           tabla+="<table border='1'>";
                 tabla+="<tr>";
                 tabla+="<th>"+idioma("cid")+"</td>";
                  tabla+="<th>"+idioma("cimagen")+"</th>";
                  tabla+="<th>"+idioma("ctitulo")+"</th>";
                  tabla+="<th>"+idioma("cprecio")+"</th>";
                  tabla+="<th>"+idioma("cunidades")+"</th>";
                  tabla+="<th>"+idioma("cpreciounitario")+"</th>";
                  tabla+="<th>ACCION</th>";
                  tabla+="</tr>";   
                  double total=0.0;
                  
          for(CompraProducto p:listacompra){
              double precioUnitario=(p.getPrecioAcalcular()*Integer.parseInt(p.getUnidades()));
              
              total+=precioUnitario;
        
               
                   tabla+="<tr>";
                       tabla+="<td>"+p.getIdRelojComp()+"</td>";
                       String imagen=p.getIdImagen();
                       tabla+="<td><img src='./RELOJES/"+imagen+"' width='90' height='100'></td>";
                       tabla+="<td>"+p.getDescripcion()+"</td>";
                       tabla+="<td>"+p.getPrecioAcalcular()+"</td>";
                       tabla+="<td>"+p.getUnidades()+"</td>";
                       tabla+="<td>"+precioUnitario+"</td>";
                       //tabla+="<td><a href='carro.jsp?id_producto="+p.getIdRelojComp()+"></a></td>";
                      
                   tabla+="</tr>"; 
                   
              
                            
                             }
          tabla+="<tr>";
              tabla+="<td colspan='5'>"+idioma("total")+"</td>";
              tabla+="<td><b>"+total+"</b></td>";
                   
        tabla+=" </tr>";
       tabla+="</table>";
        }
        
        return tabla;
    }
    public String cabeceraContenido (String cabecera,String cuerpo)
    {  
        String salida="";
        salida="\n"+"\n"+cabecera+"\n\n"+cuerpo;    
            
            return salida;
    }
}
