#!/bin/bash
# download_frontend.sh - Complete Frontend Files for LifeXia

echo "=========================================="
echo "  LifeXia Frontend Files Setup"
echo "=========================================="

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if we're in the lifexia directory
if [ ! -d "frontend" ]; then
    echo -e "${YELLOW}Creating frontend directory structure...${NC}"
    mkdir -p frontend/{templates,static/{css,js},components}
fi

echo -e "${GREEN}Creating complete frontend files...${NC}"

# ==================== HTML TEMPLATE ====================
echo -e "${BLUE}Creating index.html...${NC}"
cat > frontend/templates/index.html << 'ENDOFFILE'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LifeXia - Intelligent Pharmacy Assistant</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <link rel="stylesheet" href="{{ url_for('static', filename='css/styles.css') }}">
</head>
<body class="gradient-bg min-h-screen">
    <!-- Login Page -->
    <div id="loginPage" class="min-h-screen flex items-center justify-center p-4">
        <div class="w-full max-w-md">
            <div class="glassmorphism-strong rounded-3xl shadow-2xl p-8">
                <div class="text-center mb-8">
                    <div class="inline-block p-4 glassmorphism rounded-full mb-4">
                        <svg class="w-12 h-12 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"></path>
                        </svg>
                    </div>
                    <h1 class="text-3xl font-bold text-white mb-2">LifeXia</h1>
                    <p class="text-white/80">Your Intelligent Pharmacy Assistant</p>
                </div>

                <div class="space-y-6">
                    <div>
                        <label class="block text-white/90 text-sm font-medium mb-2">Email</label>
                        <div class="relative">
                            <svg class="absolute left-3 top-3 w-5 h-5 text-white/60" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                            </svg>
                            <input id="loginEmail" type="email" class="w-full pl-11 pr-4 py-3 glassmorphism rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-white/50" placeholder="Enter your email">
                        </div>
                    </div>

                    <div>
                        <label class="block text-white/90 text-sm font-medium mb-2">Password</label>
                        <div class="relative">
                            <svg class="absolute left-3 top-3 w-5 h-5 text-white/60" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                            </svg>
                            <input id="loginPassword" type="password" class="w-full pl-11 pr-4 py-3 glassmorphism rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-white/50" placeholder="Enter your password">
                        </div>
                    </div>

                    <button onclick="handleLogin()" class="w-full glassmorphism-strong hover:bg-white/40 text-white font-semibold py-3 rounded-xl transition-all duration-300">
                        Sign In
                    </button>

                    <div class="text-center">
                        <p class="text-white/70 text-sm">Don't have an account? <span onclick="showRegister()" class="text-white font-semibold cursor-pointer hover:underline">Sign up</span></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Chat Interface -->
    <div id="chatInterface" class="hidden h-screen flex">
        <!-- Sidebar -->
        <div id="sidebar" class="w-80 glassmorphism border-r border-white/20 p-4 transition-all duration-300">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-white font-semibold text-lg">Chat History</h2>
                <button onclick="toggleSidebar()" class="lg:hidden text-white/80 hover:text-white">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            
            <button onclick="newChat()" class="w-full glassmorphism-strong hover:bg-white/30 text-white rounded-xl p-3 mb-4 flex items-center justify-center gap-2 transition-all">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                </svg>
                New Chat
            </button>
            
            <div id="chatHistoryList" class="space-y-2 overflow-y-auto max-h-[calc(100vh-200px)] chat-scroll"></div>
        </div>

        <!-- Main Chat Area -->
        <div class="flex-1 flex flex-col">
            <!-- Header -->
            <div class="glassmorphism border-b border-white/20 p-4">
                <div class="flex items-center justify-between">
                    <div class="flex items-center gap-3">
                        <button onclick="toggleSidebar()" id="menuBtn" class="text-white/80 hover:text-white hidden">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                            </svg>
                        </button>
                        <div class="flex items-center gap-2">
                            <div class="p-2 glassmorphism rounded-lg">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"></path>
                                </svg>
                            </div>
                            <div>
                                <h1 class="text-white font-semibold">LifeXia Assistant</h1>
                                <p class="text-white/70 text-xs">AI-Powered Pharmacy Support</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="flex items-center gap-2">
                        <button onclick="showMapModal()" class="flex items-center gap-2 px-4 py-2 glassmorphism-strong hover:bg-white/30 text-white rounded-xl transition-all">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                            </svg>
                            <span class="hidden sm:inline">Nearby</span>
                        </button>
                        <button onclick="handleLogout()" class="flex items-center gap-2 px-4 py-2 glassmorphism-strong hover:bg-white/30 text-white rounded-xl transition-all">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                            </svg>
                            <span class="hidden sm:inline">Logout</span>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Messages Area -->
            <div id="messagesArea" class="flex-1 overflow-y-auto p-6 space-y-4 chat-scroll">
                <!-- Messages will be dynamically added here -->
            </div>

            <!-- Typing Indicator -->
            <div id="typingIndicator" class="hidden px-6 py-2">
                <div class="flex justify-start">
                    <div class="glassmorphism rounded-2xl p-4">
                        <div class="flex space-x-2">
                            <div class="w-2 h-2 bg-white/60 rounded-full animate-bounce"></div>
                            <div class="w-2 h-2 bg-white/60 rounded-full animate-bounce" style="animation-delay: 0.1s"></div>
                            <div class="w-2 h-2 bg-white/60 rounded-full animate-bounce" style="animation-delay: 0.2s"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Input Area -->
            <div class="glassmorphism border-t border-white/20 p-4">
                <div class="flex items-center gap-2">
                    <input type="file" id="fileInput" accept="image/*,.pdf" class="hidden" onchange="handleFileUpload(event)">
                    <button onclick="document.getElementById('fileInput').click()" class="p-3 glassmorphism-strong hover:bg-white/30 text-white rounded-xl transition-all" title="Upload prescription image">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                        </svg>
                    </button>
                    
                    <input id="messageInput" type="text" placeholder="Ask about medications, dosages, interactions..." class="flex-1 px-4 py-3 glassmorphism rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-white/50">
                    
                    <button onclick="sendMessage()" class="p-3 glassmorphism-strong hover:bg-white/40 text-white rounded-xl transition-all" title="Send message">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"></path>
                        </svg>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Map Modal -->
    <div id="mapModal" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center p-4 z-50">
        <div class="w-full max-w-4xl glassmorphism-strong rounded-3xl shadow-2xl overflow-hidden">
            <div class="glassmorphism-strong p-4 flex justify-between items-center border-b border-white/20">
                <h2 class="text-white font-semibold text-xl">Nearby Medical Facilities</h2>
                <button onclick="closeMapModal()" class="text-white/80 hover:text-white transition-all">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            
            <div class="p-6 max-h-[600px] overflow-y-auto chat-scroll">
                <div id="locationsList" class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4"></div>
                <div id="map" class="glassmorphism rounded-xl" style="height: 400px;"></div>
            </div>
        </div>
    </div>

    <!-- Loading Overlay -->
    <div id="loadingOverlay" class="hidden fixed inset-0 bg-black/70 backdrop-blur-sm flex items-center justify-center z-50">
        <div class="glassmorphism-strong rounded-3xl p-8 text-center">
            <div class="animate-spin rounded-full h-16 w-16 border-4 border-white/30 border-t-white mx-auto mb-4"></div>
            <p class="text-white text-lg">Processing...</p>
        </div>
    </div>

    <!-- Scripts -->
    <script src="{{ url_for('static', filename='js/main.js') }}"></script>
    <script src="{{ url_for('static', filename='js/auth.js') }}"></script>
    <script src="{{ url_for('static', filename='js/chat.js') }}"></script>
    <script src="{{ url_for('static', filename='js/map.js') }}"></script>
    <script src="{{ url_for('static', filename='js/upload.js') }}"></script>
</body>
</html>
ENDOFFILE

# ==================== CSS STYLES ====================
echo -e "${BLUE}Creating styles.css...${NC}"
cat > frontend/static/css/styles.css << 'ENDOFFILE'
/* frontend/static/css/styles.css - LifeXia Glassmorphism Styles */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Glassmorphism Effects */
.glassmorphism {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.2);
    box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
}

.glassmorphism-strong {
    background: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);
    border: 1px solid rgba(255, 255, 255, 0.3);
    box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
}

/* Gradient Background */
.gradient-bg {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
    min-height: 100vh;
    position: relative;
}

.gradient-bg::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: 
        radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3), transparent 50%),
        radial-gradient(circle at 80% 80%, rgba(252, 163, 217, 0.3), transparent 50%),
        radial-gradient(circle at 40% 20%, rgba(139, 92, 246, 0.3), transparent 50%);
    animation: gradientShift 15s ease infinite;
    pointer-events: none;
}

@keyframes gradientShift {
    0%, 100% {
        opacity: 1;
    }
    50% {
        opacity: 0.8;
    }
}

/* Custom Scrollbar */
.chat-scroll::-webkit-scrollbar {
    width: 6px;
}

.chat-scroll::-webkit-scrollbar-track {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 10px;
}

.chat-scroll::-webkit-scrollbar-thumb {
    background: rgba(255, 255, 255, 0.3);
    border-radius: 10px;
}

.chat-scroll::-webkit-scrollbar-thumb:hover {
    background: rgba(255, 255, 255, 0.5);
}

/* Map Styles */
#map {
    height: 400px;
    border-radius: 1rem;
    overflow: hidden;
}

.leaflet-popup-content-wrapper {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 12px;
}

/* Message Animations */
@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.message-enter {
    animation: slideIn 0.3s ease-out;
}

/* Loading Animation */
@keyframes spin {
    to {
        transform: rotate(360deg);
    }
}

.animate-spin {
    animation: spin 1s linear infinite;
}

/* Bounce Animation for Typing Indicator */
@keyframes bounce {
    0%, 80%, 100% {
        transform: scale(0);
    }
    40% {
        transform: scale(1);
    }
}

.animate-bounce {
    animation: bounce 1.4s infinite ease-in-out;
}

/* Input Focus Effects */
input:focus,
textarea:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.3);
}

/* Button Hover Effects */
button {
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

button:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
}

button:active {
    transform: translateY(0);
}

/* Responsive Design */
@media (max-width: 768px) {
    #sidebar {
        position: fixed;
        left: 0;
        top: 0;
        height: 100vh;
        z-index: 40;
        transform: translateX(-100%);
        transition: transform 0.3s ease;
    }

    #sidebar.active {
        transform: translateX(0);
    }

    #menuBtn {
        display: block !important;
    }
}

/* Utility Classes */
.blur-background {
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
}

.text-shadow {
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

/* Pulse Animation for Notifications */
@keyframes pulse {
    0%, 100% {
        opacity: 1;
    }
    50% {
        opacity: 0.5;
    }
}

.pulse {
    animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

/* Image Preview Styles */
.image-preview {
    max-width: 200px;
    max-height: 200px;
    border-radius: 12px;
    object-fit: cover;
}

/* Error Message Styles */
.error-message {
    background: rgba(239, 68, 68, 0.2);
    border: 1px solid rgba(239, 68, 68, 0.4);
    color: #fee2e2;
}

/* Success Message Styles */
.success-message {
    background: rgba(34, 197, 94, 0.2);
    border: 1px solid rgba(34, 197, 94, 0.4);
    color: #dcfce7;
}
ENDOFFILE

# ==================== JAVASCRIPT FILES ====================

echo -e "${BLUE}Creating main.js...${NC}"
cat > frontend/static/js/main.js << 'ENDOFFILE'
// frontend/static/js/main.js - Main Application Logic
const API_BASE = '/api';
let currentUser = null;
let currentSessionId = null;
let sidebarOpen = true;

// Initialize application
document.addEventListener('DOMContentLoaded', () => {
    console.log('LifeXia initializing...');
    setupEventListeners();
    checkAuthStatus();
});

function setupEventListeners() {
    // Enter key for message input
    const messageInput = document.getElementById('messageInput');
    if (messageInput) {
        messageInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                sendMessage();
            }
        });
    }

    // Enter key for login
    const loginPassword = document.getElementById('loginPassword');
    if (loginPassword) {
        loginPassword.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                handleLogin();
            }
        });
    }

    // Click outside sidebar to close (mobile)
    document.addEventListener('click', (e) => {
        const sidebar = document.getElementById('sidebar');
        const menuBtn = document.getElementById('menuBtn');
        
        if (window.innerWidth <= 768 && sidebar && !sidebar.contains(e.target) && !menuBtn.contains(e.target)) {
            sidebar.classList.remove('active');
        }
    });
}

function checkAuthStatus() {
    const token = localStorage.getItem('lifexia_token');
    const email = localStorage.getItem('lifexia_email');
    
    if (token && email) {
        // Verify token with backend
        fetch(`${API_BASE}/auth/verify`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            }
        })
        .then(res => res.json())
        .then(data => {
            if (data.valid) {
                currentUser = { email: email };
                showChatInterface();
            } else {
                clearAuth();
            }
        })
        .catch(err => {
            console.error('Auth verification failed:', err);
            clearAuth();
        });
    }
}

function clearAuth() {
    localStorage.removeItem('lifexia_token');
    localStorage.removeItem('lifexia_email');
    currentUser = null;
    currentSessionId = null;
}

function showChatInterface() {
    document.getElementById('loginPage').classList.add('hidden');
    document.getElementById('chatInterface').classList.remove('hidden');
    loadChatHistory();
    initializeChat();
}

function showLoginPage() {
    document.getElementById('loginPage').classList.remove('hidden');
    document.getElementById('chatInterface').classList.add('hidden');
    document.getElementById('messagesArea').innerHTML = '';
}

async function initializeChat() {
    try {
        const response = await fetch(`${API_BASE}/chat/init`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ user_email: currentUser.email })
        });
        
        const data = await response.json();
        currentSessionId = data.session_id;
        
        if (data.welcome_message) {
            addMessage('bot', data.welcome_message);
        }
    } catch (error) {
        console.error('Failed to initialize chat:', error);
        addMessage('bot', 'Welcome to LifeXia! I\'m here to help you with medication information, drug interactions, dosage guidelines, and more. How can I assist you today?');
    }
}

function newChat() {
    currentSessionId = null;
    document.getElementById('messagesArea').innerHTML = '';
    initializeChat();
}

function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const menuBtn = document.getElementById('menuBtn');
    
    if (window.innerWidth <= 768) {
        sidebar.classList.toggle('active');
    } else {
        sidebarOpen = !sidebarOpen;
        if (sidebarOpen) {
            sidebar.style.width = '320px';
            menuBtn.classList.add('hidden');
        } else {
            sidebar.style.width = '0';
            menuBtn.classList.remove('hidden');
        }
    }
}

function showLoading() {
    document.getElementById('loadingOverlay').classList.remove('hidden');
}

function hideLoading() {
    document.getElementById('loadingOverlay').classList.add('hidden');
}

function showTypingIndicator() {
    document.getElementById('typingIndicator').classList.remove('hidden');
}

function hideTypingIndicator() {
    document.getElementById('typingIndicator').classList.add('hidden');
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function formatTime(date = new Date()) {
    return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}

// Error handling
window.addEventListener('error', (e) => {
    console.error('Global error:', e.error);
});

window.addEventListener('unhandledrejection', (e) => {
    console.error('Unhandled promise rejection:', e.reason);
});

echo -e "${GREEN}✅ Main files created!${NC}"
echo -e "${BLUE}Creating JavaScript files...${NC}"

# ==================== AUTH.JS ====================
cat > frontend/static/js/auth.js << 'ENDOFFILE'
// frontend/static/js/auth.js - Authentication Logic

async function handleLogin() {
    const email = document.getElementById('loginEmail').value.trim();
    const password = document.getElementById('loginPassword').value;
    
    if (!email || !password) {
        showNotification('Please enter both email and password', 'error');
        return;
    }
    
    showLoading();
    
    try {
        const response = await fetch(`${API_BASE}/auth/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });
        
        const data = await response.json();
        
        if (response.ok) {
            localStorage.setItem('lifexia_token', data.token);
            localStorage.setItem('lifexia_email', email);
            currentUser = { email };
            showChatInterface();
            showNotification('Login successful!', 'success');
        } else {
            showNotification(data.error || 'Login failed', 'error');
        }
    } catch (error) {
        console.error('Login error:', error);
        showNotification('Connection error. Please try again.', 'error');
    } finally {
        hideLoading();
    }
}

async function handleRegister() {
    const email = document.getElementById('registerEmail').value.trim();
    const password = document.getElementById('registerPassword').value;
    const username = document.getElementById('registerUsername')?.value.trim();
    
    if (!email || !password) {
        showNotification('Please fill in all required fields', 'error');
        return;
    }
    
    if (password.length < 8) {
        showNotification('Password must be at least 8 characters', 'error');
        return;
    }
    
    showLoading();
    
    try {
        const response = await fetch(`${API_BASE}/auth/register`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password, username })
        });
        
        const data = await response.json();
        
        if (response.ok) {
            localStorage.setItem('lifexia_token', data.token);
            localStorage.setItem('lifexia_email', email);
            currentUser = { email };
            showChatInterface();
            showNotification('Registration successful!', 'success');
        } else {
            showNotification(data.error || 'Registration failed', 'error');
        }
    } catch (error) {
        console.error('Registration error:', error);
        showNotification('Connection error. Please try again.', 'error');
    } finally {
        hideLoading();
    }
}

function handleLogout() {
    if (confirm('Are you sure you want to logout?')) {
        clearAuth();
        showLoginPage();
        showNotification('Logged out successfully', 'success');
    }
}

function showRegister() {
    // Toggle to registration view (implement registration UI if needed)
    showNotification('Please use email and password to login. New users will be created automatically.', 'info');
}

function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `fixed top-4 right-4 z-50 glassmorphism-strong rounded-xl p-4 ${type === 'error' ? 'error-message' : type === 'success' ? 'success-message' : ''} text-white transition-all transform translate-x-full`;
    notification.textContent = message;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.classList.remove('translate-x-full');
    }, 100);
    
    setTimeout(() => {
        notification.classList.add('translate-x-full');
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}
ENDOFFILE

# ==================== CHAT.JS ====================
cat > frontend/static/js/chat.js << 'ENDOFFILE'
// frontend/static/js/chat.js - Chat Functionality

async function sendMessage() {
    const input = document.getElementById('messageInput');
    const message = input.value.trim();
    
    if (!message) return;
    
    // Add user message to UI
    addMessage('user', message);
    input.value = '';
    
    // Show typing indicator
    showTypingIndicator();
    
    try {
        const response = await fetch(`${API_BASE}/chat/send`, {
            method: 'POST',
            headers: { 
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${localStorage.getItem('lifexia_token')}`
            },
            body: JSON.stringify({
                message: message,
                user_email: currentUser.email,
                session_id: currentSessionId
            })
        });
        
        const data = await response.json();
        
        hideTypingIndicator();
        
        if (response.ok) {
            addMessage('bot', data.response);
            if (!currentSessionId) {
                currentSessionId = data.session_id;
            }
            // Reload chat history to show new conversation
            loadChatHistory();
        } else {
            addMessage('bot', 'Sorry, I encountered an error. Please try again.');
        }
    } catch (error) {
        console.error('Send message error:', error);
        hideTypingIndicator();
        addMessage('bot', 'Connection error. Please check your internet connection and try again.');
    }
}

function addMessage(type, content, timestamp = null) {
    const messagesArea = document.getElementById('messagesArea');
    const time = timestamp || formatTime();
    
    const messageDiv = document.createElement('div');
    messageDiv.className = `flex ${type === 'user' ? 'justify-end' : 'justify-start'} message-enter`;
    
    // Format content with line breaks
    const formattedContent = escapeHtml(content).replace(/\n/g, '<br>');
    
    messageDiv.innerHTML = `
        <div class="max-w-[70%] ${type === 'user' ? 'glassmorphism-strong' : 'glassmorphism'} rounded-2xl p-4 shadow-lg">
            <p class="text-white whitespace-pre-wrap">${formattedContent}</p>
            <span class="text-white/50 text-xs mt-2 block">${time}</span>
        </div>
    `;
    
    messagesArea.appendChild(messageDiv);
    
    // Smooth scroll to bottom
    messagesArea.scrollTo({
        top: messagesArea.scrollHeight,
        behavior: 'smooth'
    });
}

async function loadChatHistory() {
    try {
        const response = await fetch(`${API_BASE}/history/${currentUser.email}`, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('lifexia_token')}`
            }
        });
        
        if (!response.ok) return;
        
        const history = await response.json();
        const historyList = document.getElementById('chatHistoryList');
        
        if (history.length === 0) {
            historyList.innerHTML = `
                <div class="text-white/50 text-sm text-center py-4">
                    No chat history yet
                </div>
            `;
            return;
        }
        
        historyList.innerHTML = history.map(chat => `
            <div class="glassmorphism-strong rounded-xl p-3 hover:bg-white/30 transition-all cursor-pointer group" onclick="loadConversation('${chat.session_id}')">
                <div class="flex items-start justify-between">
                    <div class="flex-1 min-w-0">
                        <h3 class="text-white text-sm font-medium truncate">${escapeHtml(chat.title || 'Untitled Chat')}</h3>
                        <p class="text-white/60 text-xs mt-1 truncate">${chat.last_message || 'No messages'}</p>
                    </div>
                    <button onclick="deleteConversation(event, ${chat.id})" class="opacity-0 group-hover:opacity-100 transition-opacity ml-2 text-white/60 hover:text-red-400">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                        </svg>
                    </button>
                </div>
                <div class="flex items-center text-white/40 text-xs mt-2">
                    <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    ${new Date(chat.created_at).toLocaleDateString()}
                </div>
            </div>
        `).join('');
    } catch (error) {
        console.error('Failed to load chat history:', error);
    }
}

async function loadConversation(sessionId) {
    try {
        showLoading();
        
        const response = await fetch(`${API_BASE}/history/conversation/${sessionId}`, {
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('lifexia_token')}`
            }
        });
        
        const data = await response.json();
        
        // Clear current messages
        document.getElementById('messagesArea').innerHTML = '';
        currentSessionId = sessionId;
        
        // Load all messages
        data.messages.forEach(msg => {
            addMessage(
                msg.role === 'user' ? 'user' : 'bot',
                msg.content,
                formatTime(new Date(msg.timestamp))
            );
        });
        
        hideLoading();
        
        // Close sidebar on mobile
        if (window.innerWidth <= 768) {
            document.getElementById('sidebar').classList.remove('active');
        }
    } catch (error) {
        console.error('Failed to load conversation:', error);
        hideLoading();
        showNotification('Failed to load conversation', 'error');
    }
}

async function deleteConversation(event, conversationId) {
    event.stopPropagation();
    
    if (!confirm('Are you sure you want to delete this conversation?')) {
        return;
    }
    
    try {
        const response = await fetch(`${API_BASE}/history/delete/${conversationId}`, {
            method: 'DELETE',
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('lifexia_token')}`
            }
        });
        
        if (response.ok) {
            showNotification('Conversation deleted', 'success');
            loadChatHistory();
        } else {
            showNotification('Failed to delete conversation', 'error');
        }
    } catch (error) {
        console.error('Delete error:', error);
        showNotification('Failed to delete conversation', 'error');
    }
}
ENDOFFILE

# ==================== UPLOAD.JS ====================
cat > frontend/static/js/upload.js << 'ENDOFFILE'
// frontend/static/js/upload.js - File Upload Functionality

async function handleFileUpload(event) {
    const file = event.target.files[0];
    if (!file) return;
    
    // Validate file size (10MB max)
    const maxSize = 10 * 1024 * 1024;
    if (file.size > maxSize) {
        showNotification('File size exceeds 10MB limit', 'error');
        event.target.value = '';
        return;
    }
    
    // Validate file type
    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'application/pdf'];
    if (!allowedTypes.includes(file.type)) {
        showNotification('Please upload an image (JPG, PNG, GIF) or PDF file', 'error');
        event.target.value = '';
        return;
    }
    
    // Show upload message
    addMessage('user', `📎 Uploading: ${file.name} (${formatFileSize(file.size)})`);
    showLoading();
    
    // Create FormData
    const formData = new FormData();
    formData.append('image', file);
    formData.append('user_email', currentUser.email);
    formData.append('session_id', currentSessionId || '');
    
    try {
        const response = await fetch(`${API_BASE}/upload/image`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('lifexia_token')}`
            },
            body: formData
        });
        
        const data = await response.json();
        
        hideLoading();
        
        if (response.ok) {
            // Show extracted text if available
            let responseText = '✅ Image uploaded and analyzed successfully!\n\n';
            
            if (data.extracted_text) {
                responseText += `**Extracted Text:**\n${data.extracted_text}\n\n`;
            }
            
            if (data.ai_response) {
                responseText += `**Analysis:**\n${data.ai_response}`;
            }
            
            addMessage('bot', responseText);
            
            // Update session ID if new
            if (data.session_id && !currentSessionId) {
                currentSessionId = data.session_id;
            }
            
            showNotification('Image processed successfully', 'success');
        } else {
            addMessage('bot', 'Sorry, I had trouble processing your image. Please make sure it\'s clear and try again.');
            showNotification(data.error || 'Upload failed', 'error');
        }
    } catch (error) {
        console.error('Upload error:', error);
        hideLoading();
        addMessage('bot', 'Upload failed due to connection error. Please try again.');
        showNotification('Upload failed', 'error');
    }
    
    // Clear file input
    event.target.value = '';
}

function formatFileSize(bytes) {
    if (bytes === 0) return '0 Bytes';
    
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    
    return Math.round(bytes / Math.pow(k, i) * 100) / 100 + ' ' + sizes[i];
}

// Drag and drop support
document.addEventListener('DOMContentLoaded', () => {
    const messagesArea = document.getElementById('messagesArea');
    
    if (messagesArea) {
        // Prevent default drag behaviors
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            messagesArea.addEventListener(eventName, preventDefaults, false);
            document.body.addEventListener(eventName, preventDefaults, false);
        });
        
        // Highlight drop area
        ['dragenter', 'dragover'].forEach(eventName => {
            messagesArea.addEventListener(eventName, highlight, false);
        });
        
        ['dragleave', 'drop'].forEach(eventName => {
            messagesArea.addEventListener(eventName, unhighlight, false);
        });
        
        // Handle dropped files
        messagesArea.addEventListener('drop', handleDrop, false);
    }
});

function preventDefaults(e) {
    e.preventDefault();
    e.stopPropagation();
}

function highlight(e) {
    document.getElementById('messagesArea').classList.add('border-4', 'border-white', 'border-dashed');
}

function unhighlight(e) {
    document.getElementById('messagesArea').classList.remove('border-4', 'border-white', 'border-dashed');
}

function handleDrop(e) {
    const dt = e.dataTransfer;
    const files = dt.files;
    
    if (files.length > 0) {
        const file = files[0];
        const fileInput = document.getElementById('fileInput');
        
        // Create a new FileList-like object
        const dataTransfer = new DataTransfer();
        dataTransfer.items.add(file);
        fileInput.files = dataTransfer.files;
        
        // Trigger upload
        handleFileUpload({ target: fileInput });
    }
}
ENDOFFILE

# ==================== MAP.JS ====================
cat > frontend/static/js/map.js << 'ENDOFFILE'
// frontend/static/js/map.js - Leaflet Map Integration

let map = null;
const nearbyLocations = [
    { name: 'City General Hospital', distance: '0.5 km', type: 'Hospital', lat: 23.0225, lng: 72.5714, phone: '+91 79 1234 5678' },
    { name: 'MedPlus Pharmacy', distance: '0.3 km', type: 'Pharmacy', lat: 23.0235, lng: 72.5724, phone: '+91 79 2345 6789' },
    { name: 'Apollo Hospital', distance: '1.2 km', type: 'Hospital', lat: 23.0245, lng: 72.5734, phone: '+91 79 3456 7890' },
    { name: 'HealthCare Medical Store', distance: '0.8 km', type: 'Pharmacy', lat: 23.0255, lng: 72.5744, phone: '+91 79 4567 8901' },
    { name: 'Sterling Hospital', distance: '1.5 km', type: 'Hospital', lat: 23.0215, lng: 72.5700, phone: '+91 79 5678 9012' },
    { name: 'Wellness Pharmacy', distance: '0.6 km', type: 'Pharmacy', lat: 23.0250, lng: 72.5710, phone: '+91 79 6789 0123' }
];

function showMapModal() {
    document.getElementById('mapModal').classList.remove('hidden');
    loadLocations();
    
    // Initialize map after a short delay to ensure container is visible
    setTimeout(() => {
        initializeMap();
    }, 100);
}

function closeMapModal() {
    document.getElementById('mapModal').classList.add('hidden');
    
    // Clean up map
    if (map) {
        map.remove();
        map = null;
    }
}

function loadLocations() {
    const locationsList = document.getElementById('locationsList');
    
    locationsList.innerHTML = nearbyLocations.map((loc, idx) => `
        <div class="glassmorphism-strong rounded-xl p-4 hover:bg-white/30 transition-all cursor-pointer" onclick="focusLocation(${idx})">
            <div class="flex items-start justify-between mb-3">
                <div class="flex-1">
                    <h3 class="text-white font-semibold">${loc.name}</h3>
                    <p class="text-white/70 text-sm">${loc.type}</p>
                </div>
                <span class="text-white/80 text-xs glassmorphism px-3 py-1 rounded-lg font-medium">${loc.distance}</span>
            </div>
            
            <div class="space-y-2">
                ${loc.phone ? `
                    <div class="flex items-center text-white/60 text-sm">
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
                        </svg>
                        ${loc.phone}
                    </div>
                ` : ''}
                
                <button onclick="getDirections(event, ${loc.lat}, ${loc.lng}, '${loc.name}')" class="w-full text-sm text-white/90 hover:text-white flex items-center justify-center gap-2 glassmorphism p-2 rounded-lg hover:bg-white/20 transition-all">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                    </svg>
                    Get Directions
                </button>
            </div>
        </div>
    `).join('');
}

function initializeMap() {
    // Remove existing map if any
    if (map) {
        map.remove();
    }
    
    // Initialize map centered on Ahmedabad
    map = L.map('map').setView([23.0225, 72.5714], 13);
    
    // Add OpenStreetMap tiles
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors',
        maxZoom: 19
    }).addTo(map);
    
    // Add markers for each location
    nearbyLocations.forEach((loc, idx) => {
        // Custom icon based on type
        const iconColor = loc.type === 'Hospital' ? '#ef4444' : '#8b5cf6';
        const iconHtml = `
            <div style="
                background: ${iconColor};
                border-radius: 50%;
                width: 36px;
                height: 36px;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 3px solid white;
                box-shadow: 0 2px 8px rgba(0,0,0,0.3);
            ">
                <svg style="width: 20px; height: 20px; color: white;" fill="currentColor" viewBox="0 0 20 20">
                    ${loc.type === 'Hospital' ? 
                        '<path d="M10 3.5a1.5 1.5 0 013 0V4a1 1 0 001 1h3a1 1 0 011 1v3a1 1 0 01-1 1h-.5a1.5 1.5 0 000 3h.5a1 1 0 011 1v3a1 1 0 01-1 1h-3a1 1 0 01-1-1v-.5a1.5 1.5 0 00-3 0v.5a1 1 0 01-1 1H6a1 1 0 01-1-1v-3a1 1 0 00-1-1h-.5a1.5 1.5 0 010-3H4a1 1 0 001-1V6a1 1 0 011-1h3a1 1 0 001-1v-.5z"/>' : 
                        '<path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>'}
                </svg>
            </div>
        `;
        
        const icon = L.divIcon({
            html: iconHtml,
            className: '',
            iconSize: [36, 36],
            iconAnchor: [18, 18],
            popupAnchor: [0, -18]
        });
        
        const marker = L.marker([loc.lat, loc.lng], { icon: icon }).addTo(map);
        
        // Create popup content
        const popupContent = `
            <div style="min-width: 200px;">
                <h3 style="font-weight: bold; margin-bottom: 8px; color: #1f2937;">${loc.name}</h3>
                <p style="color: #6b7280; font-size: 14px; margin-bottom: 4px;">${loc.type}</p>
                <p style="color: #8b5cf6; font-size: 13px; margin-bottom: 8px;">📍 ${loc.distance}</p>
                ${loc.phone ? `<p style="color: #6b7280; font-size: 13px; margin-bottom: 8px;">📞 ${loc.phone}</p>` : ''}
                <button onclick="getDirections(event, ${loc.lat}, ${loc.lng}, '${loc.name}')" style="
                    background: linear-gradient(135deg, #667eea, #764ba2);
                    color: white;
                    border: none;
                    padding: 8px 16px;
                    border-radius: 8px;
                    cursor: pointer;
                    font-size: 13px;
                    width: 100%;
                    margin-top: 8px;
                ">
                    Get Directions
                </button>
            </div>
        `;
        
        marker.bindPopup(popupContent);
    });
    
    // Fit map to show all markers
    const group = new L.featureGroup(map._layers);
    if (Object.keys(group._layers).length > 0) {
        map.fitBounds(group.getBounds().pad(0.1));
    }
}

function focusLocation(index) {
    const loc = nearbyLocations[index];
    
    if (map) {
        map.setView([loc.lat, loc.lng], 16, {
            animate: true,
            duration: 1
        });
        
        // Find and open the marker popup
        map.eachLayer(layer => {
            if (layer instanceof L.Marker) {
                const pos = layer.getLatLng();
                if (pos.lat === loc.lat && pos.lng === loc.lng) {
                    layer.openPopup();
                }
            }
        });
    }
}

function getDirections(event, lat, lng, name) {
    event.stopPropagation();
    
    // Open Google Maps with directions
    const url = `https://www.google.com/maps/dir/?api=1&destination=${lat},${lng}&destination_place_id=${encodeURIComponent(name)}`;
    window.open(url, '_blank');
}
ENDOFFILE

echo -e "${GREEN}✅ All frontend files created successfully!${NC}"
echo -e "${BLUE}==========================================${NC}"
echo -e "${YELLOW}Frontend files created:${NC}"
echo -e "  ✓ frontend/templates/index.html (Complete UI)"
echo -e "  ✓ frontend/static/css/styles.css (Glassmorphism styles)"
echo -e "  ✓ frontend/static/js/main.js (Core application logic)"
echo -e "  ✓ frontend/static/js/auth.js (Authentication)"
echo -e "  ✓ frontend/static/js/chat.js (Chat interface)"
echo -e "  ✓ frontend/static/js/map.js (Leaflet maps)"
echo -e "  ✓ frontend/static/js/upload.js (File upload & drag-drop)"
echo -e "${BLUE}==========================================${NC}"
echo -e "${GREEN}Frontend setup complete! You can now run your Flask app.${NC}"
#!/bin/bash
# download_frontend.sh - Complete Frontend Files for LifeXia

echo "=========================================="
echo "  LifeXia Frontend Files Setup"
echo "=========================================="

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if we're in the lifexia directory
if [ ! -d "frontend" ]; then
    echo -e "${YELLOW}Creating frontend directory structure...${NC}"
    mkdir -p frontend/{templates,static/{css,js},components}
fi

echo -e "${GREEN}Creating complete frontend files...${NC}"

# ==================== HTML TEMPLATE ====================
echo -e "${BLUE}Creating index.html...${NC}"
cat > frontend/templates/index.html << 'ENDOFFILE'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LifeXia - Intelligent Pharmacy Assistant</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <link rel="stylesheet" href="{{ url_for('static', filename='css/styles.css') }}">
</head>
<body class="gradient-bg min-h-screen">
    <!-- Login Page -->
    <div id="loginPage" class="min-h-screen flex items-center justify-center p-4">
        <div class="w-full max-w-md">
            <div class="glassmorphism-strong rounded-3xl shadow-2xl p-8">
                <div class="text-center mb-8">
                    <div class="inline-block p-4 glassmorphism rounded-full mb-4">
                        <svg class="w-12 h-12 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"></path>
                        </svg>
                    </div>
                    <h1 class="text-3xl font-bold text-white mb-2">LifeXia</h1>
                    <p class="text-white/80">Your Intelligent Pharmacy Assistant</p>
                </div>

                <div class="space-y-6">
                    <div>
                        <label class="block text-white/90 text-sm font-medium mb-2">Email</label>
                        <div class="relative">
                            <svg class="absolute left-3 top-3 w-5 h-5 text-white/60" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                            </svg>
                            <input id="loginEmail" type="email" class="w-full pl-11 pr-4 py-3 glassmorphism rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-white/50" placeholder="Enter your email">
                        </div>
                    </div>

                    <div>
                        <label class="block text-white/90 text-sm font-medium mb-2">Password</label>
                        <div class="relative">
                            <svg class="absolute left-3 top-3 w-5 h-5 text-white/60" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                            </svg>
                            <input id="loginPassword" type="password" class="w-full pl-11 pr-4 py-3 glassmorphism rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-white/50" placeholder="Enter your password">
                        </div>
                    </div>

                    <button onclick="handleLogin()" class="w-full glassmorphism-strong hover:bg-white/40 text-white font-semibold py-3 rounded-xl transition-all duration-300">
                        Sign In
                    </button>

                    <div class="text-center">
                        <p class="text-white/70 text-sm">Don't have an account? <span onclick="showRegister()" class="text-white font-semibold cursor-pointer hover:underline">Sign up</span></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Chat Interface -->
    <div id="chatInterface" class="hidden h-screen flex">
        <!-- Sidebar -->
        <div id="sidebar" class="w-80 glassmorphism border-r border-white/20 p-4 transition-all duration-300">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-white font-semibold text-lg">Chat History</h2>
                <button onclick="toggleSidebar()" class="lg:hidden text-white/80 hover:text-white">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            
            <button onclick="newChat()" class="w-full glassmorphism-strong hover:bg-white/30 text-white rounded-xl p-3 mb-4 flex items-center justify-center gap-2 transition-all">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                </svg>
                New Chat
            </button>
            
            <div id="chatHistoryList" class="space-y-2 overflow-y-auto max-h-[calc(100vh-200px)] chat-scroll"></div>
        </div>

        <!-- Main Chat Area -->
        <div class="flex-1 flex flex-col">
            <!-- Header -->
            <div class="glassmorphism border-b border-white/20 p-4">
                <div class="flex items-center justify-between">
                    <div class="flex items-center gap-3">
                        <button onclick="toggleSidebar()" id="menuBtn" class="text-white/80 hover:text-white hidden">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                            </svg>
                        </button>
                        <div class="flex items-center gap-2">
                            <div class="p-2 glassmorphism rounded-lg">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"></path>
                                </svg>
                            </div>
                            <div>
                                <h1 class="text-white font-semibold">LifeXia Assistant</h1>
                                <p class="text-white/70 text-xs">AI-Powered Pharmacy Support</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="flex items-center gap-2">
                        <button onclick="showMapModal()" class="flex items-center gap-2 px-4 py-2 glassmorphism-strong hover:bg-white/30 text-white rounded-xl transition-all">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                            </svg>
                            <span class="hidden sm:inline">Nearby</span>
                        </button>
                        <button onclick="handleLogout()" class="flex items-center gap-2 px-4 py-2 glassmorphism-strong hover:bg-white/30 text-white rounded-xl transition-all">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                            </svg>
                            <span class="hidden sm:inline">Logout</span>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Messages Area -->
            <div id="messagesArea" class="flex-1 overflow-y-auto p-6 space-y-4 chat-scroll">
                <!-- Messages will be dynamically added here -->
            </div>

            <!-- Typing Indicator -->
            <div id="typingIndicator" class="hidden px-6 py-2">
                <div class="flex justify-start">
                    <div class="glassmorphism rounded-2xl p-4">
                        <div class="flex space-x-2">
                            <div class="w-2 h-2 bg-white/60 rounded-full animate-bounce"></div>
                            <div class="w-2 h-2 bg-white/60 rounded-full animate-bounce" style="animation-delay: 0.1s"></div>
                            <div class="w-2 h-2 bg-white/60 rounded-full animate-bounce" style="animation-delay: 0.2s"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Input Area -->
            <div class="glassmorphism border-t border-white/20 p-4">
                <div class="flex items-center gap-2">
                    <input type="file" id="fileInput" accept="image/*,.pdf" class="hidden" onchange="handleFileUpload(event)">
                    <button onclick="document.getElementById('fileInput').click()" class="p-3 glassmorphism-strong hover:bg-white/30 text-white rounded-xl transition-all" title="Upload prescription image">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                        </svg>
                    </button>
                    
                    <input id="messageInput" type="text" placeholder="Ask about medications, dosages, interactions..." class="flex-1 px-4 py-3 glassmorphism rounded-xl text-white placeholder-white/50 focus:outline-none focus:ring-2 focus:ring-white/50">
                    
                    <button onclick="sendMessage()" class="p-3 glassmorphism-strong hover:bg-white/40 text-white rounded-xl transition-all" title="Send message">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"></path>
                        </svg>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Map Modal -->
    <div id="mapModal" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center p-4 z-50">
        <div class="w-full max-w-4xl glassmorphism-strong rounded-3xl shadow-2xl overflow-hidden">
            <div class="glassmorphism-strong p-4 flex justify-between items-center border-b border-white/20">
                <h2 class="text-white font-semibold text-xl">Nearby Medical Facilities</h2>
                <button onclick="closeMapModal()" class="text-white/80 hover:text-white transition-all">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            
            <div class="p-6 max-h-[600px] overflow-y-auto chat-scroll">
                <div id="locationsList" class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4"></div>
                <div id="map" class="glassmorphism rounded-xl" style="height: 400px;"></div>
            </div>
        </div>
    </div>

    <!-- Loading Overlay -->
    <div id="loadingOverlay" class="hidden fixed inset-0 bg-black/70 backdrop-blur-sm flex items-center justify-center z-50">
        <div class="glassmorphism-strong rounded-3xl p-8 text-center">
            <div class="animate-spin rounded-full h-16 w-16 border-4 border-white/30 border-t-white mx-auto mb-4"></div>
            <p class="text-white text-lg">Processing...</p>
        </div>
    </div>

    <!-- Scripts -->
    <script src="{{ url_for('static', filename='js/main.js') }}"></script>
    <script src="{{ url_for('static', filename='js/auth.js') }}"></script>
    <script src="{{ url_for('static', filename='js/chat.js') }}"></script>
    <script src="{{ url_for('static', filename='js/map.js') }}"></script>
    <script src="{{ url_for('static', filename='js/upload.js') }}"></script>
</body>
</html>
ENDOFFILE

# ==================== CSS STYLES ====================
echo -e "${BLUE}Creating styles.css...${NC}"
cat > frontend/static/css/styles.css << 'ENDOFFILE'
/* frontend/static/css/styles.css - LifeXia Glassmorphism Styles */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Glassmorphism Effects */
.glassmorphism {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.2);
    box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
}

.glassmorphism-strong {
    background: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);
    border: 1px solid rgba(255, 255, 255, 0.3);
    box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
}

/* Gradient Background */
.gradient-bg {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
    min-height: 100vh;
    position: relative;
}

.gradient-bg::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: 
        radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3), transparent 50%),
        radial-gradient(circle at 80% 80%, rgba(252, 163, 217, 0.3), transparent 50%),
        radial-gradient(circle at 40% 20%, rgba(139, 92, 246, 0.3), transparent 50%);
    animation: gradientShift 15s ease infinite;
    pointer-events: none;
}

@keyframes gradientShift {
    0%, 100% {
        opacity: 1;
    }
    50% {
        opacity: 0.8;
    }
}

/* Custom Scrollbar */
.chat-scroll::-webkit-scrollbar {
    width: 6px;
}

.chat-scroll::-webkit-scrollbar-track {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 10px;
}

.chat-scroll::-webkit-scrollbar-thumb {
    background: rgba(255, 255, 255, 0.3);
    border-radius: 10px;
}

.chat-scroll::-webkit-scrollbar-thumb:hover {
    background: rgba(255, 255, 255, 0.5);
}

/* Map Styles */
#map {
    height: 400px;
    border-radius: 1rem;
    overflow: hidden;
}

.leaflet-popup-content-wrapper {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 12px;
}

/* Message Animations */
@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.message-enter {
    animation: slideIn 0.3s ease-out;
}

/* Loading Animation */
@keyframes spin {
    to {
        transform: rotate(360deg);
    }
}

.animate-spin {
    animation: spin 1s linear infinite;
}

/* Bounce Animation for Typing Indicator */
@keyframes bounce {
    0%, 80%, 100% {
        transform: scale(0);
    }
    40% {
        transform: scale(1);
    }
}

.animate-bounce {
    animation: bounce 1.4s infinite ease-in-out;
}

/* Input Focus Effects */
input:focus,
textarea:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.3);
}

/* Button Hover Effects */
button {
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

button:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
}

button:active {
    transform: translateY(0);
}

/* Responsive Design */
@media (max-width: 768px) {
    #sidebar {
        position: fixed;
        left: 0;
        top: 0;
        height: 100vh;
        z-index: 40;
        transform: translateX(-100%);
        transition: transform 0.3s ease;
    }

    #sidebar.active {
        transform: translateX(0);
    }

    #menuBtn {
        display: block !important;
    }
}

/* Utility Classes */
.blur-background {
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
}

.text-shadow {
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

/* Pulse Animation for Notifications */
@keyframes pulse {
    0%, 100% {
        opacity: 1;
    }
    50% {
        opacity: 0.5;
    }
}

.pulse {
    animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

/* Image Preview Styles */
.image-preview {
    max-width: 200px;
    max-height: 200px;
    border-radius: 12px;
    object-fit: cover;
}

/* Error Message Styles */
.error-message {
    background: rgba(239, 68, 68, 0.2);
    border: 1px solid rgba(239, 68, 68, 0.4);
    color: #fee2e2;
}

/* Success Message Styles */
.success-message {
    background: rgba(34, 197, 94, 0.2);
    border: 1px solid rgba(34, 197, 94, 0.4);
    color: #dcfce7;
}
ENDOFFILE

# ==================== JAVASCRIPT FILES ====================

echo -e "${BLUE}Creating main.js...${NC}"
cat > frontend/static/js/main.js << 'ENDOFFILE'
// frontend/static/js/main.js - Main Application Logic
const API_BASE = '/api';
let currentUser = null;
let currentSessionId = null;
let sidebarOpen = true;

// Initialize application
document.addEventListener('DOMContentLoaded', () => {
    console.log('LifeXia initializing...');
    setupEventListeners();
    checkAuthStatus();
});

function setupEventListeners() {
    // Enter key for message input
    const messageInput = document.getElementById('messageInput');
    if (messageInput) {
        messageInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                sendMessage();
            }
        });
    }

    // Enter key for login
    const loginPassword = document.getElementById('loginPassword');
    if (loginPassword) {
        loginPassword.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                handleLogin();
            }
        });
    }

    // Click outside sidebar to close (mobile)
    document.addEventListener('click', (e) => {
        const sidebar = document.getElementById('sidebar');
        const menuBtn = document.getElementById('menuBtn');
        
        if (window.innerWidth <= 768 && sidebar && !sidebar.contains(e.target) && !menuBtn.contains(e.target)) {
            sidebar.classList.remove('active');
        }
    });
}

function checkAuthStatus() {
    const token = localStorage.getItem('lifexia_token');
    const email = localStorage.getItem('lifexia_email');
    
    if (token && email) {
        // Verify token with backend
        fetch(`${API_BASE}/auth/verify`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${token}`,
                'Content-Type': 'application/json'
            }
        })
        .then(res => res.json())
        .then(data => {
            if (data.valid) {
                currentUser = { email: email };
                showChatInterface();
            } else {
                clearAuth();
            }
        })
        .catch(err => {
            console.error('Auth verification failed:', err);
            clearAuth();
        });
    }
}

function clearAuth() {
    localStorage.removeItem('lifexia_token');
    localStorage.removeItem('lifexia_email');
    currentUser = null;
    currentSessionId = null;
}

function showChatInterface() {
    document.getElementById('loginPage').classList.add('hidden');
    document.getElementById('chatInterface').classList.remove('hidden');
    loadChatHistory();
    initializeChat();
}

function showLoginPage() {
    document.getElementById('loginPage').classList.remove('hidden');
    document.getElementById('chatInterface').classList.add('hidden');
    document.getElementById('messagesArea').innerHTML = '';
}

async function initializeChat() {
    try {
        const response = await fetch(`${API_BASE}/chat/init`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ user_email: currentUser.email })
        });
        
        const data = await response.json();
        currentSessionId = data.session_id;
        
        if (data.welcome_message) {
            addMessage('bot', data.welcome_message);
        }
    } catch (error) {
        console.error('Failed to initialize chat:', error);
        addMessage('bot', 'Welcome to LifeXia! I\'m here to help you with medication information, drug interactions, dosage guidelines, and more. How can I assist you today?');
    }
}

function newChat() {
    currentSessionId = null;
    document.getElementById('messagesArea').innerHTML = '';
    initializeChat();
}

function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const menuBtn = document.getElementById('menuBtn');
    
    if (window.innerWidth <= 768) {
        sidebar.classList.toggle('active');
    } else {
        sidebarOpen = !sidebarOpen;
        if (sidebarOpen) {
            sidebar.style.width = '320px';
            menuBtn.classList.add('hidden');
        } else {
            sidebar.style.width = '0';
            menuBtn.classList.remove('hidden');
        }
    }
}

function showLoading() {
    document.getElementById('loadingOverlay').classList.remove('hidden');
}

function hideLoading() {
    document.getElementById('loadingOverlay').classList.add('hidden');
}

function showTypingIndicator() {
    document.getElementById('typingIndicator').classList.remove('hidden');
}

function hideTypingIndicator() {
    document.getElementById('typingIndicator').classList.add('hidden');
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function formatTime(date = new Date()) {
    return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}

// Error handling
window.addEventListener('error', (e) => {
    console.error('Global error:', e.error);
});

window.addEventListener('unhandledrejection', (e) => {
    console.error('Unhandled promise rejection:', e.reason);
});
ENDOFFILE

echo -e "${GREEN}✅ All frontend files created successfully!${NC}"
echo -e "${BLUE}==========================================${NC}"
echo -e "${YELLOW}Frontend files created:${NC}"
echo -e "  - frontend/templates/index.html"
echo -e "  - frontend/static/css/styles.css"
echo -e "  - frontend/static/js/main.js"
echo -e "  - frontend/static/js/auth.js"
echo -e "  - frontend/static/js/chat.js"
echo -e "  - frontend/static/js/map.js"
echo -e "  - frontend/static/js/upload.js"
echo -e "${BLUE}==========================================${NC}"
ENDOFFILE

chmod +x download_frontend.sh

echo "✅ download_frontend.sh created successfully!"
echo "Run with: ./download_frontend.sh"
