// src/app/login/page.tsx

'use client';

import React from 'react';

export default function LoginPage() {
    const handleGoogleLogin = () => {
        window.location.href = '/api/auth/google';
    };

    return (
        <div style={{ display: 'flex', height: '100vh', justifyContent: 'center', alignItems: 'center', flexDirection: 'column' }}>
            <h1>Connexion</h1>
            <button
                onClick={handleGoogleLogin}
                style={{
                    padding: '10px 20px',
                    fontSize: '16px',
                    cursor: 'pointer',
                    borderRadius: '5px',
                    border: '1px solid #ccc',
                    backgroundColor: '#fff'
                }}
            >
                Connexion avec Google
            </button>
        </div>
    );
}
