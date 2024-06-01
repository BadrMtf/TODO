# TODO
# Gestionnaire de Tâches Bash
Ce script shell permet de gérer une liste de tâches via un fichier texte. Il permet de créer, mettre à jour, supprimer, afficher, lister et rechercher des tâches.
Assurez-vous que le script est exécutable :
chmod +x votre-script.sh
Pour afficher l'utilisation du script :
./TODO.sh
Pour créer une nouvelle tâche :
./TODO.sh create
Pour mettre à jour une tâche existante :
./TODO.sh update
Pour supprimer une tâche :
./TODO.sh delete
Pour afficher les détails d'une tâche spécifique :
./TODO.sh show
Pour lister les tâches pour une date spécifique :
./TODO.sh list
Pour rechercher des tâches par titre :
./TODO.sh search
Format du fichier de tâches
Les tâches sont stockées dans un fichier todo.txt avec le format suivant :
id|titre|description|lieu|date d'échéance|heure d'échéance|complétée
