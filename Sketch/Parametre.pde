class Parametre {

  int rectWidth = width / 3;
  int rectHeight = height / 3;
  int rectX = width / 2;
  int rectY = height / 2;

  public Parametre() {
  }

  public void createUIParametre() {
    String nomThemes = "Themes";
    String nomQuitterPara = "QuitterPara";

    leavePara = cp5Para.addButton(nomQuitterPara)
      .setPosition(width - width / 4 - height / 20, height / 20 + 2)
      .setSize(height / 20, height / 30 - 1)
      .setCaptionLabel("Retour")
      .setImage(quit)
      .setColorBackground(primaryColor)
      .setColorForeground(secondaryColor)
      .setColorActive(activeColor);

    themes = cp5Para.addListBox(nomThemes)
      .setPosition(10, height / 20 + 10 + 20 + 20)
      .setSize(width / 10, height / 5)
      .setBarHeight(height / 20)
      .setItemHeight(height / 20)
      .addItems(new String[] {"Défaut", "Clair", "Sombre", "Girly"})
      .setColorBackground(primaryColor)
      .setColorForeground(secondaryColor)
      .setColorActive(activeColor)
      .setFont(createFont("Montserrat-Regular", 12))
      .close();
      
    statusLegend = cp5Para.addToggle("")
     .setPosition(width / 4, height / 20 + 65)
     .setSize(50, 30)
     .setMode(ControlP5.SWITCH)
     .setState(true);
      
  }

  public void drawParametre() {
    println("Test in");
    stroke(menuColor);

    // Dessiner le grand rectangle
    fill(fillColorLight);
    rect(0, height/20, width - width / 4, height - height /20 - height / 5);
    
    stroke(0);
    line(0, height/20 + 1,width - width / 4,height/20 + 1);

    noStroke();

    // Dessiner le rectangle pour le texte "Paramètres"
    fill(menuColor);
    rect(0, height/20 + 2, width - width / 4, height / 30 + 2);

    // Dessiner le texte "Paramètres"
    fill(textColor);
    textAlign(LEFT, TOP);
    textSize(20);

    text("Paramètres", 10, height / 20 + 10);
    textSize(18);
    text("Cacher la légende", width / 7 + 20, height / 20 + 70);
    
    if (statusLegend.getState())
      text("NON", width / 4 + 70, height / 20 + 70);
    else
      text("OUI", width / 4 + 70, height / 20 + 70);
  }


  public void setTheme(color[] palette) {
    primaryColor = palette[0];
    secondaryColor = palette[1];
    activeColor = palette[2];
    backgroundColor = palette[3];
    menuColor = palette[4];
    fillColorLight = palette[5];
    fillColorDark = palette[6];
    textColor = palette[7];
    accentColor = palette[8];
    warningColor = palette[9];
    whiteColor = palette[10];
    hoverColor = palette[11];
    selecColor = palette[12];
  }

  void buttonColorMaj(ControlP5 cp5Object, Textfield tf) {
    cp5Object.setColorBackground(primaryColor);
    cp5Object.setColorForeground(secondaryColor);
    cp5Object.setColorActive(activeColor);

    tf.setColorBackground(whiteColor);
    tf.setColorForeground(whiteColor);
    tf.setColorActive(whiteColor);

    if (cp5Object == cp5EtuSelec) {
      prenomTf.setColorBackground(whiteColor);
      prenomTf.setColorForeground(whiteColor);
      prenomTf.setColorActive(whiteColor);

      nomTf.setColorBackground(whiteColor);
      nomTf.setColorForeground(whiteColor);
      nomTf.setColorActive(whiteColor);

      numTf.setColorBackground(whiteColor);
      numTf.setColorForeground(whiteColor);
      numTf.setColorActive(whiteColor);

      grpTf.setColorBackground(whiteColor);
      grpTf.setColorForeground(whiteColor);
      grpTf.setColorActive(whiteColor);

      grpElTf.setColorBackground(whiteColor);
      grpElTf.setColorForeground(whiteColor);
      grpElTf.setColorActive(whiteColor);
    }
  }
}
