# EC2 Deployment Setup via GitHub Actions

## Overview

Is document mein GitHub Actions se AWS EC2 pe automatic deployment setup karne ki poori process hai — kya problems aayi, kaise fix kiya, aur kaun se tools/commands use kiye.

---

## Tools & Technologies Used

| Tool | Purpose |
|------|---------|
| `appleboy/ssh-action@v1.2.0` | GitHub Actions se EC2 pe SSH connect karne ke liye |
| `drone-ssh` | SSH action ke andar actual SSH connection handle karta hai |
| AWS EC2 (Ubuntu 24.04) | Deployment server |
| Docker + docker-compose v1.29.2 | App containers run karne ke liye |
| GitHub Secrets | Sensitive values (host, user, key) store karne ke liye |

---

## Problem 1 — SSH Handshake Failed

### Error
```
ssh: handshake failed: ssh: unable to authenticate,
attempted methods [none publickey], no supported methods remain
```

### Cause
`EC2_SSH_KEY` GitHub secret mein private key sahi se paste nahi hua tha — terminal ka shell prompt (`hipster@...`) accidentally copy ho gaya tha key ke saath, jo key ko corrupt kar raha tha.

### Fix — New Dedicated SSH Key Pair Banaya

**Step 1 — Local machine pe new key generate karo**
```bash
ssh-keygen -t ed25519 -f ~/github_actions_key -N ""
```

**Step 2 — Public key copy karo**
```bash
cat ~/github_actions_key.pub
```

**Step 3 — Public key EC2 ke `authorized_keys` mein add karo**
```bash
ssh -i /path/to/LMS.pem ubuntu@15.207.16.178 \
  "echo 'PUBLIC_KEY_CONTENT' >> ~/.ssh/authorized_keys"
```

**Step 4 — Verify EC2 authorized_keys**
```bash
ssh -i LMS.pem ubuntu@15.207.16.178 "cat ~/.ssh/authorized_keys"
```

**Step 5 — GitHub Secret Update karo**
- GitHub → Repo → Settings → Secrets and variables → Actions
- `EC2_SSH_KEY` → Update → Private key content paste karo (`~/github_actions_key` ka content)

**GitHub Secrets set kiye:**

| Secret Name | Value |
|-------------|-------|
| `EC2_HOST` | `15.207.16.178` |
| `EC2_USER` | `ubuntu` |
| `EC2_SSH_KEY` | Private key content (full PEM) |

---

## Problem 2 — EC2 pe `git pull` Fail Ho Raha Tha

### Error
```
git@github.com: Permission denied (publickey)
```

### Cause
EC2 instance pe GitHub ka SSH key authorized nahi tha — `git pull` ke liye EC2 ko GitHub pe authenticate karna padta hai.

### Fix — GitHub Deploy Key Setup

**Step 1 — EC2 pe login karo**
```bash
ssh -i LMS.pem ubuntu@15.207.16.178
```

**Step 2 — EC2 pe deploy key banao**
```bash
ssh-keygen -t ed25519 -C "ec2-deploy" -f ~/.ssh/github_deploy -N ""
```

**Step 3 — Public key copy karo**
```bash
cat ~/.ssh/github_deploy.pub
```

**Step 4 — GitHub repo mein Deploy Key add karo**
- GitHub → Repo → Settings → Deploy keys → Add deploy key
- Title: `EC2 Deploy`
- Key: upar copy kiya hua public key paste karo
- Allow write access: **No** (read-only kaafi hai)

**Step 5 — EC2 SSH config update karo**
```bash
echo -e "Host github.com\n  IdentityFile ~/.ssh/github_deploy\n  IdentitiesOnly yes" >> ~/.ssh/config
```

**Step 6 — Test karo**
```bash
ssh -T git@github.com
# Expected: Hi TanishqGupta12/LMS! You've successfully authenticated...
```

**Step 7 — Git remote SSH URL set karo**
```bash
cd ~/LMS
git remote set-url origin git@github.com:TanishqGupta12/LMS.git
git remote -v
```

**Step 8 — git pull test karo**
```bash
git pull origin main
```

---

## Problem 3 — Docker Compose Command Not Found

### Error
```
docker: unknown command: docker compose
unknown shorthand flag: 'd' in -d
```

### Cause
EC2 pe Docker Compose V2 plugin installed nahi tha. Sirf V1 (`docker-compose` with hyphen) available tha.

### Verify kiya
```bash
docker --version          # Docker version 29.1.3
docker-compose --version  # docker-compose version 1.29.2
docker compose version    # not found
```

### Fix — Workflow mein command update kiya

`.github/workflows/deploy.yml` mein change kiya:

```yaml
# Before (wrong)
docker compose down
docker compose up -d --build

# After (correct)
docker-compose down
docker-compose up -d --build
```

---

## Final Working `deploy.yml`

```yaml
name: Deploy to EC2

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Deploy via SSH
        uses: appleboy/ssh-action@v1.2.0
        with:
          host: ${{ secrets.EC2_HOST }}
          username: ${{ secrets.EC2_USER }}
          key: ${{ secrets.EC2_SSH_KEY }}
          script: |
            cd /home/ubuntu/LMS
            git pull origin main
            docker-compose down
            docker-compose up -d --build
```

---

## Flow Diagram

```
Developer pushes to main
        ↓
GitHub Actions triggers
        ↓
appleboy/ssh-action connects to EC2
(using EC2_HOST, EC2_USER, EC2_SSH_KEY secrets)
        ↓
EC2 pe commands run hote hain:
  1. cd /home/ubuntu/LMS
  2. git pull origin main   ← EC2 GitHub se latest code pull karta hai
  3. docker-compose down    ← purane containers band
  4. docker-compose up -d --build  ← naye containers start
```

---

## Security Notes

- `LMS.pem` ya koi bhi private key publicly share mat karo
- GitHub Personal Access Tokens chat mein share mat karo — agar ho jaaye toh turant delete karo
- `EC2_SSH_KEY` sirf GitHub Actions ke liye dedicated key use karo, apni main key nahi
