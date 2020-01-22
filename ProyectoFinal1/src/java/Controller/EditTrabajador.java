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

/**
 *
 * @author Gustavo
 */
@WebServlet(name = "EditTrabajador", urlPatterns = {"/EditTrabajador"})
public class EditTrabajador extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
            BeanTrabajador tr= new BeanTrabajador(); 
            
            String nombres = request.getParameter("nombreeditar");
            String paterno = request.getParameter("paternoeditar");
            String materno = request.getParameter("maternoeditar");
            String direccion = request.getParameter("direccioneditar");
            String distrito = request.getParameter("distritoeditar");
            String dni = request.getParameter("dnieditar");
            String mail = request.getParameter("emaileditar");
            String celular = request.getParameter("celulareditar");
            int codigo = Integer.parseInt(request.getParameter("codigoeditar"));
            int cargo = Integer.parseInt(request.getParameter("cargoeditar"));
            
            tr.setNombres(nombres);
            tr.setPaterno(paterno);
            tr.setMaterno(materno);
            tr.setDireccion(direccion);
            tr.setDistrito(distrito);
            tr.setDni(dni);
            tr.setMail(mail);
            tr.setCelular(celular);
            tr.setCargo(cargo);
            tr.setCodigo(codigo);
            
            DaoTrabajador t=new DaoTrabajador();
            t.EditTrabajador(tr);
           
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
