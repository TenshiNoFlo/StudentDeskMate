public class AjouterEtudiant {
  
  private Textfield numField;
  private Textfield nomField;
  private Textfield prenomField;
  private Textfield groupesField;
  
  private Textlabel numLabel;
  private Textlabel nomLabel;
  private Textlabel prenomLabel;
  private Textlabel groupeLabel;

  
  private Button validerButton;
  private Button effacerButton;
  private Button choisirPhoto;

  private int imageWidth = 150;
  private int imageHeight = 150;

  private int textHeight;
  private int buttonSpacing = 40;

  private float imageX;
  private float imageY;

  private float circleX;
  private float circleY;
  private float circleDiameter;

  String selectedPhotoPath = "";

  Etudiant nouvelEtudiant;
  PImage etudiantPhoto = defaultProfil;
    
  
  public AjouterEtudiant() {
  }
  
  public void createUIAjouterEtudiant() {
    textHeight = height / 8;
    imageX = 20;
    imageY = buttonSpacing + 15;
    circleX = imageX + imageWidth / 2;
    circleY = imageY + imageHeight / 2 - 40;
    circleDiameter = imageWidth;

    int labelWidth = 100;
    int textFieldWidth = 150;
    int buttonWidth = 100;
    int buttonHeight = 30;
    int margin = 20;
    int totalWidth = width - width / 4;
    int offsetB = margin + 400;
    int offsetX = (totalWidth - textFieldWidth - labelWidth - margin * 2) / 2 + margin;

    int startY = height / 20 + 100;
    int verticalSpacing = 50;


    
    String nomQuitterAddEtu = "QuitterAddEtu";

    leaveAddEtu = cipi5.addButton(nomQuitterAddEtu)
      .setPosition(width - width / 4 - height / 20, height / 20 + 2)
      .setSize(height / 20, height / 30)
      .setCaptionLabel("Retour")
      .setImage(quit)
      .setColorBackground(primaryColor)
      .setColorForeground(secondaryColor)
      .setColorActive(activeColor);

    numLabel = cipi5.addTextlabel("labelNum")
      .setText("Numéro de l'étudiant:")
      .setPosition(offsetB, startY)
      .setFont(createFont("Arial", 18))
      .setColorValue(color(0));

    numField = cipi5.addTextfield("NumField")
      .setPosition(offsetB + labelWidth + offsetX, startY)
      .setSize(textFieldWidth, 30)
      .setFont(createFont("Arial", 18))
      .setColorBackground(color(190, 190, 190))
      .setInputFilter(ControlP5.INTEGER)
      .setLabelVisible(true);

    numField.getCaptionLabel()
      .setText("");

    nomLabel = cipi5.addTextlabel("labelNom")
      .setText("Nom de l'étudiant:")
      .setPosition(offsetB, startY + verticalSpacing)
      .setFont(createFont("Arial", 18))
      .setColorValue(color(0));

    nomField = cipi5.addTextfield("NomField")
      .setPosition(offsetB + labelWidth + offsetX, startY + verticalSpacing)
      .setSize(textFieldWidth, 30)
      .setFont(createFont("Arial", 18))
      .setColorBackground(color(190, 190, 190))
      .setLabelVisible(true);

    nomField.getCaptionLabel()
      .setText("");

    prenomLabel = cipi5.addTextlabel("labelPrenom")
      .setText("Prénom de l'étudiant:")
      .setPosition(offsetB, startY + verticalSpacing * 2)
      .setFont(createFont("Arial", 18))
      .setColorValue(color(0));

    prenomField = cipi5.addTextfield("PrenomField")
      .setPosition(offsetB + labelWidth + offsetX, startY + verticalSpacing * 2)
      .setSize(textFieldWidth, 30)
      .setFont(createFont("Arial", 18))
      .setColorBackground(color(190, 190, 190))
      .setLabelVisible(true);

    prenomField.getCaptionLabel()
      .setText("");

    groupeLabel = cipi5.addTextlabel("labelGroupes")
      .setText("Groupes de l'étudiant:")
      .setPosition(offsetB, startY + verticalSpacing * 3)
      .setFont(createFont("Arial", 18))
      .setColorValue(color(0));

    groupesField = cipi5.addTextfield("GroupesField")
      .setPosition(offsetB + labelWidth + offsetX, startY + verticalSpacing * 3)      
      .setSize(textFieldWidth, 30)
      .setFont(createFont("Arial", 18))
      .setColorBackground(color(190, 190, 190))
      .setLabelVisible(true);

    groupesField.getCaptionLabel()
      .setText("");

    validerButton = cipi5.addButton("ValiderButton")
      .setPosition(offsetB + labelWidth + offsetX, startY + verticalSpacing * 4 + 20)
      .setSize(buttonWidth, buttonHeight)
      .setFont(createFont("Arial", 18))
      .setColorBackground(color(0, 255, 0))
      .setLabel("Valider")
      .onClick(e -> valider());

    effacerButton = cipi5.addButton("EffacerButton")
      .setPosition(offsetB + labelWidth, startY + verticalSpacing * 4 + 20)
      .setSize(buttonWidth, buttonHeight)
      .setFont(createFont("Arial", 18))
      .setColorBackground(color(255, 0, 0))
      .setLabel("Effacer")
      .onClick(e -> effacer());

    choisirPhoto = cipi5.addButton("Choisir Photo")
      .setPosition(circleX - 30, startY + verticalSpacing * 5 + 40)
      .setSize(imageWidth, buttonHeight)
      .setFont(createFont("Montserrat-Regular", 12))
      .setColorBackground(primaryColor)
      .setColorForeground(secondaryColor)
      .setColorActive(activeColor)
      .onClick(e -> choisirPhoto());
  }
  
  public void drawAjouterEtudiant() {
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
    text("Ajouter un étudiant", 10, height / 20 + 10);

  }
  
  void choisirPhoto() {
    Frame frame = new Frame();
    FileDialog fileDialog = new FileDialog(frame, "Choisir une photo", FileDialog.LOAD);
    fileDialog.setVisible(true);

    String selectedFile = fileDialog.getFile();
    String selectedDirectory = fileDialog.getDirectory();
    if (selectedFile != null && selectedDirectory != null) {
      selectedPhotoPath = selectedDirectory + selectedFile;
      PImage selectedPhoto = loadImage(selectedPhotoPath);
      etudiantPhoto = selectedPhoto;
      updateEtuSelection();
    }
  }

  private void valider() {
    String input = numField.getText();
    int numero;

    if (!input.isEmpty()) {
      try {
        numero = Integer.parseInt(input);
      }
      catch (NumberFormatException e) {
        e.printStackTrace();
        return;
      }
    } else {
      numero = -1;
    }

    String nom = nomField.getText();
    String prenom = prenomField.getText();
    String groupesText = groupesField.getText();

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
    }

    nouvelEtudiant = new Etudiant(numero, nom, prenom, etudiantPhoto, groupesEtudiant);
    listeEtu.ajouterEtudiant(nouvelEtudiant);

    numField.setText("");
    nomField.setText("");
    prenomField.setText("");
    groupesField.setText("");
    etudiantPhoto = defaultProfil;
  }

  public void updateEtuSelection() {
    circleY = choisirPhoto.getPosition()[1] - imageHeight - 20;

    PGraphics maskImage = createGraphics(imageWidth, imageHeight);
    maskImage.beginDraw();
    maskImage.background(0);
    maskImage.ellipse(imageWidth / 2, imageHeight / 2, circleDiameter, circleDiameter);
    maskImage.endDraw();

    if (etudiantPhoto == null) {
      defaultProfil.resize(imageWidth, imageHeight);
      imageMode(CENTER);
      image(defaultProfil, circleX + 50, circleY);
    } else {
      PImage maskedPhoto = createImage(imageWidth, imageHeight, RGB);
      maskedPhoto.copy(etudiantPhoto, 0, 0, etudiantPhoto.width, etudiantPhoto.height, 0, 0, imageWidth, imageHeight);
      maskedPhoto.mask(maskImage);

      imageMode(CENTER);
      image(maskedPhoto, circleX + 50, circleY);
    }
  }

  private void effacer() {
    numField.setText("");
    nomField.setText("");
    prenomField.setText("");
    groupesField.setText("");
    etudiantPhoto = defaultProfil;
  }
  
  public void hideAll(){
    numLabel.hide();
    nomLabel.hide();
    prenomLabel.hide();
    groupeLabel.hide();
    
    leaveAddEtu.hide();
    numField.hide();
    nomField.hide();
    prenomField.hide();
    groupesField.hide();
    
    validerButton.hide();
    effacerButton.hide();
    choisirPhoto.hide();
  }
  
  public void showAll(){
    numLabel.show();
    nomLabel.show();
    prenomLabel.show();
    groupeLabel.show();
    
    leaveAddEtu.show();
    numField.show();
    nomField.show();
    prenomField.show();
    groupesField.show();
    
    validerButton.show();
    effacerButton.show();
    choisirPhoto.show();
  }
}
