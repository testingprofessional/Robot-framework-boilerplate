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

# Robot Framework Webshop Testproject

Dit project bevat geautomatiseerde end-to-end UI-testen voor de oefenwebshop [Sauce Demo](https://saucedemo.com), geschreven in **Robot Framework** met behulp van de **Browser library** (Playwright).

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
Installeer de benodigde Python-pakketten en initialiseer de Playwright-browsers:

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

* **Via Visual Studio Code:** Open `webshop_test.robot` en klik op de groene play-knop naast `*** Test Cases ***` (voor alle testen) of naast een individuele testcase.
* **Via de terminal:**
  ```bash
  robot webshop_test.robot
  ```

Na het uitvoeren genereert Robot Framework automatisch de testrapporten (`report.html`, `log.html` en `output.xml`) in de hoofdmap. Open **`report.html`** in je browser voor een gedetailleerd overzicht van de testresultaten.

---

## Opbouw van de testcase (`webshop_test.robot`)

Het testbestand is gestructureerd volgens de standaardindeling van Robot Framework en maakt slim gebruik van browser-contexten voor snelle, geïsoleerde testen:

### 1. `*** Settings ***` (Configuratie & Lifecycle)
* **`Library Browser`:** Laadt de Playwright-gebaseerde Browser library.
* **`Suite Setup`:** Opent eenmaal de Chromium-browser (`headless=False` zodat je meekijkt) voor de gehele testsuite.
* **`Test Setup`:** Voert vóór elke testcase automatisch het keyword `Open Webshop En Log In` uit.
* **`Test Teardown`:** Sluit na elke testcase de browser-context (`Close Context`) zodat cookies en winkelwageninhoud worden gewist.
* **`Suite Teardown`:** Sluit de volledige browser af nadat alle testen zijn afgerond.

### 2. `*** Variables ***` (Testdata)
Bevat centrale variabelen zoals `${URL}`, `${USERNAME}` en `${PASSWORD}`, zodat wijzigingen op één plek beheerd worden.

### 3. `*** Test Cases ***` (Testscenario's)
* **`Product Toevoegen Aan Winkelwagen`:** Klikt bij een product op *Add to cart* en controleert of het winkelwagen-icoon (`css=.shopping_cart_badge`) exact de waarde `1` toont.
* **`Producten Sorteren Op Prijs Laag Naar Hoog`:** Selecteert in de sorteer-dropdown (`Select Options By`) de optie `lohi` en verifieert met `>> nth=0` dat het bovenste artikel het goedkoopste product is (*Sauce Labs Onesie* voor *$7.99*).

### 4. `*** Keywords ***` (Herbruikbare acties)
* **`Open Webshop En Log In`:** Opent een schone sessie (`New Context`), navigeert naar de webshop (`New Page`), vult de inloggegevens in en controleert of de overzichtspagina (*Products*) succesvol is geladen.
