# NRE Data Automation - Web Scraping

Automação para coleta, processamento e publicação de dados do site do Núcleo Regional de Educação (NRE) de Telêmaco Borba.

O sistema realiza a coleta periódica de PDFs disponibilizados para professores PSS, extrai as informações relevantes e disponibiliza os dados em formato JSON para consumo por uma aplicação web.

## Objetivo

O projeto foi criado para facilitar o acesso às informações publicadas no site do NRE, automatizando a coleta e organização dos dados para professores que participam do processo seletivo PSS.

## Possíveis melhorias futuras

- API para consulta dos dados
- Dashboard para visualização das aulas
- Deploy automatizado do pipeline
- Notificação quando novas aulas forem publicadas

## Arquitetura do Projeto

Site NRE  
↓  
Web Scraping (Python)  
↓  
Download de PDFs  
↓  
Extração e processamento dos dados  
↓  
Geração de JSON  
↓  
Commit automático no GitHub  
↓  
Site consome os dados atualizados

## Funcionalidades

- Coleta automática de PDFs publicados no site do NRE
- Extração de informações sobre aulas disponíveis
- Conversão e estruturação dos dados em JSON
- Detecção de alterações nos dados
- Atualização automática do repositório apenas quando há mudanças
- Integração com site estático que consome os dados

## Automação

O script é executado automaticamente a cada **2 horas** através de tarefas agendadas no sistema operacional.

Fluxo da automação:

1. Executa o web scraping
2. Baixa e analisa os PDFs disponíveis
3. Extrai as informações relevantes
4. Gera um arquivo JSON atualizado
5. Verifica se houve mudanças
6. Caso haja alteração, realiza commit e push no GitHub
7. O site consome automaticamente os dados atualizados

## Tecnologias Utilizadas

- Python
- Web Scraping
- Manipulação de PDFs
- JSON
- Git
- Automação com tarefas agendadas

## Estrutura do Projeto
web_scrapping_nre
│
├── scraper.py
├── parser.py
├── data.json
├── site/
└── README.md


