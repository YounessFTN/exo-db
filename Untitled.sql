CREATE TABLE `UTILISATEUR` (
  `id_utilisateur` int PRIMARY KEY AUTO_INCREMENT,
  `Pseudo` varchar(255) UNIQUE NOT NULL,
  `AdresseEmail` varchar(255) UNIQUE NOT NULL,
  `MotDePasseHash` varchar(255) NOT NULL,
  `DateInscription` date NOT NULL,
  `Role` varchar(255) NOT NULL
);

CREATE TABLE `DEFIS` (
  `id_defi` int PRIMARY KEY AUTO_INCREMENT,
  `Titre` varchar(255) UNIQUE NOT NULL,
  `Description` text,
  `DateCreation` date NOT NULL,
  `StatutPublication` varchar(255) NOT NULL,
  `id_proposeur` int NOT NULL
);

CREATE TABLE `CITATION` (
  `id_citation` int PRIMARY KEY AUTO_INCREMENT,
  `TexteCitation` text UNIQUE NOT NULL,
  `Auteur` varchar(255),
  `DateAjout` date
);

CREATE TABLE `USAGE_FONDS` (
  `id_usage` int PRIMARY KEY AUTO_INCREMENT,
  `DateUsage` datetime UNIQUE NOT NULL,
  `DescriptionUsage` text NOT NULL,
  `MontantUtilise` numeric NOT NULL
);

CREATE TABLE `DON` (
  `id_don` int PRIMARY KEY AUTO_INCREMENT,
  `DateDon` datetime NOT NULL,
  `Montant` numeric NOT NULL,
  `AffichagePublic` boolean,
  `id_utilisateur` int NOT NULL
);

CREATE TABLE `RETOUR_EXPERIENCE` (
  `id_retour` int PRIMARY KEY AUTO_INCREMENT,
  `DateHeure` datetime NOT NULL,
  `Contenu` text,
  `StatutAide` boolean,
  `id_utilisateur` int NOT NULL,
  `id_defi` int NOT NULL
);

CREATE TABLE `COMMENTAIRE` (
  `id_commentaire` int PRIMARY KEY AUTO_INCREMENT,
  `DateHeure` datetime NOT NULL,
  `Contenu` text,
  `StatutModeration` varchar(255),
  `id_utilisateur` int NOT NULL,
  `id_retour` int NOT NULL
);

CREATE TABLE `MODERE_DEFI` (
  `id_moderateur` int NOT NULL,
  `id_defi` int NOT NULL,
  PRIMARY KEY (`id_moderateur`, `id_defi`)
);

CREATE TABLE `INSPIRE` (
  `id_defi` int NOT NULL,
  `id_citation` int NOT NULL,
  PRIMARY KEY (`id_defi`, `id_citation`)
);

CREATE UNIQUE INDEX `RETOUR_EXPERIENCE_index_0` ON `RETOUR_EXPERIENCE` (`id_utilisateur`, `id_defi`, `DateHeure`);

CREATE UNIQUE INDEX `COMMENTAIRE_index_1` ON `COMMENTAIRE` (`id_utilisateur`, `id_retour`, `DateHeure`);

ALTER TABLE `DEFIS` ADD FOREIGN KEY (`id_proposeur`) REFERENCES `UTILISATEUR` (`id_utilisateur`);

ALTER TABLE `DON` ADD FOREIGN KEY (`id_utilisateur`) REFERENCES `UTILISATEUR` (`id_utilisateur`);

ALTER TABLE `RETOUR_EXPERIENCE` ADD FOREIGN KEY (`id_utilisateur`) REFERENCES `UTILISATEUR` (`id_utilisateur`);

ALTER TABLE `RETOUR_EXPERIENCE` ADD FOREIGN KEY (`id_defi`) REFERENCES `DEFIS` (`id_defi`);

ALTER TABLE `COMMENTAIRE` ADD FOREIGN KEY (`id_utilisateur`) REFERENCES `UTILISATEUR` (`id_utilisateur`);

ALTER TABLE `COMMENTAIRE` ADD FOREIGN KEY (`id_retour`) REFERENCES `RETOUR_EXPERIENCE` (`id_retour`);

ALTER TABLE `MODERE_DEFI` ADD FOREIGN KEY (`id_moderateur`) REFERENCES `UTILISATEUR` (`id_utilisateur`);

ALTER TABLE `MODERE_DEFI` ADD FOREIGN KEY (`id_defi`) REFERENCES `DEFIS` (`id_defi`);

ALTER TABLE `INSPIRE` ADD FOREIGN KEY (`id_defi`) REFERENCES `DEFIS` (`id_defi`);

ALTER TABLE `INSPIRE` ADD FOREIGN KEY (`id_citation`) REFERENCES `CITATION` (`id_citation`);
