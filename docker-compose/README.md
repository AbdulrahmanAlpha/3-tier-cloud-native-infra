# 🐳 3-Tier App: Local Docker Compose Environment

This setup allows you to test and develop the app locally before deploying to AWS EKS.

## 🚀 Quick Start

```bash
cd docker-compose
docker-compose up --build
```

Open your local dashboards:

🌐 Web App → http://localhost:8080
⚙️ API → http://localhost:5000
🗃️ pgAdmin → http://localhost:5050
📊 Prometheus → http://localhost:9090
📈 Grafana → http://localhost:3000

## 🧹 Cleanup

```bash
docker-compose down -v
```

## 🧠 Notes

* Matches your production architecture (web → api → db)
* Great for debugging before deploying via Jenkins

---

# 🧩 How It Fits in the Big Picture

| Environment | Use Case | Tool |
|--------------|-----------|------|
| **Local Dev** | Run + debug app on your machine | Docker Compose |
| **Staging** | Integration testing with CI/CD | EKS via Helm |
| **Production** | Fully automated scaling | EKS + Jenkins |

---

# 💡 Pro Tips
- You can add **`.env` overrides** to match staging variables.
- Use **docker-compose.override.yml** for dev-only services like pgAdmin or Mailhog.
- Integrate with **VS Code Dev Containers** for full “plug-and-play” coding environments.

---

# ✅ What You Have Now

✅ A **local 3-tier replica** of your production app  
✅ Shared `.env` for consistent config  
✅ Ready-to-test setup before Jenkins CD runs  
