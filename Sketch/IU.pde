void roundedRect(float x, float y, float w, float h, float r, color c) {
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

void chargerImage() {
  logo = loadImage("LOGO/logo_SDM.png");
  reload = loadImage("LOGO/reload.png");
  filtre = loadImage("LOGO/filtre.png");
  quit = loadImage("LOGO/quit.png");
  quit2 = loadImage("LOGO/quit2.png");
  cadena = loadImage("LOGO/cadena.png");
  ontoggle = loadImage("LOGO/on_toggle.png");
  offtoggle = loadImage("LOGO/off_toggle.png");
  defaultProfil = loadImage("PROFIL/defaultProfil.png");
  upload = loadImage("LOGO/upload.png");
  upload_hover = loadImage("LOGO/upload_hover.png");
}

void imageInterface() {
  chargerImage();

  logo.resize(logo.width / width * height / 20, height / 20);
  reload.resize(reload.width / width * height / 20, height / 20);
  widthReloadFull = reload.width;
  filtre.resize(filtre.width / width * height / 20, height / 20);
  widthFiltreFull = filtre.width;
  quit.resize(height / 25, height / 25);
  quit2.resize(height / 25, height / 25);
  ontoggle.resize(80, 40);
  offtoggle.resize(80, 40);
  upload.resize(200, 200);
  upload_hover.resize(200, 200);

  fill(textColor);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("StudentDeskMate", width / 2 - logo.width / 2 + width / 20, height / 40);
}


void affichage() {

  background(backgroundColor);
  fill(menuColor);

  rect(0, 0, width, height / 20);
  
  if (statusLegend.getState())
    legende.show();

  fill(fillColorDark);

  rect(width * 0.75, height / 20, width * 0.25, height - height / 20);
  fill(fillColorLight);
  roundedRect(width * 0.75 + width * 0.25 / 5, height / 20 + 10, width * 0.25 / 5 * 3 *0.9, height / 20, 15, whiteColor);

  imageInterface();


  if (afficheTab) {
    if (firstin) {

      para.buttonColorMaj(cp5, rechercheTF);
      para.buttonColorMaj(cp5Para, rechercheTF);
      para.buttonColorMaj(cp5EtuSelec, prenomTf);
      para.buttonColorMaj(cp5EtuSelec, nomTf);
      para.buttonColorMaj(cp5EtuSelec, numTf);
      para.buttonColorMaj(cp5EtuSelec, grpTf);
      para.buttonColorMaj(cp5EtuSelec, grpElTf);
      para.buttonColorMaj(cepe5, rechercheTF);

      firstin = false;
    }

    if (statusLegend.getState())
      legende.show();

    if (selecEtu) {
      afficherTableauEtudiant(listeEtu);
      selecEtu = false;
    }
    afficherTableauEtudiant(listeEtu);
  }

  if (afficherSal) {
    masalle.dessinerPlan();
  }
}


boolean quitHovering() {
  if (cp5.getController("Quitter").isInside()) {
    isHovering = true;
  } else {
    isHovering = false;
  }

  if (isHovering) {
    cp5.getController("Quitter").setImage(quit2);
    cp5.getController("Quitter").setColorBackground(color(200, 0, 0));
    return true;
  } else {
    cp5.getController("Quitter").setImage(quit);
    return false;
  }
}

void melangerEtudiants(ArrayList<Etudiant> etuTemp) {
  Collections.shuffle(etuTemp);
}

void genererCouleur() {
  for (int i=1; i<nombreGroupesEloignement; i++) {
    int[] nombresGeneres = new int[3];
    for (int j = 0; j < 3; j++) {
      nombresGeneres[j] = int(random(50, 250)) + i*(10+j);
    }

    listeCouleursGrpEloig[i] = color(nombresGeneres[0], nombresGeneres[1], nombresGeneres[2]);
  }
  listeCouleursGrpEloig[0] = color(0, 0, 0);
  listElo[0] = new Eloignement("0", listeCouleursGrpEloig[0]);
  listElo[1] = new Eloignement("1", listeCouleursGrpEloig[1]);
  listElo[2] = new Eloignement("2", listeCouleursGrpEloig[2]);
}

/*
 * A function to enable the sleepMode
 * @return type, void
 */
void modeVeille() {
  background(0);
  hideAllCP5Elements(); // Cacher tous les éléments CP5
}

/*
 * A function to hide all CP5 element
 * @return type, void
 */
void hideAllCP5Elements() {
  fichier.hide();
  ajouter.hide();
  salle.hide();
  gestion.hide();
  tri.hide();
  rechercheTF.hide();
  largTable.hide();
  longTable.hide();
  parametre.hide();
  reloadBtn.hide();
  connectButton.hide();
}

/*
 * A function to show all CP5 element
 * @return type, void
 */
void showAllCP5Elements() {
  fichier.show();
  ajouter.show();
  salle.show();
  gestion.show();
  tri.show();
  rechercheTF.show();
  largTable.show();
  longTable.show();
  parametre.show();
  reloadBtn.show();
  connectButton.show();
}

/*
 * A function to make all CP5 elements non-clickable
 * @return type, void
 */
void disableClickabilityOfAllCP5Elements() {
  fichier.setLock(true);
  ajouter.setLock(true);
  salle.setLock(true);
  gestion.setLock(true);
  tri.setLock(true);
  rechercheTF.setLock(true);
  largTable.setLock(true);
  longTable.setLock(true);
  parametre.setLock(true);
  reloadBtn.setLock(true);
  connectButton.setLock(true);
}

/*
 * A function to make all CP5 elements clickable again
 * @return type, void
 */
void enableClickabilityOfAllCP5Elements() {
  fichier.setLock(false);
  ajouter.setLock(false);
  salle.setLock(false);
  gestion.setLock(false);
  tri.setLock(false);
  rechercheTF.setLock(false);
  largTable.setLock(false);
  longTable.setLock(false);
  parametre.setLock(false);
  reloadBtn.setLock(false);
  connectButton.setLock(false);
}


/*
 * A function to draw and make moove an picture when sleepMode is on
 * @return type, void
 */
Color[] couleursVives = {
  new Color(255, 0, 0), // Rouge vif
  new Color(255, 165, 0), // Orange vif
  new Color(255, 255, 0), // Jaune vif
  new Color(0, 255, 0), // Vert vif
  new Color(0, 255, 255), // Cyan vif
  new Color(0, 0, 255), // Bleu vif
  new Color(255, 0, 255), // Violet vif
  new Color(255, 20, 147), // Rose vif
  new Color(0, 206, 209), // Turquoise vif
  new Color(0, 255, 0), // Vert citron
  new Color(204, 255, 0), // Jaune citron
  new Color(138, 43, 226), // Violet électrique
  new Color(255, 0, 255), // Magenta
  new Color(255, 0, 127), // Rose fuchsia
  new Color(255, 255, 51)    // Jaune fluo
};

void moveAndBounceImages() {
  // Mouvement et rebondissement pour la première image
  x += speedX;
  y += speedY;

  if (x + imgTellez.width >= width || x <= 0) {
    speedX *= -1;

    Color couleurVive = couleursVives[int(random(couleursVives.length))];
    tint(couleurVive.getRed(), couleurVive.getGreen(), couleurVive.getBlue());
    imgTellez.filter(GRAY);
  }

  if (y + imgTellez.height >= height || y <= 0) {
    speedY *= -1;

    Color couleurVive = couleursVives[int(random(couleursVives.length))];
    tint(couleurVive.getRed(), couleurVive.getGreen(), couleurVive.getBlue());
    imgTellez.filter(GRAY);
  }
  image(imgTellez, x, y);
  
  // Mouvement et rebondissement pour la deuxième image
  x2 += speedX2;
  y2 += speedY2;

  if (x2 + imgBerger.width >= width || x2 <= 0) {
    speedX2 *= -1;

    Color couleurVive2 = couleursVives[int(random(couleursVives.length))];
    tint(couleurVive2.getRed(), couleurVive2.getGreen(), couleurVive2.getBlue());
    imgBerger.filter(GRAY);
  }

  if (y2 + imgBerger.height >= height || y2 <= 0) {
    speedY2 *= -1;

    Color couleurVive2 = couleursVives[int(random(couleursVives.length))];
    tint(couleurVive2.getRed(), couleurVive2.getGreen(), couleurVive2.getBlue());
    imgBerger.filter(GRAY);
  }
  image(imgBerger, x2, y2);
}



void colorize(PImage img) {
  img.filter(200);
}


/*
 * A function to select a random picture and return it
 * @return type, PImage
 */
PImage getRandomImage() {
  PImage[] images = {imgTellez, imgFaru, imgKarim, imgValette, imgBoutin};

  int randomIndex = int(random(images.length));

  return images[randomIndex];
}

void changeLogin() {
  if (connect[1] != "false") {
    textConnect = connect[0];
  } else {
    textConnect = "Login";
  }
  connectButton.setLabel(textConnect);
}

public void ImageInsertion() {
  String url = "jdbc:mysql://localhost:3306/votre_base_de_donnees";
  String utilisateur = "votre_utilisateur";
  String motDePasse = "votre_mot_de_passe";

  try (Connection connexion = DriverManager.getConnection(url, utilisateur, motDePasse)) {
    // Parcours des personnes pour ajouter leurs images
    for (int i = 1; i <= 10; i++) { // Par exemple, pour 10 personnes
      String fichierImage = "chemin_vers_image_personne_" + i + ".jpg"; // Chemin vers l'image de la personne i

      // Préparation de la requête d'insertion
      String query = "UPDATE Personne SET image = ? WHERE idPersonne = ?";
      try (PreparedStatement statement = connexion.prepareStatement(query)) {
        File imageFile = new File(fichierImage);
        FileInputStream inputStream = new FileInputStream(imageFile);

        statement.setBinaryStream(1, inputStream);
        statement.setInt(2, i); // Suppose que l'identifiant de la personne est i

        // Exécution de la requête
        statement.executeUpdate();
      }
      catch (Exception e) {
        e.printStackTrace();
      }
    }
    System.out.println("Les images ont été insérées avec succès dans la base de données.");
  }
  catch (SQLException e) {
    e.printStackTrace();
  }
}
