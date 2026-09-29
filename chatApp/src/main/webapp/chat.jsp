<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String username =
        (String) session.getAttribute("username");

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

    <title>Simple Chat</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        /* =====================================================
           CHAT V2
           ===================================================== */

        .chat-top-actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .chat-action-btn {
            width: 38px;
            height: 38px;

            display: flex;
            align-items: center;
            justify-content: center;

            border: none;
            border-radius: 10px;

            background: #f5f6fa;
            color: #656978;

            cursor: pointer;

            font-size: 15px;

            transition: 0.2s ease;
        }

        .chat-action-btn:hover {
            background: #eeeeff;
            color: #5b5bd6;
        }


        /* SEARCH */

        .contact-search {
            margin: 0 14px 14px;
            position: relative;
        }

        .contact-search input {
            width: 100%;
            height: 40px;

            padding: 0 13px 0 38px;

            border: 1px solid #e5e6ed;
            border-radius: 11px;

            background: #f8f9fc;

            outline: none;

            font-size: 12px;
            color: #242633;

            box-sizing: border-box;
        }

        .contact-search input:focus {
            background: #fff;
            border-color: #5b5bd6;
            box-shadow: 0 0 0 3px rgba(91,91,214,.08);
        }

        .search-icon {
            position: absolute;

            left: 13px;
            top: 50%;

            transform: translateY(-50%);

            color: #999eab;

            font-size: 13px;
        }


        /* PROFILE */

        .profile-menu {
            position: relative;
        }

        .profile-button {
            border: none;
            background: transparent;
            cursor: pointer;
        }


        /* CHAT HEADER */

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
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }


        /* MESSAGE META */

        .message-meta {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 5px;

            margin-top: 5px;

            font-size: 9px;
            opacity: .55;
        }

        .message-check {
            font-size: 10px;
        }


        /* WELCOME */

        .welcome-content {
            max-width: 400px;
            text-align: center;
        }

        .welcome-content .empty-chat-icon {
            margin-bottom: 22px;
        }

        .welcome-content h2 {
            margin-bottom: 8px;
        }


        /* COMPOSER */

        .composer-button {
            width: 42px;
            height: 48px;

            flex-shrink: 0;

            border: none;
            border-radius: 13px;

            background: #f1f2f7;
            color: #747887;

            cursor: pointer;

            font-size: 17px;

            transition: .2s ease;
        }

        .composer-button:hover {
            background: #eeeeff;
            color: #5b5bd6;
        }

        .message-input-wrapper {
            position: relative;
        }

        .message-input-wrapper input {
            padding-right: 10px;
        }


        /* TYPING */

        .typing-indicator {
            min-height: 18px;

            padding: 0 25px 4px;

            color: #999eab;

            font-size: 10px;
        }

        .typing-indicator.hidden {
            visibility: hidden;
        }


        /* MOBILE BACK */

        .mobile-back {
            display: none;

            width: 34px;
            height: 34px;

            border: none;
            border-radius: 9px;

            background: #f2f3f7;

            cursor: pointer;

            color: #555968;
        }


        @media (max-width: 650px) {

            .mobile-back {
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .chat-sidebar.mobile-hidden {
                display: none;
            }

            .chat-main.mobile-full {
                width: 100%;
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

                <h2>Simple Chat</h2>

                <span>
                    Messaging System
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


        <!-- USERS -->

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

                <span>Logout</span>

            </a>

        </div>

    </aside>



    <!-- =====================================================
         MAIN CHAT
         ===================================================== -->

    <main class="chat-main" id="chatMain">


        <!-- EMPTY STATE -->

        <div
            id="emptyChat"
            class="empty-chat">

            <div class="welcome-content">

                <div class="empty-chat-icon">
                    💬
                </div>

                <h2>
                    Welcome to Simple Chat
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


            <!-- HEADER -->

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
                class="typing-indicator hidden">

                Typing...

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

/* =====================================================
   VARIABLES
   ===================================================== */

const contextPath =
    "<%= request.getContextPath() %>";

const currentUser =
    "<%= username %>";

let selectedUser = null;

let refreshTimer = null;

let allUsers = [];


/* =====================================================
   ELEMENTS
   ===================================================== */

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


/* =====================================================
   LOAD USERS
   ===================================================== */

async function loadUsers() {

    try {

        const response =
            await fetch(
                contextPath +
                "/ChatEndpoint?action=users"
            );


        if (!response.ok) {

            throw new Error(
                "Unable to load users"
            );

        }


        const users =
            await response.json();


        allUsers = users;


        userCount.textContent =
            users.length;


        renderUsers(users);


    } catch (error) {

        console.error(error);

        userList.innerHTML = `
            <div class="user-error">
                Unable to load users
            </div>
        `;

    }

}


/* =====================================================
   RENDER USERS
   ===================================================== */

function renderUsers(users) {

    userList.innerHTML = "";


    if (users.length === 0) {

        userList.innerHTML = `
            <div class="no-users">
                No other users available
            </div>
        `;

        return;
    }


    users.forEach(function(user) {

        createUser(user);

    });

}


/* =====================================================
   CREATE USER
   ===================================================== */

function createUser(user) {

    const button =
        document.createElement("button");

    button.type = "button";

    button.className =
        "user-item";


    if (user === selectedUser) {

        button.classList.add("active");

    }


    const avatar =
        document.createElement("div");

    avatar.className =
        "avatar avatar-random";

    avatar.textContent =
        user.charAt(0).toUpperCase();


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


/* =====================================================
   SEARCH USERS
   ===================================================== */

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

                    return user
                        .toLowerCase()
                        .includes(query);

                }
            );


        renderUsers(filtered);

    }
);


/* =====================================================
   SELECT USER
   ===================================================== */

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


    loadUsers();

    loadMessages();

    startAutoRefresh();


    /* Mobile */

    if (window.innerWidth <= 650) {

        chatSidebar.classList.add(
            "mobile-hidden"
        );

        chatMain.classList.add(
            "mobile-full"
        );

    }

}


/* =====================================================
   SHOW CONTACTS - MOBILE
   ===================================================== */

function showContacts() {

    if (window.innerWidth <= 650) {

        chatSidebar.classList.remove(
            "mobile-hidden"
        );

        chatMain.classList.remove(
            "mobile-full"
        );

    }

}


/* =====================================================
   LOAD MESSAGES
   ===================================================== */

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
                )
            );


        if (!response.ok) {

            throw new Error(
                "Unable to load messages"
            );

        }


        const data =
            await response.json();


        displayMessages(data);


    } catch (error) {

        console.error(error);

    }

}


/* =====================================================
   DISPLAY MESSAGES
   ===================================================== */

function displayMessages(data) {

    if (!data || data.length === 0) {

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


    data.forEach(function(item) {


        const isMine =
            item.sender === currentUser;


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


        const sender =
            document.createElement("div");


        sender.className =
            "message-sender";


        sender.textContent =
            isMine
                ? "You"
                : item.sender;


        const text =
            document.createElement("div");


        text.className =
            "message-text";


        text.textContent =
            item.message;


        const meta =
            document.createElement("div");


        meta.className =
            "message-meta";


        const time =
            document.createElement("span");


        time.textContent =
            item.time;


        meta.appendChild(time);


        if (isMine) {

            const check =
                document.createElement("span");

            check.className =
                "message-check";

            check.textContent =
                "✓";

            meta.appendChild(check);

        }


        bubble.appendChild(sender);

        bubble.appendChild(text);

        bubble.appendChild(meta);


        messageRow.appendChild(
            bubble
        );


        messages.appendChild(
            messageRow
        );

    });


    messages.scrollTop =
        messages.scrollHeight;

}


/* =====================================================
   SEND MESSAGE
   ===================================================== */

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


        try {

            const response =
                await fetch(
                    contextPath +
                    "/ChatEndpoint",
                    {

                        method: "POST",

                        headers: {

                            "Content-Type":
                                "application/x-www-form-urlencoded"

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
                    "Message could not be sent"
                );

            }


            messageInput.value = "";


            await loadMessages();


            messageInput.focus();


        } catch (error) {

            console.error(error);

            alert(
                "Unable to send message."
            );

        }

    }
);


/* =====================================================
   ENTER TO SEND
   ===================================================== */

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


/* =====================================================
   AUTO REFRESH
   ===================================================== */

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


/* =====================================================
   ATTACHMENT PLACEHOLDER
   ===================================================== */

function attachmentMessage() {

    alert(
        "File attachments will be added in the next version."
    );

}


/* =====================================================
   BASIC HTML ESCAPE
   ===================================================== */

function escapeHtml(value) {

    return value
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");

}


/* =====================================================
   INITIAL LOAD
   ===================================================== */

loadUsers();

</script>


</body>

</html>