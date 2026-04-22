# programming-tutor

**Un Agent-Skill pour Claude Code / Cowork — un tuteur personnel pas à pas et pratique pour apprendre un langage de programmation ou un framework, avec Claude dans le rôle du professeur patient.**

Tu travailles dans ton propre éditeur (VS Code recommandé) sur de petits exercices concrets, tu itères à travers des revues de code, et tu construis de vraies compétences, un pas à la fois.

🌐 **Langues** : [日本語](./README.md) · [English](./README.en.md) · [中文](./README.zh.md) · [Español](./README.es.md) · **Français**

---

## À qui ça s'adresse

### ✅ Bonne adéquation

- Tu débutes en programmation, ou tu attaques un nouveau langage / framework
- Tu apprends en autodidacte et tu veux un programme structuré **plus** quelqu'un qui relit ton code à la volée
- La doc officielle existe, mais tu ne sais pas dans quel ordre aborder les sujets
- Tu voudrais que quelqu'un relise ton code, sans avoir autour de toi la bonne personne à qui demander
- Ton temps est fragmenté (15–60 min par jour), il te faut du matériel découpé en petits morceaux
- Tu connais déjà un autre langage et tu veux apprendre efficacement les *idiomes* et les *pièges* d'un nouveau

### ⚠️ Mauvaise adéquation

- **Tu veux qu'il écrive ton code de production.** Cette skill est faite pour apprendre. Pour le vrai travail, utilise un autre flux.
- Tu veux une appli finie sans passer par l'apprentissage
- Tu maîtrises déjà la techno, tu ne veux que des questions-réponses façon dictionnaire

---

## Important : c'est une skill d'apprentissage, pas de production

Cette skill fournit **un environnement pour apprendre**. À garder en tête :

- **Ne lui demande pas de coder ton travail.** L'agent est conçu pour *ne pas* te livrer la solution complète et te guider par indices. Si tu es pressé de livrer du code, ça va t'exaspérer.
- **Les plans, exercices et exemples générés sont pédagogiques.** Ils privilégient la clarté sur la rigueur de production (sécurité, performance, cas limites). Ne les copie pas tels quels en prod.
- **Ne colle pas d'informations confidentielles.** Code interne d'entreprise, données personnelles, clés d'API : évite de les faire apparaître dans le chat d'apprentissage.
- **Croise toujours avec la doc officielle.** Le curriculum est *une* voie recommandée, pas *la* seule vérité. Les écosystèmes évoluent ; vérifie avec la doc en amont.

---

## Technologies supportées

| Catégorie | Technologies | Fichier de référence |
| --- | --- | --- |
| Langages généraux | Python / JavaScript / TypeScript / Java / C# / Go / Ruby, etc. | `references/language-general.md` |
| .NET | C# / ASP.NET Core / EF Core | `references/dotnet.md` |
| Spring Boot | Java / Spring Boot / Spring Data JPA | `references/spring-boot.md` |
| NestJS | Node.js / TypeScript / NestJS / Prisma | `references/nestjs.md` |
| React | React / TypeScript / Vite / React Router | `references/react.md` |
| Rust | Rust / Cargo / ownership / CLI | `references/rust.md` |

Pour une techno non listée (Next.js, Flutter, frameworks web Go, etc.), l'agent construit un curriculum à partir de `language-general.md`. Tu peux aussi ajouter ton propre fichier de référence (voir « Personnalisation »).

---

## Installation

`programming-tutor.skill` est une archive de Skill (zip).

### Claude Code

1. Double-clic sur `programming-tutor.skill`, ou action "Install Skill" dans l'UI
2. Après installation, Claude Code ajoute `programming-tutor` à `available_skills`

### Cowork

1. Glisse le fichier `.skill` dans Cowork — un bouton "Save Skill" apparaît
2. Dès lors, toute requête correspondante déclenche automatiquement la skill

### Installation manuelle (développeurs)

Place le dossier `programming-tutor/` ici :

- Claude Code : `~/.claude/skills/programming-tutor/`
- Cowork : le dossier skills indiqué dans les paramètres

---

## Mode d'emploi

### 1. Déclenche

Toute phrase portant une intention d'apprendre suffit. Pas besoin de dire "utilise cette skill".

- « Je veux apprendre Rust depuis zéro »
- « Aide-moi à devenir bon en Spring Boot »
- « Apprends-moi React étape par étape »
- « Relis mon code TypeScript »
- « Je débute en programmation, par où je commence ? »

Pour l'invoquer explicitement : « avec la skill programming-tutor ».

### 2. Réponds à l'entretien d'ouverture

L'agent pose 4 questions au début (le plus souvent en choix multiple via `AskUserQuestion`) :

- Technologie visée (langage / framework)
- Niveau actuel (débutant / expérimenté dans d'autres langages / bases acquises / intermédiaire+)
- Objectif (travail / projet perso / certification ou entretien / simple curiosité)
- Rythme (temps par jour, date cible)

Il vérifie aussi ton environnement (OS, éditeur, versions runtime). Aide utile :

```bash
bash scripts/check_env.sh rust     # une techno précise
bash scripts/check_env.sh all      # tout d'un coup
```

### 3. Reçois ton plan d'apprentissage

Deux fichiers apparaissent dans le répertoire de travail : `learning-plan.md` (chapitres, états cibles, outils, livrable final) et `progress.md` (suivi pas à pas). Tu les relis, tu demandes des ajustements, tu confirmes.

### 4. Entre dans la boucle pas à pas

Chaque étape suit ce gabarit :

```
## Step N : <titre>
### Pourquoi ça compte
### Idée centrale
### Exemple minimal
### Ta tâche
- [ ] fais ceci
- [ ] puis ceci
```

Puis **l'agent s'arrête et attend**. C'est toi qui codes dans VS Code.

### 5. Relaie avec des mots-clés

| Tu dis | Ce qui se passe |
| --- | --- |
| « fait » / « terminé » | Prêt à avancer ; `progress.md` mis à jour ; intro de l'étape suivante |
| « relis » / « vérifie » | Revue de code : bugs → design → style |
| « indice » / « coincé » | Indices progressifs : question → concept apparenté → fragment partiel → solution finale (en dernier recours) |
| « suivant » | Avance |
| « pause » | Résumé de la position actuelle, facile à reprendre plus tard |
| « saute » / « plus dur » | Ajustement de difficulté |
| « change de techno » | Relance de l'entretien pour une nouvelle techno |

### 6. Format de la revue de code

```
👍 Points forts         (1–3 points concrets)
🚨 À corriger (bugs)    (priorité maximale)
⚠️ À améliorer (design)  (max 2)
💡 Style / plus tard   (optionnel)
Prochaine action       (on avance / corriger et renvoyer)
```

La profondeur du feedback s'adapte à ton niveau — un débutant n'est pas harcelé sur le style ; un intermédiaire+ reçoit les arbitrages de design.

---

## Structure du projet

```
programming-tutor/
├── SKILL.md                          # Définition du comportement de l'agent
├── README.md                         # Japonais (par défaut)
├── README.en.md                      # Anglais
├── README.zh.md                      # Chinois
├── README.es.md                      # Espagnol
├── README.fr.md                      # Français (ce fichier)
├── LICENSE                           # MIT
├── references/                       # Supports chargés à la demande
│   ├── pedagogy.md
│   ├── onboarding.md
│   ├── code_review.md
│   ├── language-general.md
│   ├── dotnet.md
│   ├── spring-boot.md
│   ├── nestjs.md
│   ├── react.md
│   └── rust.md
├── assets/                           # Modèles clonés par l'agent
│   ├── learning-plan-template.md
│   ├── progress-tracker-template.md
│   └── exercise-template.md
└── scripts/
    └── check_env.sh
```

« Chargement à la demande » : seul le fichier de référence de ta techno est lu. Le contexte de l'agent reste léger.

---

## Support multilingue

La skill supporte 5 langues d'apprenant : **日本語 / English / 中文 (简体) / Español / Français**.

- L'agent détecte ta langue dès le premier message
- En cas d'ambiguïté, il te pose une fois la question en choix multiple
- Tu peux changer à tout moment : « from now on in English », « 请用中文 », « en español por favor », « passons au français », « 日本語に戻して »
- Le code, les noms de fichiers, les commandes et les librairies restent toujours en anglais

---

## Personnalisation

### Ajouter une technologie

Pour un framework non couvert (ex. Next.js) :

1. Crée `references/nextjs.md` en t'inspirant de `react.md` ou `nestjs.md`
2. Inclus : prérequis, curriculum chapitre par chapitre avec état cible, pièges classiques, axes de revue de code, livrables suggérés
3. Ajoute le fichier à la liste des références dans la section Planning de `SKILL.md`

### Ajuster le style pédagogique

- Taille des étapes → édite `references/pedagogy.md` "step-size checklist"
- Sévérité des revues → édite `references/code_review.md` "depth by level"
- Ton / langue → édite `SKILL.md` "Language handling"

### Emplacement des fichiers de progression

Par défaut `learning-plan.md` et `progress.md` sont créés à la racine du répertoire de travail. Tu peux dire « mets-les dans ./docs/ » et l'agent obéit.

---

## FAQ

**Q : Je veux aller plus vite, toutes ces confirmations me ralentissent.**
R : Dis « mode auto » ou « avance jusqu'au chapitre 3 ». La skill s'exécute mais te rappelle que la rétention baisse.

**Q : L'agent ne me donne pas la solution directe.**
R : C'est voulu. Après 2–3 échanges d'indices, il donne la solution complète avec explication. Si tu la veux tout de suite : « montre-moi la solution ».

**Q : Je veux changer de techno.**
R : Dis « passer à React » — l'entretien repart pour le nouveau sujet. Ton `progress.md` précédent est conservé.

**Q : Puis-je l'utiliser sur plusieurs sessions (semaines / mois) ?**
R : Oui. Ouvre chaque session par « on reprend » — l'agent lit `progress.md` et redémarre. Garde le même répertoire de travail.

**Q : J'ai du code à livrer au boulot.**
R : N'utilise pas cette skill. Utilise Claude / Claude Code classique. Celle-ci ralentit volontairement pour maximiser l'apprentissage.

**Q : Mon fichier est énorme, tu peux le relire ?**
R : Au-delà de ~500 lignes, l'agent te demande « sur quelle partie je me concentre ? ». En apprentissage normal on ne produit pas de fichiers aussi gros.

**Q : Elle ne s'est pas déclenchée.**
R : Édite le `description` de `SKILL.md` en y ajoutant tes tournures habituelles. Ou invoque-la explicitement : « avec programming-tutor ».

---

## Versions

- v1 : avril 2026
- Licence : MIT (fork et modifications libres)
- Retours : ouvre une issue sur ce dépôt, ou demande à Claude : « mets à jour `references/pedagogy.md` à... »

---

## Crédits

Construit selon le motif `skill-creator` d'Anthropic.
La structure (`SKILL.md` + `references/` + `assets/` + `scripts/`) utilise la *progressive disclosure* : seul le contexte pertinent est chargé à chaque session.
