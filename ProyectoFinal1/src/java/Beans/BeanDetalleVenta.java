package Beans;


public class BeanDetalleVenta {
    
    private int CodVenta;
    private int CodProducto;
    private int Cantidad;
    private String PVenta;

    /**
     * @return the CodVenta
     */
    public int getCodVenta() {
        return CodVenta;
    }

    /**
     * @param CodVenta the CodVenta to set
     */
    public void setCodVenta(int CodVenta) {
        this.CodVenta = CodVenta;
    }

    /**
     * @return the CodProducto
     */
    public int getCodProducto() {
        return CodProducto;
    }

    /**
     * @param CodProducto the CodProducto to set
     */
    public void setCodProducto(int CodProducto) {
        this.CodProducto = CodProducto;
    }

    /**
     * @return the Cantidad
     */
    public int getCantidad() {
        return Cantidad;
    }

    /**
     * @param Cantidad the Cantidad to set
     */
    public void setCantidad(int Cantidad) {
        this.Cantidad = Cantidad;
    }

    /**
     * @return the PVenta
     */
    public String getPVenta() {
        return PVenta;
    }

    /**
     * @param PVenta the PVenta to set
     */
    public void setPVenta(String PVenta) {
        this.PVenta = PVenta;
    }

    
}
