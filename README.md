# Maak een virtual environment aan
python -m venv .venv

# Activeer de omgeving (Windows Powershell)
.venv\Scripts\Activate.ps1

pip install robotframework robotframework-browser

rfbrowser init

# Project op andere omgeving installeren
pip install -r requirements.txt

rfbrowser init

________________________________________________________________________

# Robot Framework UI & API Testproject

Dit project bevat geautomatiseerde testsuites geschreven in **Robot Framework**:
* **UI-testen (`webshop_test.robot`):** End-to-end browsertesten voor de oefenwebshop [Sauce Demo](https://saucedemo.com) met de **Browser library** (Playwright).
* **API-testen (`api_test.robot`):** Geautomatiseerde REST API-testen voor [DummyJSON](https://dummyjson.com) met de **RequestsLibrary**.

---

## Vereisten

Zorg dat de volgende software op je systeem is geïnstalleerd voordat je begint:

* **Python** (versie 3.10 of hoger)
* **Node.js** (benodigd voor de onderliggende Playwright-engine van de Browser library)
* **Visual Studio Code** met de extensie **RobotCode - Robot Framework Support**

---

## Installatie op een nieuwe omgeving

Volg onderstaande stappen om het project lokaal op te zetten en alle afhankelijkheden te installeren.

### 1. Project binnenhalen
Clone de repository en navigeer naar de projectmap:

```bash
git clone <jouw-repository-url>
cd RF_test_local
```

### 2. Virtual environment (`.venv`) aanmaken en activeren
Maak een geïsoleerde Python-omgeving aan zodat pakketten niet conflicteren met andere projecten.

* **Windows (PowerShell):**
  ```powershell
  python -m venv .venv
  .venv\Scripts\Activate.ps1
  ```
* **Mac / Linux:**
  ```bash
  python3 -m venv .venv
  source .venv/bin/activate
  ```

### 3. Dependencies en browsers installeren
Installeer de benodigde Python-pakketten (inclusief `robotframework`, `robotframework-browser` en `robotframework-requests`) en initialiseer de Playwright-browsers:

```bash
pip install -r requirements.txt
rfbrowser init
```

### 4. VS Code configureren
1. Open de projectmap in **Visual Studio Code**.
2. Druk op `Ctrl+Shift+P` (`Cmd+Shift+P` op Mac) en kies **Python: Select Interpreter**.
3. Selecteer de Python-interpreter uit de map **`.venv`**.

---

## Testen uitvoeren

Je kunt de testen op twee manieren starten:

* **Via Visual Studio Code:** Open `webshop_test.robot` of `api_test.robot` en klik op de groene play-knop naast `*** Test Cases ***` (voor de hele suite) of naast een individuele testcase.
* **Via de terminal:**
  ```bash
  # Alle testbestanden in de map uitvoeren
  robot .

  # Alleen de UI-testen uitvoeren
  robot webshop_test.robot

  # Alleen de API-testen uitvoeren
  robot api_test.robot
  ```

Na het uitvoeren genereert Robot Framework automatisch de testrapporten (`report.html`, `log.html` en `output.xml`) in de hoofdmap. Open **`report.html`** in je browser voor een gedetailleerd overzicht van de testresultaten.

---

## Opbouw van de testsuites

### 1. UI-testen (`webshop_test.robot`)
Deze testsuite gebruikt de **Browser library** (Playwright) en maakt slim gebruik van browser-contexten voor snelle, geïsoleerde testen:

* **`*** Settings ***`:** Opent eenmaal de Chromium-browser via `Suite Setup`, logt vóór elke test in via `Test Setup` (`Open Webshop En Log In`), sluit na elke test de geïsoleerde sessie via `Test Teardown` (`Close Context`) en sluit aan het eind de browser via `Suite Teardown`.
* **`*** Variables ***`:** Bevat centrale variabelen zoals `${URL}`, `${USERNAME}` en `${PASSWORD}`.
* **`*** Test Cases ***`:**
  * **`Product Toevoegen Aan Winkelwagen`:** Voegt een rugzak toe aan de winkelwagen en controleert of de teller (`css=.shopping_cart_badge`) op `1` staat.
  * **`Producten Sorteren Op Prijs Laag Naar Hoog`:** Sorteert via de dropdown (`Select Options By`) op prijs van laag naar hoog (`lohi`) en verifieert met `>> nth=0` dat het goedkoopste product (*Sauce Labs Onesie* voor *$7.99*) bovenaan staat.
* **`*** Keywords ***`:** Bevat het herbruikbare keyword `Open Webshop En Log In` dat een schone browser-context opent, inlogt en controleert of de productpagina is geladen.

### 2. API-testen (`api_test.robot`)
Deze testsuite gebruikt **RequestsLibrary** en **Collections** om HTTP-verzoeken te testen zonder browser:

* **`*** Settings ***`:** Maakt via `Suite Setup` eenmaal een herbruikbare API-sessie (`Create Session`) aan naar `${BASE_URL}`.
* **`*** Variables ***`:** Bevat de basis-URL `https://dummyjson.com`.
* **`*** Test Cases ***`:**
  * **`Product Ophalen Via GET Request`:** Haalt product `1` op via `GET On Session`, controleert HTTP-status `200`, en verifieert de producttitel en dat de prijs groter is dan `0`.
  * **`Nieuw Product Aanmaken Via POST Request`:** Stuurt een JSON-dictionary via `POST On Session` naar `/products/add`, controleert HTTP-status `201` en verifieert de teruggegeven titel.
  * **`Niet Bestaand Product Geeft 404 Foutmelding`:** Vraagt een niet-bestaand ID op met `expected_status=404` om te verifiëren dat de API netjes een `404`-foutcode teruggeeft.
