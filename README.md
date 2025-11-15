# Overview
Questo progetto consente a un utente di inserire un'email e visualizzare gli ordini associati a un cliente presenti nel database.  
Il database MySQL contiene dati relativi a **utenti**, **prodotti** e **ordini**.

La web app è composta da due parti:
- **frontend** → Vue 3 + Vite
- **backend** → PHP + MySQL (API REST)

Funzionalità principali:
- Ricerca ordini per email cliente
- Visualizzazione tabella ordini

# Struttura progetto
watuppa_project/<br>
│<br>
├── frontend/<br>
├── backend/<br>
└── README.md

# Requisiti 
Essenziali:
- PHP 8.x
- MySQL 8.0.x
- Node.js 22.x 
- npm 11.x

Consigliato (per setup backend rapido):
- XAMPP 8.0.30 <i>(o superiore)</i>

# Installazione database
- Accedere a MySQL (tramite phpMyAdmin)
- Creare un nuovo database `db_watuppa`
- Importare il dump `db_watuppa.sql`

# Installazione e avvio frontend
- Scaricare dal repository la cartella `frontend`
- Collocare la cartella dentro `htdocs` <i>(se possiedi XAMPP)</i> altrimenti puoi decidere la posizione che preferisci
- Aprire il terminale e posizionarsi nella cartella `frontend`<br><br>
  **Windows**
    ```bash
    cd C:\xampp\htdocs\watuppa_project\frontend
    ```
  **MacOS**
    ```bash
    cd /Applications/XAMPP/htdocs/watuppa_project/frontend
    ```
  **Linux**
    ```bash
    cd /opt/lampp/htdocs/watuppa_project/frontend
    ```

- Installazione delle dipendenze per il frontend
    ```bash
    npm install
    ```
- Build frontend
  ```bash
  npm run build
  ```
- Avvio di Vite (Vue.js)
    ```bash
    npm run dev
    ```
    Il server frontend Vite sarà in ascolto su: `http://localhost:5173`

# Installazione e avvio backend 
1) Se possiedi XAMPP
   - Scarica dal repository la cartella `backend`
   - Copia la cartella all'interno della directory `htdocs`
   - Avvia Apache e MySQL dal pannello di controllo
   - In base alla configurazione dell'ambiente, il server backend sarà in ascolto sull'indirizzo `http://localhost:80`

2) Se possiedi configurazione personalizzata (PHP + MySQL)
   - Scarica dal repository la cartella `backend`
   - Copia la cartella nella posizione desiderata
   - Avvia il server PHP e MySQL
   - In base alla configurazione scelta, il server backend sarà in ascolto sull'indirizzo `http://localhost:TUA_PORTA`
  
Configurazione consigliata per le porte:
- **PHP (Apache)** → Porta `80`
- **MySQL** → Porta `3306`

# Configurazione del progetto
Per personalizzare la connessione al database e il path base per l'accesso alle API backend, modifica i seguenti file:
- **`backend/db/dbconfig.php`**  
  Sostituisci `username` e `password` con le credenziali del tuo server MySQL
- **`frontend/.env.development`**  
  Imposta il **base URL** per la comunicazione con il backend in ambiente di sviluppo locale
- **`frontend/.env.production`**  
  Imposta il **base URL** per la comunicazione con il backend in ambiente di produzione

# API test locale
Copia la **GET request** qui sotto e incollala nel browser per verificare il funzionamento del **backend**:
```bash
http://localhost:80/watuppa_project/backend/api/orders.php?email=allegri.daniele@gmail.com
```

# Live test 
```bash
https://www.davideallegra.it/watuppa_project/
```
