package com.chat;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Nimbus MySQL Database
    private static final String URL =
            "jdbc:mysql://db01.dbhost.dev:5051/db_454p4rarr"
            + "?useSSL=false"
            + "&allowPublicKeyRetrieval=true"
            + "&serverTimezone=UTC";

    private static final String USER = "user_454p4rarr";

    // Keep your existing Nimbus password here.
    // Do NOT share it publicly.
    private static final String PASSWORD = "p454p4rarr";

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String displayName = request.getParameter("displayName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // -----------------------------
        // Validate empty fields
        // -----------------------------

        if (isEmpty(username)
                || isEmpty(email)
                || isEmpty(displayName)
                || isEmpty(password)
                || isEmpty(confirmPassword)) {

            response.sendRedirect(
                    "register.jsp?error=Please+fill+all+fields"
            );
            return;
        }

        username = username.trim();
        email = email.trim();
        displayName = displayName.trim();

        // -----------------------------
        // Validate password
        // -----------------------------

        if (!password.equals(confirmPassword)) {

            response.sendRedirect(
                    "register.jsp?error=Passwords+do+not+match"
            );
            return;
        }

        if (password.length() < 6) {

            response.sendRedirect(
                    "register.jsp?error=Password+must+be+at+least+6+characters"
            );
            return;
        }

        // -----------------------------
        // Basic email validation
        // -----------------------------

        if (!email.matches(
                "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {

            response.sendRedirect(
                    "register.jsp?error=Please+enter+a+valid+email"
            );
            return;
        }

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con =
                         DriverManager.getConnection(
                                 URL,
                                 USER,
                                 PASSWORD)) {

                // -----------------------------
                // Check existing username/email
                // -----------------------------

                String checkSql =
                        "SELECT username, email FROM users "
                        + "WHERE username = ? OR email = ?";

                try (PreparedStatement check =
                             con.prepareStatement(checkSql)) {

                    check.setString(1, username);
                    check.setString(2, email);

                    ResultSet rs = check.executeQuery();

                    if (rs.next()) {

                        if (username.equalsIgnoreCase(
                                rs.getString("username"))) {

                            response.sendRedirect(
                                    "register.jsp?error=Username+already+exists"
                            );

                        } else {

                            response.sendRedirect(
                                    "register.jsp?error=Email+already+registered"
                            );
                        }

                        return;
                    }
                }

                // -----------------------------
                // Hash password
                // -----------------------------

                String passwordHash =
                        PasswordUtil.hashPassword(password);

                // -----------------------------
                // Insert user
                // -----------------------------

                String insertSql =
                        "INSERT INTO users "
                        + "(username, email, password_hash, "
                        + "display_name, status) "
                        + "VALUES (?, ?, ?, ?, 'OFFLINE')";

                try (PreparedStatement ps =
                             con.prepareStatement(insertSql)) {

                    ps.setString(1, username);
                    ps.setString(2, email);
                    ps.setString(3, passwordHash);
                    ps.setString(4, displayName);

                    int rows = ps.executeUpdate();

                    if (rows > 0) {

                        response.sendRedirect(
                                "login.jsp?success=Account+created+successfully"
                        );

                    } else {

                        response.sendRedirect(
                                "register.jsp?error=Registration+failed"
                        );
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "register.jsp?error=Database+error"
            );
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}