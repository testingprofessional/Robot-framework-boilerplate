# Maak een virtual environment aan
python -m venv .venv

# Activeer de omgeving (Windows Powershell)
.venv\Scripts\Activate.ps1

pip install robotframework robotframework-browser
rfbrowser init

# Project op andere omgeving installeren
pip install -r requirements.txt
rfbrowser init