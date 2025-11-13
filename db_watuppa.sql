-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Creato il: Nov 13, 2025 alle 13:48
-- Versione del server: 8.0.40
-- Versione PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_watuppa`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `dettaglio_ordine`
--

CREATE TABLE `dettaglio_ordine` (
  `id` int UNSIGNED NOT NULL,
  `id_ordine` int UNSIGNED NOT NULL,
  `id_prodotto` int UNSIGNED NOT NULL,
  `prezzo` float UNSIGNED NOT NULL,
  `quantità` smallint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `dettaglio_ordine`
--

INSERT INTO `dettaglio_ordine` (`id`, `id_ordine`, `id_prodotto`, `prezzo`, `quantità`) VALUES
(1, 1, 9, 210, 1),
(2, 1, 6, 85.7, 2),
(3, 2, 2, 25.75, 1),
(4, 3, 4, 180.5, 1),
(5, 4, 1, 1350, 1),
(6, 4, 8, 790.99, 1),
(7, 5, 2, 25.75, 2),
(8, 5, 4, 180.5, 1),
(9, 6, 7, 37.8, 2),
(10, 7, 9, 210, 2),
(11, 8, 3, 17.6, 3),
(12, 8, 10, 75.89, 1),
(13, 9, 7, 37.8, 2),
(14, 9, 3, 17.6, 2),
(15, 9, 8, 790.99, 2),
(16, 10, 7, 37.8, 2),
(17, 11, 3, 17.6, 3),
(18, 11, 10, 75.89, 3),
(19, 12, 5, 12.65, 5),
(20, 12, 4, 180.5, 1),
(21, 13, 6, 85.7, 3),
(22, 13, 4, 180.5, 2),
(23, 13, 7, 37.8, 4),
(24, 14, 1, 1099, 1),
(25, 14, 9, 380, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `ordini`
--

CREATE TABLE `ordini` (
  `id` int UNSIGNED NOT NULL,
  `data` date NOT NULL,
  `id_utente` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `ordini`
--

INSERT INTO `ordini` (`id`, `data`, `id_utente`) VALUES
(1, '2025-04-23', 2),
(2, '2025-05-08', 7),
(3, '2025-05-31', 5),
(4, '2025-06-06', 9),
(5, '2025-08-07', 9),
(6, '2025-08-17', 8),
(7, '2025-06-04', 5),
(8, '2025-10-22', 10),
(9, '2025-10-26', 10),
(10, '2025-10-29', 1),
(11, '2025-11-01', 3),
(12, '2025-11-02', 10),
(13, '2025-11-03', 4),
(14, '2025-11-07', 3);

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotti`
--

CREATE TABLE `prodotti` (
  `id` int UNSIGNED NOT NULL,
  `nome` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `tipologia` enum('elettronica','abiti','indoor','outdoor') COLLATE utf8mb4_general_ci NOT NULL,
  `prezzo_listino` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `prodotti`
--

INSERT INTO `prodotti` (`id`, `nome`, `tipologia`, `prezzo_listino`) VALUES
(1, 'iPhone 17 Pro', 'elettronica', 1350),
(2, 'Felpa Zara', 'abiti', 25.75),
(3, 'Camicia Alcott', 'abiti', 17.6),
(4, 'Tavolo in vetro', 'indoor', 180.5),
(5, 'Portavaso', 'outdoor', 12.65),
(6, 'Sedia in vimini', 'outdoor', 85.7),
(7, 'Poltrona Ikea', 'indoor', 37.8),
(8, 'Televisore Samsung 55\"', 'elettronica', 790.99),
(9, 'Giradischi Marshall', 'elettronica', 210),
(10, 'Tappeto per salotto', 'indoor', 75.89);

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `id` int UNSIGNED NOT NULL,
  `cognome` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `nome` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `data_nascita` date NOT NULL,
  `genere` enum('M','F','Altro') COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(200) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`id`, `cognome`, `nome`, `data_nascita`, `genere`, `email`) VALUES
(1, 'Valenti', 'Federica', '1995-07-08', 'F', 'valenti.federica@gmail.com'),
(2, 'Castaldi', 'Alessio', '1997-11-12', 'M', 'castaldi.alessio@hotmail.com'),
(3, 'Allegri', 'Daniele', '1990-05-13', 'M', 'allegri.daniele@gmail.com'),
(4, 'Valenti', 'Raffaele', '1985-07-17', 'M', 'valenti.raffaele@hotmail.com'),
(5, 'Di Pietro', 'Rossana', '1982-03-23', 'F', 'dpt.rossana@live.it'),
(6, 'Panarello', 'Alfonso', '1993-09-06', 'M', 'panarello.alfonso@gmail.com'),
(7, 'Marchese', 'Claudia', '1992-12-08', 'F', 'marchese.claudia@hotmail.it'),
(8, 'Petralia', 'Luisa', '1998-04-23', 'F', 'petralia.luisa@gmail.com'),
(9, 'Verdone', 'Davide', '1994-06-26', 'M', 'verdone.davide@gmail.com'),
(10, 'Serra', 'Valentino', '1982-05-17', 'M', 'serra.vale@hotmail.com');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `dettaglio_ordine`
--
ALTER TABLE `dettaglio_ordine`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_ordine_prodotto` (`id_ordine`,`id_prodotto`),
  ADD KEY `FK_prodotti_idprodotto` (`id_prodotto`);

--
-- Indici per le tabelle `ordini`
--
ALTER TABLE `ordini`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_ordini_idutente` (`id_utente`);

--
-- Indici per le tabelle `prodotti`
--
ALTER TABLE `prodotti`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `dettaglio_ordine`
--
ALTER TABLE `dettaglio_ordine`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT per la tabella `ordini`
--
ALTER TABLE `ordini`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT per la tabella `prodotti`
--
ALTER TABLE `prodotti`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT per la tabella `utenti`
--
ALTER TABLE `utenti`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `dettaglio_ordine`
--
ALTER TABLE `dettaglio_ordine`
  ADD CONSTRAINT `FK_dettaglio_idordine` FOREIGN KEY (`id_ordine`) REFERENCES `ordini` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_prodotti_idprodotto` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `ordini`
--
ALTER TABLE `ordini`
  ADD CONSTRAINT `FK_ordini_idutente` FOREIGN KEY (`id_utente`) REFERENCES `utenti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
