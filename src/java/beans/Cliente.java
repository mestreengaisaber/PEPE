/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author CARMEN
 */
public class Cliente {
    private boolean resultados;
    private int id_cliente;
    private String nombre_cliente;
    private String apellidos;
    private String dni;
    private String email;
    private String pass;
    private String claveCompra;
    private String estado;
    private String fecha_nacimiento;
    private String rol;
    private String nick;
    private String mensajeBienvenida;
    
    
    private String direccion,poblacion,cpostal,provincia,telefono;
    private boolean menuAdmin;
    private String estilo;

    /**
     * @return the id_cliente
     */
    public int getId_cliente() {
        return id_cliente;
    }

    /**
     * @param id_cliente the id_cliente to set
     */
    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    /**
     * @return the nombre_cliente
     */
    public String getNombre_cliente() {
         return nombre_cliente=(nombre_cliente==null)?"": nombre_cliente;
    }

    /**
     * @param nombre_cliente the nombre_cliente to set
     */
    public void setNombre_cliente(String nombre_cliente) {
        this.nombre_cliente = nombre_cliente;
    }

    /**
     * @return the apellidos
     */
    public String getApellidos() {
         return apellidos=(apellidos==null)?"": apellidos;
    }

    /**
     * @param apellidos the apellidos to set
     */
    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    /**
     * @return the dni
     */
    public String getDni() {
         return dni=(dni==null)?"": dni;
    }

    /**
     * @param dni the dni to set
     */
    public void setDni(String dni) {
        this.dni = dni;
    }

    /**
     * @return the email
     */
    public String getEmail() {
         return email=(email==null)?"": email;
    }
    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }
    /**
     * @return the pass
     */
    public String getPass() {
       return pass=(pass==null)?"": pass;
       
    }

    /**
     * @param pass the pass to set
     */
    public void setPass(String pass) {
        this.pass = pass;
    }

    /**
     * @return the claveCompra
     */
    public String getClaveCompra() {
         return claveCompra=(claveCompra==null)?"": claveCompra;
    }

    /**
     * @param claveCompra the claveCompra to set
     */
    public void setClaveCompra(String claveCompra) {
        this.claveCompra = claveCompra;
    }

    /**
     * @return the estado
     */
    public String getEstado() {
        return estado;
    }

    /**
     * @param estado the estado to set
     */
    public void setEstado(String estado) {
        this.estado = estado;
    }

    /**
     * @return the fecha_nacimiento
     */
    public String getFecha_nacimiento() {
         return fecha_nacimiento=(fecha_nacimiento==null)?"": fecha_nacimiento;
    }

    /**
     * @param fecha_nacimiento the fecha_nacimiento to set
     */
    public void setFecha_nacimiento(String fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    /**
     * @return the rol
     */
    public String getRol() {
        return rol;
    }

    /**
     * @param rol the rol to set
     */
    public void setRol(String rol) {
        this.rol = rol;
    }

    /**
     * @return the nick
     */
    public String getNick() {
         return nick=(nick==null)?"": nick;
    }

    /**
     * @param nick the nick to set
     */
    public void setNick(String nick) {
        this.nick = nick;
    }

    /**
     * @return the resultados
     */
    public boolean isResultados() {
        return resultados;
    }

    /**
     * @param resultados the resultados to set
     */
    public void setResultados(boolean resultados) {
        this.resultados = resultados;
    }

    /**
     * @return the direccion
     */
    public String getDireccion() {
         return direccion=(direccion==null)?"": direccion;
    }

    /**
     * @param direccion the direccion to set
     */
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    /**
     * @return the poblacion
     */
    public String getPoblacion() {
         return poblacion=(poblacion==null)?"": poblacion;
    }

    /**
     * @param poblacion the poblacion to set
     */
    public void setPoblacion(String poblacion) {
        this.poblacion = poblacion;
    }

    /**
     * @return the cpostal
     */
    public String getCpostal() {
       return cpostal=(cpostal==null)?"": cpostal;
    }

    /**
     * @param cpostal the cpostal to set
     */
    public void setCpostal(String cpostal) {
        this.cpostal = cpostal;
    }

    /**
     * @return the provincia
     */
    public String getProvincia() {
         return provincia=(provincia==null)?"": provincia;
    }

    /**
     * @param provincia the provincia to set
     */
    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    /**
     * @return the telefono
     */
    public String getTelefono() {
         return telefono=(telefono==null)?"": telefono;
    }

    /**
     * @param telefono the telefono to set
     */
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    /**
     * @return the mensajeBienvenida
     */
    public String getMensajeBienvenida() {
        return mensajeBienvenida=(mensajeBienvenida==null)?"": mensajeBienvenida;
    }

    /**
     * @param mensajeBienvenida the mensajeBienvenida to set
     */
    public void setMensajeBienvenida(String mensajeBienvenida) {
        this.mensajeBienvenida = mensajeBienvenida;
    }

    /**
     * @return the menuAdmin
     */
    public boolean isMenuAdmin() {
        return menuAdmin;
    }

    /**
     * @param menuAdmin the menuAdmin to set
     */
    public void setMenuAdmin(boolean menuAdmin) {
        this.menuAdmin = menuAdmin;
    }

    /**
     * @return the estilo
     */
    public String getEstilo() {
        return estilo;
    }

    /**
     * @param estilo the estilo to set
     */
    public void setEstilo(String estilo) {
        this.estilo = estilo;
    }
    
    
    
    
    
}
