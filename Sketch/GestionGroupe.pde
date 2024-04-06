import javax.swing.JColorChooser;
import java.awt.Color;
import java.util.List;
import java.util.Map;
import java.lang.Object;


class GestionGroupe extends Fenetre {

  private ArrayList<Groupe> lst;
  private FloatList buttonList;
  private Groupe activeGroup;
  private DropdownList ajoutDeroulant;
  private Color picker;
  private color currentColor;
  ControlP5 controlP5;
  private boolean ajouterGroupe = false;
  private Textfield nomNouveauGroupe;
  private ListBox listMembers;
  ArrayList<Etudiant> tabEtuAjoutes = new ArrayList<Etudiant>();
  ArrayList<Etudiant> tabEtuSupprimes = new ArrayList<Etudiant>();
  boolean modifications = false, etuAjoute = false, etuSupprime = false;
  private int numAj, numSp;

  public GestionGroupe(PApplet parent, int w, int h) {
    super(parent, w, h);
    this.lst = new ArrayList<Groupe>();
    this.buttonList = new FloatList();

    PApplet.runSketch(new String[] {"Gestion groupes"}, this);
    surface.setVisible(false);
    controlP5 = new ControlP5(this);
    nomNouveauGroupe = controlP5.addTextfield("")
      .setPosition(width/3+180, 110)
      .setSize(300, 30)
      .setFocus(true)
      .setColor(new CColor(secondaryColor, color(255), activeColor, color(0), color(0))) // police blanche
      .setFont(createFont("arial", 18))
      .setColorCursor(color(0));
    nomNouveauGroupe.hide();
  }


  public void draw() {

    noStroke();
    fill(200);
    rect(0, 0, wid/3, height);
    fill(250);
    rect(wid/3, 0, width/3 * 2, height);

    if (activeGroup == null && lst.size() > 0 && !ajouterGroupe) {
      fill(0);
      text("Aucun groupe sélectionné", width/2+50, height/2);
      ajoutDeroulant = null;
      listMembers = null;
    } else if (activeGroup != null && !ajouterGroupe)
      showMain();

    fill(0);
    textSize(20);
    if (!lst.isEmpty() || ajouterGroupe)
      showGroupe();
    else {
      text("Aucun groupe existant", width/2+50, height/2);
      ajoutDeroulant = null;
      listMembers = null;
    }

    fill(150);
    rect(0, height-60, width/3, 60);
    drawBtnAjouterMain();
    drawBtnSuppMain();

    if (ajouterGroupe)
      showAjouterGroupe();
  }

  public void loadGroupe(ArrayList<Groupe> grp) {
    this.lst = grp;
  }

  public void exit() {
    surface.setVisible(false);
    this.exist = false;
    controlP5.remove("Ajouter un etudiant");
    ajoutDeroulant = null;
    controlP5.remove("Membres");
    listMembers = null;
    activeGroup = null;
    ajouterGroupe = false;
    nomNouveauGroupe.hide();
  }

  public void show() {
    exist = true;
    surface.setVisible(true);
  }

  private void showGroupe() {
    buttonList.clear();
    int cpt = 0;
    for (int i = scrollGestionGrp; i < lst.size(); i++) {

      if (activeGroup == null || lst.get(i) != activeGroup)
        fill(200);
      else
        fill(230);
      rect(0, cpt * 50, wid/3, 48);

      if (buttonList.size() < lst.size()*2) {
        buttonList.append(cpt*50);
        buttonList.append(cpt*50+50);
      }

      fill(0);
      text(lst.get(i).getNom(), 20, cpt*50+30);
      cpt++;
    }
  }

  public void showMain() {
    float y = width/3, x = 0;

    fill(0);
    text("Couleur", y+20, x+50);

    fill(currentColor);
    stroke(2);
    rect(y+130, x+30, 50, 33);
    noStroke();

    fill(0);
    text("Ajouter", y+20, x+130);

    if (ajoutDeroulant == null) {
      ajoutDeroulant = controlP5.addDropdownList("Ajouter un etudiant")
        .setPosition(width/3+130, 100)
        .setSize(350, 150)
        .setBarHeight(40)
        .setItemHeight(35)
        .addItems(new String[] {" "})
        .setColorBackground(color(180, 180, 180))
        .setColorForeground(secondaryColor)
        .setColorActive(color(150, 150, 150))
        .setFont(createFont("arial", 20)) //C:/Users/payet/Documents/IUT/BUT_2/SAE/DEV/placement-salle-ds/Sketch/data/
        .close();

      List<String> list = new ArrayList<String>();
      for (Map.Entry item : mapEtudiant.entrySet()) {
        if (!list.contains((String)item.getKey()))
          list.add((String)item.getKey());
      }
      ajoutDeroulant.setItems(list);

    }

    text("Membre(s)", y+20, x+210);

    if (listMembers == null) {
      listMembers = controlP5.addListBox("Membres")
        .setPosition(width/3+130, 180)
        .setSize(350, 150)
        .setColorBackground(color(150))
        .setColorForeground(color(100))
        .setBarHeight(40)
        .setItemHeight(35)
        .setFont(createFont("arial", 18));

      for (Etudiant etu : activeGroup.getEtudiants())
        listMembers.addItem(etu.getNom() +" "+ etu.getPrenom() +" "+ etu.getNum(), etu);
    }
    if (!listMembers.isOpen()) listMembers.open();
    if (ajoutDeroulant.isOpen()) listMembers.hide();
    else listMembers.show();

    if (etuSupprime)
      text("(!) - '" + getEtuById(numSp) + "' a été supprimé(e) !", width/3+50, height-120);
    if (etuAjoute)
      text("(!) - '" + getEtuById(numAj) + "' a été ajouté(e) !", width/3+50, height-80);
    drawBtnAjouterEtu();
    drawBtnSuppEtu();
    drawBtnEnregistrer();
  }

  private void drawBtnEnregistrer() {
    int y = 2*width/3;
    // HOVER
    if (mouseX > y-50 && mouseX < y+70 && mouseY > height-60 && mouseY < height-20)
      fill(150);
    else
      fill(200);

    rect(y-50, height-60, 120, 40);
    fill(0);
    text("Enregistrer", y-35, height-35);
  }
  private void drawBtnAjouterMain() {
    // HOVER
    if (mouseX > 30 && mouseX < 130 && mouseY > height-50 && mouseY < height-10)
      fill(180);
    else
      fill(200);

    rect(30, height-50, 100, 40);
    fill(0);
    text("Ajouter", 50, height-25);
  }

  private void drawBtnSuppMain() {
    // HOVER
    if (mouseX > 190 && mouseX < 300 && mouseY > height-50 && mouseY < height-10)
      fill(180);
    else
      fill(200);

    rect(190, height-50, 110, 40);
    fill(0);
    text("Supprimer", 200, height-25);
  }

  private void drawBtnAjouterEtu() {
    int x = width/3+525, y = 100;
    int wid = 100, hei = 40;
    // HOVER
    if (mouseX > x && mouseX < x+wid && mouseY > y && mouseY < y+hei)
      fill(180);
    else
      fill(200);

    rect(x, y, wid, hei);
    fill(0);
    text("Ajouter", x+20, y+25);
  }

  private void drawBtnSuppEtu() {
    int x = width/3+525, y = 180;
    int wid = 110, hei = 40;
    // HOVER
    if (mouseX > x && mouseX < x+wid && mouseY > y && mouseY < y+hei)
      fill(180);
    else
      fill(200);

    rect(x, y, wid, hei);
    fill(0);
    text("Supprimer", x+10, y+25);
  }

  private void showAjouterGroupe() {
    fill(0);
    text("Couleur", width/3+20, 50);

    fill(currentColor);
    rect(width/3+130, 30, 50, 33);

    fill(0);
    text("Nom du groupe", width/3+20, 130);
    nomNouveauGroupe.show();

    drawBtnEnregistrer();
  }

  public void ajouterGroupe(Groupe g) {
    this.lst.add(g);
  }

  public ArrayList<Groupe> getLst() {
    return this.lst;
  }
  
  
  public String getEtuById(int num) {
      //for (Map.Entry item : mapEtudiant.entrySet())
      //    if (activeGroup != null && ((Etudiant)item.getValue()).getNum() == num && !activeGroup.estDans(((Etudiant)item.getValue())))
      //      return ((Etudiant)item.getValue()).getNom() + " " + ((Etudiant)item.getValue()).getPrenom();
      for (Etudiant etu : listeEtu.getEtudiants())
          if (activeGroup != null && etu.getNum() == num)
              return etu.getNom() + " " + etu.getPrenom();
      return null;
  }

  public void mousePressed()
  {
    // GROUP BUTTONS ON LEFT SIDE ----------------------------------------------------
    for (int i = 0; i < buttonList.size()-1; i+=2) {
      if (mouseX > 0 && mouseX < wid/3) {
        if (mouseY > buttonList.get(i) && mouseY < buttonList.get(i+1) && lst.size() > 0) {
          activeGroup = lst.get(i/2+scrollGestionGrp); // i/2
          currentColor = activeGroup.getColor();

          ajouterGroupe = false;
          nomNouveauGroupe.hide();

          controlP5.remove("Ajouter un etudiant");
          ajoutDeroulant = null;
          controlP5.remove("Membres");
          listMembers = null;
        }
      }

    }

    // COLOR PICKER BUTTON -----------------------------------------------------------
    if ((activeGroup != null || ajouterGroupe)
      && mouseX > width/3+130 && mouseX < width/3+130+50
      && mouseY > 30 && mouseY < 63) {
      picker = JColorChooser.showDialog(null, "Choisissez une couleur", Color.white);

      if (picker != null)
        currentColor = color(picker.getRed(), picker.getGreen(), picker.getBlue());
    }

    // BOUTON AJOUTER UN ETUDIANT --------------------------------------------------------------------
    if (mouseX > width/3+525 && mouseX < width/3+525+100 && mouseY > 100 && mouseY < 100+40) {
      if (ajoutDeroulant.getItems().size() > 0) {
        String lstStr[] = ((String)ajoutDeroulant.getItem((int)ajoutDeroulant.getValue()).get("name")).split(" ");

        if (lstStr.length > 0) {
          numAj = lstStr[1].equals("") ? Integer.parseInt(lstStr[3]) : Integer.parseInt(lstStr[2]);

          for (Map.Entry item : mapEtudiant.entrySet()) {
            if (((Etudiant)item.getValue()).getNum() == numAj && !activeGroup.estDans(((Etudiant)item.getValue()))) {
              tabEtuAjoutes.add((Etudiant)item.getValue());
              etuAjoute = true;
            }
          }
          
        }
      }
    }

    // BOUTON SUPPRIMER UN ETUDIANT --------------------------------------------------------------------
    if (mouseX > width/3+525 && mouseX < width/3+525+110 && mouseY > 180 && mouseY < 180+140) {
      if (listMembers.getItems().size() > 0) {
        String[] lstStr = ((String)listMembers.getItem((int)listMembers.getValue()).get("name")).split(" ");

        if (lstStr.length > 0) {
          numSp = lstStr[1].equals("") ? Integer.parseInt(lstStr[3]) : Integer.parseInt(lstStr[2]);

          for (Map.Entry item : mapEtudiant.entrySet()) {
            if (((Etudiant)item.getValue()).getNum() == numSp && activeGroup.estDans(((Etudiant)item.getValue()))) {
              tabEtuSupprimes.add((Etudiant)item.getValue());
              etuSupprime = true;
            }
          }
        }
      }
    }

    // SAVE BUTTON --------------------------------------------------------------------

    if (mouseX > 2*width/3-50 && mouseX < 2*width/3+70 && mouseY > height-60 && mouseY < height-20 && !ajouterGroupe) {
      
      activeGroup.setColor(currentColor); // changer la couleur
      print("Ajout: ");
      for (Etudiant etu : tabEtuAjoutes) {
        print(etu.getNom() +" "+ etu.getPrenom()+", ");
        if (!activeGroup.estDans(etu)) {
          activeGroup.addEtu(etu);
          listMembers.addItem(etu.getNom() +" "+ etu.getPrenom() +" "+ etu.getNum(), etu);
          etu.ajouterGroupe(activeGroup);
          for (Etudiant etud : activeGroup.getEtudiants())
            print(etud.getNom() +" "+ etud.getPrenom());
        }
      }
      println();
      tabEtuAjoutes.clear();
      etuAjoute = false;

      print("Supprime: ");
      for (Etudiant etu : tabEtuSupprimes) {
        print(etu.getNom() +" "+ etu.getPrenom()+", ");
        activeGroup.removeEtu(etu);
        listMembers.removeItem(etu.getNom() +" "+ etu.getPrenom() +" "+ etu.getNum());
        etu.supprimerGroupe(activeGroup);
      }
      tabEtuSupprimes.clear();
      etuSupprime = false;

      afficherTableauEtudiant(listeEtu);
      
    }

    // BOUTON AJOUTER GROUPE MAIN ----------------------------------------------------------------
    if (mouseX > 30 && mouseX < 130 && mouseY > height-50 && mouseY < height-10) {
      if (!ajouterGroupe) nomNouveauGroupe.clear();
      ajouterGroupe = true;
      activeGroup = null;
      controlP5.remove("Ajouter un etudiant");
      ajoutDeroulant = null;
      controlP5.remove("Membres");
      listMembers = null;
    }
    // BOUTON SUPPRIMER GROUPE MAIN ----------------------------------------------------------------
    if (mouseX > 190 && mouseX < 300 && mouseY > height-50 && mouseY < height-10) {
      if (activeGroup != null) {
        for (Etudiant etu : activeGroup.getEtudiants())
          etu.supprimerGroupe(activeGroup);

        lst.remove(activeGroup);
        controlP5.remove("Ajouter un etudiant");
        ajoutDeroulant = null;
        controlP5.remove("Membres");
        listMembers = null;
        legende.supprimerGroupe(activeGroup);
        activeGroup = null;
        nbGroupe--;
      }
    }
    
    // AJOUTER GROUPE
    if (mouseX > 2*width/3-50 && mouseX < 2*width/3+70 && mouseY > height-60 && mouseY < height-20 && ajouterGroupe) {
      if (nbGroupe >= 15)
          JOptionPane.showMessageDialog(null, "Limite de groupe atteinte !", "/!\\ Notification Gestion groupes", JOptionPane.WARNING_MESSAGE);
      else {
          boolean exists = false;
    
          for (Groupe grp : lst) {
            if (grp.getNom().equals(nomNouveauGroupe.getText())) {
              exists = true;
              JOptionPane.showMessageDialog(null, "Le groupe que vous souhaitez créer existe déjà !", "/!\\ Notification Gestion groupes", JOptionPane.WARNING_MESSAGE);
            }
          }
    
          if (!exists) { // limite de 15 groupes (affichage légende)
            Groupe g = new Groupe(nomNouveauGroupe.getText(), currentColor);
            
            activeGroup = g;
            ajouterGroupe = false;
            nomNouveauGroupe.hide();
            controlP5.remove("Ajouter un etudiant");
            ajoutDeroulant = null;
            controlP5.remove("Membres");
            listMembers = null;
            if (nbGroupe > 9) scrollGestionGrp++;
          }
      }
    }
  }

  void mouseWheel(MouseEvent event)
  {
    println("MOUSE WHEEL ---");
      if (mouseX > 0 && mouseX < width/3 && mouseY > 0 && mouseY < height-60) {
          float e = event.getCount();
          println("event : " + e);
          if (e > 0) {
            if (scrollGestionGrp+1 < lst.size())
              scrollGestionGrp++;
            
          } else if(e < 0) {
            if (scrollGestionGrp-1 >= 0)
              scrollGestionGrp--;
          }
            
          println("MOUSE WHEEL : " + scrollGestionGrp);
      }
  }
}
