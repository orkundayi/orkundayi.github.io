// Firebase configuration template
// This file will be automatically populated when using Google Sign-In
// Users can also manually configure their Firebase project here

// Default configuration (will be overridden by Google Sign-In)
const firebaseConfig = {
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_PROJECT_ID.appspot.com",
    messagingSenderId: "YOUR_SENDER_ID",
    appId: "YOUR_APP_ID"
};

// Google Sign-In configuration
const googleSignInConfig = {
    clientId: "562894717464-247kcid63jgl1nv9li1tnsk0bsuqhskr.apps.googleusercontent.com",
    clientSecret: "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",
    scopes: [
        'https://www.googleapis.com/auth/cloud-platform',
        'https://www.googleapis.com/auth/firebase'
    ]
};

// Service Account configuration
const serviceAccountConfig = {
    type: "service_account",
    project_id: "flulog-468804",
    private_key_id: "cf80865f830844c3ef8aea15363c507a042c84e0",
    private_key: "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZWELObuwu1Fti\n+WL0CSAiJ1xF99qchQ4w1LES0gBmk6JnXKy+9tBdwx8fLg4YAZ2pSZNuolcOzQ20\nGPuyHyzAZ/2X38DwuIML97Bwnhw2P7LrSwLHmUS1pudx0kSwTghzG901aMnYN/aL\n4/fGUCFQCqOVJnzsSHdOv/bG80uH5w021v2MhSzfm0Eo3ux4eAUhwrLicxNbllm6\nWEN/jimSPw1C9OpJX6+7/qD+JoO2PkqWJ+vuAP54AnfceTgy0pRM2gaPa0oqOdnt\nk0x1+t6SVnAJe94eyw0+ykRfK8TXo/mbKqPfv9EmEtgia7tC9khyeGEqNhZXat2E\ns3+4NuqzAgMBAAECggEAJwTK3Y+ZVCDolSCrbJ80xxzk2mTQONhEP2z3qybLTp8D\ngWXoV1Is/yA39puIiTPFD663Sp3XXj9eze3MReKF4LbqlnjjhPPDBwN9CALCktSl\ntMsfISE5bhkcJNl4XmRr7OpcMKnyzp/hYaTYByC8kkeOrYie1bZ+wMMCtR3Zefii\no6uiOqiriRWqHrtVHGbwZ+zQ3T5q6HKfOSN8NP0Pi3tEowAh8azG4T7gH4AYoGvm\nlqWo5WA5rVpJVvorkxcugSh6C36jbp5UedaXooQl/gJJYGzSUOgVPKZmY0GaMdec\nYTMCjuF0kCw06HmgGu8CP4BzfJ9d6TPoMjQ7jRdPvQKBgQD3LWdYKwlnWCaj9a1W\nf5JtaF3R5jlJjqEODcpr3T3dzSL3AtyQ/Qio6gBFp9Ie6jAQdPWMLPakYvFsSd3c\nWysABguNFRCffd256JDkqP28iy96QkNcnQMz3WH2mDxS0sgRQQdHlnGYpPvFXjAM\n9xGDaw2rD0tKKwkF2bZoI8AUzQKBgQDhGkKpla80XI3h1CG3Zi2QLUwDcEeUc530\nANTKFDxJzMXVYeFYLow21Hq4dJ+nWyZjw3o1efl0ifnYr0M8TwFld3K5qo5jaJOK\nwJwm3vSG+ST+UFazlEnabkOFK8DyzxZH63Gp8ea3c52gVZ92toebRizMNdBcNpzX\nyQGO1Nb9fwKBgEmOknWTgR3nBsC+SNI37qxuZZUkTSINtvIGupl04odSF7ioelkP\nY/dYg7I26fnXOWx8UeJgMxnic/QE22hLHTXJlsBqZ2L/Qu+jPRM/Ext71Cou8/ro\not5ZYGDRFwqSvYUc8/yi0bVaS66FhAknsWeJgSzJxV8SBYJfMsA0+2F1AoGBAKAl\n8Lt6NPZJyt+Z7orudQgYUfY4UZS6VOweE0XZ87KFr1JKmuoD49m2fcDxqAyG+t8L\nWczmBKX26/xPZMRpaRLpUoPpZfgvlJiow++bu9izNLCCM8z7eTegLwV1xYZ58t4k\nEe/YnE50QParNBJfdkbwPDrlJmIUsK2M4kDeCD69AoGAL99xW/7qP3UwmP/w1rt7\noPQxHyNih+bx8MLUVUa0FHKV0I7EyVn2sA0TDx5RZF64sDE2Kd2vhZEUhsoGl3vF\nCvkomufReeYsO0NaHo2Wh3FQzyxV0X8OpUchSBkWOuDxMDze9SKevMkQHRQFEmI0\nxNGPEGP6ok/HSQmqfIGz72I=\n-----END PRIVATE KEY-----\n",
    client_email: "flulogaccess@flulog-468804.iam.gserviceaccount.com",
    client_id: "113630777453796784402",
    auth_uri: "https://accounts.google.com/o/oauth2/auth",
    token_uri: "https://oauth2.googleapis.com/token",
    auth_provider_x509_cert_url: "https://www.googleapis.com/oauth2/v1/certs",
    client_x509_cert_url: "https://www.googleapis.com/robot/v1/metadata/x509/flulogaccess%40flulog-468804.iam.gserviceaccount.com",
    universe_domain: "googleapis.com"
};

// Export configurations for use in Flutter
window.firebaseConfig = firebaseConfig;
window.googleSignInConfig = googleSignInConfig;

// Debug logging
console.log('Firebase config loaded:', window.firebaseConfig);
console.log('Google Sign-In config loaded:', window.googleSignInConfig);

// Helper function to update Firebase config dynamically
window.updateFirebaseConfig = function (newConfig) {
    Object.assign(window.firebaseConfig, newConfig);
    console.log('Firebase configuration updated:', window.firebaseConfig);
};
