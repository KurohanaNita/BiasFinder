// src/types/express.d.ts
// MARCHE PAS DEMANDER AU PROF ....
declare namespace Express {
  interface User {
    email: string;
    oauthId: string;
    provider: string;
  }

  interface Request {
    user?: User;
  }
}

export {};
