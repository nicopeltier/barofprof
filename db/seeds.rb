
# db/seeds.rb
# encoding: UTF-8
# Seeds BaroProf — Thématiques & Questions
# Source: "Barprofs - questions V5.pdf"

puts "Seeding themes & questions…"

themes_data = [
  {
    number: 1,
    name: "Je me sens bien dans l’ambiance d’équipe",
    questions: [
      "Je trouve que l’ambiance entre adultes est bonne",
      "Je ressors généralement satisfait(e) des concertations",
      "Il est facile pour moi de m’exprimer en session de travail (plénière, petit groupe), je suis écouté(e)",
      "Toute l’équipe prend appui sur un règlement d’école clair et explicite. Les sanctions ne sont pas aléatoires",
      "Il y a une politique d’échange de bonnes pratiques entre enseignant(e)s (référentiels, évaluations, outils pédagogiques)",
      "L’erreur est valorisée. Elle est une occasion d’apprendre. À l’école, elle n’est jamais stigmatisée comme un échec",
      "Je suis satisfait(e) de notre réflexion collective sur la prise en charge d’élèves à besoins spécifiques",
      "Pendant les cours, nous permettons les échanges, les activités de coopération, les ateliers différenciés… lorsque c’est possible",
      "La salle des profs est un lieu de ressources, je m’y rends avec plaisir",
      "Je trouve que les désaccords finissent par être une occasion d’approfondir positivement les relations de travail",
      "La communication avec la hiérarchie est facile pour moi",
      "Je ne perçois pas de jeux de pouvoir ou d’influence au sein de l’équipe face à la hiérarchie",
      "Les critères de décision pour la vie, l’organisation de l’école sont clairs à mes yeux",
      "D’une manière générale, compte tenu de son contexte, je trouve que mon école est bien tenue",
      "J’aime mon école, je suis content(e) de faire partie de cette équipe"
    ]
  },
  {
    number: 2,
    name: "Notre dynamique de travail est bonne",
    questions: [
      "D’une manière générale, j’apprécie les séquences de travail avec mes collègues en dehors de la classe",
      "L’information circule bien au sein de l’équipe",
      "Notre projet d’école est clair, il a du sens pour moi",
      "En concertation, nous avançons avec bon sens",
      "En concertation, chacun participe",
      "En concertation, notre méthode de travail est explicite",
      "Nos sessions de concertation débouchent sur des actions ou des productions écrites",
      "J’ai une vision claire de l’ensemble des projets menés au sein de mon école",
      "Même si parfois je ressens des résistances, je peux vivre avec les directives ministérielles appliquées à l’école",
      "Au sein d’un cycle ou d’une option, il existe des pratiques (carnet de liaison, cahier de cycle, concertation spécifique) qui facilitent la progression des élèves au sein du cycle",
      "Les progrès de l’élève sont pris en compte lors d’une évaluation, pas seulement l’écart à la norme attendue",
      "Des appréciations accompagnent la remise des interrogations, des bulletins. Elles permettent à l’élève de voir si et comment il a progressé",
      "À l’école, nous ne rassemblons pas les élèves en difficulté dans une même classe, section. La composition des classes est suffisamment hétérogène",
      "Les élèves ont l’occasion de s’engager en tant qu’acteurs (sorties, projets, conseil d’élèves, journal d’école…)",
      "Les enseignants en difficulté sont entourés. En tant qu’enseignant(e), je ne me sens jamais seul(e)"
    ]
  },
  {
    number: 3,
    name: "Nos règles de vie sont justes, notre autorité élève les élèves (Justice scolaire)",
    questions: [
      "Les règles de l’école sont justes",
      "Je trouve que le règlement est mis en œuvre de manière cohérente par toute l’équipe pédagogique",
      "Les élèves ne subissent pas le cadre de règles car il prend du sens pour eux",
      "Lorsqu’un acte/comportement inadéquat se produit, l’élève est conduit à approfondir (perceptions, croyances, besoins). Il pose un acte réparateur",
      "J’ai le sentiment que les élèves se sentent en sécurité à l’école et dans l’espace périscolaire (la toile, les abords de l’école, le chemin de l’école, le bus,…)",
      "Les élèves participent à l’élaboration des règles de vie commune au sein de la classe",
      "Les sanctions sont porteuses de sens et réparatrices. Elles dépassent la simple liste des interdictions",
      "Les classes ont la capacité de s’écouter, de tenir un cercle de classe",
      "Une progression est organisée grâce à des activités spécifiques afin que la classe soit capable de s’écouter davantage",
      "Des cercles de parole régulée sont ouverts périodiquement (au minimum une fois par mois) pour favoriser la bonne dynamique de classe",
      "Il existe un protocole simple et clair pour aider les élèves à traverser leur conflit par la grande porte",
      "En tant qu’enseignant, je suis capable de mettre en œuvre ce protocole de gestion des tensions dans ma vie professionnelle. Je ne garde pas de conflit en tension",
      "En tant qu’enseignant, je connais les 5 règles d’un cercle de parole de classe, je me sens à l’aise pour l’organiser si nécessaire",
      "S’il y a des classes où le cercle de parole me paraît impossible à organiser, des solutions sont recherchées en équipe (concertation) pour améliorer la vie en classe",
      "Face à un comportement de transgression, l’équipe éducative a la compétence de se placer « dans les chaussures » de l’élève pour identifier ses vrais besoins et ses représentations. Cette compétence n’est pas perdue sous le joug de la colère.",
      "En cas de sanction de l’élève, celui-ci comprend toujours pourquoi il est sanctionné",
      "Au besoin, une explication peut être donnée à sa famille. Le comportement attendu est explicité",
      "À l’école, l’autorité est utilisée de manière juste : pour « élever » l’élève, pas le rabaisser",
      "Je trouve que les limites sont exprimées de manière suffisamment claire et ferme par l’équipe pédagogique",
      "En cas de problème répété avec un élève, un contrat avec les familles est toujours tenté. Nous cherchons une alliance éducative",
      "Dans ce cas, les familles sont informées des éventuels progrès du jeune ainsi que des points d’amélioration",
      "Je trouve que dans mon école, la transgression des règles est une occasion d’apprendre, notre système éducatif est bien « huilé »",
      "Le personnel éducatif s’organise bien pour ne pas être dépassé par l’administratif. Le contact reste possible",
      "J’apprécie l’entraide entre collègues en cas de difficulté de comportement d’un élève ou d’une classe",
      "Des activités de prise de connaissance, de dynamique de classe sont organisées en début d’année pour favoriser la cohésion de classe"
    ]
  },
  {
    number: 4,
    name: "Ensemble, nous posons un bon cadre de valeurs et de règles (Prévention des violences scolaires)",
    questions: [
      "Il existe une procédure de signalement en cas de harcèlement et je la trouve efficace",
      "Nous mettons en place en équipe une dynamique pour favoriser la circulation de la parole en classe (charte, animations spécifiques, cercles de parole)",
      "En équipe, nous comprenons bien le mécanisme du harcèlement et l’omerta qui y est liée. Nous pouvons discriminer le harcèlement et le conflit",
      "À l’école, les élèves apprennent à distinguer le déclencheur de leurs émotions",
      "Les élèves sont conduits à approfondir les tensions (légitimes) qu’ils vivent entre eux. Ils apprennent à faire les liens entre leurs émotions et leurs besoins",
      "Je trouve que nos élèves sont capables de placer par eux-mêmes des limites saines. Sinon, l’école les y aide de manière efficace",
      "Quand un fait de harcèlement est avéré, nous mettons en place la méthode de la préoccupation partagée (no blâme)",
      "L’école a identifié la personne référente pour recevoir des copies d’écran et instruire selon le règlement les dérapages sur les réseaux. Les élèves le savent et en font usage",
      "Lorsqu’un fait grave est commis, le recours à la « sanction rogatoire » est possible de sorte que l’élève-auteur puisse faire de sa transgression une occasion d’apprendre. L’école ne se laisse pas aspirer dans la spirale de la sanction",
      "Certains élèves utilisent les dispositifs de lutte contre les violences scolaires pour attirer l’attention. Ils génèrent des « tempêtes dans un verre d’eau ». En équipe nous sommes conscients de ce piège. Nous pouvons discerner quand renvoyer l’élève vers sa propre force (capacité) d’apaiser un conflit",
      "Les cercles de parole s’organisent bien. En classe, l’écoute mutuelle est bonne et les émotions peuvent s’exprimer authentiquement",
      "Les moments d’écoute (de digression) et les moments d’apprentissage pédagogique (les cours) sont bien distincts. Nous pouvons maintenir un juste équilibre",
      "Dans la gestion éducative, le rôle spécifique du titulaire de classe ou de l’éducateur référent est clair et la communication autour d’une sanction est bonne au sein de l’équipe",
      "L’équipe est consciente de sa force de motivation. Chacun est compétent pour mettre un élève en avant pour ses qualités, ses progrès. Cette compétence ne se perd pas en cas de tension avec l’élève",
      "En cas de problème, les élèves savent à qui parler. Il y a toujours une personne disponible au sein de l’équipe pédagogique",
      "L’équipe connaît les bases de la communication bienveillante (observation, sentiment, besoin, demande). Elle la pratique quand c’est nécessaire",
      "En cas de besoin, l’école a identifié un réseau de partenaires (AMO, centre de planning, asbl locale)",
      "L’équipe est en mesure d’identifier ses petites victoires au quotidien. La parole qui circule met assez en lumière le positif, les actions entreprises",
      "L’ambiance dans la salle des profs me convient. Ce n’est pas le bureau des plaintes, on peut également y passer de bons moments entre collègues",
      "Il y a régulièrement des moments conviviaux entre collègues. Nous cultivons une bonne complicité professionnelle"
    ]
  },
  {
    number: 5,
    name: "Nos élèves sont en sécurité physique et affective (Qualité de vie et sécurité à l’école)",
    questions: [
      "Les lieux de vie de l’école sont suffisamment surveillés, il n’y a pas de territoire d’impunité à l’école",
      "En fonction de leur âge, il existe des espaces qui correspondent aux besoins des élèves (lieux d’apaisement, lieux d’autonomie, salle des rhétos). La cour est aménagée",
      "Les toilettes sont propres. L’intimité y est suffisante",
      "Les abords de l’école (espaces périscolaires, trajets depuis le bus/la gare) sont bien vécus par les élèves",
      "Lorsqu’un fait de comportement (moquerie, insulte, dispute, bagarre, dégradation…) est vu par un enseignant, il réagit de manière prompte, même s’il ne connaît pas directement l’élève. Toute l’équipe porte le règlement",
      "Les élèves peuvent maintenir leurs affaires personnelles en sécurité grâce aux aménagements ad hoc (casiers, espaces sécurisés…)",
      "Les locaux sont propres. Les dégradations sont réparées rapidement si nécessaire",
      "La pause de midi est bien organisée. Le niveau de bruit du réfectoire est sous contrôle, de sorte que le réfectoire ne soit pas un lieu de stress",
      "Il est possible de trouver des adaptations aux élèves à besoins spécifiques (gestion du handicap, entraide)",
      "Chaque élève peut trouver un adulte de référence à qui parler en cas de soucis"
    ]
  },
  {
    number: 6,
    name: "L’école est bien entourée, elle est aidée par des services professionnels (Pratiques partenariales)",
    questions: [
      "Les partenaires de l’école sont identifiés. Les instances de rencontre de ces partenaires sont tenues (conseil de participation, réunion des parents…)",
      "Les partenaires et l’école collaborent bien. Chacun reste dans son rôle",
      "Il est possible de rédiger une convention de fonctionnement avec un partenaire si besoin",
      "L’école ne nourrit pas de communication délétère envers un partenaire (ex : « avec ces parents-là, que veux-tu faire !! »)",
      "Les difficultés peuvent être formulées en demandes recevables aux partenaires si nécessaire",
      "L’école a cartographié les ressources locales et en informe les élèves et parents au besoin",
      "Les réunions d’intégration des élèves à besoins spécifiques sont bien balisées. Les échanges entre partenaires sont bons. Des adaptations pertinentes sont identifiées et évaluées entre partenaires au cours du temps",
      "Les élèves à besoins spécifiques ne se sentent pas sujets de moquerie ou de jalousie",
      "Les coopérations sont valorisées publiquement (affichage…), les personnes impliquées sont remerciées",
      "La communication interne au sujet des pratiques partenariales (projets) est fluide. Chacun sait comment prendre connaissance des informations"
    ]
  },
  {
    number: 7,
    name: "Notre alliance éducative avec les parents me satisfait",
    questions: [
      "Les familles sont considérées comme des partenaires avec lesquels construire une cohérence éducative. Elles ne sont ni jugées, ni culpabilisées. Nous ne cultivons pas de discours négatifs à leur propos",
      "Il existe un dispositif favorisant la communication (site web, journal, café des parents…) entre la famille et l’école",
      "La participation des parents à la vie de l’école existe et est à sa juste place (instances…)",
      "Une charte de coéducation définissant les attentes, les rôles, les responsabilités existe. Sinon, je trouve que nous gagnerions à en créer une",
      "Si nécessaire, les documents transmis aux parents sont traduits ou simplifiés",
      "En cas de tension avec l’élève, nous trouvons le temps de chercher à communiquer avec les parents",
      "En équipe, nous parvenons à garder notre calme face aux parents agressifs",
      "En tant qu’enseignant(e), je connais (maîtrise) suffisamment bien les techniques de gestion des conflits face à l’agressivité",
      "Après que le ton soit monté, j’arrive à lâcher, à prendre du recul, à ne pas garder de rancœur, à revenir plus calmement dans le lien. Sinon, je sais où recevoir de l’aide",
      "Face aux parents dysfonctionnels, lorsqu’une alliance n’est pas possible, nous parvenons à poser avec l’élève le cadre de règles. Il finit par accepter que le mode de vie en dehors de l’école et au sein de l’école sont différents. Notre énergie est placée davantage sur le maintien du cadre au sein de l’école que sur un jugement sur le laisser-aller en dehors de l’école"
    ]
  },
  {
    number: 8,
    name: "Mon rôle d’enseignant a évolué et j’en suis heureux",
    questions: [
      "Même s’il m’arrive de sentir que le rôle de l’enseignant a beaucoup changé depuis mon entrée en fonction, je cherche à évoluer avec cette situation.",
      "C’est rare dans mon chef d’imputer mes difficultés face aux élèves au manque de présence éducative de leurs parents.",
      "Les discours médiatiques sont souvent anxiogènes, c’est mon rôle de tenter de les déconstruire avec les élèves, cela fait partie de leur formation.",
      "L’anxiété des élèves s’invite en classe et je suis d’accord de tenter d’y faire face par l’écoute et le dialogue.",
      "Dans le contexte actuel, j’ai le sentiment que l’institution scolaire est bien conduite par le Ministère et je valide souvent ses directives.",
      "Le travail hors classe est devenu avec le temps de plus en plus important et je m’y adapte volontiers.",
      "Les pédagogies actives ou nouvelles qui cherchent à mettre les élèves en projets ou en action m’intéressent ou m’inspirent.",
      "À l’école comme dans notre société, il est important de chercher à inclure, à trouver un équilibre avec les personnes dont le mode de vie ou l’origine s’écarte de la moyenne (élèves migrants, les nouveaux « genres » sexuels, élèves en parcours d’inclusion).",
      "À l’école, l’ouverture et la fermeté sur les limites vont de pair et sont bien en équilibre.",
      "L’intelligence artificielle présente un risque et un défi pour les enseignants et nous arrivons à situer nos cours et notre enseignement face à la quantité d’information qu’elle rend disponible."
    ]
  }
]

ActiveRecord::Base.transaction do
  themes_data.each do |t|
    theme = Theme.find_or_initialize_by(number: t[:number])
    theme.name   = t[:name]
    theme.active = true
    theme.save!

    # Crée/actualise les questions dans l’ordre demandé
    labels = t[:questions]
    labels.each_with_index do |label, idx|
      q = theme.questions.find_or_initialize_by(label: label)
      q.position = idx + 1
      q.active   = true
      q.save!
    end

    # Option de “nettoyage doux” : désactive les anciennes questions non listées
    theme.questions.where.not(label: labels).update_all(active: false)
  end
end

puts "Done. Themes: #{Theme.count}, Questions: #{Question.count}"
