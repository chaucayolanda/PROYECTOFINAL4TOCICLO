/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Beans.BeanDetalleVenta;
import Dao.DaoDetalleVenta;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author gfernandez
 */
@WebServlet(name = "AddDetalleVenta", urlPatterns = {"/AddDetalleVenta"})
public class AddDetalleVenta extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
         response.setContentType("text/html;charset=UTF-8");
     
            BeanDetalleVenta detalle= new BeanDetalleVenta(); 

            int COD_VENTA = Integer.parseInt(request.getParameter("codigoventaactual"));
            int COD_PRODUCTO = Integer.parseInt(request.getParameter("codigoproducto"));    
            int CANTIDAD = Integer.parseInt(request.getParameter("stock"));
            String PRECIO_VENTA = request.getParameter("preventa");
            
            detalle.setCodVenta(COD_VENTA);
            detalle.setCodProducto(COD_PRODUCTO);
            detalle.setCantidad(CANTIDAD);
            detalle.setPVenta(PRECIO_VENTA);
            
            DaoDetalleVenta DV=new DaoDetalleVenta();
            DV.DetalleCompra(detalle);
           
            request.getRequestDispatcher("carrito.jsp").forward(request, response); 
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
