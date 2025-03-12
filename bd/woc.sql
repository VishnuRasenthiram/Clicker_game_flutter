-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 10 mars 2025 à 16:20
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `woc`
--

-- --------------------------------------------------------

--
-- Structure de la table `buy`
--

CREATE TABLE `buy` (
  `id_player` int(11) NOT NULL,
  `id_enhancement` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `buy`
--

INSERT INTO `buy` (`id_player`, `id_enhancement`) VALUES
(1, 2),
(2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `enemy`
--

CREATE TABLE `enemy` (
  `level` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `floor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enemy`
--

INSERT INTO `enemy` (`level`, `name`, `floor`) VALUES
(1, 'Kobold', 1),
(2, 'Gnoll', 1),
(3, 'Looter', 1),
(4, 'Polar Bear', 1),
(5, 'Spider', 1),
(6, 'Murloc', 2),
(7, 'Stranglethorn Tiger', 2),
(8, 'Vulture', 2),
(9, 'Jaguar', 2),
(10, 'Basilisk', 2),
(11, 'Furbolg', 3),
(12, 'Night Elf', 3),
(13, 'Bear', 3),
(14, 'Boar', 3),
(15, 'Spider', 3),
(16, 'Centaur', 4),
(17, 'Troll', 4),
(18, 'Felhound', 4),
(19, 'Cleft Scorpid', 4),
(20, 'Skeletal Warrior', 4),
(21, 'Scourge', 5),
(22, 'Plague Cauldron', 5),
(23, 'Abomination', 5),
(24, 'Crypt Fiend', 5),
(25, 'Death Knight', 5);

-- --------------------------------------------------------

--
-- Structure de la table `enhancement`
--

CREATE TABLE `enhancement` (
  `id_enhancement` int(11) NOT NULL,
  `gold_cost` int(11) NOT NULL,
  `boost_value` int(11) NOT NULL,
  `id_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enhancement`
--

INSERT INTO `enhancement` (`id_enhancement`, `gold_cost`, `boost_value`, `id_type`) VALUES
(2, 50, 2, 1),
(4, 50, 2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `player`
--

CREATE TABLE `player` (
  `id_player` int(11) NOT NULL,
  `pseudo` varchar(50) NOT NULL,
  `floor` int(11) NOT NULL DEFAULT 1,
  `gold` int(11) NOT NULL DEFAULT 0,
  `experience` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player`
--

INSERT INTO `player` (`id_player`, `pseudo`, `floor`, `gold`, `experience`) VALUES
(1, 'OmegaZ', 5, 1715, 0),
(2, 'Sparadrap', 1, 20, 0),
(7, 'az', 1, 20, 0);

-- --------------------------------------------------------

--
-- Structure de la table `type_enhancement`
--

CREATE TABLE `type_enhancement` (
  `id_type` int(11) NOT NULL,
  `name_type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `type_enhancement`
--

INSERT INTO `type_enhancement` (`id_type`, `name_type`) VALUES
(1, 'dps'),
(2, 'exp');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `buy`
--
ALTER TABLE `buy`
  ADD PRIMARY KEY (`id_player`,`id_enhancement`),
  ADD KEY `id_enhancement` (`id_enhancement`);

--
-- Index pour la table `enemy`
--
ALTER TABLE `enemy`
  ADD PRIMARY KEY (`level`);

--
-- Index pour la table `enhancement`
--
ALTER TABLE `enhancement`
  ADD PRIMARY KEY (`id_enhancement`),
  ADD KEY `id_type` (`id_type`);

--
-- Index pour la table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`id_player`);

--
-- Index pour la table `type_enhancement`
--
ALTER TABLE `type_enhancement`
  ADD PRIMARY KEY (`id_type`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `enemy`
--
ALTER TABLE `enemy`
  MODIFY `level` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `enhancement`
--
ALTER TABLE `enhancement`
  MODIFY `id_enhancement` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `player`
--
ALTER TABLE `player`
  MODIFY `id_player` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `type_enhancement`
--
ALTER TABLE `type_enhancement`
  MODIFY `id_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `buy`
--
ALTER TABLE `buy`
  ADD CONSTRAINT `buy_ibfk_1` FOREIGN KEY (`id_player`) REFERENCES `player` (`id_player`) ON DELETE CASCADE,
  ADD CONSTRAINT `buy_ibfk_2` FOREIGN KEY (`id_enhancement`) REFERENCES `enhancement` (`id_enhancement`) ON DELETE CASCADE;

--
-- Contraintes pour la table `enhancement`
--
ALTER TABLE `enhancement`
  ADD CONSTRAINT `enhancement_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `type_enhancement` (`id_type`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
