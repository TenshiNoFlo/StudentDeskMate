class ConnexionMode {

  int rectWidth = width / 3;
  int rectHeight = height / 3;
  int rectX = width / 2;
  int rectY = height / 2;

  public ConnexionMode() {
  }

  public void createUIConnexionMode() {
    String nomThemes = "Themes";

    idConnexion = cp5.addTextfield("IDConn")
      .setPosition(width / 3 + ((width / 2 - width / 3 / 2) - 200) / 2, height / 3 + ((height / 2 - height / 3 / 2) - 120) / 2)
      .setSize(width / 10, height / 30)
      .setFont(createFont("Montserrat-Regular", 12))
      .setColor(color(50))
      .setColorBackground(color(255))
      .setColorActive(color(255))
      .setColorForeground(color(255))
      .setColorCursor(textColorField)
      .setCaptionLabel("");

    lgConnexion = cp5.addTextfield("LGConn")
      .setPosition(width / 3 + ((width / 2 - width / 3 / 2) - 200) / 2, height / 3 + ((height / 2 - height / 3 / 2) - 120) / 2 + height / 15)
      .setSize(width / 10, height / 30)
      .setFont(createFont("Montserrat-Regular", 12))
      .setColor(color(50))
      .setColorBackground(color(255))
      .setColorActive(color(255))
      .setColorForeground(color(255))
      .setColorCursor(textColorField)
      .setPasswordMode(true)
      .setCaptionLabel("");

    connButton = cp5.addButton("connexionButton")
      .setPosition(width / 3 + ((width / 2 - width / 3 / 2) - 100) / 2, height / 2 + 60)
      .setSize(100, 40)
      .setLabel("Connection");

    deconnButton = cp5.addButton("deconnexionButton")
      .setPosition(width / 3 + ((width / 2 - width / 3 / 2) - 100) / 2, height / 2 + 60)
      .setSize(100, 40)
      .setLabel("Déconnexion");

    leaveConnexion = cp5.addButton("leaveConn")
      .setPosition(width / 3 * 2 - height / 30, height / 3)
      .setSize(height / 30, height / 30)
      .setCaptionLabel("")
      .setImage(quit)
      .setColorBackground(primaryColor)
      .setColorForeground(secondaryColor)
      .setColorActive(activeColor);
  }

  public void drawConnexionMode() {
    if (connect[1] == "false") {
      stroke(menuColor);

      fill(fillColorLight);
      rect(width/3, height/3, width / 2 - width / 3 / 2, height / 2 - height / 3 / 2);

      noStroke();

      fill(menuColor);
      rect(width/3, height/3, width / 2 - width / 3 / 2, height / 30);

      fill(textColor);
      textAlign(LEFT, TOP);
      textSize(20);
      text("Connexion", width / 3 + 10, height / 3 + 10);

      textAlign(CENTER, BOTTOM);

      text("ID :", width / 3 + ((width / 2 - width / 3 / 2) - 200) / 2 + width / 20, height / 3 + ((height / 2 - height / 3 / 2) - 120) / 2 - 5);

      text("Login :", width / 3 + ((width / 2 - width / 3 / 2) - 200) / 2 + width / 20, height / 3 + ((height / 2 - height / 3 / 2) - 120) / 2 + height / 15 - 5);
    } else {
      // Code pour afficher le profil de l'utilisateur connecté à partir de la base de données
      Connection connexion = null;
      PreparedStatement statement = null;
      ResultSet resultat = null;
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connexion = DriverManager.getConnection(url, utilisateur, motDePasse);
        String query = "SELECT * FROM Personne WHERE loginPersonne = ?";
        statement = connexion.prepareStatement(query);
        statement.setString(1, connect[0]);
        resultat = statement.executeQuery();
        if (resultat.next()) {
          int idPersonne = resultat.getInt("idPersonne");
          String loginPersonne = resultat.getString("loginPersonne");
          String imagePath = resultat.getString("image");

          // Afficher le profil de la personne
          stroke(menuColor);
          fill(fillColorLight);
          rect(width/3, height/3, width / 2 - width / 3 / 2, height / 2 - height / 3 / 2);
          noStroke();
          fill(menuColor);
          rect(width/3, height/3, width / 2 - width / 3 / 2, height / 30);
          fill(textColor);
          textAlign(LEFT, TOP);
          textSize(20);
          text("Profil de " + loginPersonne, width / 3 + 10, height / 3 + 10);

          println(imagePath);

          PImage img = loadImage(imagePath);

          img.resize(100, 100);
          image(img, width / 3 + 25, height / 3 + 50);


          text("ID : " + idPersonne, width / 3 + 150, height / 3 + 60);
          text("Login : " + loginPersonne, width / 3 + 150, height / 3 + 110);
        }
      }
      catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
      }
      finally {
        // Fermeture des ressources
        try {
          if (resultat != null) resultat.close();
          if (statement != null) statement.close();
          if (connexion != null) connexion.close();
        }
        catch (SQLException e) {
          e.printStackTrace();
        }
      }
    }
  }

  String[] verifierConnexion() {
    String username = idConnexion.getText();
    String password = lgConnexion.getText();
    Connection connexion = null;
    PreparedStatement statement = null;
    ResultSet resultat = null;
    String loginPersonne = "Login";
    String validate = "false";
    String idPersonne = "empty";
    String[] toReturn =  {"Login", "false","empty"};

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      connexion = DriverManager.getConnection(url, utilisateur, motDePasse);

      String query = "SELECT * FROM Personne WHERE loginPersonne = ? AND mdpPersonne = ?";
      statement = connexion.prepareStatement(query);
      statement.setString(1, username);
      statement.setString(2, password);

      resultat = statement.executeQuery();

      if (resultat.next()) {
        loginPersonne = resultat.getString("loginPersonne");
        idPersonne = resultat.getString("idPersonne");
        validate = "true";
        toReturn[0] = loginPersonne;
        toReturn[1] = validate;
        toReturn[2] = idPersonne;
      }
    }
    catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
    }
    finally {
      try {
        if (resultat != null) {
          resultat.close();
        }
        if (statement != null) {
          statement.close();
        }
        if (connexion != null) {
          connexion.close();
        }
      }
      catch (SQLException e) {
        e.printStackTrace();
      }
    }
    return toReturn;
  }
}
