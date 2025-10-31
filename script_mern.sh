#!/bin/bash
# ============================================================
# Script de instalação e configuração da Stack MERN no Linux Mint
# (sem instalação do VS Code)
# Autor: Anderson dos Reis Barros (adaptado por ChatGPT)
# ============================================================

# Atualização do sistema
echo "🚀 Atualizando sistema..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git wget gnupg

# ------------------------------------------------------------
# Node.js (LTS) e npm
# ------------------------------------------------------------
echo "🟢 Instalando Node.js (versão LTS) e npm..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
echo "✅ Node.js instalado: $(node -v)"
echo "✅ npm instalado: $(npm -v)"

# ------------------------------------------------------------
# MongoDB (versão 7.0)
# ------------------------------------------------------------
echo "🍃 Instalando MongoDB..."
wget -qO - https://pgp.mongodb.com/server-7.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-7.0.gpg
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt update
sudo apt install -y mongodb-org

# Inicia e habilita o serviço do MongoDB
sudo systemctl start mongod
sudo systemctl enable mongod
echo "✅ MongoDB instalado e em execução!"
sudo systemctl status mongod --no-pager | head -n 10

# ------------------------------------------------------------
# Teste rápido da stack (estrutura de projeto inicial)
# ------------------------------------------------------------
echo "🧱 Criando estrutura de projeto MERN de teste..."
mkdir -p ~/mern-test/{backend,frontend}
cd ~/mern-test/backend
npm init -y
npm install express mongoose cors dotenv
echo 'import express from "express";
import mongoose from "mongoose";
import cors from "cors";
import dotenv from "dotenv";

dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());

app.get("/", (req, res) => res.send("API MERN funcionando 🚀"));
app.listen(5000, () => console.log("Servidor rodando na porta 5000"));' > index.js

# ------------------------------------------------------------
# Finalização
# ------------------------------------------------------------
echo ""
echo "✅ Instalação completa!"
echo "📂 Projeto de teste criado em: ~/mern-test"
echo "➡ Para testar o backend:"
echo "   cd ~/mern-test/backend && node index.js"
echo "➡ Depois acesse http://localhost:5000"
echo ""
echo "🌐 Para iniciar o front-end React:"
echo "   cd ~/mern-test && npx create-react-app frontend && cd frontend && npm start"
echo ""
echo "🚀 Ambiente MERN pronto para uso!"
