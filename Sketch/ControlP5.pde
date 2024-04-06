void createUI() {
  affichage();

  String nomTri = "Trier";
  String nomFichier = "Fichier";
  String nomAjouter = "Ajouter";
  String nomSalle = "Salle";
  String nomGestion = "Gestion";
  String nomPara = "Paramètres";
  String nomReload = "Reload";
  String nomConnect = "Connect";

  fichier = cp5.addListBox(nomFichier)
    .setPosition(10, 10)
    .setSize(width / 20, height / 5)
    .setBarHeight(height / 30)
    .setItemHeight(height / 30)
    .addItems(new String[] {"Ouvrir CSV", "Enregistrer", "Charger", "Imprimer", "Ouvrir Plan"})
    .setColorBackground(primaryColor)
    .setColorForeground(secondaryColor)
    .setColorActive(activeColor)
    .setFont(createFont("data/Montserrat-Regular.ttf", 12))
    .close();

  ajouter = cp5.addListBox(nomAjouter)
    .setPosition(10 + width / 20 + width / 80, 10)
    .setSize(width / 20, height / 10)
    .setBarHeight(height / 30)
    .setItemHeight(height / 30)
    .addItems(new String[] {"Etudiant", "Table"})
    .setColorBackground(primaryColor)
    .setColorForeground(secondaryColor)
    .setColorActive(activeColor)
    .setFont(createFont("data/Montserrat-Regular.ttf", 12))
    .close();

  salle = cp5.addListBox(nomSalle)
    .setPosition(10 + width / 10 + width / 40, 10)
    .setSize(width / 10, height / 5)
    .setBarHeight(height / 30)
    .setItemHeight(height / 30)
    .addItems(new String[] {"Placement automatique", "Vider les tables", "Vider la salle"})
    .setColorBackground(primaryColor)
    .setColorForeground(secondaryColor)
    .setColorActive(activeColor)
    .setFont(createFont("data/Montserrat-Regular.ttf", 12))
    .close();

  gestion = cp5.addListBox(nomGestion)
    .setPosition(10 + width / 10 + width / 11 + 80, 10)
    .setSize(width / 20, height / 5)
    .setBarHeight(height / 30)
    .setItemHeight(height / 30)
    .addItems(new String[] {"Groupes", "Eloignements"})
    .setColorBackground(primaryColor)
    .setColorForeground(secondaryColor)
    .setColorActive(activeColor)
    .setFont(createFont("data/Montserrat-Regular.ttf", 12))
    .close();

  parametre = cp5.addButton(nomPara)
    .setPosition(10 + width / 4 + 80, 10)
    .setSize(width / 20, height / 30)
    .setColorBackground(primaryColor)
    .setColorForeground(secondaryColor)
    .setFont(createFont("data/Montserrat-Regular.ttf", 12))
    .setColorActive(activeColor);

  reloadBtn = cp5.addButton(nomReload)
    .setPosition(width * 0.75 + 10, height / 20 + 10)
    .setSize(widthReloadFull, height / 20)
    .setCaptionLabel("")
    .setImage(reload)
    .setColorBackground(color(190, 190, 190));

  tri = cp5.addListBox(nomTri)
    .setPosition(width - widthFiltreFull - 65, height / 20 + 10)
    .setSize(width / 17, height / 5)
    .setBarHeight(height / 20)
    .setItemHeight(height / 30)
    .addItems(new String[] {"Nom [A-Z]", "Nom [Z-A]", "Groupe", "Sous Groupe"})

    .setPosition(width - widthFiltreFull - 65, height / 20 + 10)
    .setSize(width / 17, height / 5)
    .setBarHeight(height / 20)
    .setItemHeight(height / 30)
    .addItems(new String[] {"Nom [A-Z]", "Nom [Z-A]", "Groupe", "Sous Groupe"})

    .setColorBackground(primaryColor)
    .setColorForeground(secondaryColor)
    .setColorActive(activeColor)
    .setFont(createFont("data/Montserrat-Regular.ttf", 12))
    .close();


  


  longTable = cp5.addSlider("Longueur Table")
    .setNumberOfTickMarks(91)
    .setPosition(width / 6*2.5 +320, height/ 5*4-30)
    .setSize(200, 20)
    .setRange(40, 130)
    .setColorLabel(0)
    .setValue(50);


  largTable = cp5.addSlider("Largeur Table")
    .setNumberOfTickMarks(111)
    .setPosition(width / 6*2.5 + 320, height/ 5*4-60)
    .setSize(200, 20)
    .setRange(70, 180)
    .setColorLabel(0)
    .setValue(100);

  Label label = cp5.getController("Largeur Table").getCaptionLabel();
  label.setFont(createFont("Arial", 13));
  label = cp5.getController("Longueur Table").getCaptionLabel();
  label.setFont(createFont("Arial", 13));


  float rectX = width * 0.75 + width * 0.25 / 5;

  rechercheTF = cp5.addTextfield("recherche")
    .setPosition(rectX + 10, height / 20 + 15)
    .setSize(int(width * 0.25 / 5 * 3 * 0.9 - 20), height / 20 - 10)
    .setFont(createFont("data/Montserrat-Regular.ttf", 22))
    .setColor(color(50))
    .setColorBackground(color(255))
    .setColorActive(color(255))
    .setColorForeground(color(255))
    .setColorCursor(textColorField)
    .setCaptionLabel("");

  cp5.addButton("Quitter")
    .setPosition(width - quit.width - 6, 6)
    .setSize(widthFiltreFull, height / 20)
    .setCaptionLabel("")
    .setImage(quit)
    .setColorBackground(color(190))
    .setColorForeground(primaryColor);

  connectButton = cp5.addButton(nomConnect)
    .setPosition(width - width / 4, 10)
    .setSize(width / 20, height / 30)
    .setLabel(textConnect)
    .setColorBackground(primaryColor)
    .setColorForeground(secondaryColor)
    .setFont(createFont("data/Montserrat-Regular.ttf", 12))
    .setColorActive(activeColor);
}

void controlEvent(ControlEvent theEvent) {
  if (etat == 0) {
    if (theEvent.isController()) {
      if (theEvent.getController() instanceof ListBox) {
        ListBox d = (ListBox) theEvent.getController();
        if (d.getName().equals("Fichier")) {
          if (d.getValue() == 0) {
              try {
                ouvrirExcel.showAll();
                excelIn = true;
                excelOpen = true;
                etat = 4;
                disableClickabilityOfAllCP5Elements();
              }
              catch(Exception ex) {
              }
            fichier.close();
          } else if (d.getValue() == 1) {
               enregistrerDonneesJSON();
            fichier.close();
          } else if (d.getValue() == 2) {
            chargerDonneesJSON();
            fichier.close();
          } else if (d.getValue() == 3) {
            if (afficheTab) {

              drawListeEtudiants2();
            }
            fichier.close();
          } else if (d.getValue() == 4) {
            Frame mainFrame = new Frame("Sélectionnez un fichier SVG");
            FileDialog dialog = new FileDialog(mainFrame, "Sélectionnez un fichier SVG", FileDialog.LOAD);
            dialog.setFile("*.svg");
            dialog.setVisible(true);
            String directory = dialog.getDirectory();
            String file = dialog.getFile();
            if (directory != null && file != null) {
              String selectedFilePath = directory + file;
              masalle= new Salle(selectedFilePath);
              svgSalleToString= loadStrings(selectedFilePath);
              compteurTables=1;
              afficherSal=true;
              println("Open 1");
              masalle.dessinerPlan();
            }
            fichier.close();
          }
        } else if (d.getName().equals("Trier") && listeEtu != null) {
          int filterOption = (int)d.getValue()+1;
          if (filterOption == 1) {
            listeEtu.trierEtudiantsParNom();
            afficherTableauEtudiant(listeEtu);
            tri.close();
          } else if (filterOption == 2) {
            listeEtu.trierEtudiantsParNomDecroissant();
            afficherTableauEtudiant(listeEtu);
            tri.close();
          } else if (filterOption == 3) {
            listeEtu.trierEtudiantsParGroupePrincipal();
            afficherTableauEtudiant(listeEtu);
            tri.close();
          } else if (filterOption == 4) {
            listeEtu.trierEtudiantsParSousGroupe();
            afficherTableauEtudiant(listeEtu);
            tri.close();
          }
        } else if (d.getName().equals("Ajouter")) {
          if (d.getValue() == 0) {

            if (afficheTab) {
              ajouter.close();
              if (listeEtu != null) {
                try {
                  ajouterEtudiant.showAll();
                  etat = 2;
                  disableClickabilityOfAllCP5Elements();
                  ajoutEtudiant = true;
                }
                catch(Exception ex) {
                }
              }
            } else {
              sonAlerte.play();
              JOptionPane.showMessageDialog(null, "Veuillez d'abord ouvrir un fichier Excel (.csv)", "Liste d'étudiants manquante", JOptionPane.INFORMATION_MESSAGE);
            }
            ajouter.close();
          } else if (d.getValue() == 1) {
            if (afficherSal) {
              Table t=new Table(masalle.getMinScale());
              masalle.addTable(t);
              masalle.dessinerPlan();
              ajouter.close();
            } else {
              sonAlerte.play();
              JOptionPane.showMessageDialog(null, "Veuillez d'abord ouvrir un plan de salle (.svg)", "Plan de salle manquant", JOptionPane.INFORMATION_MESSAGE);
            }
          }
        } else if (d.getName().equals("Config")) {

          if (d.getValue() == 0) {
          } else if (d.getValue() == 1) {
            if (connect[1] == "false") {
              chargerDonneesJSON();
            } else {
              chargerDonnesJSONDataBase();
            }
          }
        } else if (d.getName().equals("Salle")) {
          if (afficherSal) {
            if (d.getValue() == 0) {
              masalle.placerEtudiantsAvecContraintes();
              salle.close();
            }
            if (d.getValue() == 1) {
              salle.close();
              masalle.viderTable();
            }
            if (d.getValue() == 2) {
              salle.close();
              masalle.viderSalle();
            }
          } else {
            sonAlerte.play();
            JOptionPane.showMessageDialog(null, "Veuillez d'abord ouvrir un plan de salle (.svg)", "Plan de salle manquant", JOptionPane.INFORMATION_MESSAGE);
          }
        } else if (d.getName().equals("Gestion")) {
          println("Gestion : " + afficheTab);
          if (afficheTab) {
            if (d.getValue() == 0) {
              if (!gestionGrp.exist()) {
                try {
                  gestionGrp.show();
                }
                catch(Exception ex) {
                }
              }
              gestion.close();
            } else
              if (d.getValue() == 1) {
                etat = 7;
                eloiOpen = true;
                createRectangleButton.show();
                removeEtudiantButton.show();
                removeButton.show();
                addEtudiantButton.show();
                ajoutEtudiantDeroulant.show();
                leaveEloi.show();
                disableClickabilityOfAllCP5Elements();
              }
            gestion.close();
          } else {
            sonAlerte.play();
            JOptionPane.showMessageDialog(null, "Veuillez d'abord ouvrir un fichier Excel (.csv)", "Liste d'étudiants manquante", JOptionPane.INFORMATION_MESSAGE);
          }
        } else {
          d.open();
        }
      } else {
        if (theEvent.getController().getName().equals("Reloader")) {
          resetRecherche();
        } else if (theEvent.getController().getName().equals("Filtre")) {
        } else if (theEvent.getController().getName().equals("Paramètres")) {
          themes.show();
          statusLegend.show();
          leavePara.show();
          etat = 3;
          disableClickabilityOfAllCP5Elements();
        } else if (theEvent.getController().getName().equals("Quitter")) {
          sonAlerte.play();
          String stringQuitApp = "Voulez-vous vraiment quitter ? Toute donnée non sauvegardée sera perdue.";
          int confirmation = JOptionPane.showConfirmDialog(null, stringQuitApp, "Quitter StudentDeskMate", JOptionPane.YES_NO_OPTION);

          if (confirmation == JOptionPane.YES_OPTION) {
            exit();
          }
        } else if (theEvent.getController().getName().equals("Connect")) {
          etat = 8;
          if (connect[1] == "false") {
            leaveConnexion.show();
            idConnexion.show();
            lgConnexion.show();
            connButton.show();
          } else {
            deconnButton.show();
            leaveConnexion.show();
          }
        } else if (theEvent.getName().equals("tableWidth")) {
          longueurTable = (int) theEvent.getValue();
        } else if (theEvent.getName().equals("tableHeight")) {
          largeurTable = (int) theEvent.getValue();
        } else if (theEvent.getName().equals("Longueur Table")) {
          longueurTable = (int) theEvent.getValue();
        } else if (theEvent.getName().equals("Largeur Table")) {
          largeurTable = (int) theEvent.getValue();
        }
      }
    }
    if (theEvent.isAssignableFrom(Textfield.class)) {
      if (theEvent.getName().equals("recherche") && listeEtu != null) {
        recherche = theEvent.getStringValue();
        switch (colonneSelectionnee) {
        case 0:
          rechercheDansLesNoms(recherche, listeEtu);
          break;
        case 1:
          rechercheDansLesPrenoms(recherche, listeEtu);
          break;
        case 2:
          rechercheDansLesGroupes(recherche, listeEtu);
          break;
        case 3:
          rechercheDansLesNumeros(recherche, listeEtu);
          break;
        case -1:
          afficherTableauEtudiant(listeEtu);
          break;
        }
      }
    }
  } else 
    if (etat == 2) {
      if (theEvent.isController()) {
        String name = theEvent.getController().getName();
        if (name.equals("ValiderButton")) {
          fill(backgroundColor);
          rect(width/3, height/3, width / 2 - width / 3 / 2, height / 2 - height / 3 / 2);
          println("Sort");
          ajouterEtudiant.hideAll();
          enableClickabilityOfAllCP5Elements();
          derniereActivite = millis();
          etat = 0;
        } else if (name.equals("QuitterAddEtu")){
          fill(backgroundColor);
          rect(width/3, height/3, width / 2 - width / 3 / 2, height / 2 - height / 3 / 2);
          println("Sort");
          ajouterEtudiant.hideAll();
          enableClickabilityOfAllCP5Elements();
          derniereActivite = millis();
          etat = 0;
        }
      }
  } else {
    if (etat == 3) {
      if (theEvent.isController()) {
        if (theEvent.getController() instanceof ListBox) {
          ListBox d = (ListBox) theEvent.getController();
          if (d.getName().equals("Themes")) {
            if (d.getValue() == 0) {
              etat = 0;
              para.setTheme(paletteDefault);
              etat = 3;
              d.close();
            } else if (d.getValue() == 1) {
              etat = 0;
              para.setTheme(paletteClair);
              etat = 3;
              d.close();
            } else if (d.getValue() == 2) {
              etat = 0;
              para.setTheme(paletteSombre);
              etat = 3;
              d.close();
            } else if (d.getValue() == 3) {
              etat = 0;
              para.setTheme(paletteGirly);
              etat = 3;
              d.close();
            }
            para.buttonColorMaj(cp5, rechercheTF);
            para.buttonColorMaj(cp5Para, rechercheTF);
            para.buttonColorMaj(cp5EtuSelec, prenomTf);
            para.buttonColorMaj(cp5EtuSelec, nomTf);
            para.buttonColorMaj(cp5EtuSelec, numTf);
            para.buttonColorMaj(cp5EtuSelec, grpTf);
            para.buttonColorMaj(cp5EtuSelec, grpElTf);
            para.buttonColorMaj(cepe5, rechercheTF);
            para.buttonColorMaj(cp5Elo, rechercheTF);
          }
        } else {
          if (theEvent.getController().getName().equals("QuitterPara")) {
            fill(backgroundColor);
            rect(0, height/20, width - width / 4, height - height / 5 - height /20);
            println("Sort");
            themes.hide();
            statusLegend.hide();
            leavePara.hide();
            enableClickabilityOfAllCP5Elements();
            derniereActivite = millis();
            etat = 0;
          }
        }
      }
    } else 
      if (etat == 4) {
        if (theEvent.isController()) {
          String name = theEvent.getController().getName();
          if (name.equals("OuvrirFichier")) {
            fill(backgroundColor);
            rect(width/3, height/3, width / 2 - width / 3 / 2, height / 2 - height / 3 / 2);
            println("Sort open Excel");
            ouvrirExcel.hideAll();
            enableClickabilityOfAllCP5Elements();
            derniereActivite = millis();
            etat = 0;
          } else if (name.equals("QuitterOpenExcel")){
            fill(backgroundColor);
            rect(width/3, height/3, width / 2 - width / 3 / 2, height / 2 - height / 3 / 2);
            println("Sort open Excel");
            ouvrirExcel.hideAll();
            enableClickabilityOfAllCP5Elements();
            derniereActivite = millis();
            etat = 0;
          }
        }
    } else {
      if (etat == 8) {
        if (theEvent.isController()) {
          if (theEvent.getController().getName().equals("connexionButton")) {
            connect = connexionMode.verifierConnexion();
            if (connect[1] != "false") {
              changeLogin();
              leaveConnexion.hide();
              idConnexion.hide();
              lgConnexion.hide();
              connButton.hide();
              lgConnexion.setText("");
              idConnexion.setText("");
              derniereActivite = millis();

              etat = 0;
            } else {
              lgConnexion.setText("");
            }
          } else if (theEvent.getController().getName().equals("deconnexionButton")) {
            deconnButton.hide();
            leaveConnexion.hide();
            connect[0] = "Login";
            connect[1] = "false";
            lgConnexion.setText("");
            idConnexion.setText("");
            changeLogin();
            derniereActivite = millis();
            etat = 0;
          } else if (theEvent.getController().getName().equals("leaveConn")) {
            fill(backgroundColor);
            rect(width/3, height/3, width / 2 - width / 3 / 2, height / 2 - height / 3 / 2);

            leaveConnexion.hide();
            idConnexion.hide();
            lgConnexion.hide();
            connButton.hide();
            deconnButton.hide();

            derniereActivite = millis();
            etat = 0;
          }
        }
      }
      if (etat == 7) {
        if (theEvent.getController().getName().equals("leaveEloi")) {
          fill(backgroundColor);
          rect(0, height/20, width - width / 4, height - height / 5 - height /20);
          println("Sort");
          createRectangleButton.hide();
          removeEtudiantButton.hide();
          removeButton.hide();
          addEtudiantButton.hide();
          ajoutEtudiantDeroulant.hide();
          leaveEloi.hide();
          enableClickabilityOfAllCP5Elements();
          derniereActivite = millis();
          etat = 0;
        }
      }
    }
  }
}
