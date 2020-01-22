package Controller;

import Beans.BeanLogin;
import Dao.DaoLogin;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ServletLogin", urlPatterns = {"/ServletLogin"})
public class ServletLogin extends HttpServlet {

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
            out.println("<title>Servlet ServletLogin</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletLogin at " + request.getContextPath() + "</h1>");
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
            sesion.removeAttribute("sUsuario");
            sesion.removeAttribute("sCargo");
            sesion.removeAttribute("sCodigo");
            sesion.invalidate();
            response.sendRedirect("Login.jsp");
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
        String usuario = request.getParameter("UserID");
        String clave = request.getParameter("UserPass");
        BeanLogin user = new BeanLogin();
        DaoLogin login= new DaoLogin();
        BeanLogin obj = new BeanLogin();

        user.setUsuario(usuario);
        user.setClave(clave);
        
        obj=login.Logueo(user);
        
        if(obj.getCargo()==null){
            response.sendRedirect("Error.jsp");
        }
        else{
//            if(obj.getCargo().equalsIgnoreCase("Administrador")){
                response.sendRedirect("Home.jsp");
//            }
//            if(obj.getCargo().equalsIgnoreCase("Secretaria")){
//                 response.sendRedirect("ventas.jsp");
//            }
            sesion.setAttribute("sUsuario", obj.getUsuario());
            sesion.setAttribute("sCargo", obj.getCargo());
            sesion.setAttribute("sCodigo", obj.getCodigo());
        }
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
