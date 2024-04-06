class Table { //<>// //<>//
  private float x, y, orientation, lon, lar, offsetX, offsetY;
  private int numero;
  private boolean verrouille;
  private boolean exploitable;
  private Etudiant etuAssigne;

  private float txtSize;
  private color tableColor;

  Table(float scale) {
    exploitable = true;
    x = spawnPointX;
    y = spawnPointY;
    lon = longueurTable * scale;
    lar = largeurTable * scale;
    orientation = 0;
    numero = compteurTables;
    compteurTables++;
    verrouille = false;
    etuAssigne = null;
    txtSize = scale * 40;
    tableColor = listeCouleursGrpEloig[0];
  }

  Table(float x, float y, float orientation, float lon, float lar, float offsetX, float offsetY, int numero, boolean verrouille, boolean exploitable, Etudiant etuAssigne, float txtSize) {
    this.x = x;
    this.y = y;
    this.orientation = orientation;
    this.lon = lon;
    this.lar = lar;
    this.offsetX = offsetX;
    this.offsetY = offsetY;
    this.numero = numero;
    this.verrouille = verrouille;
    this.exploitable = exploitable;
    this.etuAssigne = etuAssigne;
    this.txtSize = txtSize;
    this.tableColor = listeCouleursGrpEloig[0];
  }

  void setOffset(float mouseX, float mouseY) {
    this.offsetX = mouseX - this.x;
    this.offsetY = mouseY - this.y;
  }

  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  float getLon() {
    return lon;
  }
  float getLar() {
    return lar;
  }
  float getOffsetX() {
    return offsetX;
  }
  float getOffsetY() {
    return offsetY;
  }
  int getNumero() {
    return numero;
  }
  boolean isVerrouille() {
    return verrouille;
  }
  boolean isExploitable() {
    return exploitable;
  }
  float getOrientation() {
    return orientation;
  }
  float getTxtSize() {
    return txtSize;
  }
  Etudiant getEtuAssigne() {
    return etuAssigne;
  }


  void dessiner() {
    pushMatrix();

    if(etuAssigne!=null){
      fill(etuAssigne.getColorGrpMin());
    }

    if (this==selectedTable) {
      fill(255, 0, 0);
    }

    if (exploitable == false) {
      fill(couleurInexploitable);
    }

    float centerX = x + lon / 2;
    float centerY = y + lar / 2;

    PVector[] corners = new PVector[4];
    corners[0] = new PVector(x, y);
    corners[1] = new PVector(x + lon, y);
    corners[2] = new PVector(x + lon, y + lar);
    corners[3] = new PVector(x, y + lar);

    for (int i = 0; i < corners.length; i++) {
      PVector corner = corners[i];
      float tempX = corner.x - centerX;
      float tempY = corner.y - centerY;
      float rotatedX = tempX * cos(radians(orientation)) - tempY * sin(radians(orientation));
      float rotatedY = tempX * sin(radians(orientation)) + tempY * cos(radians(orientation));
      corner.x = rotatedX + centerX;
      corner.y = rotatedY + centerY;
    }

    beginShape();
    for (PVector corner : corners) {
      vertex(corner.x, corner.y);
    }
    endShape(CLOSE);

    textSize(txtSize);
    fill(0);
    textAlign(CENTER, CENTER);

    fill(tableColor);
    text(numero, centerX, centerY);
    fill(0);
    

    if (this.verrouille) {
      float tailleCadenas = min(lon, lar) * 0.5;
      float marge = tailleCadenas * 0.1;
      float cadenasX = corners[1].x - tailleCadenas - marge;
      float cadenasY = corners[1].y + marge;

      pushMatrix();
      translate(centerX, centerY);
      rotate(radians(orientation));
      image(cadena, cadenasX - centerX, cadenasY - centerY, tailleCadenas, tailleCadenas);
      popMatrix();
    }

    popMatrix();
  }

  void setVerrouille(boolean verrouille) {
    this.verrouille = verrouille;
  }

  void setExploit(boolean e) {
    this.exploitable = e;
  }

  void setCoord(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void setOrientation(float i) {
    orientation = i % 360;
  }

  boolean survoleContextMenulappingWithAny(ArrayList<Table> allTables) {
    for (Table otherTable : allTables) {
      if (this != otherTable && rectanglesOverlap(this.x, this.y, this.lon, this.lar,
        otherTable.x, otherTable.y, otherTable.lon, otherTable.lar)) {
        return true;
      }
    }
    return false;
  }

  boolean rectanglesOverlap(float x1, float y1, float w1, float h1,
    float x2, float y2, float w2, float h2) {
    if (x1 + w1 <= x2 || x2 + w2 <= x1) return false;
    if (y1 + h1 <= y2 || y2 + h2 <= y1) return false;
    return true;
  }

  void setTableNumber(int number) {
    this.numero = number;
  }



  void setColorEloignement(int groupeEloignement) {
    this.tableColor = listeCouleursGrpEloig[groupeEloignement];
  }


  int getNumber() {
    return numero;
  }

  boolean estDisponible() {
    if (!exploitable || etuAssigne != null ) {
      return false;
    }
    return true;
  }


  boolean isAdjacentTo(Table other) {
    if (this.distTable(other)<300) {
      return true;
    }
    return false;
  }

  void addEtu(Etudiant e) {
    etuAssigne=e;
  }

  Etudiant getEtu() {
    return etuAssigne;
  }

  float distTable(Table autre) {
    float centerX1 = this.x + this.lon / 2;
    float centerY1 = this.y + this.lar / 2;

    float centerX2 = autre.getX() + autre.getLon() / 2;
    float centerY2 = autre.getY() + autre.getLar() / 2;

    float distance = dist(centerX1, centerY1, centerX2, centerY2);
    return distance;
  }

  boolean survoleContextMenu(float mouseX, float mouseY) {
    float centerX = x + lon / 2;
    float centerY = y + lar / 2;

    float tempX = mouseX - centerX;
    float tempY = mouseY - centerY;

    float rotatedX = tempX * cos(-radians(orientation)) - tempY * sin(-radians(orientation));
    float rotatedY = tempX * sin(-radians(orientation)) + tempY * cos(-radians(orientation));

    float translatedX = rotatedX + centerX;
    float translatedY = rotatedY + centerY;

    return translatedX >= x && translatedX <= x + lon && translatedY >= y && translatedY <= y + lar;
  }

  boolean isOccupied() {
    return etuAssigne != null;
  }

  boolean hasStudentWithSameEloignement(Etudiant student) {
    return etuAssigne != null && etuAssigne.getGroupeEloignement() == student.getGroupeEloignement();
  }


  boolean hasAdjacentStudentsWithSameEloignement(Etudiant student) {
    boolean noMatchingAdjacentTable = true;

    for (Table adjacentTable : tableGraph.getAdjacentTables(this)) {
      Etudiant assignedStudent = adjacentTable.getEtu();
      if (assignedStudent == null) {
        println("Table non attribuée");
      } else {
        if (assignedStudent.getGroupeEloignement() == student.getGroupeEloignement()) {
          println("Same grp éloi");
          noMatchingAdjacentTable = false;
          break;
        }
      }
    }

    return noMatchingAdjacentTable;
  }

  void dessiner2() {

    pushMatrix();

    fill(255);

    float centerX = x + lon / 2;
    float centerY = y + lar / 2;

    PVector[] corners = new PVector[4];
    corners[0] = new PVector(x, y);
    corners[1] = new PVector(x + lon, y);
    corners[2] = new PVector(x + lon, y + lar);
    corners[3] = new PVector(x, y + lar);

    for (int i = 0; i < corners.length; i++) {
      PVector corner = corners[i];
      float tempX = corner.x - centerX;
      float tempY = corner.y - centerY;
      float rotatedX = tempX * cos(radians(orientation)) - tempY * sin(radians(orientation));
      float rotatedY = tempX * sin(radians(orientation)) + tempY * cos(radians(orientation));
      corner.x = rotatedX + centerX;
      corner.y = rotatedY + centerY;
    }

    beginShape();
    for (PVector corner : corners) {
      vertex(corner.x, corner.y);
    }
    endShape(CLOSE);

    textSize(txtSize);
    fill(0);
    textAlign(CENTER, CENTER);

    fill(tableColor);
    text(numero, centerX, centerY);
    fill(0);

    popMatrix();
  }
}
