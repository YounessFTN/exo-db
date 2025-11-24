# Mini-Rapport Explicatif de la Base de Données

---

## 1. Résumé des Choix de Modélisation

Le modèle de données a été conçu pour répondre aux besoins fonctionnels de l'application, en suivant les bonnes pratiques du **Modèle Logique de Données (MLD)**.

### Clés Substituts Généralisées

- **Choix principal** : Ajout d'une **clé primaire technique** (`id_...`, entier auto-incrémenté) pour chaque table (`UTILISATEUR`, `DEFIS`, `CITATION`, etc.).
  - **Avantages** :
    - Stabilité des relations (les clés étrangères sont des entiers simples).
    - Simplification des jointures, même si les clés naturelles (ex. `Pseudo`, `Titre`) évoluent.
  - Les clés naturelles sont conservées comme **contraintes d'unicité** (`[unique]`).

### Gestion des Relations N-N

- Les associations de type **N-N** (`MODERE_DEFI`, `INSPIRE`) sont transformées en **tables d'association dédiées**.
  - Ces tables utilisent les **clés étrangères des entités participantes** comme **clé primaire composée**.

### Entités Faibles

- Les entités dépendantes (`RETOUR_EXPERIENCE`, `COMMENTAIRE`) intègrent les **clés étrangères** nécessaires pour représenter leur dépendance vis-à-vis d'autres entités (`UTILISATEUR`, `DEFIS`, etc.).

### Relation 0,N-0,1 (`PROPOSE`)

- La proposition d'un défi est modélisée comme une **relation 1-N**.
  - L'identifiant du proposeur (`id_proposeur`) migre directement dans la table `DEFIS`.

---

## 2. Contraintes et Règles d'Intégrité Implémentées

Les règles métier sont assurées par des **contraintes de base de données** :

| Type de Contrainte           | Exemples d'Application                                                                                                                                                             |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Unicité**                  | Index `[unique]` sur les clés naturelles (`Pseudo`, `Titre`, `TexteCitation`).                                                                                                     |
| **Non-Nullité** (`not null`) | Champs obligatoires (`DateInscription`, `Pseudo` dans `UTILISATEUR`).                                                                                                              |
| **Intégrité Référentielle**  | Clés étrangères (FK) pour garantir la validité des liens entre les tables.                                                                                                         |
| **Clés Composées**           | Contraintes d'unicité sur `RETOUR_EXPERIENCE` et `COMMENTAIRE` (ex. : un utilisateur ne peut pas publier deux fois le même retour d'expérience pour le même défi à la même heure). |

---

## 3. Pistes d'Évolution Futures

Pour les prochaines itérations, voici des pistes d'amélioration :

- **Gestion des Médias** :

  - Ajouter une table `MEDIA` pour gérer les images ou vidéos associées aux `RETOUR_EXPERIENCE` ou `DEFIS`.
  - Lier cette table via une **clé étrangère**.

- **Modération Détaillée** :

  - Remplacer les champs simples (`StatutPublication`, `StatutModeration`) par une table `HISTORIQUE_MODERATION`.
  - Suivre précisément **qui** (modérateur), **quoi** (décision), **quand** (date), et **pourquoi** (motif).

- **Catégorisation des Défis** :

  - Créer une table `CATEGORIE` (ex. : "Environnement", "Aide aux autres").
  - Ajouter une table d'association `CATEGORISER` (relation **N-N**).

- **Gestion des Rôles** :
  - Remplacer le champ `Role` (varchar) dans `UTILISATEUR` par une table `ROLE` (`id`, `nom_role`).
  - Permettre une gestion plus fine et extensible des permissions (Modérateur, Administrateur, etc.).

---

## Un Mot sur l'Équipe

La modélisation de cette base de données a été le fruit d'une **analyse rigoureuse** des besoins fonctionnels. L'approche collaborative et la remise en question des choix initiaux ont été essentielles.

- **Zak** : Responsable du **backend**, a veillé à ce que le modèle facilite le travail d'**ORM** (Object-Relational Mapping).
- **Youness** : Responsable de la **modélisation et des données**, a garanti la robustesse des contraintes d'intégrité et la simplicité des clés substituts.

Notre coordination a permis de créer une base **stable, performante et facile à maintenir** pour la suite du projet.
