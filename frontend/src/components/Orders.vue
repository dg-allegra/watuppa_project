<script setup>
import { ref } from 'vue'
import axios from 'axios'

const api = axios.create({
    baseURL: import.meta.env.VITE_API_PATH_BASE || 'http://localhost:80/backend/api/'
})

const email = ref('')
const orders = ref(null)
const errorMsg = ref('')

function resetSearch()
{
    email.value = ''
    orders.value = null
    errorMsg.value = ''
}

async function getOrders()
{
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
      orders.value = groupOrders(response.data.data)
    } catch(e) {
      errorMsg.value = e.response.data.message
    }
}

function groupOrders(data)
{
    const grouped = {}

    for (let item of data)
    {
        // Se non esiste ancora l'ordine lo creo
        if (!grouped[item.id_ordine])
        {
            grouped[item.id_ordine] = {
                id_ordine: item.id_ordine,
                data_ordine: item.data_ordine,
                prodotti: []
            }
        }

        // Push del prodotto nell'array "prodotti"
        // es: grouped[1]["prodotti"] = {"nome_prodotto": "iPhone 17 Pro", ...}
        grouped[item.id_ordine]["prodotti"].push({
            nome_prodotto: item.nome_prodotto,
            quantità: item.quantità,
            prezzo: item.prezzo
        })
    }

    return Object.values(grouped)
}

function dateFormat(date, format=null)
{
    const [year, month, day] = date.split('-')
    if (format == 'it') {
        return `${day}/${month}/${year}`
    }
    return `${year}-${month}-${day}`
}
</script>


<style lang="css" scoped>
@font-face {
    font-family: 'STENCIL';
    font-weight: normal;
    font-style: normal;
    src: url('../assets/fonts/stencil/STENCIL.woff') format('woff');
}
header {
    width: 100%;
    padding: 8px 20px;
    margin-bottom: 0;
    color: #f8cf39;
    background-color: #1d1f51;
    font-family: "STENCIL", sans-serif;
    box-sizing: border-box;
}
.main-container-orders {
    width: 100%;
    padding: 30px;
    border: 1px solid white;
    border-radius: 8px;
    background-color: white;
    box-sizing: border-box;
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
    margin: 36px 0px;
    color: black;
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
            <div v-for="ordine in orders" :key="ordine.id_ordine" style="margin-bottom: 40px;">
                <h2>
                    Ordine n. <span class="bold">{{ ordine.id_ordine }}</span> del {{ dateFormat(ordine.data_ordine, 'it') }}
                </h2>

                <table>
                    <thead>
                        <tr>
                            <th>Prodotto</th>
                            <th>Quantità</th>
                            <th>Prezzo</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr v-for="p in ordine.prodotti" :key="p.nome_prodotto">
                            <td>{{ p.nome_prodotto }}</td>
                            <td>{{ p.quantità }}</td>
                            <td>{{ p.prezzo }} €</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <button @click="resetSearch">Effettua altra ricerca</button>
        </div>

    </div>
</template>