/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Beans.BeanTrabajador;
import Dao.DaoTrabajador;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "Addtrabajador", urlPatterns = {"/Addtrabajador"})
public class Addtrabajador extends HttpServlet {   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
     
            BeanTrabajador tr= new BeanTrabajador(); 
            
            String nombre = request.getParameter("nombre");
            String apepaterno = request.getParameter("apepaterno");
            String apematerno = request.getParameter("apematerno");
            String sexo = request.getParameter("sexo");
            String direccion = request.getParameter("direccion");
            String distrito = request.getParameter("distrito");
            String dni = request.getParameter("dni");
            String email = request.getParameter("email");
            String celular = request.getParameter("celular");
            int cargo = Integer.parseInt(request.getParameter("cargo"));
            
            tr.setNombres(nombre);
            tr.setPaterno(apepaterno);
            tr.setMaterno(apematerno);
            tr.setSexo(sexo);
            tr.setDireccion(direccion);
            tr.setDistrito(distrito);
            tr.setDni(dni);
            tr.setMail(email);
            tr.setCelular(celular);
            tr.setCargo(cargo);
            
            DaoTrabajador t=new DaoTrabajador();
            t.Trabajador(tr);
           
            request.getRequestDispatcher("Trabajadores.jsp").forward(request, response); 

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
