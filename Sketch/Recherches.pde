boolean rechercheEtudiant(Etudiant etudiant) {
  if (recherche != null) {
    String rechercheLower = recherche.toLowerCase();
    if (recherche.isEmpty() ||
      etudiant.getNom().toLowerCase().contains(rechercheLower) ||
      etudiant.getPrenom().toLowerCase().contains(rechercheLower) ||
      etudiant.getGroupeString().toLowerCase().contains(rechercheLower) ||
      etudiant.getNumString().contains(recherche)) {
      return true;
    }
  } else {
    return true;
  }
  return false;
}

void rechercheDansLesNoms(String recherche, ListeEtu liste) {
    for (Etudiant etudiant : liste.getEtudiants()) {
        if (recherche.isEmpty() || etudiant.getNom().toLowerCase().contains(recherche.toLowerCase())) {
            etudiant.setVisible(true);
        } else {
            etudiant.setVisible(false);
        }
    }
}

void rechercheDansLesPrenoms(String recherche, ListeEtu liste) {
    for (Etudiant etudiant : liste.getEtudiants()) {
        if (recherche.isEmpty() || etudiant.getPrenom().toLowerCase().contains(recherche.toLowerCase())) {
            etudiant.setVisible(true);
        } else {
            etudiant.setVisible(false);
        }
    }
}

void rechercheDansLesGroupes(String recherche, ListeEtu liste) {
    for (Etudiant etudiant : liste.getEtudiants()) {
        if (recherche.isEmpty() || etudiant.getGroupeString().toLowerCase().contains(recherche.toLowerCase())) {
            etudiant.setVisible(true);
        } else {
            etudiant.setVisible(false);
        }
    }
}

void rechercheDansLesNumeros(String recherche, ListeEtu liste) {
    for (Etudiant etudiant : liste.getEtudiants()) {
        if (recherche.isEmpty() || etudiant.getNumString().toLowerCase().contains(recherche.toLowerCase())) {
            etudiant.setVisible(true);
        } else {
            etudiant.setVisible(false);
        }
    }
}

void resetRecherche() {
    for (Etudiant etudiant : listeEtu.getEtudiants()) {
        etudiant.setVisible(true); 
    }
  recherche = "";
  cp5.get(Textfield.class, "recherche").setText(recherche);
  afficherTableauEtudiant(listeEtu);
}
