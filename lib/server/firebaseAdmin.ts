import * as admin from 'firebase-admin'
import { getApps, initializeApp } from 'firebase-admin/app'
import { getAuth } from 'firebase-admin/auth'

const apps = getApps()

export const firebaseAdmin =
  apps[0] ??
  initializeApp({
    credential: admin.credential.cert({
      privateKey: process.env.FIREBASE_PRIVATE_KEY 
        ? process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, '\n') 
        : undefined,
      clientEmail: process.env.FIREBASE_CLIENT_EMAIL || undefined,
      projectId: process.env.FIREBASE_PROJECT_ID || undefined,
    }),
  })

export const firebaseAdminAuth = getAuth()
