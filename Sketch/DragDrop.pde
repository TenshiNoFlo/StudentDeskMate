void mousePressed() {
  boolean clickedOnTable = false;

  if (masalle != null) {
    ArrayList<Table> list = masalle.getList();
    for (int i = list.size() - 1; i >= 0; i--) {
      Table table = list.get(i);
      if (table.survoleContextMenu(mouseX, mouseY)) {
        clickedOnTable = true;

        if (mouseButton == RIGHT) {
          selectedTable = table;
          contextMenu.show(mouseX, mouseY, selectedTable);
        } else if (mouseButton == LEFT && !contextMenu.survoleContextMenu(mouseX, mouseY)) {
          selectedTable = table;
          selectedTable.setOffset(mouseX, mouseY);
        }
        break;
      }
    }
  }

  if (!clickedOnTable && mouseButton == LEFT && !contextMenu.survoleContextMenu(mouseX, mouseY)) {
    contextMenu.hide();
    if (selectedTable != null) {
      selectedTable = null;
    }
  }

  float yMin = height / 20 + widthFiltreFull + 20;
  float yMax = yMin + (height / 20 - yOffset);
  if (mouseY > yMin && mouseY < yMax && !tri.isOpen()) {
    float xStart = width * 0.75;
    for (int i = 0; i < 4; i++) {
      float xMin = xStart + i * colonneWidth;
      float xMax = xMin + colonneWidth + 15;

      if (i == 0) {
        xMin -= xOffset;
      }

      if (mouseX > xMin && mouseX < xMax) {
        if (colonneSelectionnee == i) {
          colonneSelectionnee = -1;
        } else {
          colonneSelectionnee = i;
        }
      }
    }
  }

  if (afficheTab) {
    float yOffset = 15;
    if (!tri.isOpen() && mouseX > width * 0.75 && mouseX < width && mouseY > height / 20 + widthFiltreFull + 20 + yOffset * 2 &&
      mouseY < height) {
      int ligneCliquee = int((mouseY - (height / 20 + widthFiltreFull + 20)) / 20) - 2;
      if (ligneCliquee >= 0 && ligneCliquee < listeEtu.getEtudiants().size() && (mouseButton == RIGHT)) {
        if (!inGererEtu) {
          if (!gereretu.exist()) {
            try {
              gereretu.show();
              inGererEtu=true;
            }
            catch(Exception ex) {
            }
          }
        }
      }
    }
  }
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    if (selectedTable != null && selectedTable.isVerrouille() == false) {
      contextMenu.hide();
      float newX = mouseX - selectedTable.offsetX;
      float newY = mouseY - selectedTable.offsetY;

      float minX = 0;
      float maxX = width * 0.75;
      float minY = height/20;
      float maxY = height - height * 0.2;

      newX = constrain(newX, minX, maxX - selectedTable.getLon());
      newY = constrain(newY, minY, maxY - selectedTable.getLar());

      selectedTable.setCoord(newX, newY);
    }

    // DRAG DROP ETU on A TABLE
    else if (etuSelec != null && mouseButton == LEFT) {
      println("dragdropping");
      dragDropEtu = true;
    }
  }
}

void keyPressed() {
  derniereActivite = millis();

  if (selectedTable != null && selectedTable.isVerrouille() == false) {
    float currentOrientation = selectedTable.getOrientation();
    if (keyCode == UP || keyCode == DOWN) {
      selectedTable.setOrientation(currentOrientation + (keyCode == DOWN ? 30 : -30));
    } else if (keyCode == LEFT || keyCode == RIGHT) {
      selectedTable.setOrientation(currentOrientation + (keyCode == LEFT ? -15 : 15));
    }
  }

  if (keyCode == CONTROL && key=='o') {
    println("control");
    if (key == 'o' || key == 'O') {
      println("verr");
      verrouillerToutesLesTables();
    } else if (key == 'c' || key == 'C') {
      println("deverr");
      deverrouillerToutesLesTables();
    }
  }

  if (afficheTab) {
    if (keyCode == 'P' || keyCode == 'p') {
      pPressed = true;
    } else if (keyCode == 'O' || keyCode == 'o') {
      oPressed = true;
    } else if (keyCode == 17) {
      shiftPressed = true;
    }
    if (pPressed && oPressed && !shiftPressed) {
      actionOnTwoKeysPlace();
    }
    if (pPressed && shiftPressed && !oPressed) {
      actionOnTwoKeysImp();
    }
  }
}

void keyReleased() {
  if (keyCode == 'P' || keyCode == 'p') {
    pPressed = false;
  } else if (keyCode == 'O' || keyCode == 'o') {
    oPressed = false;
  } else if (keyCode == 17) {
    shiftPressed = false;
  }
}

void actionOnTwoKeysPlace() {
  if (afficherSal && afficheTab) {
    masalle.placerEtudiantsAvecContraintes();
  } else {
    println("Pas chargé");
  }
}

void actionOnTwoKeysImp() {
  if (afficherSal && afficheTab) {
    drawListeEtudiants2();
  } else {
    println("Pas chargé");
  }
}

void mouseClicked() {
  if (mouseButton == LEFT && contextMenu.isVisible) {
    int selectedOption = contextMenu.getSelectedOption(mouseX, mouseY);
    if (selectedOption != -1) {
      handleContextMenuAction(selectedOption);
      contextMenu.hide();
    } else if (!contextMenu.survoleContextMenu(mouseX, mouseY)) {
      contextMenu.hide();
    }
  }
}

void handleContextMenuAction(int index) {
  switch (index) {
  case 0:
    if (selectedTable.getEtu() != null) {
      selectedTable.addEtu(null);
    }
    break;
  case 1:
    if (selectedTable != null) {
      masalle.removeTable(selectedTable);
      println("Table supprimée: " + selectedTable);
      selectedTable = null;
    }
    break;
  case 2:
    if (selectedTable != null) {
      selectedTable.setVerrouille(!selectedTable.isVerrouille());
    }
    break;
  case 3:
    if (selectedTable != null) {
      selectedTable.setExploit(!selectedTable.isExploitable());
      selectedTable.addEtu(null);
    }
  }
}

void mouseReleased() {
  if (afficheTab) {
    float yOffset = 15;
    if (mouseX > width * 0.75 && mouseX < width && mouseY > height / 20 + widthFiltreFull + 20 + yOffset * 2 &&
      mouseY < height && !tri.isOpen()) {
      int ligneCliquee = int((mouseY - (height / 20 + widthFiltreFull + 20)) / 20) - 2;
      if (ligneCliquee >= 0 && ligneCliquee < listeEtu.getEtudiants().size() && (mouseButton == LEFT)) {
        etuOpen = true;
        etudiantSelectionne = ligneCliquee + scrollListEtu;
        etuSelec = listeEtu.getEtudiants().get(etudiantSelectionne);
        selecEtu = true;
      } else {
        selecEtu = false;
      }
      if (ligneCliquee >= 0 && ligneCliquee < listeEtu.getEtudiants().size() && (mouseButton == RIGHT)) {
        if (!inGererEtu) {
          if (!gereretu.exist()) {
            try {
              gereretu.show();
              inGererEtu=true;
            }
            catch(Exception ex) {
            }
          }
        }
      }
    }
  }

  if (dragDropEtu == true) {
    if (masalle != null) {
      for (Table t : masalle.getList()) {
        if (t.survoleContextMenu(mouseX, mouseY) && t.isExploitable()) {
          for (Table ti : masalle.getList()) {
            masalle.enleverEtu(etuSelec);
          }
          t.addEtu(etuSelec);
          etuSelec.setTableEtu(t.getNumero());
          dragDropEtu=false;
          etuSelec=null;
          break;
        }
      }
      dragDropEtu=false;
      etuSelec=null;
    }
  }

  float yOffset = 15;
  if (listeEtu != null) {
    if (mouseX > width * 0.75 && mouseX < width && mouseY > height / 20 + widthFiltreFull + 20 + yOffset * 2 &&
      mouseY < height) {
      int ligneCliquee = int((mouseY - (height / 20 + widthFiltreFull + 20)) / 40) - 1;
      if (ligneCliquee >= 0 && ligneCliquee < listeEtu.getEtudiants().size() && (mouseButton == LEFT)) {
        etudiantSelectionne = ligneCliquee + scrollListEtu;
        etuSelec = listeEtu.getEtudiants().get(etudiantSelectionne);
        selecEtu = true;
      } else {
        selecEtu = false;
      }
      if (ligneCliquee >= 0 && ligneCliquee < listeEtu.getEtudiants().size() && (mouseButton == RIGHT)) {
        if (!inGererEtu) {
          if (!gereretu.exist()) {
            try {
              gereretu.show();
              inGererEtu=true;
            }
            catch(Exception ex) {
            }
          }
        }
      }
    }
  }

  if (!fichier.isMouseOver()) fichier.close();
  if (!ajouter.isMouseOver()) ajouter.close();
  if (!tri.isMouseOver()) tri.close();
  if (!salle.isMouseOver()) salle.close();
  if (!gestion.isMouseOver()) gestion.close();
}

void verrouillerToutesLesTables() {
  for (Table table : masalle.getList()) {
    table.setVerrouille(true);
  }
}

void deverrouillerToutesLesTables() {
  for (Table table : masalle.getList()) {
    table.setVerrouille(false);
  }
}
