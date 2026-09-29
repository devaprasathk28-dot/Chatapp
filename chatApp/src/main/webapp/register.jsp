<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Create Account - Simple Chat</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        /* =========================================
           REGISTER PAGE
           ========================================= */

        .register-page {
            min-height: 100vh;

            display: flex;

            justify-content: center;

            align-items: center;

            padding: 30px;

            box-sizing: border-box;
        }


        /* =========================================
           REGISTER CARD
           ========================================= */

        .register-card {

            width: 100%;

            max-width: 520px;

            background: #ffffff;

            border-radius: 24px;

            padding: 40px;

            box-sizing: border-box;

            box-shadow:
                0 20px 60px rgba(0, 0, 0, 0.15);
        }


        /* =========================================
           HEADER
           ========================================= */

        .register-header {

            text-align: center;

            margin-bottom: 28px;
        }


        .register-logo {

            width: 64px;

            height: 64px;

            margin: 0 auto 18px;

            display: flex;

            align-items: center;

            justify-content: center;

            border-radius: 18px;

            background:
                linear-gradient(
                    135deg,
                    #667eea,
                    #764ba2
                );

            font-size: 30px;

            box-shadow:
                0 10px 25px
                rgba(108, 92, 231, 0.25);
        }


        .register-header h1 {

            margin: 0 0 8px;

            font-size: 30px;

            font-weight: 700;

            color: #1f2937;
        }


        .register-header p {

            margin: 0;

            color: #777;

            font-size: 14px;

            line-height: 1.6;
        }


        /* =========================================
           ERROR MESSAGE
           ========================================= */

        .register-error {

            display: flex;

            align-items: center;

            gap: 10px;

            padding: 13px 15px;

            margin-bottom: 20px;

            border-radius: 10px;

            background: #fff1f1;

            border: 1px solid #ffd0d0;

            color: #d93025;

            font-size: 14px;
        }


        /* =========================================
           FORM
           ========================================= */

        .register-form {

            display: flex;

            flex-direction: column;

            gap: 18px;
        }


        .input-group {

            width: 100%;
        }


        .input-group label {

            display: block;

            margin-bottom: 7px;

            font-size: 14px;

            font-weight: 600;

            color: #333;
        }


        /* =========================================
           INPUT
           ========================================= */

        .input-box {

            position: relative;

            width: 100%;
        }


        .input-box input {

            width: 100%;

            height: 52px;

            padding: 0 16px;

            border: 1px solid #dfe3eb;

            border-radius: 12px;

            background: #fafbfc;

            color: #222;

            font-size: 15px;

            outline: none;

            box-sizing: border-box;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease,
                background 0.2s ease;
        }


        .input-box input:focus {

            background: #ffffff;

            border-color: #6c5ce7;

            box-shadow:
                0 0 0 3px
                rgba(108, 92, 231, 0.10);
        }


        .input-box input::placeholder {

            color: #9aa0aa;
        }


        /* =========================================
           PASSWORD TOGGLE
           ========================================= */

        .password-toggle {

            position: absolute;

            right: 14px;

            top: 50%;

            transform: translateY(-50%);

            border: none;

            background: transparent;

            cursor: pointer;

            font-size: 17px;

            padding: 5px;

            opacity: 0.7;
        }


        .password-toggle:hover {

            opacity: 1;
        }


        /* =========================================
           CREATE ACCOUNT BUTTON
           ========================================= */

        .register-button {

            width: 100%;

            height: 52px;

            margin-top: 5px;

            border: none;

            border-radius: 12px;

            background:
                linear-gradient(
                    135deg,
                    #667eea,
                    #764ba2
                );

            color: #ffffff;

            font-size: 16px;

            font-weight: 700;

            cursor: pointer;

            transition:
                transform 0.2s ease,
                box-shadow 0.2s ease,
                opacity 0.2s ease;

            box-shadow:
                0 10px 25px
                rgba(108, 92, 231, 0.20);
        }


        .register-button:hover {

            transform: translateY(-1px);

            box-shadow:
                0 14px 30px
                rgba(108, 92, 231, 0.28);
        }


        .register-button:active {

            transform: translateY(0);

        }


        /* =========================================
           LOGIN LINK
           ========================================= */

        .login-link {

            text-align: center;

            margin-top: 24px;

            color: #777;

            font-size: 14px;
        }


        .login-link a {

            margin-left: 5px;

            color: #6c5ce7;

            font-weight: 700;

            text-decoration: none;
        }


        .login-link a:hover {

            text-decoration: underline;
        }


        /* =========================================
           PASSWORD INFO
           ========================================= */

        .password-info {

            margin-top: 6px;

            font-size: 12px;

            color: #888;
        }


        /* =========================================
           MOBILE
           ========================================= */

        @media (max-width: 600px) {

            .register-page {

                padding: 18px;
            }


            .register-card {

                padding: 28px 22px;

                border-radius: 20px;
            }


            .register-header h1 {

                font-size: 26px;
            }


            .register-logo {

                width: 56px;

                height: 56px;

                font-size: 26px;
            }

        }

    </style>

</head>


<body class="login-page">


    <!-- =========================================
         BACKGROUND
         ========================================= -->

    <div class="login-bg-circle circle-1"></div>

    <div class="login-bg-circle circle-2"></div>

    <div class="login-bg-circle circle-3"></div>


    <!-- =========================================
         REGISTER PAGE
         ========================================= -->

    <div class="register-page">


        <div class="register-card">


            <!-- HEADER -->

            <div class="register-header">


                <div class="register-logo">
                    💬
                </div>


                <h1>
                    Create Account
                </h1>


                <p>
                    Create your account and start
                    chatting with your friends.
                </p>


            </div>


            <!-- =====================================
                 ERROR MESSAGE
                 ===================================== -->

            <%

                String error =
                    request.getParameter("error");

                if (error != null &&
                    !error.isEmpty()) {

            %>

                <div class="register-error">

                    <span>⚠</span>

                    <span>
                        <%= error.replace("+", " ") %>
                    </span>

                </div>

            <%

                }

            %>


            <!-- =====================================
                 REGISTRATION FORM
                 ===================================== -->

            <form

                action="<%= request.getContextPath() %>/RegisterServlet"

                method="post"

                class="register-form">


                <!-- DISPLAY NAME -->

                <div class="input-group">

                    <label for="displayName">
                        Display Name
                    </label>


                    <div class="input-box">

                        <input

                            type="text"

                            id="displayName"

                            name="displayName"

                            placeholder="Enter your name"

                            maxlength="100"

                            autocomplete="name"

                            required>

                    </div>

                </div>


                <!-- USERNAME -->

                <div class="input-group">

                    <label for="username">
                        Username
                    </label>


                    <div class="input-box">

                        <input

                            type="text"

                            id="username"

                            name="username"

                            placeholder="Choose a username"

                            maxlength="50"

                            autocomplete="username"

                            required>

                    </div>

                </div>


                <!-- EMAIL -->

                <div class="input-group">

                    <label for="email">
                        Email Address
                    </label>


                    <div class="input-box">

                        <input

                            type="email"

                            id="email"

                            name="email"

                            placeholder="Enter your email"

                            maxlength="255"

                            autocomplete="email"

                            required>

                    </div>

                </div>


                <!-- PASSWORD -->

                <div class="input-group">

                    <label for="password">
                        Password
                    </label>


                    <div class="input-box">

                        <input

                            type="password"

                            id="password"

                            name="password"

                            placeholder="Create a password"

                            autocomplete="new-password"

                            required>


                        <button

                            type="button"

                            class="password-toggle"

                            onclick="togglePassword('password', this)"

                            aria-label="Show password">

                            👁

                        </button>

                    </div>


                    <div class="password-info">
                        Password must contain at least 6 characters.
                    </div>

                </div>


                <!-- CONFIRM PASSWORD -->

                <div class="input-group">

                    <label for="confirmPassword">
                        Confirm Password
                    </label>


                    <div class="input-box">

                        <input

                            type="password"

                            id="confirmPassword"

                            name="confirmPassword"

                            placeholder="Confirm your password"

                            autocomplete="new-password"

                            required>


                        <button

                            type="button"

                            class="password-toggle"

                            onclick="togglePassword('confirmPassword', this)"

                            aria-label="Show password">

                            👁

                        </button>

                    </div>

                </div>


                <!-- CREATE ACCOUNT -->

                <button

                    type="submit"

                    class="register-button">

                    Create Account

                </button>


            </form>


            <!-- =====================================
                 LOGIN LINK
                 ===================================== -->

            <div class="login-link">

                Already have an account?

                <a href="login.jsp">
                    Login
                </a>

            </div>


        </div>

    </div>


    <!-- =========================================
         JAVASCRIPT
         ========================================= -->

    <script>

        function togglePassword(
            inputId,
            button
        ) {

            const input =
                document.getElementById(inputId);


            if (input.type === "password") {

                input.type = "text";

                button.textContent = "🙈";

                button.setAttribute(
                    "aria-label",
                    "Hide password"
                );

            } else {

                input.type = "password";

                button.textContent = "👁";

                button.setAttribute(
                    "aria-label",
                    "Show password"
                );
            }
        }


        /*
         * Client-side password confirmation.
         *
         * The real validation is still performed
         * by RegisterServlet on the server.
         */

        document
            .querySelector(".register-form")
            .addEventListener(
                "submit",
                function(event) {

                    const password =
                        document.getElementById(
                            "password"
                        ).value;

                    const confirmPassword =
                        document.getElementById(
                            "confirmPassword"
                        ).value;


                    if (password.length < 6) {

                        alert(
                            "Password must be at least 6 characters."
                        );

                        event.preventDefault();

                        return;
                    }


                    if (password !== confirmPassword) {

                        alert(
                            "Passwords do not match."
                        );

                        event.preventDefault();

                    }

                }
            );

    </script>


</body>

</html>