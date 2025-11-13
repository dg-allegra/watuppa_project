# Overview
Questo progetto permette ad un utente di inserire una email e visualizzare gli ordini, associati a un cliente, presenti nel database.
Il database MySQL contiene dati di utenti, prodotti e ordini.

La web app è composta da due parti:
- **frontend** → (Vue 3, Vite)
- **backend** → (PHP, MySQL, API REST)

Le cartelle `frontend` e `backend` non devono necessariamente essere nella stessa posizione.
Se hai una tua configurazione di PHP e MySQL locale, è possibile posizionare la logica del `backend` dove preferisci.
In questo progetto si consiglia di installare la piattaforma XAMPP (o simili) per semplificare la configurazione di PHP e MySQL.

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

Consigliato:
- MAMP (MacOS)
- LAMPP (Linux)
- WAMPP (Windows)

# Installazione database
- Accedere a MySQL (tramite phpMyAdmin)
- Creare un nuovo database `db_watuppa`
- Importare il dump `db_watuppa.sql`

# Installazione progetto
- Crea la cartella `watuppa_project` dentro `htdocs` di XAMPP
- Scaricare dal repository le cartelle `backend` e `frontend` e copiarle dentro `watuppa_project`
- Aprire il terminale e posizionarsi nella cartella `frontend`<br><br>
  **MacOS**
    ```bash
    cd /Applications/MAMP/htdocs/watuppa_project/frontend
    ```
  **Linux**
    ```bash
    cd /opt/lampp/htdocs/watuppa_project/frontend
    ```
  **Windows**
    ```bash
    cd C:\wamp64\www\watuppa_project\frontend
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
    Il server sarà in ascolto su: `http://localhost:5173`

# Configurazione progetto
I file dove è possibile personalizzare la configurazione della connessione al database e del path globale sono in:
- `backend/db/dbconfig.php` <i>(sostituire username e password con i valori della connessione al tuo server MySQL)</i>
- `frontend/src/components/Orders.vue` e modificare il path `baseURL`

# API test locale
Copia la **GET request** qui sotto e incollala nel browser per verificare il funzionamento del **backend**:
```bash
http://localhost:80/watuppa_project/backend/api/orders.php?email=allegri.daniele@gmail.com
```

# Live test 
```bash
https://www.davideallegra.it/watuppa_project/
```
