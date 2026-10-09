# 🛡️ Sentinel AI — Cloud IDS & IPS Security Command Center

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new)
![Supabase](https://img.shields.io/badge/Database-Supabase%20Postgres-3ECF8E?logo=supabase&logoColor=white)
![TailwindCSS](https://img.shields.io/badge/Styling-Tailwind%20CSS-38B2AC?logo=tailwind-css&logoColor=white)
![Hosting](https://img.shields.io/badge/Hosting-Vercel-000000?logo=vercel&logoColor=white)
![Realtime](https://img.shields.io/badge/WebSockets-Supabase%20Realtime-brightgreen)

> An enterprise-grade, real-time Cloud Intrusion Detection & Prevention System (IDS/IPS) built for hackathons. Features automated threat neutralization, live WebSocket telemetry, AI-powered heuristic assessments, and an adaptive dual-theme interface.

---

## 🌟 Key Features

- **⚡ Real-Time Threat Telemetry**: Instant bi-directional WebSocket syncing powered by **Supabase Realtime**. New intrusion attempts appear live across all connected client devices without page reloads.
- **🤖 Autonomous IPS (Auto-Defense Mode)**: When armed, newly simulated attacks are analyzed and neutralized (`Blocked`) automatically within 2 seconds.
- **🧠 Sentinel AI Threat Analyst ("Ask AI")**: Provides instant contextual threat intelligence, MITRE ATT&CK technique mapping (e.g., T1498 DDoS, T1190 SQLi, Zero-Day RCE), severity scoring, and dynamic firewall drop rules (`iptables` / `eBPF`).
- **🎨 Dual-Personality Interface**:
  - **Hacker Dark Mode**: Deep obsidian backdrop, glowing neon accents (`#00ff9d` green, `#00f0ff` cyan, `#ff0055` crimson), radar pulses, and CRT scanlines.
  - **Corporate Light Mode**: Polished, professional SaaS dashboard with clean slate palettes and crisp contrast.
- **💥 Attack Simulator**: Generate synthetic network anomalies (DDoS SYN Floods, SQL Injection, Zero-Day Exploits, Credential Stuffing, Ransomware beacons) across global IP vectors.
- **📊 Incident Audit Export**: Download filtered or full security event telemetry in standard RFC-4180 CSV format.

---

## 🏗️ Architecture & Technology Stack

```
[ Inbound Network Traffic ] ──► [ Sentinel AI Neural Filter ]
                                          │
                 ┌────────────────────────┴────────────────────────┐
                 ▼                                                 ▼
     [ Supabase PostgreSQL ]                           [ Edge Client Dashboard ]
     - `network_threats` table                         - Tailwind CSS (CDN)
     - Row Level Security (RLS)                        - Vanilla JS (Zero Build Tools)
     - Realtime Replication Publication                - Lucide Icon System
                 │                                                 ▲
                 └────────── WebSocket Event Stream ───────────────┘
                              (Hosted on Vercel)
```

| Layer | Technology | Purpose |
| :--- | :--- | :--- |
| **Frontend** | Vanilla JavaScript + Tailwind CSS CDN | High-performance, single-file dashboard with zero build steps |
| **Icons** | Lucide Icons | Sleek, vector-rendered cybersecurity indicators |
| **Database** | Supabase (PostgreSQL 15+) | Cloud telemetry storage & historical audit logging |
| **Realtime** | Supabase WebSockets | Push notifications for new intrusions & quarantine state changes |
| **Hosting** | Vercel Edge Network | Sub-millisecond global CDN hosting |
| **VCS** | GitHub | Continuous Deployment (CI/CD) trigger |

---

## 🚀 Quick Start Guide

### 1. Database Setup (Supabase)

1. Create a free account at [Supabase](https://supabase.com) and create a new project.
2. Navigate to **SQL Editor** in the left sidebar.
3. Open [`schema.sql`](./schema.sql), paste the SQL commands into the editor, and click **Run**.
4. Go to **Project Settings** &rarr; **API** and copy:
   - **Project URL** (`https://<project-ref>.supabase.co`)
   - **anon / public key** (`eyJ...`)

### 2. Configure Credentials in `index.html`

Open [`index.html`](./index.html) and locate the `SUPABASE_CONFIG` object (around line 415):

```javascript
const SUPABASE_CONFIG = {
  ENABLED: true, // Set to true
  URL: 'https://YOUR_PROJECT_ID.supabase.co', // Paste your Project URL
  ANON_KEY: 'YOUR_SUPABASE_ANON_PUBLIC_KEY',  // Paste your Anon Key
};
```

### 3. Run Locally

Simply double-click `index.html` or open it with VS Code Live Server. No `npm install` or compilation step required!

---

## 🌐 Deploy to Vercel via GitHub

### Step 1: Initialize Git & Push to GitHub

In your project directory, run:

```bash
# Initialize repository
git init

# Stage and commit files
git add index.html schema.sql README.md
git commit -m "feat: sentinel ai cloud command center release"

# Rename branch to main
git branch -M main

# Link to your remote GitHub repository
git remote add origin https://github.com/YOUR_USERNAME/sentinel-ai-ids.git

# Push code
git push -u origin main
```

### Step 2: Deploy on Vercel

1. Log in to [Vercel](https://vercel.com) using your GitHub account.
2. Click **Add New...** &rarr; **Project**.
3. Import `sentinel-ai-ids`.
4. Framework Preset: **Other** (Static HTML).
5. Click **Deploy**. Your dashboard will be live at `https://sentinel-ai-ids.vercel.app` in under 15 seconds!

---

## 🏆 Hackathon Presentation & Demo Walkthrough

When presenting this project to judges:

1. **Multi-Screen Realtime Sync**:
   - Open your live Vercel URL on a laptop and on your smartphone.
   - Click **"Simulate Attack"** on the laptop. Show the judges how the threat appears on the phone screen instantaneously via Supabase WebSockets.
2. **Showcase Autonomous IPS**:
   - Show that **Auto-Defense** is **ARMED**.
   - Watch the active threat turn into **Blocked** after 2 seconds with an automatic mitigation flash.
3. **Trigger AI Remediation**:
   - Click **"Ask AI"** on any threat row.
   - Explain that Sentinel AI identifies the MITRE ATT&CK vector and automatically scripts an `iptables` drop rule for immediate edge execution.
4. **Theme Switch**:
   - Toggle between **Hacker Dark Mode** and **Corporate Light Mode** to demonstrate attention to UI/UX design.

---

## 📜 Database Schema Reference

Table: `public.network_threats`

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | `UUID` | `PRIMARY KEY`, Default `gen_random_uuid()` | Unique event ID |
| `created_at` | `TIMESTAMPTZ` | `DEFAULT now()`, `NOT NULL` | Timestamp of breach attempt |
| `source_ip` | `TEXT` | `NOT NULL` | Ingress IPv4 address |
| `origin_country` | `TEXT` | `NOT NULL` | ISO 3166-1 alpha-2 country code |
| `attack_type` | `TEXT` | `NOT NULL` | Vector classification (e.g. DDoS, SQLi, RCE) |
| `status` | `TEXT` | Check `('Active', 'Blocked')` | Current IPS state |

---

## 🛡️ License

MIT License &mdash; Free for academic, personal, and hackathon use.
