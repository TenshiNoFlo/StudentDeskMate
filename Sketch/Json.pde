import processing.svg.*; //<>//
 //<>//
import processing.data.*;
import java.io.*;


void enregistrerDonneesJSON() {

  Frame fenetre = new Frame("Sélectionnez le fichier JSON");
  FileDialog dialog = new FileDialog(fenetre, "Enregistrer", FileDialog.SAVE);
  dialog.setFile("*.json");
  dialog.setVisible(true);
  String directory = dialog.getDirectory();
  String file = dialog.getFile();

  if (directory != null && file != null) {
    String nomFichier = directory + file;

    JSONObject donnees = new JSONObject();
    AESCrypt crypteur= new AESCrypt();


    //SALLE SVG

    if (svgSalleToString != null) {
      JSONArray svgContent = new JSONArray();

      for (int i = 0; i < svgSalleToString.length; i++) {
        svgContent.setString(i, svgSalleToString[i]);
      }

      donnees.setJSONArray("svgContent", svgContent);
    } else {
      println("Impossible de charger le fichier SVG !");
    }

    // ETUDIANTS
    JSONArray listeEtudiants = new JSONArray();

    for (Etudiant etudiant : listeEtu.getEtudiants()) {
      JSONObject etudiantJSON = new JSONObject();
      etudiantJSON.setInt("num", etudiant.getNum());
      etudiantJSON.setString("nom", etudiant.getNom());
      etudiantJSON.setString("prenom", etudiant.getPrenom());
      etudiantJSON.setBoolean("tierTemps", etudiant.getTierTemps());
      etudiantJSON.setString("photo", (etudiant.getPhoto() != null) ? "OUI" : "NON");
      etudiantJSON.setString("groupe", etudiant.getGroupeString());
      etudiantJSON.setBoolean("visible", etudiant.isVisible());
      etudiantJSON.setInt("NumTable", etudiant.getTableEtu());
      etudiantJSON.setInt("NumEloignement", etudiant.getGroupeEloignement());

      listeEtudiants.append(etudiantJSON);
    }


    donnees.setJSONArray("listeEtudiants", listeEtudiants);


    // ELOIGNEMENT

    JSONArray jsonArrayGroups = new JSONArray();

    for (int i = 0; i < listElo.length; i++) {
      Eloignement eloignement = listElo[i];

      if (eloignement != null) {
        JSONObject eloignementJSON = new JSONObject();
        eloignementJSON.setString("nomEloignement", eloignement.getNomEloignement());

        eloignementJSON.setFloat("red", red(eloignement.getColor()));
        eloignementJSON.setFloat("green", green(eloignement.getColor()));
        eloignementJSON.setFloat("blue", blue(eloignement.getColor()));


        if (eloignement.getLstEtuEloignement() != null) {
          JSONArray jsonArrayEtudiants = new JSONArray();
          for (Etudiant etudiant : eloignement.getLstEtuEloignement()) {
            JSONObject etudiantJSON = new JSONObject();
            etudiantJSON.setInt("numeroEtu", etudiant.getNum());
            jsonArrayEtudiants.append(etudiantJSON);
          }
          eloignementJSON.setJSONArray("lstEtuEloignement", jsonArrayEtudiants);
        }

        jsonArrayGroups.append(eloignementJSON);
      }
    }

    donnees.setJSONArray("listeEloignement", jsonArrayGroups);

    // tables

    JSONArray jsonArrayTables = new JSONArray();

    for (Table table : masalle.getList()) {
      JSONObject tableJSON = new JSONObject();
      tableJSON.setFloat("x", table.getX());
      tableJSON.setFloat("y", table.getY());
      tableJSON.setFloat("orientation", table.getOrientation());
      tableJSON.setFloat("lon", table.getLon());
      tableJSON.setFloat("lar", table.getLar());
      tableJSON.setFloat("offsetX", table.getOffsetX());
      tableJSON.setFloat("offsetY", table.getOffsetY());
      tableJSON.setInt("numero", table.getNumero());
      tableJSON.setBoolean("verrouille", table.isVerrouille());
      tableJSON.setBoolean("exploitable", table.isExploitable());

      if (table.getEtuAssigne() != null) {
        tableJSON.setInt("numEtudiantAssigne", table.getEtuAssigne().getNum());
      } else {
        tableJSON.setInt("numEtudiantAssigne", -1);
      }
      tableJSON.setFloat("txtSize", table.getTxtSize());

      jsonArrayTables.append(tableJSON);
    }
    donnees.setJSONArray("listeTables", jsonArrayTables);


    // GROUPES

    JSONArray jsonArrayGroupes = new JSONArray();

    for (Groupe groupe : gestionGrp.getLst()) {
      JSONObject groupeJSON = new JSONObject();
      groupeJSON.setString("nom", groupe.getNom());
      groupeJSON.setInt("couleur", groupe.getColor());

      JSONArray numEtudiantsArray = new JSONArray();
      ArrayList<Etudiant> etudiants = groupe.getEtudiants();
      for (Etudiant etudiant : etudiants) {
        numEtudiantsArray.append(etudiant.getNum());
      }
      groupeJSON.setJSONArray("numEtudiants", numEtudiantsArray);

      jsonArrayGroupes.append(groupeJSON);
    }
    donnees.setJSONArray("listeGroupes", jsonArrayGroupes);


    String donneesJSON = "";
    try {
      donneesJSON = crypteur.encrypt(donnees.toString());
    }
    catch (Exception e) {
      e.printStackTrace();
      println("erreur cryptage");
    }

    println(donneesJSON);
    saveStrings(nomFichier, new String[]{donneesJSON});
    println("Données enregistrées dans donnees.json");

    if (connect[1] == "true") {
      println("Stock in DB");
      try {
        Connection conn = DriverManager.getConnection(url, utilisateur, motDePasse);

        String sql = "INSERT INTO Salles (Json, PersonneID) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        String json = donneesJSON;
        println(json);
        int personneID = Integer.parseInt(connect[2]);
        ;

        pstmt.setString(1, json);
        pstmt.setInt(2, personneID);

        pstmt.executeUpdate();

        pstmt.close();
        conn.close();

        println("La salle a été ajoutée à la DataBase !");
      }
      catch (SQLException e) {
        e.printStackTrace();
        println("Erreur lors de l'ajout de la salle : " + e.getMessage());
      }
    }
  }
}

void chargerDonneesJSON() {
  selectInput("Sélectionner un fichier JSON", "chargerFichierJSON");
}

void chargerDonnesJSONDataBase() {
  chargerFichierJSONDataBase();
}

void chargerFichierJSON(File selection) {

  if (selection == null) {
    println("Aucun fichier sélectionné.");
  } else {
    String filePath = selection.getAbsolutePath();
    StringBuilder contenu = new StringBuilder();

    try {
      BufferedReader lecteur = new BufferedReader(new FileReader(filePath));
      String ligne;
      while ((ligne = lecteur.readLine()) != null) {
        contenu.append(ligne);
      }
      lecteur.close();
    }
    catch(Exception e) {
      e.printStackTrace();
    }

    String donneesChiffrees= contenu.toString();

    if (donneesChiffrees == null) {
      println("Erreur lors du chargement du fichier JSON : " + filePath);
      return;
    }

    AESCrypt crypteur = new AESCrypt();
    JSONObject donnees;
    try {
      println("le poulet");


      String donneesJSON = crypteur.decrypt(donneesChiffrees);

      donnees = JSONObject.parse(donneesJSON);


      println("Données JSON déchiffrées avec succès.");
    }
    catch (Exception e) {
      println("Erreur lors du déchiffrement des données JSON : " + e.getMessage());
      e.printStackTrace();
      println("j'ai mal");
      donnees=null;
      donnees = JSONObject.parse(donneesChiffrees);
    }

    println(donnees.toString());
 //<>//
    if (donnees.hasKey("svgContent")) { //<>//
      println("chargement JSON");
      chargerSVG(donnees);
      if (donnees.hasKey("listeEtudiants")) {
        listeEtu = new ListeEtu();
        println("YES1");
        chargerListeEtudiants(donnees);
      }

      if (donnees.hasKey("listeGroupes")) {
        println("YES2");

        chargerListeGroupes(donnees);
      }

      if (donnees.hasKey("listeTables")) {
        chargerListeTables(donnees);
        println("YES3");
      }
      if (donnees.hasKey("listeEloignement")) {
        println("YES4");
        loadEloignementData(donnees);
      }
    }
    println("Chargement du fichier JSON terminé : " + filePath);
  }
}


void chargerFichierJSONDataBase() {

  String donneesChiffrees = "";

  try {
    Connection conn = DriverManager.getConnection(url, utilisateur, motDePasse);

    String sql = "SELECT Json FROM Salles WHERE ID = ? AND PersonneID = ? LIMIT 1";
    PreparedStatement pstmt = conn.prepareStatement(sql);

    int salleID = 1;
    int personneID = Integer.parseInt(connect[2]);
    pstmt.setInt(1, salleID);
    pstmt.setInt(2, personneID);

    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
      donneesChiffrees = rs.getString("Json");

      println("JSON récupéré : " + donneesChiffrees);
    } else {
      println("Aucun enregistrement trouvé pour l'ID de la salle spécifié.");
    }

    rs.close();
    pstmt.close();
    conn.close();
  }

    catch (SQLException e) {
      e.printStackTrace();
      println("Erreur lors de la récupération du JSON depuis la base de données : " + e.getMessage());
    }


    AESCrypt crypteur = new AESCrypt();
    JSONObject donnees;
    try {
      println("le poulet");


      String donneesJSON = crypteur.decrypt(donneesChiffrees);

      donnees = JSONObject.parse(donneesJSON);


      println("Données JSON déchiffrées avec succès.");
    }
    catch (Exception e) {
      println("Erreur lors du déchiffrement des données JSON : " + e.getMessage());
      e.printStackTrace();
      println("j'ai mal");
      donnees=null;
      donnees = JSONObject.parse(donneesChiffrees);
    }

    println(donnees.toString());


 //<>//
    if (donnees.hasKey("svgContent")) { //<>// //<>//
      println("chargement JSON");
      chargerSVG(donnees);
      if (donnees.hasKey("listeEtudiants")) {
        listeEtu = new ListeEtu();
        println("YES1");
        chargerListeEtudiants(donnees);
      }

      if (donnees.hasKey("listeGroupes")) {
        println("YES2");

        chargerListeGroupes(donnees);
      }

      if (donnees.hasKey("listeTables")) {
        chargerListeTables(donnees);
        println("YES3");
      }
      if (donnees.hasKey("listeEloignement")) {
        println("YES4");
        loadEloignementData(donnees);
      }
    }
    println("Chargement du fichier JSON terminé");
 
}


void chargerListeEtudiants(JSONObject donnees) {
  gestionGrp = new GestionGroupe(this, 1000, 500);
  JSONArray listeEtudiantsJSON = donnees.getJSONArray("listeEtudiants");

  for (int i = 0; i < listeEtudiantsJSON.size(); i++) {
    JSONObject etudiantJSON = listeEtudiantsJSON.getJSONObject(i);
    int num = etudiantJSON.getInt("num");
    String nom = etudiantJSON.getString("nom");
    String prenom = etudiantJSON.getString("prenom");
    boolean tierTemps = etudiantJSON.getBoolean("tierTemps");
    String photo = etudiantJSON.getString("photo");
    boolean visible = etudiantJSON.getBoolean("visible");
    int tableEtu = etudiantJSON.getInt("NumTable");
    int NumEloignement = etudiantJSON.getInt("NumEloignement");

    PImage image = null;
    if (!photo.equals("NON") && !photo.isEmpty()) {
      image = loadImage(photo);
    }
    ArrayList<Groupe> lstGroupes= new ArrayList<Groupe>();
    Etudiant etudiant = new Etudiant(num, nom, prenom, tierTemps, lstGroupes, image, visible, tableEtu, NumEloignement);

    listeEtu.ajouterEtudiant(etudiant);
  }
  afficheTab=true;
}


void chargerSVG(JSONObject donnees) {
  if (donnees.hasKey("svgContent")) {
    JSONArray svgContent = donnees.getJSONArray("svgContent");

    StringBuilder fullSVGContent = new StringBuilder();
    for (int i = 0; i < svgContent.size(); i++) {
      fullSVGContent.append(svgContent.getString(i));
    }


    PShape maFormeSVG = SVGtoPShape(fullSVGContent.toString());
    maFormeSVG.setStroke(color(0));
    maFormeSVG.setStrokeWeight(1);

    afficherSal=true;
  } else {
    println("Aucun contenu SVG trouvé !");
  }
}

PShape SVGtoPShape(String content) {
  PrintWriter file = createWriter("temp.svg");

  file.print(content);
  file.flush();
  file.close();

  String nomFichier = sketchPath("") + "\\temp.svg";

  masalle = new Salle(nomFichier);
  svgSalleToString = loadStrings(nomFichier);

  PShape maFormeSVG = loadShape(nomFichier);

  // Supprimer le fichier temporaire après avoir chargé la forme SVG
  File tempFile = new File(nomFichier);
  try {
    if (tempFile.delete()) {
      println("Le fichier temporaire a été supprimé avec succès.");
    } else {
      println("Impossible de supprimer le fichier temporaire.");
    }
  }
  catch (Exception e) {
    e.printStackTrace();
  }

  return maFormeSVG;
}



void chargerListeTables(JSONObject donnees) {

  Etudiant etuAssigne;
  JSONArray listeTablesJSON = donnees.getJSONArray("listeTables");
  for (int i = 0; i < listeTablesJSON.size(); i++) {
    JSONObject tableJSON = listeTablesJSON.getJSONObject(i);

    float x = tableJSON.getFloat("x");
    float y = tableJSON.getFloat("y");
    float orientation = tableJSON.getFloat("orientation");
    float lon = tableJSON.getFloat("lon");
    float lar = tableJSON.getFloat("lar");
    float offsetX = tableJSON.getFloat("offsetX");
    float offsetY = tableJSON.getFloat("offsetY");
    int numero = tableJSON.getInt("numero");
    boolean verrouille = tableJSON.getBoolean("verrouille");
    boolean exploitable = tableJSON.getBoolean("exploitable");
    int numEtudiantAssigne = tableJSON.getInt("numEtudiantAssigne");
    float txtSize = tableJSON.getFloat("txtSize");


    if (numEtudiantAssigne >0) {
      etuAssigne = listeEtu.getEtu(numEtudiantAssigne);
    } else {
      etuAssigne= null;
    }
    Table table = new Table(x, y, orientation, lon, lar, offsetX, offsetY, numero, verrouille, exploitable, etuAssigne, txtSize);
    if (etuAssigne !=null && etuAssigne.getGroupeEloignement() >0) {
      table.setColorEloignement(etuAssigne.getGroupeEloignement());
    }
    compteurTables=numero+1;
    masalle.addTable(table);
  }
}

void chargerListeGroupes(JSONObject donnees) {
 //<>//
  listeEtu.clearGrp(); //<>//
  legende.clearGrp();
  flag_json = true;
  nbGroupe = 0;

  JSONArray listeGroupesJSON = donnees.getJSONArray("listeGroupes");
  for (int i = 0; i < listeGroupesJSON.size(); i++) {
    JSONObject groupeJSON = listeGroupesJSON.getJSONObject(i);
    String nomGroupe = groupeJSON.getString("nom");
    int couleurGroupe = groupeJSON.getInt("couleur");

    JSONArray numEtudiantsArray = groupeJSON.getJSONArray("numEtudiants");
    Groupe groupe = new Groupe(nomGroupe, couleurGroupe);
    for (int j = 0; j < numEtudiantsArray.size(); j++) {
      int numEtudiant = numEtudiantsArray.getInt(j);



      groupe.addEtu(listeEtu.getEtu(numEtudiant));

      listeEtu.getEtu(numEtudiant).ajouterGroupe(groupe);
    }
    listeEtu.ajouterGroupe(groupe);
  }
}

void loadEloignementData(JSONObject donnees) {
  // Clear existing data or initialize new data structures
  listElo = new Eloignement[10];  // Adjust this based on your actual data structure for Eloignement

  // Extract the JSONArray for Eloignements from the donnees object
  JSONArray jsonArrayEloignements = donnees.getJSONArray("listeEloignement");

  // Iterate through the JSON array
  for (int i = 0; i < jsonArrayEloignements.size(); i++) {
    JSONObject eloignementJSON = jsonArrayEloignements.getJSONObject(i);

    // Extract data from the JSON object
    String nomEloignement = eloignementJSON.getString("nomEloignement");
    float red = eloignementJSON.getFloat("red");
    float green = eloignementJSON.getFloat("green");
    float blue = eloignementJSON.getFloat("blue");

    // Example: Assuming you have a constructor for Eloignement
    Eloignement eloignement = new Eloignement(nomEloignement, color(red, green, blue));

    // Load the list of Etudiants
    JSONArray jsonArrayEtudiants = eloignementJSON.getJSONArray("lstEtuEloignement");
    if (jsonArrayEtudiants != null) {
      for (int j = 0; j < jsonArrayEtudiants.size(); j++) {
        JSONObject etudiantJSON = jsonArrayEtudiants.getJSONObject(j);
        int numeroEtu = etudiantJSON.getInt("numeroEtu");

        // Example: Assuming you have a method to add Etudiant to Eloignement
        Etudiant etu = listeEtu.getEtu(numeroEtu);
        eloignement.addEtuEloignement(etu);
      }
    }

    // Example: Adding the Eloignement object to your data structure
    // Adjust this based on your actual data structure for Eloignement
    listElo[i]=eloignement;
  }
}
