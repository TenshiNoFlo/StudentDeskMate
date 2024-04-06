public class OuvrirExcel{

  Textfield ligneDebutField, ligneFinField;
  Textlabel lignedebut, lignefin;
  Button openFile;
  String selectedFilePath;
  int ligneDebut = 1;
  int ligneFin = 10;

  public OuvrirExcel() {
  }

  public void createUIOuvrirExcel() {
    String nomQuitterOpenExcel = "QuitterOpenExcel";

    leaveOpenExcel = cipi5.addButton(nomQuitterOpenExcel)
      .setPosition(width - width / 4 - height / 20, height / 20 + 2)
      .setSize(height / 20, height / 30)
      .setCaptionLabel("Retour")
      .setImage(quit)
      .setColorBackground(primaryColor)
      .setColorForeground(secondaryColor)
      .setColorActive(activeColor);
      
    FichierChoix = cepe5.addButton("ChoisirFichier")
      .setPosition(((width - width / 4) / 2) - 100 - 200, ((height / 20) + ((height - height /20 - height / 5) / 4) - 100) + 150)
      .setSize(200, 200)
      .setFont(createFont("arial", 18))
      .setColorBackground(color(190, 190, 190))
      .setLabel("Choisir un fichier CSV")
      .onEnter(e -> uploadSurvol = true)
      .onLeave(e -> uploadSurvol = false)
      .onClick(e -> choisirFichier());

    openFile = cepe5.addButton("OuvrirFichier")
      .setPosition(((width - width / 4) / 2) - 75, (height / 20) + ((height - height /20 - height / 5) / 2) - 25 + 150)
      .setSize(150, 50)
      .setFont(createFont("arial", 18))
      .setLabel("Ouvrir")
      .onClick(e -> ouvrirFichier());

    lignedebut = cepe5.addTextlabel("labelLigneDebut")
      .setText("Ligne de début")
      .setPosition(((width - width / 4) / 2) + 100 + 100, ((height / 20) + ((height - height /20 - height / 5) / 4) - 60) + 100)
      .setFont(createFont("Arial", 18))
      .setColorValue(color(0));

    ligneDebutField = cepe5.addTextfield("Ligne de début :")
      .setPosition(((width - width / 4) / 2) + 100 + 100, ((height / 20) + ((height - height /20 - height / 5) / 4) - 30) + 100)
      .setSize(150, 50)
      .setFont(createFont("Arial", 18))
      .setColorBackground(color(190, 190, 190))
      .setInputFilter(ControlP5.INTEGER)
      .setText("1")
      .setLabelVisible(false);

    ligneDebutField.getCaptionLabel()
      .setFont(createFont("Arial", 18))
      .setColor(0)
      .toUpperCase(false)
      .setText("");
      
    lignefin = cepe5.addTextlabel("ligneFinField")
      .setText("Ligne de fin")
      .setPosition(((width - width / 4) / 2) + 100 + 100, lignedebut.getPosition()[1] + 60 + 75)
      .setFont(createFont("Arial", 18))
      .setColorValue(color(0));

    ligneFinField = cepe5.addTextfield("Ligne de fin :")
      .setPosition(((width - width / 4) / 2) + 100 + 100, lignefin.getPosition()[1] + 30)
      .setSize(150, 50)
      .setFont(createFont("Arial", 18))
      .setColorBackground(color(190, 190, 190))
      .setInputFilter(ControlP5.INTEGER)
      .setText("10")
      .setLabelVisible(false);
      
    ligneFinField.getCaptionLabel()
      .setFont(createFont("Arial", 18))
      .setColor(0)
      .toUpperCase(false)
      .setText("");
  }
  
  public void drawOuvrirExcel() {
    stroke(menuColor);

    fill(fillColorLight);
    rect(0, height/20, width - width / 4, height - height /20 - height / 5);
    
    stroke(0);
    line(0, height/20 + 1,width - width / 4,height/20 + 1);

    noStroke();
    fill(menuColor);
    rect(0, height/20 + 2, width - width / 4, height / 30 + 2);

    fill(textColor);
    textAlign(LEFT, TOP);
    textSize(20);
    text("Ouvrir Excel", 10, height / 20 + 10);

  }

  void choisirFichier() {
    listeEtu = new ListeEtu();
    Frame mainFrame = new Frame("Sélectionnez un fichier CSV");
    FileDialog dialog = new FileDialog(mainFrame, "Sélectionnez un fichier CSV", FileDialog.LOAD);
    dialog.setFile("*.csv");
    dialog.setVisible(true);

    String directory = dialog.getDirectory();
    String fileName = dialog.getFile();
    if (fileName != null) {
      selectedFilePath = directory + fileName;
      int[] debutFin = listeEtu.detecterDebutFinListeEtudiants(selectedFilePath);
      ligneDebut = debutFin[0];
      ligneFin = debutFin[1]; 
      ligneDebutField.setText(""+ligneDebut);
      ligneFinField.setText(""+ligneFin);
      println(ligneDebut);
    }
    mainFrame.dispose();
  }


  void chargerCSV(String selectedFilePath) {
    listeEtu.importerEtudiants(selectedFilePath, ligneDebut, ligneFin);
    afficherTableauEtudiant(listeEtu);
    lastEtudiant = 0;
    afficheTab = true;
  }

  void ouvrirFichier() {
    if (selectedFilePath != null) {
      try {
        ligneDebut = Integer.parseInt(ligneDebutField.getText());
        ligneFin = Integer.parseInt(ligneFinField.getText());
        
        String[] tailleCSV = loadStrings(selectedFilePath);
        int nombreDeLignes = tailleCSV.length;
        if (ligneFin > nombreDeLignes) {
            println("La ligne de fin est trop élevée. Veuillez entrer une valeur inférieure ou égale à " + nombreDeLignes + ".");
            sonAlerte.play();
            JOptionPane.showMessageDialog(null, "La ligne de fin est trop élevée. Veuillez entrer une valeur inférieure ou égale à " + nombreDeLignes + ".", "Erreur", JOptionPane.ERROR_MESSAGE);
            return;
        }
        
        chargerCSV(selectedFilePath);
        // exit ici
      } catch (NumberFormatException e) {
        println("Veuillez entrer un numéro de ligne valide.");
          sonAlerte.play();
          JOptionPane.showMessageDialog(null, "Veuillez entrer un numéro de ligne valide.", "Erreur", JOptionPane.ERROR_MESSAGE);
      }
    } else {
      println("Veuillez d'abord sélectionner un fichier");
      sonAlerte.play();
      JOptionPane.showMessageDialog(null, "Veuillez d'abord sélectionner un fichier", "Erreur", JOptionPane.ERROR_MESSAGE);
    }
  }

  void drawExcel(){
    if (excelOpen) {
      if (selectedFilePath != null) {
        textSize(16);
        String fileName = new File(selectedFilePath).getName();
        text("Fichier: " + fileName, 20, height - 240);
      }
      if (excelIn) {
        upload.resize(200, 200);
        upload_hover.resize(200, 200);
        FichierChoix.setImage(upload_hover);
        excelIn = false;
      }
    }
  }

  void mouseMovedUpload() {
    if (uploadSurvol) {
      upload.resize(200, 200);
      upload_hover.resize(200, 200);
      cepe5.getController("ChoisirFichier").setImage(upload_hover);
    } else {
      upload.resize(200, 200);
      upload_hover.resize(200, 200);
      cepe5.getController("ChoisirFichier").setImage(upload);
    }
  }
  
  public void hideAll(){
    leaveOpenExcel.hide();
    FichierChoix.hide();
    openFile.hide();
    lignedebut.hide();
    ligneDebutField.hide();

    lignefin.hide();
    ligneFinField.hide();

  }
  
  public void showAll(){
    leaveOpenExcel.show();
    FichierChoix.show();
    openFile.show();
    lignedebut.show();
    ligneDebutField.show();

    lignefin.show();
    ligneFinField.show();

  }
}
