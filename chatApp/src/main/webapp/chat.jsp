<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Nexa - Messaging</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        /* =====================================================
           NEXA CHAT UI
           ===================================================== */

        .chat-app {
            width: 100%;
            height: 100vh;
            display: flex;
            overflow: hidden;
        }


        /* =====================================================
           SIDEBAR
           ===================================================== */

        .chat-sidebar {
            width: 365px;
            min-width: 365px;
            height: 100vh;
            background: #ffffff;
            border-right: 1px solid #e7e8ef;
            display: flex;
            flex-direction: column;
            position: relative;
            z-index: 10;
        }


        .sidebar-header {
            height: 82px;
            padding: 0 24px;
            display: flex;
            align-items: center;
            gap: 13px;
            border-bottom: 1px solid #ececf2;
        }


        .app-logo {
            width: 46px;
            height: 46px;
            border-radius: 14px;

            background:
                linear-gradient(
                    135deg,
                    #5b5bd6,
                    #7650c9
                );

            display: flex;
            align-items: center;
            justify-content: center;

            color: white;
            font-size: 22px;

            box-shadow:
                0 8px 20px
                rgba(91, 91, 214, .20);
        }


        .sidebar-header h2 {
            margin: 0;
            font-size: 17px;
            color: #202231;
            font-weight: 750;
            letter-spacing: -.3px;
        }


        .sidebar-header span {
            display: block;
            margin-top: 3px;
            font-size: 10px;
            color: #969aa9;
        }


        /* =====================================================
           CURRENT USER
           ===================================================== */

        .current-user {
            margin: 20px 20px 14px;

            padding: 14px;

            border: 1px solid #e5e6ed;
            border-radius: 15px;

            background: #fafbfe;

            display: flex;
            align-items: center;
            gap: 12px;
        }


        .current-user-info {
            min-width: 0;
        }


        .current-user-info strong {
            display: block;
            color: #272936;
            font-size: 13px;
            font-weight: 700;
        }


        .current-user-info > span {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-top: 4px;
            color: #9a9eaa;
            font-size: 10px;
        }


        /* =====================================================
           AVATARS
           ===================================================== */

        .avatar {
            width: 42px;
            height: 42px;
            flex-shrink: 0;

            border-radius: 50%;

            display: flex;
            align-items: center;
            justify-content: center;

            color: white;
            font-size: 14px;
            font-weight: 700;
        }


        .avatar-purple {
            background:
                linear-gradient(
                    135deg,
                    #6366df,
                    #7955c9
                );
        }


        .avatar-blue {
            background:
                linear-gradient(
                    135deg,
                    #3b82f6,
                    #6366df
                );
        }


        .avatar-random {
            background:
                linear-gradient(
                    135deg,
                    #6366df,
                    #7651c8
                );
        }


        .online-dot {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: #22c55e;
            display: inline-block;
        }


        /* =====================================================
           SEARCH
           ===================================================== */

        .contact-search {
            margin: 0 15px 15px;
            position: relative;
        }


        .contact-search input {
            width: 100%;
            height: 43px;

            padding:
                0 14px 0 40px;

            box-sizing: border-box;

            border: 1px solid #e3e5ed;
            border-radius: 12px;

            background: #f8f9fc;

            color: #292b36;

            outline: none;

            font-size: 12px;

            transition: .2s ease;
        }


        .contact-search input:focus {
            background: white;

            border-color: #6565dc;

            box-shadow:
                0 0 0 3px
                rgba(101, 101, 220, .10);
        }


        .search-icon {
            position: absolute;

            left: 14px;
            top: 50%;

            transform:
                translateY(-50%);

            font-size: 13px;
            color: #969baa;

            pointer-events: none;
        }


        /* =====================================================
           CONTACT HEADER
           ===================================================== */

        .users-heading {
            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 20px 10px;

            color: #9094a2;

            font-size: 10px;
            font-weight: 750;

            letter-spacing: .7px;
        }


        #userCount {
            min-width: 22px;
            height: 22px;

            padding: 0 6px;

            border-radius: 7px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #eeeeff;
            color: #5d5dd7;

            font-size: 9px;
        }


        /* =====================================================
           USER LIST
           ===================================================== */

        .user-list {
            flex: 1;
            overflow-y: auto;

            padding: 0 10px 15px;
        }


        .user-item {
            width: 100%;

            border: none;

            background: transparent;

            padding: 11px 10px;

            border-radius: 12px;

            display: flex;
            align-items: center;

            gap: 12px;

            text-align: left;

            cursor: pointer;

            transition:
                background .18s ease,
                transform .18s ease;
        }


        .user-item:hover {
            background: #f7f7fd;
        }


        .user-item.active {
            background: #eeeeff;
        }


        .user-item-details {
            min-width: 0;
            flex: 1;
        }


        .user-item-details strong {
            display: block;

            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;

            color: #292b36;

            font-size: 13px;
            font-weight: 700;
        }


        .user-item-details span {
            display: flex;
            align-items: center;

            gap: 5px;

            margin-top: 4px;

            color: #9a9daa;

            font-size: 9px;
        }


        .loading-users,
        .no-users,
        .user-error {
            padding: 35px 15px;

            text-align: center;

            color: #a0a4b1;

            font-size: 11px;
        }


        .user-error {
            color: #dc5555;
            line-height: 1.6;
        }


        .retry-button {
            margin-top: 10px;

            border: none;

            padding: 7px 12px;

            border-radius: 8px;

            background: #eeeeff;
            color: #5b5bd6;

            cursor: pointer;

            font-size: 10px;
        }


        /* =====================================================
           SIDEBAR FOOTER
           ===================================================== */

        .sidebar-footer {
            padding: 16px;

            border-top: 1px solid #ececf2;
        }


        .logout-btn {
            width: 100%;
            height: 44px;

            border: 1px solid #e5e6ed;
            border-radius: 11px;

            background: white;

            color: #666a78;

            text-decoration: none;

            display: flex;
            align-items: center;
            justify-content: center;

            gap: 8px;

            font-size: 11px;

            transition: .2s ease;
        }


        .logout-btn:hover {
            background: #f7f7fb;
            color: #5b5bd6;
        }


        /* =====================================================
           MAIN CHAT
           ===================================================== */

        .chat-main {
            flex: 1;

            min-width: 0;

            height: 100vh;

            background: #f7f8fc;

            position: relative;

            display: flex;
            flex-direction: column;
        }


        /* =====================================================
           EMPTY STATE
           ===================================================== */

        .empty-chat {
            flex: 1;

            display: flex;
            align-items: center;
            justify-content: center;

            text-align: center;
        }


        .welcome-content {
            max-width: 450px;
            padding: 30px;
        }


        .empty-chat-icon {
            width: 82px;
            height: 82px;

            margin: 0 auto 25px;

            border-radius: 24px;

            background: #eeeeff;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 32px;

            box-shadow:
                0 12px 35px
                rgba(91,91,214,.08);
        }


        .welcome-content h2 {
            margin: 0 0 9px;

            color: #20222d;

            font-size: 22px;
            font-weight: 750;
        }


        .welcome-content p {
            margin: 0;

            color: #9a9eac;

            font-size: 12px;
            line-height: 1.6;
        }


        /* =====================================================
           ACTIVE CHAT
           ===================================================== */

        .active-chat {
            width: 100%;
            height: 100%;

            display: flex;
            flex-direction: column;
        }


        .hidden {
            display: none !important;
        }


        /* =====================================================
           CHAT HEADER
           ===================================================== */

        .chat-header {
            height: 82px;
            flex-shrink: 0;

            padding: 0 24px;

            background: white;

            border-bottom: 1px solid #e5e6ed;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }


        .chat-header-left {
            display: flex;
            align-items: center;
            gap: 12px;

            min-width: 0;
        }


        .chat-header-details {
            min-width: 0;
        }


        .chat-header-details h2 {
            margin: 0;

            color: #20222d;

            font-size: 14px;
            font-weight: 750;

            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }


        .chat-header-details span {
            display: block;

            margin-top: 4px;

            color: #9a9eac;

            font-size: 10px;
        }


        .chat-top-actions {
            display: flex;
            align-items: center;
            gap: 9px;
        }


        .connection-status {
            height: 30px;

            padding: 0 11px;

            border-radius: 20px;

            background: #edf9f2;

            color: #2e9d59;

            display: flex;
            align-items: center;

            gap: 6px;

            font-size: 9px;
        }


        .status-dot {
            width: 7px;
            height: 7px;

            border-radius: 50%;

            background: #25c465;
        }


        .chat-action-btn {
            width: 36px;
            height: 36px;

            border: none;
            border-radius: 10px;

            background: #f4f5f9;

            color: #777b89;

            cursor: pointer;

            font-size: 18px;
        }


        .chat-action-btn:hover {
            background: #eeeeff;
            color: #5b5bd6;
        }


        .mobile-back {
            display: none;

            width: 35px;
            height: 35px;

            border: none;
            border-radius: 9px;

            background: #f1f2f6;

            cursor: pointer;

            color: #555968;

            font-size: 18px;
        }


        /* =====================================================
           MESSAGES
           ===================================================== */

        .messages-area {
            flex: 1;

            overflow-y: auto;

            padding: 25px 30px;

            display: flex;
            flex-direction: column;
        }


        .no-messages {
            margin: auto;

            text-align: center;
        }


        .no-message-icon {
            width: 58px;
            height: 58px;

            margin: 0 auto 14px;

            border-radius: 17px;

            background: #eeeeff;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 23px;
        }


        .no-messages h3 {
            margin: 0;

            color: #555968;

            font-size: 15px;
        }


        .no-messages p {
            margin-top: 6px;

            color: #a0a4af;

            font-size: 11px;
        }


        /* =====================================================
           MESSAGE ROWS
           ===================================================== */

        .message-row {
            width: 100%;

            display: flex;

            margin-bottom: 12px;
        }


        .message-row.sent {
            justify-content: flex-end;
        }


        .message-row.received {
            justify-content: flex-start;
        }


        .message-bubble {
            max-width: min(600px, 72%);

            padding: 11px 14px;

            border-radius: 15px;

            box-shadow:
                0 2px 7px
                rgba(0,0,0,.03);
        }


        .message-row.sent .message-bubble {
            background: #6366dc;

            color: white;

            border-bottom-right-radius: 4px;
        }


        .message-row.received .message-bubble {
            background: white;

            color: #31333e;

            border: 1px solid #e8e9ef;

            border-bottom-left-radius: 4px;
        }


        .message-sender {
            font-size: 9px;

            font-weight: 700;

            margin-bottom: 4px;

            opacity: .7;
        }


        .message-text {
            font-size: 12px;

            line-height: 1.55;

            white-space: pre-wrap;

            word-break: break-word;
        }


        .message-meta {
            display: flex;

            align-items: center;
            justify-content: flex-end;

            gap: 5px;

            margin-top: 5px;

            font-size: 8px;

            opacity: .55;
        }


        .message-check {
            font-size: 10px;
        }


        /* =====================================================
           TYPING
           ===================================================== */

        .typing-indicator {
            min-height: 18px;

            padding: 0 25px 4px;

            color: #999eab;

            font-size: 10px;
        }


        /* =====================================================
           MESSAGE COMPOSER
           ===================================================== */

        .message-area {
            flex-shrink: 0;

            padding: 13px 20px 10px;

            background: white;

            border-top: 1px solid #e5e6ed;
        }


        .message-form {
            display: flex;

            align-items: center;

            gap: 8px;
        }


        .composer-button {
            width: 43px;
            height: 43px;

            flex-shrink: 0;

            border: none;

            border-radius: 12px;

            background: #f1f2f7;

            color: #747887;

            cursor: pointer;

            font-size: 20px;
        }


        .composer-button:hover {
            background: #eeeeff;
            color: #5b5bd6;
        }


        .message-input-wrapper {
            flex: 1;
        }


        .message-input-wrapper input {
            width: 100%;
            height: 43px;

            box-sizing: border-box;

            padding: 0 14px;

            border: 1px solid #dedfe8;

            border-radius: 12px;

            background: #fafbfe;

            color: #292b36;

            outline: none;

            font-size: 12px;
        }


        .message-input-wrapper input:focus {
            background: white;

            border-color: #6565dc;

            box-shadow:
                0 0 0 3px
                rgba(101,101,220,.08);
        }


        .send-button {
            height: 43px;

            padding: 0 17px;

            border: none;

            border-radius: 12px;

            background:
                linear-gradient(
                    135deg,
                    #6366df,
                    #744fc3
                );

            color: white;

            cursor: pointer;

            display: flex;
            align-items: center;

            gap: 8px;

            font-size: 11px;
            font-weight: 700;

            box-shadow:
                0 8px 18px
                rgba(99,102,223,.20);
        }


        .send-button:hover {
            transform: translateY(-1px);
        }


        .send-icon {
            font-size: 13px;
        }


        .message-hint {
            text-align: right;

            margin-top: 6px;

            padding-right: 53px;

            color: #b0b3be;

            font-size: 8px;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 800px) {

            .chat-sidebar {
                width: 300px;
                min-width: 300px;
            }

            .message-bubble {
                max-width: 82%;
            }

        }


        @media (max-width: 650px) {

            .chat-sidebar {
                width: 100%;
                min-width: 100%;
            }


            .chat-sidebar.mobile-hidden {
                display: none;
            }


            .chat-main.mobile-full {
                width: 100%;
            }


            .mobile-back {
                display: flex;

                align-items: center;
                justify-content: center;
            }


            .connection-status {
                display: none;
            }


            .chat-header {
                padding: 0 14px;
            }


            .messages-area {
                padding: 18px 15px;
            }


            .message-area {
                padding: 10px;
            }


            .message-hint {
                display: none;
            }


            .composer-button {
                display: none;
            }


            .send-button {
                padding: 0 14px;
            }

        }

    </style>

</head>


<body class="chat-page">


<div class="chat-app">


    <!-- =====================================================
         SIDEBAR
         ===================================================== -->

    <aside class="chat-sidebar" id="chatSidebar">


        <!-- HEADER -->

        <div class="sidebar-header">

            <div class="app-logo">
                💬
            </div>

            <div>

                <h2>Nexa</h2>

                <span>
                    Real-time messaging
                </span>

            </div>

        </div>


        <!-- CURRENT USER -->

        <div class="current-user">

            <div class="avatar avatar-purple">

                <%= username.substring(0, 1).toUpperCase() %>

            </div>


            <div class="current-user-info">

                <strong>
                    <%= username %>
                </strong>

                <span>

                    <span class="online-dot"></span>

                    Online

                </span>

            </div>

        </div>


        <!-- SEARCH -->

        <div class="contact-search">

            <span class="search-icon">
                🔍
            </span>

            <input
                type="text"
                id="userSearch"
                placeholder="Search contacts..."
                autocomplete="off">

        </div>


        <!-- CONTACT TITLE -->

        <div class="users-heading">

            <span>
                CONTACTS
            </span>

            <span id="userCount">
                0
            </span>

        </div>


        <!-- USER LIST -->

        <div
            id="userList"
            class="user-list">

            <div class="loading-users">
                Loading users...
            </div>

        </div>


        <!-- FOOTER -->

        <div class="sidebar-footer">

            <a
                href="<%= request.getContextPath() %>/LogoutServlet"
                class="logout-btn">

                <span>↪</span>

                <span>
                    Logout
                </span>

            </a>

        </div>


    </aside>


    <!-- =====================================================
         MAIN CHAT
         ===================================================== -->

    <main
        class="chat-main"
        id="chatMain">


        <!-- EMPTY STATE -->

        <div
            id="emptyChat"
            class="empty-chat">

            <div class="welcome-content">

                <div class="empty-chat-icon">
                    💬
                </div>

                <h2>
                    Welcome to Nexa
                </h2>

                <p>
                    Select someone from your contacts
                    to start a conversation.
                </p>

            </div>

        </div>


        <!-- =================================================
             ACTIVE CHAT
             ================================================= -->

        <div
            id="activeChat"
            class="active-chat hidden">


            <!-- CHAT HEADER -->

            <header class="chat-header">


                <div class="chat-header-left">


                    <button
                        type="button"
                        class="mobile-back"
                        onclick="showContacts()">

                        ←

                    </button>


                    <div
                        id="chatAvatar"
                        class="avatar avatar-blue">

                        ?

                    </div>


                    <div class="chat-header-details">

                        <h2 id="chatUser">
                            Select User
                        </h2>

                        <span id="chatStatus">
                            Available to chat
                        </span>

                    </div>

                </div>


                <div class="chat-top-actions">


                    <div
                        id="connectionStatus"
                        class="connection-status">

                        <span class="status-dot"></span>

                        Connected

                    </div>


                    <button
                        type="button"
                        class="chat-action-btn"
                        title="More options">

                        ⋮

                    </button>


                </div>


            </header>


            <!-- MESSAGES -->

            <section
                id="messages"
                class="messages-area">

                <div class="no-messages">

                    <div class="no-message-icon">
                        💬
                    </div>

                    <h3>
                        No messages yet
                    </h3>

                    <p>
                        Start the conversation!
                    </p>

                </div>

            </section>


            <!-- TYPING -->

            <div
                id="typingIndicator"
                class="typing-indicator">

            </div>


            <!-- MESSAGE COMPOSER -->

            <footer class="message-area">


                <form
                    id="messageForm"
                    class="message-form">


                    <button
                        type="button"
                        class="composer-button"
                        title="Attach file"
                        onclick="attachmentMessage()">

                        +

                    </button>


                    <div class="message-input-wrapper">

                        <input
                            type="text"
                            id="messageInput"
                            placeholder="Write a message..."
                            autocomplete="off"
                            maxlength="1000">

                    </div>


                    <button
                        type="submit"
                        class="send-button">

                        <span>
                            Send
                        </span>

                        <span class="send-icon">
                            ➤
                        </span>

                    </button>


                </form>


                <div class="message-hint">

                    Enter to send · Shift + Enter for a new line

                </div>


            </footer>


        </div>


    </main>


</div>


<script>

/* =========================================================
   VARIABLES
   ========================================================= */

const contextPath =
    "<%= request.getContextPath() %>";

const currentUser =
    "<%= username.replace("\\", "\\\\").replace("\"", "\\\"") %>";

let selectedUser = null;

let refreshTimer = null;

let allUsers = [];


/* =========================================================
   ELEMENTS
   ========================================================= */

const userList =
    document.getElementById("userList");

const userCount =
    document.getElementById("userCount");

const emptyChat =
    document.getElementById("emptyChat");

const activeChat =
    document.getElementById("activeChat");

const chatUser =
    document.getElementById("chatUser");

const chatAvatar =
    document.getElementById("chatAvatar");

const chatStatus =
    document.getElementById("chatStatus");

const messages =
    document.getElementById("messages");

const messageForm =
    document.getElementById("messageForm");

const messageInput =
    document.getElementById("messageInput");

const userSearch =
    document.getElementById("userSearch");

const chatSidebar =
    document.getElementById("chatSidebar");

const chatMain =
    document.getElementById("chatMain");


/* =========================================================
   LOAD USERS
   ========================================================= */

async function loadUsers() {

    userList.innerHTML = `
        <div class="loading-users">
            Loading users...
        </div>
    `;


    try {

        const response = await fetch(
            contextPath +
            "/ChatEndpoint?action=users",
            {
                method: "GET",
                cache: "no-store",
                headers: {
                    "Accept": "application/json"
                }
            }
        );


        console.log(
            "Users HTTP status:",
            response.status
        );


        if (!response.ok) {

            throw new Error(
                "Server returned HTTP " +
                response.status
            );

        }


        /*
         * Read text first instead of directly
         * calling response.json().
         *
         * This makes debugging much easier.
         */

        const rawText =
            await response.text();


        console.log(
            "Users API response:",
            rawText
        );


        if (
            !rawText ||
            rawText.trim() === ""
        ) {

            throw new Error(
                "The server returned an empty response."
            );

        }


        let data;


        try {

            data =
                JSON.parse(rawText);

        } catch (jsonError) {

            console.error(
                "Invalid JSON:",
                rawText
            );

            throw new Error(
                "ChatEndpoint did not return valid JSON."
            );

        }


        /*
         * Support multiple formats.
         *
         * Format 1:
         * ["admin","gokul","student"]
         *
         * Format 2:
         * {"users":["admin","gokul","student"]}
         *
         * Format 3:
         * {"data":["admin","gokul","student"]}
         *
         * Format 4:
         * {"usernames":[...]}
         */

        let users = [];


        if (Array.isArray(data)) {

            users = data;

        }

        else if (
            data &&
            Array.isArray(data.users)
        ) {

            users =
                data.users;

        }

        else if (
            data &&
            Array.isArray(data.data)
        ) {

            users =
                data.data;

        }

        else if (
            data &&
            Array.isArray(data.usernames)
        ) {

            users =
                data.usernames;

        }

        else {

            throw new Error(
                "Unexpected users response format."
            );

        }


        /*
         * Normalize usernames.
         */

        allUsers =
            users
                .map(function(user) {

                    if (
                        typeof user === "string"
                    ) {

                        return user.trim();

                    }


                    if (
                        user &&
                        typeof user.username === "string"
                    ) {

                        return user.username.trim();

                    }


                    if (
                        user &&
                        typeof user.name === "string"
                    ) {

                        return user.name.trim();

                    }


                    return null;

                })
                .filter(function(user) {

                    return (
                        user !== null &&
                        user !== ""
                    );

                });


        /*
         * Remove current logged-in user.
         */

        allUsers =
            allUsers.filter(
                function(user) {

                    return (
                        user.toLowerCase() !==
                        currentUser.toLowerCase()
                    );

                }
            );


        userCount.textContent =
            allUsers.length;


        renderUsers(allUsers);


    }

    catch (error) {

        console.error(
            "Unable to load users:",
            error
        );


        userCount.textContent = "0";


        userList.innerHTML = `

            <div class="user-error">

                <strong>
                    Unable to load contacts
                </strong>

                <br>

                <small>
                    ${escapeHtml(error.message)}
                </small>

                <br>

                <button
                    type="button"
                    class="retry-button"
                    onclick="loadUsers()">

                    Retry

                </button>

            </div>

        `;

    }

}


/* =========================================================
   RENDER USERS
   ========================================================= */

function renderUsers(users) {

    userList.innerHTML = "";


    if (
        !users ||
        users.length === 0
    ) {

        userList.innerHTML = `

            <div class="no-users">

                No other users available

            </div>

        `;

        return;

    }


    users.forEach(
        function(user) {

            createUser(user);

        }
    );

}


/* =========================================================
   CREATE USER
   ========================================================= */

function createUser(user) {

    const button =
        document.createElement("button");


    button.type = "button";

    button.className =
        "user-item";


    if (
        user === selectedUser
    ) {

        button.classList.add(
            "active"
        );

    }


    const avatar =
        document.createElement("div");


    avatar.className =
        "avatar avatar-random";


    avatar.textContent =
        user
            .charAt(0)
            .toUpperCase();


    const details =
        document.createElement("div");


    details.className =
        "user-item-details";


    const name =
        document.createElement("strong");


    name.textContent =
        user;


    const status =
        document.createElement("span");


    status.innerHTML =
        '<span class="online-dot"></span> Available';


    details.appendChild(name);

    details.appendChild(status);


    button.appendChild(avatar);

    button.appendChild(details);


    button.addEventListener(
        "click",
        function() {

            selectUser(user);

        }
    );


    userList.appendChild(button);

}


/* =========================================================
   SEARCH USERS
   ========================================================= */

userSearch.addEventListener(
    "input",
    function() {

        const query =
            userSearch.value
                .trim()
                .toLowerCase();


        const filtered =
            allUsers.filter(
                function(user) {

                    return String(user)
                        .toLowerCase()
                        .includes(query);

                }
            );


        userCount.textContent =
            filtered.length;


        renderUsers(filtered);

    }
);


/* =========================================================
   SELECT USER
   ========================================================= */

function selectUser(user) {

    selectedUser =
        user;


    emptyChat.classList.add(
        "hidden"
    );


    activeChat.classList.remove(
        "hidden"
    );


    chatUser.textContent =
        user;


    chatAvatar.textContent =
        user
            .charAt(0)
            .toUpperCase();


    chatStatus.textContent =
        "Available to chat";


    messageInput.focus();


    renderUsers(
        allUsers
    );


    loadMessages();


    startAutoRefresh();


    /*
     * Mobile
     */

    if (
        window.innerWidth <= 650
    ) {

        chatSidebar.classList.add(
            "mobile-hidden"
        );


        chatMain.classList.add(
            "mobile-full"
        );

    }

}


/* =========================================================
   MOBILE: SHOW CONTACTS
   ========================================================= */

function showContacts() {

    if (
        window.innerWidth <= 650
    ) {

        chatSidebar.classList.remove(
            "mobile-hidden"
        );


        chatMain.classList.remove(
            "mobile-full"
        );

    }

}


/* =========================================================
   LOAD MESSAGES
   ========================================================= */

async function loadMessages() {

    if (!selectedUser) {

        return;

    }


    try {

        const response =
            await fetch(

                contextPath +
                "/ChatEndpoint?action=messages&receiver=" +
                encodeURIComponent(
                    selectedUser
                ),

                {
                    method: "GET",
                    cache: "no-store",
                    headers: {
                        "Accept":
                            "application/json"
                    }
                }

            );


        if (!response.ok) {

            throw new Error(
                "Unable to load messages. HTTP " +
                response.status
            );

        }


        const rawText =
            await response.text();


        console.log(
            "Messages response:",
            rawText
        );


        if (
            !rawText ||
            rawText.trim() === ""
        ) {

            displayMessages([]);

            return;

        }


        let data;


        try {

            data =
                JSON.parse(rawText);

        }

        catch (jsonError) {

            console.error(
                "Invalid messages JSON:",
                rawText
            );

            throw new Error(
                "Messages response is not valid JSON."
            );

        }


        /*
         * Support:
         *
         * [...]
         *
         * {"messages":[...]}
         *
         * {"data":[...]}
         */

        let messageData = [];


        if (
            Array.isArray(data)
        ) {

            messageData =
                data;

        }

        else if (
            data &&
            Array.isArray(data.messages)
        ) {

            messageData =
                data.messages;

        }

        else if (
            data &&
            Array.isArray(data.data)
        ) {

            messageData =
                data.data;

        }


        displayMessages(
            messageData
        );


    }

    catch (error) {

        console.error(
            "Unable to load messages:",
            error
        );

    }

}


/* =========================================================
   DISPLAY MESSAGES
   ========================================================= */

function displayMessages(data) {

    if (
        !data ||
        data.length === 0
    ) {

        messages.innerHTML = `

            <div class="no-messages">

                <div class="no-message-icon">
                    💬
                </div>

                <h3>
                    No messages yet
                </h3>

                <p>
                    Start the conversation with
                    ${escapeHtml(selectedUser)}
                </p>

            </div>

        `;

        return;

    }


    messages.innerHTML = "";


    data.forEach(
        function(item) {


            /*
             * Support different backend field names.
             */

            const sender =
                item.sender ||
                item.from ||
                item.username ||
                "";


            const message =
                item.message ||
                item.text ||
                item.content ||
                "";


            const time =
                item.time ||
                item.timestamp ||
                item.createdAt ||
                "";


            const isMine =
                String(sender).toLowerCase() ===
                String(currentUser).toLowerCase();


            const messageRow =
                document.createElement("div");


            messageRow.className =
                isMine
                    ? "message-row sent"
                    : "message-row received";


            const bubble =
                document.createElement("div");


            bubble.className =
                "message-bubble";


            const senderElement =
                document.createElement("div");


            senderElement.className =
                "message-sender";


            senderElement.textContent =
                isMine
                    ? "You"
                    : sender;


            const text =
                document.createElement("div");


            text.className =
                "message-text";


            text.textContent =
                message;


            const meta =
                document.createElement("div");


            meta.className =
                "message-meta";


            const timeElement =
                document.createElement("span");


            timeElement.textContent =
                formatMessageTime(time);


            meta.appendChild(
                timeElement
            );


            if (isMine) {

                const check =
                    document.createElement("span");


                check.className =
                    "message-check";


                check.textContent =
                    "✓";


                meta.appendChild(
                    check
                );

            }


            bubble.appendChild(
                senderElement
            );


            bubble.appendChild(
                text
            );


            bubble.appendChild(
                meta
            );


            messageRow.appendChild(
                bubble
            );


            messages.appendChild(
                messageRow
            );

        }
    );


    messages.scrollTop =
        messages.scrollHeight;

}


/* =========================================================
   SEND MESSAGE
   ========================================================= */

messageForm.addEventListener(
    "submit",
    async function(event) {

        event.preventDefault();


        if (!selectedUser) {

            return;

        }


        const message =
            messageInput.value.trim();


        if (!message) {

            return;

        }


        const sendButton =
            messageForm.querySelector(
                ".send-button"
            );


        try {

            sendButton.disabled =
                true;


            const response =
                await fetch(

                    contextPath +
                    "/ChatEndpoint",

                    {

                        method: "POST",

                        headers: {

                            "Content-Type":
                                "application/x-www-form-urlencoded; charset=UTF-8",

                            "Accept":
                                "application/json"

                        },

                        body:

                            "receiver=" +
                            encodeURIComponent(
                                selectedUser
                            ) +

                            "&message=" +
                            encodeURIComponent(
                                message
                            )

                    }

                );


            if (!response.ok) {

                throw new Error(
                    "Message could not be sent. HTTP " +
                    response.status
                );

            }


            const resultText =
                await response.text();


            console.log(
                "Send response:",
                resultText
            );


            messageInput.value =
                "";


            await loadMessages();


            messageInput.focus();


        }

        catch (error) {

            console.error(
                "Send message error:",
                error
            );


            alert(
                "Unable to send message.\n\n" +
                error.message
            );

        }

        finally {

            sendButton.disabled =
                false;

        }

    }
);


/* =========================================================
   ENTER TO SEND
   ========================================================= */

messageInput.addEventListener(
    "keydown",
    function(event) {

        if (
            event.key === "Enter" &&
            !event.shiftKey
        ) {

            event.preventDefault();

            messageForm.requestSubmit();

        }

    }
);


/* =========================================================
   AUTO REFRESH
   ========================================================= */

function startAutoRefresh() {

    if (refreshTimer) {

        clearInterval(
            refreshTimer
        );

    }


    refreshTimer =
        setInterval(
            function() {

                if (selectedUser) {

                    loadMessages();

                }

            },
            2000
        );

}


/* =========================================================
   ATTACHMENT
   ========================================================= */

function attachmentMessage() {

    alert(
        "File attachments will be added in a future version."
    );

}


/* =========================================================
   FORMAT MESSAGE TIME
   ========================================================= */

function formatMessageTime(value) {

    if (!value) {

        return "";

    }


    /*
     * If backend already gives a simple
     * formatted time, keep it.
     */

    if (
        typeof value === "string" &&
        !value.includes("T")
    ) {

        return value;

    }


    try {

        const date =
            new Date(value);


        if (
            isNaN(date.getTime())
        ) {

            return value;

        }


        return date.toLocaleTimeString(
            [],
            {
                hour: "2-digit",
                minute: "2-digit"
            }
        );

    }

    catch (error) {

        return value;

    }

}


/* =========================================================
   HTML ESCAPE
   ========================================================= */

function escapeHtml(value) {

    if (
        value === null ||
        value === undefined
    ) {

        return "";

    }


    return String(value)

        .replace(
            /&/g,
            "&amp;"
        )

        .replace(
            /</g,
            "&lt;"
        )

        .replace(
            />/g,
            "&gt;"
        )

        .replace(
            /"/g,
            "&quot;"
        )

        .replace(
            /'/g,
            "&#039;"
        );

}


/* =========================================================
   INITIAL LOAD
   ========================================================= */

document.addEventListener(
    "DOMContentLoaded",
    function() {

        loadUsers();

    }
);

</script>


</body>

</html>
