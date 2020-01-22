/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Beans.BeanDetalleCompra;
import Dao.DaoDetalleCompra;

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
@WebServlet(name = "AddDetalleCompra", urlPatterns = {"/AddDetalleCompra"})
public class AddDetalleCompra extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         response.setContentType("text/html;charset=UTF-8");
     
            BeanDetalleCompra detalle= new BeanDetalleCompra(); 
                        
            int COD_COMPRA = Integer.parseInt(request.getParameter("codigocompraactual"));
            int COD_PRODUCTO = Integer.parseInt(request.getParameter("codigoproducto"));    
            int CANTIDAD = Integer.parseInt(request.getParameter("stock"));
            String PRECIO_COMPRA = request.getParameter("pcompra");
            String PRECIO_VENTA = request.getParameter("pventa");
            String PRESENTACION = request.getParameter("presentacion");
            String DESCRIPCION = request.getParameter("producto");
            int COD_MARCA = Integer.parseInt(request.getParameter("marca"));
            
            detalle.setCOD_COMPRA(COD_COMPRA);
            detalle.setCOD_PRODUCTO(COD_PRODUCTO);
            detalle.setCANTIDAD(CANTIDAD);
            detalle.setPRECIO_COMPRA(PRECIO_COMPRA);
            detalle.setPRECIO_VENTA(PRECIO_VENTA);
            detalle.setPRESENTACION(PRESENTACION);
            detalle.setDESCRIPCION(DESCRIPCION);
            detalle.setCOD_MARCA(COD_MARCA);
            
            DaoDetalleCompra DC=new DaoDetalleCompra();
            DC.DetalleCompra(detalle);
           
            request.getRequestDispatcher("Productos.jsp").forward(request, response); 
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
