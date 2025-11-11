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