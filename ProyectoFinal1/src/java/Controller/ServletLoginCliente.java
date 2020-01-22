/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Beans.BeanLoginCliente;
import Dao.DaoLoginCliente;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

/**
 *
 * @author gfernandez
 */
@WebServlet(name = "ServletLoginCliente", urlPatterns = {"/ServletLoginCliente"})
public class ServletLoginCliente extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletLoginCliente</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletLoginCliente at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        HttpSession sesion = request.getSession();
        int conf=Integer.parseInt(request.getParameter("conf"));
        if (conf==0){
            sesion.removeAttribute("sCliente");
            sesion.removeAttribute("sCodigoCliente");
            sesion.invalidate();
            response.sendRedirect("LoginClientes.jsp");
        }
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
        HttpSession sesion = request.getSession();
        String dni = request.getParameter("dni");
        String clave = request.getParameter("UserPass");
        BeanLoginCliente cliente = new BeanLoginCliente();
        DaoLoginCliente login= new DaoLoginCliente();
        BeanLoginCliente obj = new BeanLoginCliente();

        cliente.setDni(dni);
        cliente.setClave(clave);
        
        obj=login.LogueoCliente(cliente);      
        
         if(obj.getDni()==null){
            response.sendRedirect("ErrorClientes.jsp");
        }else{
             response.sendRedirect("HomeClientes.jsp");
         }
            sesion.setAttribute("sCliente", obj.getDni());
            sesion.setAttribute("sCodigoCliente", obj.getCodigo());
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
