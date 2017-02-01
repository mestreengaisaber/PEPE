/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package compra;

import java.util.ArrayList;

/**
 *
 * @author alumno
 */
public class ListaCompra {
    
    
    public ListaCompra(){
       
    }
    
   
    
    private ArrayList<CompraProducto> listacompra= new ArrayList<CompraProducto>();
    
    
    public ArrayList<CompraProducto> cargarCompra(CompraProducto pr){
        CompraProducto prod = new CompraProducto();
        
        prod.setIdRelojComp(pr.getIdRelojComp());
        prod.setUnidades(pr.getUnidades());
        prod.setDescripcion(pr.getDescripcion());
        prod.setIdImagen(pr.getIdImagen());
        //prod.setPrecio(pr.getPrecio());
        prod.setPrecioAcalcular(pr.getPrecioAcalcular());
        //int precioForm=Integer.parseInt(pr.getPrecio());
        
        
        
        getListacompra().add(prod);
        return getListacompra();
    }

    /**
     * @return the listacompra
     */
    public ArrayList<CompraProducto> getListacompra() {
        return listacompra;
    }

   
    
   

}
