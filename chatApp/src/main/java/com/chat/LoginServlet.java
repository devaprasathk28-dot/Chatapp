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
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Nimbus MySQL Database
    private static final String URL =
            "jdbc:mysql://db01.dbhost.dev:5051/db_454p4rarr"
            + "?useSSL=false"
            + "&allowPublicKeyRetrieval=true"
            + "&serverTimezone=UTC";

    private static final String USER = "user_454p4rarr";

    // Use your existing Nimbus password
    private static final String PASSWORD = "p454p4rarr";

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        if (username == null
                || password == null
                || username.trim().isEmpty()
                || password.isEmpty()) {

            response.sendRedirect(
                    "login.jsp?error=Please+enter+username+and+password"
            );

            return;
        }

        String sql =
                "SELECT id, username, password_hash, "
                + "display_name "
                + "FROM users "
                + "WHERE username = ?";

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            try (
                Connection con =
                    DriverManager.getConnection(
                        URL,
                        USER,
                        PASSWORD);

                PreparedStatement ps =
                    con.prepareStatement(sql)
            ) {

                ps.setString(
                        1,
                        username.trim());

                ResultSet rs =
                        ps.executeQuery();

                if (rs.next()) {

                    String storedHash =
                            rs.getString("password_hash");

                    boolean valid =
                            PasswordUtil.verifyPassword(
                                    password,
                                    storedHash);

                    if (valid) {

                        HttpSession session =
                                request.getSession();

                        session.setAttribute(
                                "userId",
                                rs.getLong("id"));

                        session.setAttribute(
                                "username",
                                rs.getString("username"));

                        session.setAttribute(
                                "displayName",
                                rs.getString("display_name"));

                        // Update user status
                        updateStatus(
                                rs.getLong("id"),
                                "ONLINE"
                        );

                        response.sendRedirect(
                                "chat.jsp"
                        );

                    } else {

                        response.sendRedirect(
                                "login.jsp?error=Invalid+username+or+password"
                        );
                    }

                } else {

                    response.sendRedirect(
                            "login.jsp?error=Invalid+username+or+password"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "login.jsp?error=Database+connection+error"
            );
        }
    }

    private void updateStatus(
            long userId,
            String status) {

        String sql =
                "UPDATE users "
                + "SET status = ?, last_seen = CURRENT_TIMESTAMP "
                + "WHERE id = ?";

        try (
            Connection con =
                DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD);

            PreparedStatement ps =
                con.prepareStatement(sql)
        ) {

            ps.setString(1, status);
            ps.setLong(2, userId);

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}