String[] lines;  // Pour stocker les lignes du fichier CSV
String[] header; // Pour stocker le nom des colonnes

class ListeEtu {
  private ArrayList<Etudiant> etudiants;
  private ArrayList<Groupe> groupes;

  public ListeEtu() {
    etudiants = new ArrayList<Etudiant>();
    groupes = new ArrayList<Groupe>();
  }

  public ListeEtu(ArrayList<Etudiant> etudiants) {
    this.etudiants = new ArrayList<>(etudiants);
  }

  public boolean estVide() {
    return etudiants.isEmpty();
  }

  public void ajouterEtudiant(Etudiant etudiant) {
    etudiants.add(etudiant);
    mapEtudiant.put(etudiant.getNom() +" "+ etudiant.getPrenom() +" "+ etudiant.getNum(), etudiant);
  }

  public void ajouterGroupe(Groupe groupe) {
    for (Groupe existingGroupe : groupes) {
        if (existingGroupe.getNom().equals(groupe.getNom())) {
            return;
        }
    }
    groupes.add(groupe);
  }

  public void supprimerEtudiant(Etudiant etudiant) {
    etudiants.remove(etudiant);
    mapEtudiant.remove(etudiant.getNom() +" "+ etudiant.getPrenom() +" "+ etudiant.getNum());
  }

  public Etudiant getEtu(int num){
  for(Etudiant e : etudiants){
    if(e.getNum()==num){return e;}
  }
  return null;
  }

  public void clearEtu(){
    etudiants.clear();
  }
  
  public void clearGrp(){
    groupes.clear();
  }

  public ArrayList<Etudiant> getEtudiants() {
    return etudiants;
  }

  public ArrayList<Groupe> getGroupes() {
    return groupes;
  }

  public int[] detecterDebutFinListeEtudiants(String fichierCSV) {
    String[] lignes = loadStrings(fichierCSV);
    int debut = -1;
    int fin = -1;
  
    for (int i = 0; i < lignes.length; i++) {
      String ligne = lignes[i].trim();
      if (!ligne.equals("")) {
        String[] parts = split(ligne, ';');
        if (parts.length >= 5) { 
          try {
            Integer.parseInt(parts[0].trim());
            boolean autresColonnesValides = true;
            for (int j = 1; j <= 4; j++) {
              if (parts[j].trim().isEmpty()) {
                autresColonnesValides = false;
                break;
              }
            }
            if (autresColonnesValides) {
              if (debut == -1) debut = i;
              fin = i;
            }
          } catch (NumberFormatException e) {
          }
        }
      }
    }
  
    return new int[]{debut, fin};
  }
  
  //public void importerEtudiants(String fichierCSV, int debut, int fin) {
  //  if (debut != -1 && fin != -1) {
  //    String[] lignes = loadStrings(fichierCSV);
  
  //    for (int i = debut; i <= fin; i++) {
  //      String[] parts = split(lignes[i], ';');
  //      if (parts.length > 0 && !parts[0].isEmpty()) {
  //        int numeroEtudiant = parts.length > 0 ? Integer.parseInt(parts[0]) : -1;
  //        String groupe = parts.length > 1 ? parts[1] : "";
  //        String sous_groupe = parts.length > 2 ? parts[2] : "";
  //        String nom = parts.length > 3 ? parts[3] : "";
  //        String prenom = parts.length > 4 ? parts[4] : "";
  
  //        Etudiant etudiant = new Etudiant(numeroEtudiant, nom, prenom, null);
  //        Groupe groupeObj = chercheGroupeParNom(groupe);
  //        if (groupeObj == null) {
  //          groupeObj = new Groupe(groupe, color(random(256), random(256), random(256)));
  //          groupes.add(groupeObj);
  //        }
  
  //        groupeObj.addEtu(etudiant);
  //        etudiant.ajouterGroupe(groupeObj);
  
  
  //        groupeObj = chercheGroupeParNom(sous_groupe);
  //        if (groupeObj == null) {
  //          groupeObj = new Groupe(sous_groupe, color(random(256), random(256), random(256)));
  //          groupes.add(groupeObj);
  //        }
  
  //        groupeObj.addEtu(etudiant);
  //        etudiant.ajouterGroupe(groupeObj);
  
  
  //        ajouterEtudiant(etudiant);
  //      }
  //    }
  //      gestionGrp.loadGroupe(groupes);
  //      legende.setGroupe(groupes);
  //      nbGroupe = groupes.size();
  //  } else {
  //    println("Liste d'étudiants non détectée dans le fichier.");
  //  }
  //}
  
  public void importerEtudiants(String fichierCSV, int debut, int fin) {
    if (debut != -1 && fin != -1) {
        String[] lignes = loadStrings(fichierCSV);

        for (int i = debut; i <= fin; i++) {
            String[] parts = split(lignes[i], ';');
            boolean ligneValide = false;

            for (String part : parts) {
                if (!part.isEmpty()) {
                    ligneValide = true;
                    break;
                }
            }

            // Si la ligne est valide pour un étudiant
            if (ligneValide) {
                int numeroEtudiant = parts.length > 0 && !parts[0].isEmpty() ? Integer.parseInt(parts[0]) : -1;
                String groupe = parts.length > 1 ? parts[1] : "";
                String sous_groupe = parts.length > 2 ? parts[2] : "";
                String nom = parts.length > 3 ? parts[3] : "";
                String prenom = parts.length > 4 ? parts[4] : "";

                Etudiant etudiant = new Etudiant(numeroEtudiant, nom, prenom, null);
                Groupe groupeObj = chercheGroupeParNom(groupe);
                if (groupeObj == null) {
                    groupeObj = new Groupe(groupe, color(random(256), random(256), random(256)));
                    groupes.add(groupeObj);
                }

                groupeObj.addEtu(etudiant);
                etudiant.ajouterGroupe(groupeObj);

                groupeObj = chercheGroupeParNom(sous_groupe);
                if (groupeObj == null) {
                    groupeObj = new Groupe(sous_groupe, color(random(256), random(256), random(256)));
                    groupes.add(groupeObj);
                }

                groupeObj.addEtu(etudiant);
                etudiant.ajouterGroupe(groupeObj);

                ajouterEtudiant(etudiant);
            }
        }

        gestionGrp.loadGroupe(groupes);
        legende.setGroupe(groupes);
        nbGroupe = groupes.size();
    } else {
        println("Liste d'étudiants non détectée dans le fichier.");
    }
}



  private Groupe chercheGroupeParNom(String nomGroupe) {
    for (Groupe groupe : groupes) {
      if (groupe.getNom().equals(nomGroupe)) {
        return groupe;
      }
    }
    return null;
  }

  public void exporterListe(String nomFichier) {
    String[] lignes = new String[etudiants.size() + 9];
    lignes[0] = "DUT INFORMATIQUE - SEMESTRE 3;;;;;Matiere :;;" + day() + "/" + month() + "/" + year();
    lignes[1] = ";;;;;;;";
    lignes[2] = "MERCI DE LAISSER LA LISTE CI-DESSOUS DANS L'ORDRE ALPHABETIQUE;;;;;;;";
    lignes[3] = ";;;;;;;";
    lignes[4] = ";;;;;;;";
    lignes[5] = "Num Etudiant;Groupe;\"1/2 Groupe\";Nom;Prenom;Note;;";
    lignes[6] = ";;;;;;;";

    for (int i = 0; i < etudiants.size(); i++) {
      Etudiant etudiant = etudiants.get(i);
      String ligne = etudiant.getNum() + ";" + getGroupeName(etudiant) + ";" + getGroupeNameSousGroupe(etudiant) + ";" + etudiant.getNom() + ";" + etudiant.getPrenom() + ";;;";
      lignes[i + 7] = ligne;
    }

    for (int i = lignes.length - 1; i >= 0; i--) {
      if (lignes[i] != null) {
        break;
      }
      lignes = shorten(lignes);
    }

    saveStrings(nomFichier, lignes);
  }

  String getGroupeName(Etudiant etudiant) {
    String groupeName = "";
    ArrayList<Groupe> groupesEtudiant = etudiant.getGroupe();
    if (groupesEtudiant.size() > 0) {
      groupeName = groupesEtudiant.get(0).getNom();
    }
    return groupeName;
  }

  String getGroupeNameSousGroupe(Etudiant etudiant) {
    String groupeNameSousGroupe = "";
    ArrayList<Groupe> groupesEtudiant = etudiant.getGroupe();
    if (groupesEtudiant.size() > 1) {
      groupeNameSousGroupe = groupesEtudiant.get(1).getNom();
    }
    return groupeNameSousGroupe;
  }

  public void trierEtudiantsParNom() {
    for (int i = 0; i < etudiants.size() - 1; i++) {
      for (int j = 0; j < etudiants.size() - i - 1; j++) {
        if (etudiants.get(j).getNom().compareToIgnoreCase(etudiants.get(j + 1).getNom()) > 0) {
          // Échange des étudiants
          Etudiant temp = etudiants.get(j);
          etudiants.set(j, etudiants.get(j + 1));
          etudiants.set(j + 1, temp);
        }
      }
    }
  }

  public void trierEtudiantsParNomDecroissant() {
    for (int i = 0; i < etudiants.size() - 1; i++) {
      for (int j = 0; j < etudiants.size() - i - 1; j++) {
        if (etudiants.get(j).getNom().compareToIgnoreCase(etudiants.get(j + 1).getNom()) < 0) {
          // Échange des étudiants
          Etudiant temp = etudiants.get(j);
          etudiants.set(j, etudiants.get(j + 1));
          etudiants.set(j + 1, temp);
        }
      }
    }
  }


  public void trierEtudiantsParGroupePrincipal() {
    for (int i = 0; i < etudiants.size() - 1; i++) {
      for (int j = 0; j < etudiants.size() - i - 1; j++) {
        String groupeEtu1 = etudiants.get(j).getGroupe().get(0).getNom();
        String groupeEtu2 = etudiants.get(j + 1).getGroupe().get(0).getNom();

        if (groupeEtu1.compareTo(groupeEtu2) > 0) {
          // Échange des étudiants
          Etudiant temp = etudiants.get(j);
          etudiants.set(j, etudiants.get(j + 1));
          etudiants.set(j + 1, temp);
        }
      }
    }
  }

  public void trierEtudiantsParSousGroupe() {
    for (int i = 0; i < etudiants.size() - 1; i++) {
      for (int j = 0; j < etudiants.size() - i - 1; j++) {
        String groupeEtu1 = etudiants.get(j).getGroupe().get(1).getNom();
        String groupeEtu2 = etudiants.get(j + 1).getGroupe().get(1).getNom();

        if (groupeEtu1.compareTo(groupeEtu2) > 0) {
          // Échange des étudiants
          Etudiant temp = etudiants.get(j);
          etudiants.set(j, etudiants.get(j + 1));
          etudiants.set(j + 1, temp);
        }
      }
    }
  }
  
  private color trouverCouleurNonUtilisee() {
    color couleurAleatoire;

    do {
        couleurAleatoire = color(random(256), random(256), random(256));
    } while (couleurDejaUtilisee(couleurAleatoire));

    return couleurAleatoire;
  }
  
  private boolean couleurDejaUtilisee(color couleur) {
      for (Groupe groupe : groupes) {
          if (groupe.getColor() == couleur) {
              return true;
          }
      }
      return false;
  }
}
