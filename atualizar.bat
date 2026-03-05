@echo off
cd /d "%~dp0"

echo [%date% %time%] Iniciando atualizacao...

:: Roda o scraping
python main.py

:: Mostra status do git para debug
echo Status do git:
git status

:: Faz o commit e push do dados.json
git add dados.json
git status

git diff --cached --quiet && (
    echo Nenhuma mudanca detectada no dados.json.
) || (
    git commit -m "Atualiza dados.json %date%"
    git push
    echo [%date% %time%] Dados enviados para o GitHub!
)

echo [%date% %time%] Concluido.
pause