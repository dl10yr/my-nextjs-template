import { NextResponse } from 'next/server'

export async function GET() {
  // 機密情報を含まないFirebase関連の環境変数のみを返す
  const envVars = {
    FIREBASE_PROJECT_ID: process.env.FIREBASE_PROJECT_ID || 'not set',
    FIREBASE_CLIENT_EMAIL: process.env.FIREBASE_CLIENT_EMAIL ? 'set but not shown' : 'not set',
    FIREBASE_PRIVATE_KEY: process.env.FIREBASE_PRIVATE_KEY ? 'set but not shown' : 'not set'
  }

  return NextResponse.json({ status: 'ok', envVars })
}