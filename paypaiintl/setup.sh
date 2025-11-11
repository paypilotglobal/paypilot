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
                        <button type="submit" class="submit-btn">Sign Up</button>
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
                        <button type="submit" class="submit-btn">Login</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Success Message -->
        <div id="successMessage" class="success-message">
            <p>Thank you for signing up! We'll contact you soon.</p>
        </div>
    </div>

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
}

.tagline {
    font-size: 1.2rem;
    color: rgba(255,255,255,0.9);
}

.coming-soon h2 {
    font-size: 2.5rem;
    color: white;
    margin-bottom: 1rem;
}

.coming-soon p {
    font-size: 1.2rem;
    color: rgba(255,255,255,0.9);
    margin-bottom: 2rem;
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

.close {
    position: absolute;
    right: 1rem;
    top: 1rem;
    font-size: 1.5rem;
    cursor: pointer;
    color: #999;
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
    transition: border-color 0.3s ease;
}

.form-group input:focus {
    outline: none;
    border-color: #667eea;
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
    transition: background 0.3s ease;
}

.submit-btn:hover {
    background: #5a6fd8;
}

/* Success Message */
.success-message {
    display: none;
    background: #4CAF50;
    color: white;
    padding: 1rem;
    border-radius: 8px;
    margin-top: 1rem;
    animation: slideIn 0.3s ease;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
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
const closeModal = document.querySelector('.close');
const tabButtons = document.querySelectorAll('.tab-button');
const authForms = document.querySelectorAll('.auth-form');
const signupForm = document.getElementById('signupForm');
const loginForm = document.getElementById('loginForm');
const successMessage = document.getElementById('successMessage');

// Modal functionality
getStartedBtn.addEventListener('click', () => {
    authModal.style.display = 'block';
});

closeModal.addEventListener('click', () => {
    authModal.style.display = 'none';
});

window.addEventListener('click', (event) => {
    if (event.target === authModal) {
        authModal.style.display = 'none';
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
    
    const name = document.getElementById('signupName').value;
    const email = document.getElementById('signupEmail').value;
    const password = document.getElementById('signupPassword').value;
    
    try {
        const { data, error } = await supabase.auth.signUp({
            email: email,
            password: password,
            options: {
                data: {
                    full_name: name
                }
            }
        });
        
        if (error) throw error;
        
        // Show success message
        showSuccessMessage();
        authModal.style.display = 'none';
        signupForm.reset();
        
    } catch (error) {
        alert('Error signing up: ' + error.message);
    }
});

// Login Form Submission
loginForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const email = document.getElementById('loginEmail').value;
    const password = document.getElementById('loginPassword').value;
    
    try {
        const { data, error } = await supabase.auth.signInWithPassword({
            email: email,
            password: password
        });
        
        if (error) throw error;
        
        // Show success message
        showSuccessMessage('Login successful! Welcome back.');
        authModal.style.display = 'none';
        loginForm.reset();
        
    } catch (error) {
        alert('Error logging in: ' + error.message);
    }
});

function showSuccessMessage(message = 'Thank you for signing up! We\'ll contact you soon.') {
    successMessage.querySelector('p').textContent = message;
    successMessage.style.display = 'block';
    
    setTimeout(() => {
        successMessage.style.display = 'none';
    }, 5000);
}

// Check if user is already logged in (optional)
supabase.auth.getSession().then(({ data: { session } }) => {
    if (session) {
        console.log('User is logged in:', session.user.email);
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
- Modern, responsive design
- Sign up and login functionality
- Supabase integration for user management
- Mobile-friendly interface

## Running the Site

After running the setup script, start the local server:

```bash
cd paypaiintl
python3 -m http.server 8000