void afficherTableauEtudiant(ListeEtu liste) {
  fill(fillColorLight);
  rect(width * 0.75, height / 20 + widthFiltreFull + 20, width * 0.25, height - height / 20);

  fill(180);
  rect(width * 0.75, height / 20 + widthFiltreFull + 20, width * 0.25, height / 20 - yOffset);

  if (colonneSelectionnee >= 0 && colonneSelectionnee <= 3) {
    fill(colorSelectionnee);
    if (colonneSelectionnee == 0) {
      rect(width * 0.75, height / 20 + widthFiltreFull + 20, colonneWidth + (xOffset / 3), height / 20 - yOffset);
    } else {
      rect(width * 0.76 + colonneSelectionnee * colonneWidth, height / 20 + widthFiltreFull + 20, colonneWidth, height / 20 - yOffset);
    }
  }

  fill(0);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Nom", width * 0.76 + xOffset, height / 20 + widthFiltreFull + 20 + yOffset);
  text("Prenom", width * 0.76 + colonneWidth + xOffset, height / 20 + widthFiltreFull + 20 + yOffset);
  text("Groupe", width * 0.76 + 2 * colonneWidth + xOffset, height / 20 + widthFiltreFull + 20 + yOffset);
  text("Numéro", width * 0.76 + 3 * colonneWidth + xOffset, height / 20 + widthFiltreFull + 20 + yOffset);
  textAlign(LEFT, CENTER);

  for (int i = 1; i < 4; i++) {
    float x = width * 0.76 + i * colonneWidth;
    line(x, height / 20 + widthFiltreFull + 20, x, height / 20 + widthFiltreFull + 20 + height / 20 - yOffset);
  }

  int startIndex = 0;

  if (scrollListEtu >= 1) {
    startIndex = Math.min(liste.getEtudiants().size() - 1, startIndex + scrollListEtu);
  } else if (scrollListEtu <= -1) {
    startIndex = Math.max(0, startIndex + scrollListEtu);
  }

  lastEtudiant = 0;
  couleurFondClaire = true;
  for (int i = startIndex; i < liste.getEtudiants().size(); i++) {
    Etudiant etudiant = liste.getEtudiants().get(i);

    if (rechercheEtudiant(etudiant) && etudiant.isVisible()) {
      ajouterLigne(etudiant.getNom(), etudiant.getPrenom(), etudiant.getGroupe(), etudiant.getNum());
    }
  }

  //verifLigneSelec(liste);

  //line(width * 0.76, height / 20 + widthFiltreFull + 20 + yOffset * 4, width * 0.76 + xOffset + width * 0.25, height / 20 + widthFiltreFull + 20 + yOffset * 4);

  lastEtudiant = 0;
  afficheTab = true;
}

void ajouterLigne(String nom, String prenom, ArrayList<Groupe> lstGroupes, int num) {
  stroke(0);
  float colonneWidth = (width * 0.25) / 4;
  float ligneOffset = 0;
  float espaceEntreLignes = 40;
  float rectWidth = width * 0.25;
  float rectHeight = 40;
  float rectYOffset = 10;

  if (couleurFondClaire) {
    fill(190);
  } else {
    fill(200);
  }

  if (lastEtudiant == etudiantSelectionne - scrollListEtu) {
    fill(selecColor);
  } else {
    if (couleurFondClaire) {
      fill(190);
    } else {
      fill(200);
    }
  }

  rect(width * 0.75, height / 20 + widthFiltreFull + 20 + ligneOffset + 40 * lastEtudiant + espaceEntreLignes, rectWidth, rectHeight);

  fill(0);

  if (masalle != null && afficheTab) {
    if (etudiantAttribueATable(num, masalle.getList())) {
      fill(255, 0, 0);
    } else {
      fill(0);
    }
  }

  textSize(15);

  float textNomWidth = textWidth(nom);
  float textPrenomWidth = textWidth(prenom);

  if (textNomWidth > colonneWidth - 10 && nom.length() > 10) {
    nom = nom.substring(0, 10) + "...";
  }
  if (textPrenomWidth > colonneWidth - 10 && prenom.length() > 10) {
    prenom = prenom.substring(0, 10) + "...";
  }


  text(nom, width * 0.76, height / 20 + widthFiltreFull + 20 + ligneOffset + 40 * lastEtudiant + espaceEntreLignes + 20);
  text(prenom, width * 0.76 + colonneWidth + 15, height / 20 + widthFiltreFull + 20 + ligneOffset + 40 * lastEtudiant + espaceEntreLignes + 20);

  String groupesString = "";
  for (Groupe groupe : lstGroupes) {
    groupesString += groupe.getNom() + ", ";
  }
  if (!groupesString.equals("")) {
    groupesString = groupesString.substring(0, groupesString.length() - 2);
  }
  text(groupesString, width * 0.76 + 2 * colonneWidth + 15, height / 20 + widthFiltreFull + 20 + ligneOffset + 40 * lastEtudiant + espaceEntreLignes+20);

  text(num, width * 0.76 + 3 * colonneWidth + 15, height / 20 + widthFiltreFull + 20 + ligneOffset + 40 * lastEtudiant + espaceEntreLignes+20);

  for (int i = 1; i < 4; i++) {
    float x = width * 0.76 + i * colonneWidth;
    line(x, height / 20 + widthFiltreFull + 20 + ligneOffset + 20 * lastEtudiant + espaceEntreLignes, x, height / 20 + widthFiltreFull + 20 + ligneOffset + 40 * lastEtudiant + espaceEntreLignes-10 + rectYOffset + rectHeight);
  }

  lastEtudiant++;
  couleurFondClaire = !couleurFondClaire;
}

public boolean etudiantAttribueATable(int numeroEtudiant, ArrayList<Table> tables) {
  for (Table table : tables) {
    Etudiant etudiantAssigne = table.getEtu();
    if (etudiantAssigne != null && etudiantAssigne.getNum() == numeroEtudiant) {
      return true;
    }
  }
  return false;
}
