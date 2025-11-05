<script setup>
import { ref } from 'vue'
import axios from 'axios'

const api = axios.create({
  baseURL: 'http://localhost/watuppa_devtest/backend/api/'
})

const email = ref('')
const orders = ref(null)
const errorMsg = ref('')

function resetSearch() {
  email.value = ''
  orders.value = null
  errorMsg.value = ''
}

async function getOrders() {
    errorMsg.value = ''
    orders.value = null

    if (!email.value) {
        errorMsg.value = 'Inserisci un indirizzo email valido'
        return
    }

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email.value)) {
        errorMsg.value = 'Inserizzo email non valido, verifica il formato'
        return
    }

    try {
      const response = await api.get('orders.php', { params: { email: email.value } })
      orders.value = response.data.data
    } catch(e) {
      errorMsg.value = e.response.data.message
    }
}
</script>


<style lang="css" scoped>
@font-face {
    font-family: 'STENCIL';
    font-weight: normal;
    font-style: normal;
    src: url('@/assets/fonts/stencil/STENCIL.woff') format('woff');
}
header {
    width: 100%;
    padding: 8px 20px;
    margin-bottom: 0;
    color: #f8cf39;
    background-color: #1d1f51;
    font-family: "STENCIL", sans-serif;
}
.main-container-orders {
    width: 100%;
    padding: 30px;
    border: 1px solid white;
    border-radius: 8px;
    background-color: white;
}
.main-container-orders h2 {
    font-size: 22px;
    margin-bottom: 20px;
    color: #303488;
    font-weight: normal;
    font-style: normal;
    font-family: "Lyon Text OSF Web",Georgia,"Times New Roman",Times,serif;
}
.main-container-orders input[type="email"] {
    width: 80%;
    padding: 12px 20px;
    border: 0;
    background-color: #f5f4f4;
    color: #999790;
    font-weight: 300;
    font-size: 16px;
    font-family: "Lyon Text OSF Web",Georgia,"Times New Roman",Times,serif;
}
.main-container-orders button {
    border: 1px solid #007bb5;
    border-radius: 0;
    padding: 12px 44px;
    margin-top: 0;
    margin-right: 10px;
    color: #007bb5 !important;
    background-color: white;
    border-color: #007bb5;
    font-size: 16px;
    font-weight: normal;
    font-family: "Lyon Text OSF Web",Georgia,"Times New Roman",Times,serif;
}
.main-container-orders .searchbar-flex {
    width: 100%;
    display: flex;
    flex-direction: row;
    gap: 12px;
}
.main-container-orders .searchbar-flex input[type="email"] {
    width: 80%;
}
.main-container-orders .searchbar-flex button {
    width: 20%;
    padding-left: 0;
    padding-right: 0;
}
.main-container-orders table {
    width: 100%;
    margin: 16px 0px;
}
.main-container-orders table td {
    padding: 4px;
    border: 1px solid #dddddd;
    text-align: left;
}
.main-container-orders .errorMsg {
    color: #d14040;
    margin-top: 20px;
}
.main-container-orders .bold {
    font-weight: bold;
}
</style>


<template>
    <header>
        <h1>Gestione ordini</h1>
    </header>

    <div class="main-container-orders">

        <!-- Visualizzazione per la ricerca -->
        <div v-if="orders === null">
            <h2>Cerca ordini per cliente</h2>

            <div class="searchbar-flex">
                <input v-model="email" type="email" placeholder="Email cliente" />
                <button @click="getOrders">Cerca ordini</button>
            </div>

            <p v-if="errorMsg" class="errorMsg">{{ errorMsg }}</p>
        </div>

        <!-- Visualizzazione dei risultati -->
        <div v-else>
            <h2>Elenco ordini effettuati dal cliente <span class="bold">{{ email }}</span></h2>

            <table>
                <tr>
                  <th>N. Ordine</th>
                  <th>Data</th>
                  <th>Prodotto</th>
                  <th>Qtà</th>
                  <th>Prezzo</th>
                </tr>
                <tr v-for="r in orders" :key="r.id_ordine + r.nome_prodotto">
                  <td>{{ r.id_ordine }}</td>
                  <td>{{ r.data_ordine }}</td>
                  <td>{{ r.nome_prodotto }}</td>
                  <td>{{ r.quantità }}</td>
                  <td>{{ r.prezzo }}</td>
                </tr>
            </table>

            <button @click="resetSearch">Effettua altra ricerca</button>
        </div>

    </div>
</template>