## Web Scrapping site PSS

Bom, nesse projeto desenvolvi exatamente para resolver um problema pessoal meu: **Que era precisar fazer download de todos os PDFs disponíveis no site do NRE da minha cidade**
Esses pdfs servem para nós professores PSS sabermos quais as aulas estão indo para a distribuição.

Nele eu faço um web scrapping dos pdfs, analiso os pdfs mais recentes e então pretendo publicar em um site estático para facilitar a vida de todos os professores da minha cidade
# 🏫 PSS Aulas — NRE Telêmaco Borba

**Automação completa para coleta, processamento e publicação de dados educacionais públicos.**

Professores PSS do município de Telêmaco Borba (PR) precisam acompanhar diariamente PDFs publicados pelo Núcleo Regional de Educação para saber quais aulas estão disponíveis para distribuição. O processo manual exige acessar o site, baixar o arquivo, abrir o PDF e procurar a disciplina de interesse — todo dia.

Este projeto elimina esse processo com um pipeline automatizado de ponta a ponta: do scraping ao site publicado.

🌐 **[Acesse o site](https://bak4riba.github.io/ws_pss)**

---

## O que o sistema faz

1. **Coleta** — acessa o site do NRE e baixa apenas os PDFs publicados nos últimos 3 dias
2. **Extrai** — lê as tabelas de distribuição de aulas dentro dos PDFs com `pdfplumber`
3. **Processa** — deduplica registros, preserva anotações especiais e normaliza os dados
4. **Publica** — gera um `dados.json` e atualiza o site automaticamente via Git

Tudo isso roda no computador local de forma agendada, sem depender de servidores pagos.

---

## Stack utilizada

| Camada | Tecnologia |
|--------|-----------|
| Scraping | Python · `requests` · `BeautifulSoup` |
| Extração de PDF | `pdfplumber` |
| Dados | JSON |
| Frontend | HTML · CSS · JavaScript puro |
| Hospedagem | GitHub Pages |
| Automação | Windows Task Scheduler · `.bat` |

---

## Arquitetura

```
┌─────────────────────────────────────────────────┐
│           Windows Task Scheduler                │
│         (executa 2x ao dia, local)              │
└────────────────────┬────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────┐
│                  main.py                        │
│                                                 │
│  1. POST → site do NRE (session + cookies)      │
│  2. Filtra PDFs dos últimos 3 dias              │
│  3. Baixa apenas arquivos novos                 │
│  4. Extrai tabelas com extractor.py             │
│  5. Deduplica por escola + disciplina           │
│  6. Salva dados.json                            │
└────────────────────┬────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────┐
│            git commit + push                    │
│         GitHub Pages serve o site              │
└─────────────────────────────────────────────────┘
```

---

## Desafios técnicos resolvidos

**Sessão autenticada** — o site do NRE exige uma sequência de requests POST com cookies de sessão para liberar os arquivos. Foi necessário mapear o fluxo de autenticação via DevTools do navegador.

**PDFs sem estrutura padrão** — as tabelas variam entre PDFs: algumas têm duas disciplinas lado a lado, outras têm linhas extras vazias antes dos cabeçalhos, outras misturam notações especiais (`*6`, `6 subst.`) nos valores numéricos. O extrator trata cada caso individualmente.

**Deduplicação temporal** — como aulas não distribuídas reaparecem no PDF do dia seguinte somadas às novas, o sistema mantém apenas o registro mais recente para cada par `escola + disciplina`, evitando contagem duplicada.

**Bloqueio de IP em CI/CD** — o site do governo bloqueia requisições vindas de servidores de nuvem (GitHub Actions). A solução foi mover a execução para o ambiente local do usuário, mantendo apenas o GitHub Pages para hospedagem estática.

---

## Estrutura do projeto

```
ws_pss/
├── main.py          # Pipeline principal: scraping → extração → JSON
├── extractor.py     # Parser de PDFs com lógica de normalização
├── downloader.py    # Download dos arquivos com controle de sessão
├── index.html       # Interface web com filtros dinâmicos
├── atualizar.bat    # Script de automação local com push automático
└── dados.json       # Dados gerados (atualizado automaticamente)
```

---

## Como rodar localmente

```bash
# Clone o repositório
git clone https://github.com/Bak4riba/ws_pss.git
cd ws_pss

# Instale as dependências
pip install requests beautifulsoup4 pdfplumber

# Execute o pipeline
python main.py

# Visualize o site (requer Live Server ou servidor local)
python -m http.server 8000
# Acesse http://localhost:8000
```

---

## Resultado

O site exibe os dados em cards organizados por data, com filtros por disciplina, escola e município. Professores conseguem verificar em segundos se há aulas disponíveis na sua área, sem precisar baixar ou abrir nenhum PDF.

---

*Desenvolvido por Matheus — Telêmaco Borba, PR*