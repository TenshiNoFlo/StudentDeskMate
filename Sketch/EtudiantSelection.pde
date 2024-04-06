class EtudiantSelection extends Fenetre {

  String CheminPhotoEtu = "";

  public EtudiantSelection(PApplet parent, int w, int h) {
    super(parent, w, h);
    PApplet.runSketch(new String[]{"Gérer étudiant"}, this);
    surface.setVisible(false);
  }

  public void setup() {
    cp5EtuSelec = new ControlP5(this);
    createUI();
    int buttonWidth = int(width / 3.5);
    int textHeight = height / 8;
    stroke(0);
    background(backgroundColor);
    fill(menuColor);
    rect(0, 0, width, height / 8);
    roundedRectEtu(5, 25 + textHeight, buttonWidth+5, textHeight+5, 15, primaryColor);
    textFont(createFont("Montserrat-Regular", 12));
  }

  void createUI() {
    int buttonWidth = int(width / 3.5);
    int buttonHeight = height / 14;
    int textHeight = height / 8;
    int buttonSpacing = 40;
    int pad = 10;

    float imageX = 20;
    float imageY = buttonSpacing + 15;
    int imageWidth = 150;


    cp5EtuSelec.addButton("Supprimer étudiant")
      .setPosition(10, 10)
      .setSize(buttonWidth, buttonHeight)
      .setFont(createFont("Montserrat-Regular", 12))
      .setColorBackground(primaryColor)
      .setColorForeground(secondaryColor)
      .setColorActive(activeColor);


    cp5EtuSelec.addButton("Lier à une table")
      .setPosition(10 + buttonWidth + buttonSpacing, 10)
      .setSize(buttonWidth, buttonHeight)
      .setFont(createFont("Montserrat-Regular", 12))
      .setColorBackground(primaryColor)
      .setColorForeground(secondaryColor)
      .setColorActive(activeColor)
      .onClick(new CallbackListener() {
        public void controlEvent(CallbackEvent event) {
            lierTable();
        }
    });

    cp5EtuSelec.addButton("Sauvegarder modifs")
      .setPosition(10 + 2 * (buttonWidth + buttonSpacing), 10)
      .setSize(buttonWidth, buttonHeight)
      .setFont(createFont("Montserrat-Regular", 12))
      .setColorBackground(primaryColor)
      .setColorForeground(secondaryColor)
      .setColorActive(activeColor);


    prenomTf = cp5EtuSelec.addTextfield("prenomModif")
      .setPosition(buttonWidth, 8 + textHeight + pad*2)
      .setSize(buttonWidth, buttonHeight)
      .setFont(createFont("Montserrat-Regular", 12))
      .setColor(color(50))
      .setColorBackground(color(255))
      .setColorActive(color(255))
      .setColorForeground(color(255))
      .setColorCursor(textColorField)
      .setCaptionLabel("");

    nomTf = cp5EtuSelec.addTextfield("nomModif")
      .setPosition(buttonWidth, 13 + 2 * textHeight + pad*2)
      .setSize(buttonWidth, buttonHeight)
      .setFont(createFont("Montserrat-Regular", 12))
      .setColor(color(50))
      .setColorBackground(color(255))
      .setColorActive(color(255))
      .setColorForeground(color(255))
      .setColorCursor(textColorField)
      .setCaptionLabel("");

    numTf = cp5EtuSelec.addTextfield("numModif")
      .setPosition(buttonWidth, 19 + 3 * textHeight + pad*2)
      .setSize(buttonWidth, buttonHeight)
      .setFont(createFont("Montserrat-Regular", 12))
      .setColor(color(50))
      .setColorBackground(color(255))
      .setColorActive(color(255))
      .setColorForeground(color(255))
      .setColorCursor(textColorField)
      .setCaptionLabel("");


    grpTf = cp5EtuSelec.addTextfield("grpModif")
      .setPosition(10, 7 * textHeight - 16)
      .setSize(buttonWidth / 2, buttonHeight)
      .setFont(createFont("Montserrat-Regular", 12))
      .setColor(color(50))
      .setColorBackground(color(255))
      .setColorActive(color(255))
      .setColorForeground(color(255))
      .setColorCursor(textColorField)
      .setCaptionLabel("");

    grpElTf = cp5EtuSelec.addTextfield("grpElModif")
      .setPosition(buttonWidth / 2 + 30, 7 * textHeight - 16)
      .setSize(buttonWidth, buttonHeight)
      .setFont(createFont("Montserrat-Regular", 12))
      .setColor(color(50))
      .setColorBackground(color(255))
      .setColorActive(color(255))
      .setColorForeground(color(255))
      .setColorCursor(textColorField)
      .setCaptionLabel("");

    tiersTemps = cp5EtuSelec.addButton("toggleTiersTemps")
      .setPosition(buttonWidth *2, 7 * textHeight - 3)
      .setSize(buttonWidth / 2, buttonHeight*2)
      .setCaptionLabel("")
      .hide()
      .setImage(offtoggle);

    cp5EtuSelec.addButton("Choisir Photo")
      .setPosition(imageX, 5 * textHeight - 3)
      .setSize(imageWidth, buttonHeight)
      .setFont(createFont("Montserrat-Regular", 12))
      .setColorBackground(primaryColor)
      .setColorForeground(secondaryColor)
      .setColorActive(activeColor);
  }


  void roundedRectEtu(float x, float y, float w, float h, float r, color c) {
    fill(c);
    beginShape();
    vertex(x + r, y);
    vertex(x + w - r, y);
    quadraticVertex(x + w, y, x + w, y + r);
    vertex(x + w, y + h - r);
    quadraticVertex(x + w, y + h, x + w - r, y + h);
    vertex(x + r, y + h);
    quadraticVertex(x, y + h, x, y + h - r);
    vertex(x, y + r);
    quadraticVertex(x, y, x + r, y);
    endShape(CLOSE);
  }

  public void draw() {
    if (etuOpen) {

      fill(menuColor);
      rect(0, 0, width, height / 8);

      if (selecEtu) {
        imageInterface();
        println(etuSelec.getNom());
        background(backgroundColor);

        updateEtuSelection();
        prenomTf.setText(etuSelec.getPrenom());
        nomTf.setText(etuSelec.getNom());
        numTf.setText(String.valueOf(etuSelec.getNum()));
        grpTf.setText(etuSelec.getGroupeString());
        grpElTf.setText(etuSelec.getGroupeEloignementString());
      }
    }
  }

  public void updateEtuSelection() {


    int buttonWidth = int(width / 3.5);
    int textHeight = height / 12;
    int buttonSpacing = 40;
    int pad = 20;

    stroke(0);
    background(backgroundColor);
    fill(menuColor);
    rect(0, 0, width, height / 8);

    roundedRectEtu(buttonWidth - 5, 15 + textHeight + pad, buttonWidth + 10, textHeight +8, 15, whiteColor);
    roundedRectEtu(buttonWidth - 5, 35 + 2 * textHeight + pad, buttonWidth + 10, textHeight +8, 15, whiteColor);
    roundedRectEtu(buttonWidth - 5, 55 + 3 * textHeight + pad, buttonWidth + 10, textHeight +8, 15, whiteColor);

    roundedRectEtu(5, 75 + 7 * textHeight, buttonWidth / 2 + 10, textHeight + 8, 15, whiteColor);
    roundedRectEtu(5 + buttonWidth / 2 + buttonSpacing / 2, 75 + 7 * textHeight, buttonWidth + 10, textHeight + 8, 15, whiteColor);

    fill(textColorField);
    textSize(16);
    text("Groupe(s) :", 10, 65 + 7 * textHeight);
    text("Eloignement(s) :", 10 + buttonWidth / 2 + buttonSpacing / 2, 65 + 7 * textHeight);
    text("Tiers-Temps :", 10 + buttonWidth * 1.5 + buttonSpacing*2, 65 + 7 * textHeight);

    int imageWidth = 150;
    int imageHeight = 150;

    float imageX = 20;
    float imageY = buttonSpacing + 15;

    float circleX = imageX + imageWidth / 2;
    float circleY = imageY + imageHeight / 2;
    float circleDiameter = imageWidth;


    if (etuSelec.getPhoto() == null) {
      defaultProfil.resize(imageWidth, imageHeight);
      imageMode(CENTER);
      image(defaultProfil, circleX, circleY);
    } else {
      PGraphics maskImage = createGraphics(imageWidth, imageHeight);
      maskImage.beginDraw();
      maskImage.background(0);
      maskImage.ellipse(imageWidth / 2, imageHeight / 2, circleDiameter, circleDiameter);
      maskImage.endDraw();

      PImage maskedPhoto = createImage(imageWidth, imageHeight, RGB);
      maskedPhoto.copy(etuSelec.getPhoto(), 0, 0, etuSelec.getPhoto().width, etuSelec.getPhoto().height, 0, 0, imageWidth, imageHeight);
      maskedPhoto.mask(maskImage);

      imageMode(CENTER);
      image(maskedPhoto, circleX, circleY);
    }



    if (ErrorNumModif) {
      fill(255, 0, 0);
      //JOptionPane.showMessageDialog(null, "Veuillez entrer des informations valides", "Informations invalides", JOptionPane.ERROR_MESSAGE);
      fill(textColorField);
    }
  }

  public void modifEtu() {
    if (selecEtu) {
      try {
        String numText = numTf.getText();
        if (!numText.matches("\\d+")) {
          throw new NumberFormatException("Not a valid number: " + numText);
        }

        etuSelec.setNum(Integer.parseInt(numText));
        if (!prenomTf.getText().isEmpty()) {
          etuSelec.setPrenom(prenomTf.getText());
        }
        if (!nomTf.getText().isEmpty()) {
          etuSelec.setNom(nomTf.getText());
        }
            if (!grpTf.getText().isEmpty()) {
          String groupesText = grpTf.getText();
          String[] groupes = groupesText.split(",");
          ArrayList<String> listeGroupes = new ArrayList<>();
          
          for (String groupe : groupes) {
              listeGroupes.add(groupe.trim());
          }
          
          ArrayList<Groupe> groupesEtudiant = new ArrayList<>();
          
          for (String nomGroupe : listeGroupes) {
              Groupe groupeObj = listeEtu.chercheGroupeParNom(nomGroupe);
              if (groupeObj == null) {
                  groupeObj = new Groupe(nomGroupe, listeEtu.trouverCouleurNonUtilisee());
                  listeEtu.ajouterGroupe(groupeObj);
              }
              groupesEtudiant.add(groupeObj);
               if (!etuSelec.getGroupe().contains(groupeObj)) {
                  groupesEtudiant.add(groupeObj);
                  etuSelec.ajouterGroupe(groupeObj);
              }
          }
          ArrayList<Groupe> groupesASupprimer = new ArrayList<>();
          for (Groupe groupeActuel : etuSelec.getGroupe()) {
              if (!groupesEtudiant.contains(groupeActuel)) {
                  groupesASupprimer.add(groupeActuel);
              }
          }
          for (Groupe groupeASuppr : groupesASupprimer) {
              etuSelec.supprimerGroupe(groupeASuppr);
          }
        
        }
        if (!grpElTf.getText().isEmpty()) {
          if (grpElTf.getText() == "Aucun" || grpElTf.getText() == "aucun") {
            etuSelec.setGroupeEloignement(0);
            grpElTf.setText("Aucun");
          } else {
            int temp = Integer.parseInt(grpElTf.getText());
            boolean tempExist = false;
            for (int i=0; i<10; i++) {
              if (listElo[i] != null) {
                if (Integer.parseInt(listElo[i].getNomEloignement()) == temp) {
                  tempExist = true;
                  break;
                }
              }
            }
            if (tempExist) {
              listElo[temp].addEtuEloignement(etuSelec);
              etuSelec.setGroupeEloignement(temp);
            } else {

              int[] nombresGeneres = new int[3];
              for (int j = 0; j < 3; j++) {
                nombresGeneres[j] = int(random(50, 250)) + nombreGroupesEloignement * (10 + j);
              }
              color tempColor = color(nombresGeneres[0], nombresGeneres[1], nombresGeneres[2]);

              Eloignement newEloignement = new Eloignement(Integer.toString(nombreGroupesEloignement), tempColor);

              listElo[nombreGroupesEloignement] = newEloignement;

              etuSelec.setGroupeEloignement(nombreGroupesEloignement);
              grpElTf.setText(Integer.toString(nombreGroupesEloignement));

              listElo[nombreGroupesEloignement].addEtuEloignement(etuSelec);

              nombreGroupesEloignement++;
            }
          }
        }
        ErrorNumModif = false;
        etuSelec.setTierTemps(tiertemps);
        updateEtuSelection();
      }
      catch (NumberFormatException e) {
        e.printStackTrace();
        ErrorNumModif = true;
      }
    }
  }
  
  void lierTable() {
      if (masalle == null) {
          JOptionPane.showMessageDialog(null, "Aucune salle n'est chargée.", "Erreur", JOptionPane.ERROR_MESSAGE);
          return;
      }
  
      String tableNumStr = JOptionPane.showInputDialog(null, "Entrez le numéro de table:");
      if (tableNumStr != null && tableNumStr.length() > 0) {
          try {
              int tableNum = Integer.parseInt(tableNumStr);
              Table tableTrouvee = null;
  
              for (Table table : masalle.getList()) {
                  if (table.getNumero() == tableNum) {
                      tableTrouvee = table;
                      break;
                  }
              }
  
              if (tableTrouvee == null) {
                  JOptionPane.showMessageDialog(null, "La table n'existe pas.", "Erreur", JOptionPane.ERROR_MESSAGE);
              } else if (tableTrouvee.isVerrouille()) {
                  JOptionPane.showMessageDialog(null, "La table est verrouillée.", "Erreur", JOptionPane.ERROR_MESSAGE);
              } else if (tableTrouvee.getEtu() != null) {
                  JOptionPane.showMessageDialog(null, "La table est déjà assignée à un autre étudiant.", "Erreur", JOptionPane.ERROR_MESSAGE);
              } else {
                  etuSelec.setTableEtu(tableNum);
                  tableTrouvee.addEtu(etuSelec);
              }
          } catch (NumberFormatException e) {
              JOptionPane.showMessageDialog(null, "Le numéro de table doit être un entier.", "Erreur", JOptionPane.ERROR_MESSAGE);
          }
      }
  }

  public void suppEtu() {
    if (selecEtu) {
      listeEtu.supprimerEtudiant(etuSelec);
    }
  }

  public void show() {
    exist = true;
    surface.setVisible(true);
  }

  void controlEvent(ControlEvent theEvent) {
    if (theEvent.isController()) {
      if (theEvent.getController().getName().equals("Sauvegarder modifs")) {
        sonAlerte.play();
        String stringModifEtu = "Voulez-vous vraiment modifier l'étudiant n°" + etuSelec.getNum() + "? (" + etuSelec.getPrenom() + " " + etuSelec.getNom() + ")";
        int confirmation = JOptionPane.showConfirmDialog(null, stringModifEtu, "Modifier étudiant", JOptionPane.YES_NO_OPTION);
        if (confirmation == JOptionPane.YES_OPTION) {
          selecEtu = true;
          modifEtu();
        }
      }
      if (theEvent.getController().getName().equals("Supprimer étudiant")) {
        sonAlerte.play();
        String stringSuppEtu = "Voulez-vous vraiment supprimer l'étudiant n°" + etuSelec.getNum() + "? (" + etuSelec.getPrenom() + " " + etuSelec.getNom() + ")\n" + "Cette action est irréversible !";
        int confirmation = JOptionPane.showConfirmDialog(null, stringSuppEtu, "Supprimer étudiant", JOptionPane.YES_NO_OPTION);
        if (confirmation == JOptionPane.YES_OPTION) {
          selecEtu = true;
          suppEtu();
          exit();
        }
      }
      if (theEvent.getController().getName().equals("toggleTiersTemps")) {
        if (tiertemps) {
          tiersTemps.setImage(ontoggle);
          tiertemps = false;
        } else {
          tiersTemps.setImage(offtoggle);
          tiertemps = true;
        }
      }
      if (theEvent.getController().getName().equals("Choisir Photo")) {
        Frame frame = new Frame();
        FileDialog fileDialog = new FileDialog(frame, "Choisir une photo", FileDialog.LOAD);
        fileDialog.setVisible(true);

        String selectedFile = fileDialog.getFile();
        String selectedDirectory = fileDialog.getDirectory();
        if (selectedFile != null && selectedDirectory != null) {
          CheminPhotoEtu = selectedDirectory + selectedFile;

          PImage selectedPhoto = loadImage(CheminPhotoEtu);
          etuSelec.setPhoto(selectedPhoto);

          updateEtuSelection();
        }
      }
    }
  }
}
