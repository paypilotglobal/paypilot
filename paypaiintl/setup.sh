#!/bin/bash

# PayPaiIntl Site Setup Script
echo "Setting up PayPaiIntl Coming Soon Site..."

# Check if Python is available
if command -v python3 &> /dev/null; then
    PYTHON_CMD=python3
elif command -v python &> /dev/null; then
    PYTHON_CMD=python
else
    echo "Python is not installed. Installing Python3..."
    sudo apt update
    sudo apt install -y python3
    PYTHON_CMD=python3
fi

# Create project directory
mkdir -p paypaiintl
cd paypaiintl

# Create all necessary files
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PayPaiIntl - Coming Soon</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
</head>
<body>
    <div class="container">
        <header>
            <h1 class="logo">PayPaiIntl</h1>
            <p class="tagline">Revolutionizing Global Payments</p>
        </header>

        <main>
            <div class="coming-soon">
                <h2>Coming Soon</h2>
                <p>We're building something amazing for global payments</p>
                <button id="getStartedBtn" class="cta-button">Get Started</button>
            </div>
        </main>

        <!-- Auth Modal -->
        <div id="authModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                
                <div class="auth-container">
                    <div class="auth-tabs">
                        <button class="tab-button active" data-tab="signup">Sign Up</button>
                        <button class="tab-button" data-tab="login">Login</button>
                    </div>

                    <!-- Sign Up Form -->
                    <form id="signupForm" class="auth-form active">
                        <h3>Create Account</h3>
                        <div class="form-group">
                            <label for="signupName">Full Name</label>
                            <input type="text" id="signupName" required>
                        </div>
                        <div class="form-group">
                            <label for="signupEmail">Email</label>
                            <input type="email" id="signupEmail" required>
                        </div>
                        <div class="form-group">
                            <label for="signupPassword">Password</label>
                            <input type="password" id="signupPassword" required minlength="6">
                        </div>
                        <button type="submit" class="submit-btn">
                            <span class="btn-text">Sign Up</span>
                            <div class="spinner hidden"></div>
                        </button>
                    </form>

                    <!-- Login Form -->
                    <form id="loginForm" class="auth-form">
                        <h3>Login to Your Account</h3>
                        <div class="form-group">
                            <label for="loginEmail">Email</label>
                            <input type="email" id="loginEmail" required>
                        </div>
                        <div class="form-group">
                            <label for="loginPassword">Password</label>
                            <input type="password" id="loginPassword" required>
                        </div>
                        <button type="submit" class="submit-btn">
                            <span class="btn-text">Login</span>
                            <div class="spinner hidden"></div>
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Success Modal -->
        <div id="successModal" class="modal">
            <div class="modal-content success-modal">
                <div class="success-animation">
                    <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                        <circle class="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                        <path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
                    </svg>
                </div>
                <h3>Success!</h3>
                <p id="successMessage">Your account has been created successfully!</p>
                <button class="cta-button" id="successCloseBtn">Continue</button>
            </div>
        </div>
    </div>

    <!-- Toast Container -->
    <div id="toastContainer" class="toast-container"></div>

    <script src="script.js"></script>
</body>
</html>
EOF

cat > styles.css << 'EOF'
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Arial', sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: #333;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}

.container {
    text-align: center;
    padding: 2rem;
    max-width: 800px;
    width: 100%;
}

header {
    margin-bottom: 3rem;
}

.logo {
    font-size: 3.5rem;
    font-weight: bold;
    color: white;
    margin-bottom: 0.5rem;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    animation: fadeInUp 1s ease;
}

.tagline {
    font-size: 1.2rem;
    color: rgba(255,255,255,0.9);
    animation: fadeInUp 1s ease 0.2s both;
}

.coming-soon h2 {
    font-size: 2.5rem;
    color: white;
    margin-bottom: 1rem;
    animation: fadeInUp 1s ease 0.4s both;
}

.coming-soon p {
    font-size: 1.2rem;
    color: rgba(255,255,255,0.9);
    margin-bottom: 2rem;
    animation: fadeInUp 1s ease 0.6s both;
}

.cta-button {
    background: #ff6b6b;
    color: white;
    border: none;
    padding: 15px 30px;
    font-size: 1.1rem;
    border-radius: 50px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(255,107,107,0.4);
    animation: fadeInUp 1s ease 0.8s both;
}

.cta-button:hover {
    background: #ff5252;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(255,107,107,0.6);
}

/* Modal Styles */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.5);
    backdrop-filter: blur(5px);
}

.modal-content {
    background-color: white;
    margin: 5% auto;
    padding: 2rem;
    border-radius: 15px;
    width: 90%;
    max-width: 400px;
    position: relative;
    animation: modalSlideIn 0.3s ease;
}

@keyframes modalSlideIn {
    from {
        opacity: 0;
        transform: translateY(-50px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.close {
    position: absolute;
    right: 1rem;
    top: 1rem;
    font-size: 1.5rem;
    cursor: pointer;
    color: #999;
    transition: color 0.3s ease;
}

.close:hover {
    color: #333;
}

/* Auth Styles */
.auth-tabs {
    display: flex;
    margin-bottom: 2rem;
    border-bottom: 1px solid #eee;
}

.tab-button {
    flex: 1;
    padding: 1rem;
    border: none;
    background: none;
    cursor: pointer;
    font-size: 1rem;
    border-bottom: 3px solid transparent;
    transition: all 0.3s ease;
}

.tab-button.active {
    border-bottom: 3px solid #667eea;
    color: #667eea;
    font-weight: bold;
}

.auth-form {
    display: none;
}

.auth-form.active {
    display: block;
    animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

.form-group {
    margin-bottom: 1.5rem;
    text-align: left;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;
    font-weight: bold;
    color: #555;
}

.form-group input {
    width: 100%;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 8px;
    font-size: 1rem;
    transition: all 0.3s ease;
}

.form-group input:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.submit-btn {
    width: 100%;
    padding: 12px;
    background: #667eea;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.submit-btn:hover:not(:disabled) {
    background: #5a6fd8;
    transform: translateY(-1px);
}

.submit-btn:disabled {
    opacity: 0.7;
    cursor: not-allowed;
    transform: none;
}

/* Spinner */
.spinner {
    width: 20px;
    height: 20px;
    border: 2px solid transparent;
    border-top: 2px solid white;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -10px;
    margin-left: -10px;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.hidden {
    display: none;
}

.btn-text {
    transition: opacity 0.3s ease;
}

.submit-btn.loading .btn-text {
    opacity: 0;
}

.submit-btn.loading .spinner {
    display: block;
}

/* Success Modal */
.success-modal {
    text-align: center;
    padding: 3rem 2rem;
}

.success-animation {
    margin-bottom: 1.5rem;
}

.checkmark {
    width: 80px;
    height: 80px;
    margin: 0 auto;
}

.checkmark__circle {
    stroke-dasharray: 166;
    stroke-dashoffset: 166;
    stroke-width: 2;
    stroke-miterlimit: 10;
    stroke: #4CAF50;
    fill: none;
    animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
}

.checkmark__check {
    transform-origin: 50% 50%;
    stroke-dasharray: 48;
    stroke-dashoffset: 48;
    animation: stroke 0.3s cubic-bezier(0.65, 0, 0.45, 1) 0.8s forwards;
}

@keyframes stroke {
    100% {
        stroke-dashoffset: 0;
    }
}

.success-modal h3 {
    color: #4CAF50;
    margin-bottom: 1rem;
    font-size: 1.5rem;
}

.success-modal p {
    color: #666;
    margin-bottom: 2rem;
    line-height: 1.5;
}

/* Toast Styles */
.toast-container {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 2000;
    max-width: 400px;
}

.toast {
    background: white;
    padding: 1rem 1.5rem;
    border-radius: 8px;
    margin-bottom: 0.5rem;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    display: flex;
    align-items: center;
    animation: toastSlideIn 0.3s ease;
    border-left: 4px solid #4CAF50;
}

.toast.error {
    border-left-color: #f44336;
}

.toast.warning {
    border-left-color: #ff9800;
}

.toast.info {
    border-left-color: #2196F3;
}

.toast-icon {
    margin-right: 0.75rem;
    font-size: 1.2rem;
}

.toast-message {
    flex: 1;
    color: #333;
    font-weight: 500;
}

.toast-close {
    background: none;
    border: none;
    font-size: 1.2rem;
    cursor: pointer;
    color: #999;
    margin-left: 1rem;
    transition: color 0.3s ease;
}

.toast-close:hover {
    color: #333;
}

@keyframes toastSlideIn {
    from {
        opacity: 0;
        transform: translateX(100%);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

@keyframes toastSlideOut {
    from {
        opacity: 1;
        transform: translateX(0);
    }
    to {
        opacity: 0;
        transform: translateX(100%);
    }
}

.toast.hiding {
    animation: toastSlideOut 0.3s ease forwards;
}

/* Responsive Design */
@media (max-width: 768px) {
    .logo {
        font-size: 2.5rem;
    }
    
    .coming-soon h2 {
        font-size: 2rem;
    }
    
    .modal-content {
        margin: 10% auto;
        width: 95%;
        padding: 1.5rem;
    }
    
    .toast-container {
        left: 20px;
        right: 20px;
        max-width: none;
    }
}
EOF

cat > script.js << 'EOF'
// Supabase configuration
const supabaseUrl = 'https://otvatrqlzcwoayalnipw.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im90dmF0cnFsemN3b2F5YWxuaXB3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI4NTA4MzcsImV4cCI6MjA3ODQyNjgzN30.RZSdTJplK9qjqOVRtR0Vy0dq3vs59xc3ab-x4x1bDDA';

// Initialize Supabase
const supabase = window.supabase.createClient(supabaseUrl, supabaseKey);

// DOM Elements
const getStartedBtn = document.getElementById('getStartedBtn');
const authModal = document.getElementById('authModal');
const successModal = document.getElementById('successModal');
const closeModal = document.querySelector('.close');
const successCloseBtn = document.getElementById('successCloseBtn');
const tabButtons = document.querySelectorAll('.tab-button');
const authForms = document.querySelectorAll('.auth-form');
const signupForm = document.getElementById('signupForm');
const loginForm = document.getElementById('loginForm');
const successMessage = document.getElementById('successMessage');
const toastContainer = document.getElementById('toastContainer');

// Track active form submissions to prevent duplicates
let isSubmitting = false;

// Modal functionality
getStartedBtn.addEventListener('click', () => {
    authModal.style.display = 'block';
});

closeModal.addEventListener('click', () => {
    authModal.style.display = 'none';
    resetForms();
});

successCloseBtn.addEventListener('click', () => {
    successModal.style.display = 'none';
});

window.addEventListener('click', (event) => {
    if (event.target === authModal) {
        authModal.style.display = 'none';
        resetForms();
    }
    if (event.target === successModal) {
        successModal.style.display = 'none';
    }
});

// Tab switching
tabButtons.forEach(button => {
    button.addEventListener('click', () => {
        const targetTab = button.getAttribute('data-tab');
        
        // Update active tab button
        tabButtons.forEach(btn => btn.classList.remove('active'));
        button.classList.add('active');
        
        // Show corresponding form
        authForms.forEach(form => {
            form.classList.remove('active');
            if (form.id === `${targetTab}Form`) {
                form.classList.add('active');
            }
        });
    });
});

// Sign Up Form Submission
signupForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    if (isSubmitting) return;
    
    const name = document.getElementById('signupName').value;
    const email = document.getElementById('signupEmail').value;
    const password = document.getElementById('signupPassword').value;
    const submitBtn = signupForm.querySelector('.submit-btn');
    const btnText = submitBtn.querySelector('.btn-text');
    const spinner = submitBtn.querySelector('.spinner');
    
    // Validate form
    if (!name || !email || !password) {
        showToast('Please fill in all fields', 'error');
        return;
    }
    
    if (password.length < 6) {
        showToast('Password must be at least 6 characters', 'error');
        return;
    }
    
    // Show loading state
    setButtonLoading(submitBtn, true);
    isSubmitting = true;
    
    try {
        const { data, error } = await supabase.auth.signUp({
            email: email,
            password: password,
            options: {
                data: {
                    full_name: name
                },
                // Disable email confirmation
                emailRedirectTo: window.location.origin
            }
        });
        
        if (error) throw error;
        
        // Show success modal
        showSuccessModal('Your account has been created successfully! Welcome to PayPaiIntl!');
        
        // Reset form
        signupForm.reset();
        authModal.style.display = 'none';
        
    } catch (error) {
        console.error('Sign up error:', error);
        showToast('Error signing up: ' + error.message, 'error');
    } finally {
        setButtonLoading(submitBtn, false);
        isSubmitting = false;
    }
});

// Login Form Submission
loginForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    if (isSubmitting) return;
    
    const email = document.getElementById('loginEmail').value;
    const password = document.getElementById('loginPassword').value;
    const submitBtn = loginForm.querySelector('.submit-btn');
    
    // Validate form
    if (!email || !password) {
        showToast('Please fill in all fields', 'error');
        return;
    }
    
    // Show loading state
    setButtonLoading(submitBtn, true);
    isSubmitting = true;
    
    try {
        const { data, error } = await supabase.auth.signInWithPassword({
            email: email,
            password: password
        });
        
        if (error) throw error;
        
        // Show success message
        showSuccessModal('Login successful! Welcome back to PayPaiIntl!');
        
        // Reset form
        loginForm.reset();
        authModal.style.display = 'none';
        
    } catch (error) {
        console.error('Login error:', error);
        showToast('Error logging in: ' + error.message, 'error');
    } finally {
        setButtonLoading(submitBtn, false);
        isSubmitting = false;
    }
});

// Utility Functions
function setButtonLoading(button, loading) {
    if (loading) {
        button.disabled = true;
        button.classList.add('loading');
    } else {
        button.disabled = false;
        button.classList.remove('loading');
    }
}

function showSuccessModal(message) {
    successMessage.textContent = message;
    successModal.style.display = 'block';
}

function showToast(message, type = 'info') {
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    toast.innerHTML = `
        <div class="toast-icon">${getToastIcon(type)}</div>
        <div class="toast-message">${message}</div>
        <button class="toast-close">&times;</button>
    `;
    
    toastContainer.appendChild(toast);
    
    // Add click event to close button
    toast.querySelector('.toast-close').addEventListener('click', () => {
        removeToast(toast);
    });
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        removeToast(toast);
    }, 5000);
}

function getToastIcon(type) {
    const icons = {
        success: '✓',
        error: '✕',
        warning: '⚠',
        info: 'ℹ'
    };
    return icons[type] || 'ℹ';
}

function removeToast(toast) {
    toast.classList.add('hiding');
    setTimeout(() => {
        if (toast.parentNode) {
            toast.parentNode.removeChild(toast);
        }
    }, 300);
}

function resetForms() {
    signupForm.reset();
    loginForm.reset();
    
    // Reset loading states
    const submitButtons = document.querySelectorAll('.submit-btn');
    submitButtons.forEach(button => {
        setButtonLoading(button, false);
    });
    
    isSubmitting = false;
}

// Check if user is already logged in (optional)
supabase.auth.getSession().then(({ data: { session } }) => {
    if (session) {
        console.log('User is logged in:', session.user.email);
        showToast(`Welcome back, ${session.user.user_metadata?.full_name || session.user.email}!`, 'success');
    }
});

// Listen for auth state changes
supabase.auth.onAuthStateChange((event, session) => {
    if (event === 'SIGNED_IN') {
        console.log('User signed in:', session.user.email);
    } else if (event === 'SIGNED_OUT') {
        console.log('User signed out');
    }
});
EOF

# Create README
cat > README.md << 'EOF'
# PayPaiIntl Coming Soon Site

A beautiful coming soon page with authentication for PayPaiIntl.

## Features
- Modern, responsive design with animations
- Sign up and login functionality with spinners
- Success modal with animated checkmark
- Toast notifications for user feedback
- Supabase integration for user management
- Mobile-friendly interface

## Running the Site

After running the setup script, start the local server:

```bash
cd paypaiintl
python3 -m http.server 8000