-- =============================================================================
-- Sentinel AI: Cloud IDS & IPS Security Command Center
-- Supabase PostgreSQL Schema & Realtime Setup
-- =============================================================================

-- 1. Create the `network_threats` table
CREATE TABLE IF NOT EXISTS public.network_threats (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    source_ip TEXT NOT NULL,
    origin_country TEXT NOT NULL,
    attack_type TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'Active' CHECK (status IN ('Active', 'Blocked'))
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE public.network_threats ENABLE ROW LEVEL SECURITY;

-- 3. Create RLS Policies for Anon & Authenticated access (For Hackathon frontend direct access)
CREATE POLICY "Allow public read access"
    ON public.network_threats
    FOR SELECT
    TO anon, authenticated
    USING (true);

CREATE POLICY "Allow public insert"
    ON public.network_threats
    FOR INSERT
    TO anon, authenticated
    WITH CHECK (true);

CREATE POLICY "Allow public update"
    ON public.network_threats
    FOR UPDATE
    TO anon, authenticated
    USING (true)
    WITH CHECK (true);

-- 4. Enable Replica Identity (Ensures all columns are broadcast during updates in Realtime)
ALTER TABLE public.network_threats REPLICA IDENTITY FULL;

-- 5. Enable Supabase Realtime publication for the table
ALTER PUBLICATION supabase_realtime ADD TABLE public.network_threats;

-- 6. Insert realistic initial threat telemetry seed data
INSERT INTO public.network_threats (source_ip, origin_country, attack_type, status, created_at)
VALUES
    ('185.220.101.5', 'RU', 'DDoS SYN Flood', 'Active', now() - INTERVAL '2 minutes'),
    ('45.154.255.89', 'CN', 'SQL Injection (Union Based)', 'Active', now() - INTERVAL '5 minutes'),
    ('103.251.167.20', 'KP', 'Zero-Day Remote Code Execution', 'Blocked', now() - INTERVAL '12 minutes'),
    ('194.26.29.112', 'IR', 'SSH Brute Force', 'Blocked', now() - INTERVAL '18 minutes'),
    ('198.51.100.42', 'US', 'Cross-Site Scripting (XSS)', 'Blocked', now() - INTERVAL '25 minutes'),
    ('91.240.118.172', 'BR', 'API Credential Stuffing', 'Blocked', now() - INTERVAL '31 minutes');
