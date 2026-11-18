# Bubudex

Bubudex is a personal finance web app (Italian UI) that installs on your phone like a normal app and syncs across devices through your own free Supabase database.

Modules: accounts, transactions, transfers between accounts (giroconti), CSV import from your bank, monthly budget per category, net worth and investment portfolio, savings goals, recurring income/expenses, CSV export and full JSON backup.

## How it works

- Static files hosted on GitHub Pages: `index.html`, `sw.js`, `manifest.webmanifest`, `vendor/supabase.js`, `icons/`.
- Data lives in one Supabase table (`docs`) protected by Row Level Security: each row belongs to your user, and only your login can read or write it.
- Each device keeps a local copy, so the app opens instantly and works offline. Changes you make offline are queued on the device and sent to Supabase when the connection comes back.

## Setup (one time, about 10 minutes)

### 1. Create the database
1. Sign up at https://supabase.com and create a new project (free plan; choose an EU region such as Frankfurt).
2. Open **SQL Editor → New query**, paste the contents of `supabase/schema.sql` and press **Run**.
3. Open **Authentication → URL Configuration** and set **Site URL** to your GitHub Pages address (for example `https://<your-user>.github.io/<repo>/`).
4. Open **Project Settings → API** and copy the **Project URL** and the **anon / publishable key**.

### 2. Publish on GitHub Pages
1. Push this folder to a GitHub repository.
2. In the repo: **Settings → Pages → Build and deployment → Deploy from a branch**, branch `main`, folder `/ (root)`.
3. After about a minute the app is live at `https://<your-user>.github.io/<repo>/`.

### 3. First launch
1. Open the address and paste the Project URL and key (or put them in `config.js` before pushing, so you don't have to type them on every device; this key is designed to be public, and your data stays protected by the RLS policies).
2. Tap **Crea account**, confirm the email, then sign in.
3. Recommended: in Supabase, **Authentication → Sign In / Providers → Email**, turn off **Allow new users to sign up** so nobody else can create an account on your database.

### 4. Install on your phone
- **iPhone (Safari):** Share button → **Add to Home Screen**.
- **Android (Chrome):** menu ⋮ → **Install app** / **Add to Home screen**.

## Updating the app
Edit the files and push. Installed apps pick up the new version the next time they're opened online. If you change the list of files in `sw.js`, also bump `CACHE` (for example `bilancio-v2`).

## Backups
**Impostazioni → Backup completo → Scarica backup** saves everything as JSON. **Ripristina da backup** loads it back (it adds or overwrites, never deletes).
