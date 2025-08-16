// Firebase configuration template (PUBLIC ONLY)
// Do NOT put secrets here.

const firebaseConfig = {
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_PROJECT_ID.appspot.com",
    messagingSenderId: "YOUR_SENDER_ID",
    appId: "YOUR_APP_ID"
};

const googleSignInConfig = {
    clientId: "562894717464-247kcid63jgl1nv9li1tnsk0bsuqhskr.apps.googleusercontent.com",
    scopes: [
        'https://www.googleapis.com/auth/cloud-platform',
        'https://www.googleapis.com/auth/firebase'
    ]
};

window.firebaseConfig = firebaseConfig;
window.googleSignInConfig = googleSignInConfig;
