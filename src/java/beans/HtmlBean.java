/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import baseDatos.GestionBd;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ResultSet;
import com.mysql.jdbc.Statement;
import java.sql.SQLException;

/**
 *
 * @author CARMEN
 */
public class HtmlBean {
    GestionBd gb = new GestionBd();
    
    public String dibujarCombo(String nombrecombo, String consulta,String seleccionado) throws SQLException{
        if(seleccionado==null){
            seleccionado="";
        }
       Connection cn= gb.conectarMYSQL();
       Statement st =(Statement)cn.createStatement();
       ResultSet rs = (ResultSet)st.executeQuery(consulta);
       String combo="";
       combo="<select name='"+nombrecombo+"'>";
       while(rs.next()){
           combo+="<option value='"+rs.getString(1)+ "'";
            if(seleccionado.equals(rs.getString(1))){
                combo+=" SELECTED";
            }
           combo+=">" + rs.getString(2)+"</option>";
       } 
       combo+="</select>";
        return combo;
        
        
    }
    
    
}
