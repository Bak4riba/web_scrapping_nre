@echo off
cd /d "%~dp0"

echo [%date% %time%] Iniciando atualizacao...

:: Roda o scraping
python main.py

:: Faz o commit e push do dados.json
git add dados.json
git diff --cached --quiet && (
    echo [%date% %time%] Nenhuma mudanca encontrada.
) || (
    git commit -m "Atualiza dados.json %date%"
    git push
    echo [%date% %time%] Dados atualizados e enviados para o GitHub!
)

echo [%date% %time%] Concluido.