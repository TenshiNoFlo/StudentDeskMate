import controlP5.*;

class GestionEloignement {

  int selectedRectIndex = -1;
  int selectedEtuIndex = -1;
  boolean isRectSelected = false;
  boolean isEtuSelected = false;
  int lastRect = -1;

  ArrayList<Eloignement> lst;
  Etudiant etudiantSelectionne;
  String nomEtudiantSelectionne;

  public GestionEloignement() {
  }

  void createUIEloignement() {
    removeButton = cp5Elo.addButton("removeButton")
      .setPosition(width / 8, height - height / 5 - 65)
      .setSize(width / 9, 60)
      .setLabel("Supprimer un groupe")
      .hide()
      .setFont(createFont("Montserrat-Regular", 12))
      .addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent event) {
          if (event.getAction() == ControlP5.ACTION_CLICK) {
            removeButton();
          }
        }
      });

    if (ajoutEtudiantDeroulant == null) {
      ajoutEtudiantDeroulant = cp5Elo.addDropdownList("Ajouter un étudiant")
        .setPosition(width / 4 + 5, height / 20 + height / 30 + 2 + height / 40 + 3)
        .setSize(width / 4, height - height /20 - height / 30 + 2)
        .setBarHeight(height /20 - 4)
        .setItemHeight(height /20 - 4)
        .addItems(new String[] {" "})
        .setColorBackground(color(180, 180, 180))
        .setColorForeground(secondaryColor)
        .setColorActive(color(150, 150, 150))
        .setFont(createFont("arial", 20))
        .close();
    }
    ajoutEtudiantDeroulant.hide();

    ajoutEtudiantDeroulant.addListener(new ControlListener() {
      public void controlEvent(ControlEvent event) {
        nomEtudiantSelectionne = event.getController().getCaptionLabel().getText();
        println("Nom d'étudiant sélectionné : " + nomEtudiantSelectionne);
      }
    });

    addEtudiantButton = cp5Elo.addButton("addEtudiantButton")
      .setPosition(width / 4 + 15, height - height / 5 - 65)
      .setSize(width / 9, 60)
      .setLabel("Ajouter un étudiant")
      .setFont(createFont("Montserrat-Regular", 12))
      .addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent event) {
          if (event.getAction() == ControlP5.ACTION_CLICK) {
            addEtudiantButton();
          }
        }
      });

    removeEtudiantButton = cp5Elo.addButton("removeEtudiantButton")
      .setPosition(width / 4 + width / 8 + 15, height - height / 5 - 65)
      .setSize(width / 9, 60)
      .setLabel("Supprimer un étudiant")
      .setFont(createFont("Montserrat-Regular", 12))
      .hide()
      .addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent event) {
          if (event.getAction() == ControlP5.ACTION_CLICK) {
            removeEtudiantButton();
          }
        }
      });

    createRectangleButton = cp5Elo.addButton("createRectangleButton")
      .setPosition(10, height - height / 5 - 65)
      .setSize(width / 9, 60)
      .setFont(createFont("Montserrat-Regular", 12))
      .setLabel("Ajouter un groupe")
      .addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent event) {
          if (event.getAction() == ControlP5.ACTION_CLICK) {
            createRectangleButton();
          }
        }
      });
      
    leaveEloi = cp5Para.addButton("leaveEloi")
      .setPosition(width - width / 4 - height / 20, height / 20 + 2)
      .setSize(height / 20, height / 30 - 1)
      .setCaptionLabel("Retour")
      .setImage(quit)
      .setColorBackground(primaryColor)
      .setColorForeground(secondaryColor)
      .setColorActive(activeColor);
  }

  void gererDropdownList() {
    if (!isRectSelected && afficheTab) {
      ajoutEtudiantDeroulant.hide();
    }
    if (isRectSelected && afficheTab) {
      if (!ajoutEtudiantDeroulant.isOpen()) {
        ajoutEtudiantDeroulant.clear();
        remplirAjoutEtudiantDeroulant();
        ajoutEtudiantDeroulant.show();
      }
    } else {
      if (ajoutEtudiantDeroulant.isOpen()) {
        ajoutEtudiantDeroulant.close();
      }
    }
  }

  void remplirAjoutEtudiantDeroulant() {
    List<String> list = new ArrayList<String>();
    for (Map.Entry item : mapEtudiant.entrySet()) {
      if (!list.contains((String)item.getKey())) {
        list.add((String)item.getKey());
      }
    }

    ajoutEtudiantDeroulant.setItems(list);
  }

  public void drawEloignement() {
    stroke(menuColor);  

    // Dessiner le grand rectangle
    fill(fillColorLight);
    rect(0, height/20, width - width / 4, height - height /20 - height / 5);
    
    stroke(0);
    line(0, height/20 + 1,width - width / 4,height/20 + 1);

    noStroke();

    // Dessiner le rectangle pour le texte "Eloignement"
    fill(menuColor);
    rect(0, height/20 + 2, width - width / 4, height / 30 + 2);

    // Dessiner le texte "Eloignement"
    fill(textColor);
    textAlign(LEFT, TOP);
    textSize(20);
    text("Eloignements", 10, height / 20 + 10);
  }
  
  public void drawGEloignement(){
    if (eloiOpen) {
      showEloignement();
      gererDropdownList();
    }
  }

  private void showEloignement() {
    if (afficheTab) {
      removeButton.hide();
      removeEtudiantButton.hide();
      addEtudiantButton.hide();

      textSize(18);
      fill(menuColor);
      stroke(0);
      rect(0, height / 20 + height / 30 + 2, width - width / 4, 30);
      fill(textColor);
      textAlign(LEFT,CENTER);
      text("Eloignements :", 10, height / 20 + height / 30 + 15);
      text("Information du groupe d'éloignement :", width / 4 + 10, height / 20 + height / 30 + 15);
      textSize(14);
      noStroke();

      for (int i = 1; i < nombreGroupesEloignement; i++) {
        fill(230);
        if (mouseX > 0 && mouseX < width / 4 && mouseY > height / 20 + height / 30 + 2 + i * 50 - 28 && mouseY < height / 20 + height / 30 + 2 + (i+1) * 50 - 20) {
          fill(200);
          if (mousePressed) {
            lastRect = selectedRectIndex;
            selectedRectIndex = i;
            isRectSelected = true;
          }
        } else if (selectedRectIndex == i && isRectSelected) {
          fill(200);
        } else {
          fill(230);
        }
        rect(0,height / 20 + height / 30 + 2 + i * 50 - 20, width / 4, 48);

        fill(0);
        textAlign(CENTER, CENTER);
        text("Eloignement n°" + listElo[i].getNomEloignement(), width / 8, height / 20 + height / 30 + 2 + i*50, 20);
      }

      fill(0);
      rect(width/4, height / 20, 5, height - height / 5 - height / 20);

      if (isRectSelected) {
        if (lastRect != selectedRectIndex) {
          isEtuSelected = false;
          selectedEtuIndex = -1;
        }
        removeButton.show();
        addEtudiantButton.show();
        removeEtudiantButton.show();
        ajoutEtudiantDeroulant.show();

        showEtuEloi();
      }
    }
  }

private void showEtuEloi() {
  if (afficheTab) {
    Eloignement selectedEloignement = listElo[selectedRectIndex];

    float grandRectX = 0;
    float grandRectY = height / 20 + 50;
    float grandRectWidth = width - width / 4;
    float grandRectHeight = height - height / 20 - height / 5;

    float titleBarWidth = 200;
    float titleBarHeight = 30;
    float titleBarX = grandRectX + grandRectWidth - titleBarWidth;
    float titleBarY = grandRectY;

    fill(menuColor);
    rect(titleBarX, titleBarY, titleBarWidth, titleBarHeight);
    fill(textColor);
    float textX = titleBarX + 5;
    text("Étudiants de l'éloignement n°" + selectedEloignement.getNomEloignement(), textX, titleBarY + 20);

    float listStartY = titleBarY + titleBarHeight + 5;

    for (int i = 0; i < selectedEloignement.getNombreEtudiants(); i++) {
      float rectY = listStartY + i * 25;

      if (rectY + 24 > grandRectY + grandRectHeight) {
        break;
      }

      float rectX = textX;
      float rectWidth = titleBarWidth - 5; 
      float rectHeight = 24;

      if (mouseX > rectX && mouseX < rectX + rectWidth && mouseY > rectY && mouseY < rectY + rectHeight) {
        fill(200);
        if (mousePressed) {
          selectedEtuIndex = i;
          isEtuSelected = true;
        }
      } else if (selectedEtuIndex == i && isEtuSelected) {
        fill(200);
      } else {
        fill(230);
      }

      rect(rectX, rectY, rectWidth, rectHeight);

      fill(0);
      textSize(10);
      String etuNom = selectedEloignement.getEtudiantsEloignement().get(i).getNom();
      String etuPrenom = selectedEloignement.getEtudiantsEloignement().get(i).getPrenom();
      text(etuNom + " " + etuPrenom, rectX + 5, rectY + 17);
    }
  }
}

/* ancien
  private void showEtuEloi() {
    if (afficheTab) {
      Eloignement selectedEloignement = listElo[selectedRectIndex];

      fill(0);
      textSize(14);
      fill(menuColor);
      rect(width - 200, 0, 200, 30);
      fill(textColor);
      text("Étudiants de l'éloignement n°" + selectedEloignement.getNomEloignement(), width - 195, 20);

      for (int i = 0; i < selectedEloignement.getNombreEtudiants(); i++) {
        fill(230);
        float rectX = width - width/4;
        float rectY = i * 25 + 30;
        float rectWidth = width/4;
        float rectHeight = 24;
        if (mouseX > rectX && mouseX < rectX + rectWidth && mouseY > rectY && mouseY < rectY + rectHeight) {
          fill(200);
          if (mousePressed) {
            selectedEtuIndex = i;
            isEtuSelected = true;
          }
        } else if (selectedEtuIndex == i && isEtuSelected) {
          fill(200);
        } else {
          fill(230);
        }
        rect(width - width/4, i * 25 + 30, width/4, 24);

        fill(0);
        textSize(10);
        String etutemp = listElo[selectedRectIndex].getEtudiantsEloignement().get(i).getNom() + " " + listElo[selectedRectIndex].getEtudiantsEloignement().get(i).getPrenom();
        println(etutemp);
        text(etutemp, width - width/4 + 5, i*25 + 45);
      }
    }
  }
*/


  public void removeButton() {
    println("Rectangle supprimé : " + selectedRectIndex);

    if (selectedRectIndex >= 0) {
      listElo[selectedRectIndex] = null;
      isRectSelected = false;

      for (int i = selectedRectIndex + 1; i < nombreGroupesEloignement; i++) {
        listElo[i].setNomEloignement(Integer.parseInt(listElo[i].getNomEloignement())-1 + "");
        listElo[i - 1] = listElo[i];
      }

      nombreGroupesEloignement--;

      showEloignement();
    }
  }

  public void addEtudiantButton() {
    int selectedIndex = (int) ajoutEtudiantDeroulant.getValue();
    if (selectedIndex >= 0) {
      String nomEtudiantSelectionne = ajoutEtudiantDeroulant.getItem(selectedIndex).get("name").toString();
      if (mapEtudiant.containsKey(nomEtudiantSelectionne)) {
        Etudiant etudiantSelectionne = mapEtudiant.get(nomEtudiantSelectionne);

        List<Etudiant> etudiantsDansEloignement = listElo[selectedRectIndex].getEtudiantsEloignement();

        if (!etudiantsDansEloignement.contains(etudiantSelectionne)) {
          etudiantSelectionne.setGroupeEloignement(selectedRectIndex);
          listElo[selectedRectIndex].addEtuEloignement(etudiantSelectionne);
          println("Étudiant ajouté : " + etudiantSelectionne.getNom() + " dans le groupe d'éloignement " + selectedRectIndex);
        } else {
          println("L'étudiant est déjà présent dans l'éloignement sélectionné.");
        }
      } else {
        println("Aucun étudiant correspondant trouvé pour le nom : " + nomEtudiantSelectionne);
      }
    } else {
      println("Aucun étudiant sélectionné pour l'ajout.");
    }
  }

  public void removeEtudiantButton() {
    if (selectedEtuIndex >= 0 && isEtuSelected) {
      listElo[selectedRectIndex].removeEtuEloignement(listElo[selectedRectIndex].getEtudiantsEloignement().get(selectedEtuIndex));
      selectedEtuIndex = -1;
      isEtuSelected = false;
      println("Supprimer un étudiant dans Eloignement : " + selectedRectIndex);
    }
  }

  public void createRectangleButton() {
    int[] nombresGeneres = new int[3];
    for (int j = 0; j < 3; j++) {
      nombresGeneres[j] = int(random(50, 250)) + nombreGroupesEloignement * (10 + j);
    }
    color tempColor = color(nombresGeneres[0], nombresGeneres[1], nombresGeneres[2]);
    Eloignement newEloignement = new Eloignement(Integer.toString(nombreGroupesEloignement), tempColor);

    listElo[nombreGroupesEloignement] = newEloignement;

    nombreGroupesEloignement++;

    showEloignement();
  }
}
