/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Beans.BeanProveedor;
import Dao.DaoProveedor;
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
@WebServlet(name = "EditProveedor", urlPatterns = {"/EditProveedor"})
public class EditProveedor extends HttpServlet {

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
        
            BeanProveedor pr= new BeanProveedor(); 
            
            int codigo = Integer.parseInt(request.getParameter("codigoeditar"));
            String compania = request.getParameter("companiaeditar");
            String contacto = request.getParameter("contactoeditar");
            String cargo = request.getParameter("cargoeditar");
            String direccion = request.getParameter("direccioneditar");
            String distrito = request.getParameter("distritoeditar");
            String telefono = request.getParameter("telefonoeditar");
            String web = request.getParameter("webeditar");
            
            pr.setId(codigo);
            pr.setCompania(compania);
            pr.setContacto(contacto);
            pr.setCargo(cargo);
            pr.setDireccion(direccion);
            pr.setDistrito(distrito);
            pr.setTelefono(telefono);
            pr.setWeb(web);
                   
            DaoProveedor prov=new DaoProveedor();
            prov.EditTrabajador(pr);
           
            request.getRequestDispatcher("Proveedores.jsp").forward(request, response); 

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
