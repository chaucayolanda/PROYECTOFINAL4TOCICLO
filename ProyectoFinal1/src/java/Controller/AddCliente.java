package Controller;

import Beans.BeanCliente;
import Dao.DaoCliente;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddCliente", urlPatterns = {"/AddCliente"})
public class AddCliente extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
     
            BeanCliente cl= new BeanCliente(); 
            
            String nombre = request.getParameter("nombre");
            String apepaterno = request.getParameter("apepaterno");
            String apematerno = request.getParameter("apematerno");
            String sexo = request.getParameter("sexo");
            String direccion = request.getParameter("direccion");
            String distrito = request.getParameter("distrito");
            String email = request.getParameter("email");
            String celular = request.getParameter("celular");
            String dni = request.getParameter("dni");
            String clave = request.getParameter("clave");
            
            cl.setNombres(nombre);
            cl.setPaterno(apepaterno);
            cl.setMaterno(apematerno);
            cl.setSexo(sexo);
            cl.setDireccion(direccion);
            cl.setDistrito(distrito);
            cl.setMail(email);
            cl.setCelular(celular);
            cl.setDni(dni);
            cl.setClave(clave);
            
            
            DaoCliente C=new DaoCliente();
            C.Cliente(cl);
           
            request.getRequestDispatcher("LoginClientes.jsp").forward(request, response); 

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
