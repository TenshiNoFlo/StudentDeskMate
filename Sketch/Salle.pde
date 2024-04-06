import java.util.Random;

class Salle {

  private String nom;
  private PShape file;
  private ArrayList<Table> lstTable;


  public Salle( String file) {


    this.file = loadShape(file);

    this.lstTable = new ArrayList<Table>();
  }

  PShape getSvg() {
    return file;
  }

  ArrayList<Table> getList() {
    return lstTable;
  }

  void setSalle(PShape shape) {
    this.file = shape;
  }

  void addTable(Table newTable) {
    boolean overlaps;
    do {
      overlaps = false;
      for (Table existingTable : lstTable) {
        if (newTable.survoleContextMenulappingWithAny(lstTable)) {
          overlaps = true;


          newTable.setCoord(newTable.getX() + newTable.getLon(), newTable.getY() );
          if (newTable.getX()+newTable.getLon()>width/4*3) {
            newTable.setCoord(spawnPointX, newTable.getY()+newTable.getLar());
          }


          break;
        }
      }
    } while (overlaps);
    lstTable.add(newTable);
  }



  PShape resizeShape(PShape original, float scaleFactor) {
    PShape scaled = createShape();
    scaled.beginShape();
    for (int i = 0; i < original.getVertexCount(); i++) {
      PVector v = original.getVertex(i);
      if (v != null) {
        println("existe");
      }
      scaled.vertex(v.x * scaleFactor, v.y * scaleFactor);
    }
    scaled.endShape();
    return scaled;
  }

  void dessinerPlan() {
    pushMatrix();
    scale(getMinScale());
    shape(file, 0, height/11.5);
    popMatrix();
    pushMatrix();
    float minScale = getMinScale();



    for (Table t : lstTable)
    {

      t.dessiner();
    }
    popMatrix();
  }

  void removeTable(Table table) {
    lstTable.remove(table);
    compteurTables--;
    for (int i = 0; i < lstTable.size(); i++) {
      lstTable.get(i).setTableNumber(i + 1);
    }
  }




  void clearTable() {
    lstTable.clear();
  }


  void viderTable() {
    if (afficheTab && masalle != null) {
      String stringDelTableEtu = "Voulez vous vraiment libérer toutes les tables ?";
      int confirmation = JOptionPane.showConfirmDialog(null, stringDelTableEtu, "Libérer toutes les tables", JOptionPane.YES_NO_OPTION);
      if (confirmation == JOptionPane.YES_OPTION) {
        for (int i = 0; i < lstTable.size(); i++) {
          lstTable.get(i).addEtu(null);
        }
        for(Etudiant student : listeEtu.getEtudiants()){
          student.setTableEtu(-1);
        }
      }
    }
  }

  void viderSalle() {
    if (afficheTab && masalle != null) {

      String stringDelTable = "Voulez vous vraiment supprimer toutes les tables ? Cette action est irreversible";
      int confirmation = JOptionPane.showConfirmDialog(null, stringDelTable, "Libérer toutes les tables", JOptionPane.YES_NO_OPTION);
      if (confirmation == JOptionPane.YES_OPTION) {
        for (int i=lstTable.size()-1; i>=0; i--) {
          this.removeTable(lstTable.get(i));
          
        }
        
        for(Etudiant student : listeEtu.getEtudiants()){
          student.setTableEtu(-1);
        }
      }
    }
  }


  void placementAleaAvecGroupes() {
    if (afficheTab && masalle != null) {


      if (listeEtu.getEtudiants().size() > lstTable.size()) {

        int tableManq = listeEtu.getEtudiants().size() - lstTable.size();
        String stringAddTable = "Il manque " + tableManq + " tables pour votre liste d'étudiants, voulez-vous les ajouter automatiquement ?";
        int confirmation = JOptionPane.showConfirmDialog(null, stringAddTable, "Tables manquantes", JOptionPane.YES_NO_OPTION);

        if (confirmation == JOptionPane.YES_OPTION) {
          for (int i = 0; i < tableManq; i++) {
            println("Table ajoutée automatiquement");
            Table t = new Table(masalle.getMinScale());
            masalle.addTable(t);
            masalle.dessinerPlan();
          }
        }
      }
    }
  }





  class Binome {
    private Etudiant etudiant1;
    private Etudiant etudiant2;
    private int poids;

    public Binome(Etudiant etudiant1, Etudiant etudiant2, int poids) {
      this.etudiant1 = etudiant1;
      this.etudiant2 = etudiant2;
      this.poids = poids;
    }

    public int getPoids() {
      return poids;
    }

    public Etudiant getEtudiant1() {
      return etudiant1;
    }

    public Etudiant getEtudiant2() {
      return etudiant2;
    }
  }

  class BinomeTable {
    private Table table1;
    private Table table2;
    private float distance;

    public BinomeTable(Table table1, Table table2, float distance) {
      this.table1 = table1;
      this.table2 = table2;
      this.distance = distance;
    }

    public Table getTable1() {
      return table1;
    }

    public Table getTable2() {
      return table2;
    }

    public float getDistance() {
      return distance;
    }
  }


  ArrayList<Binome> calculBinomes() {
    ArrayList<Binome> BL = new ArrayList<>();

    for (Etudiant etu1 : listeEtu.getEtudiants() ) {
      int poids=0;
      for (Etudiant etu2 : listeEtu.getEtudiants() ) {
        if (etu1 != etu2) {
          if (etu1.getGroupeEloignement() == etu2.getGroupeEloignement() ) {
            poids=100;
          } else {
            poids=etu1.nombreGroupesCommuns(etu2);
          }
        }
        BL.add(new Binome(etu1, etu2, poids));
      }
    }

    return BL;
  }


  ArrayList<BinomeTable> calculBinomesTables(ArrayList<Table> tables) {
    ArrayList<BinomeTable> binomesTables = new ArrayList<>();

    for (Table table1 : tables) {
      for (Table table2 : tables) {
        if (table1 != table2) {
          float poids = table1.distTable(table2);
          binomesTables.add(new BinomeTable(table1, table2, poids));
        }
      }
    }

    return binomesTables;
  }

  void enleverEtu(Etudiant etu) {
    for (Table t : lstTable) {
      if (t.getEtu()== etu) {
        t.addEtu(null);
      }
    }
  }

  float getMinScale() {
    float maxWidth = width * 0.75;
    float maxHeight = height-height*0.2-height/20;
    float scaleX = maxWidth / file.width;
    float scaleY = maxHeight / file.height;
    return min(scaleX, scaleY);
  }

  float getMinScale2() {
    float maxWidth = width;
    float maxHeight = height;
    float scaleX = maxWidth / file.width;
    float scaleY = maxHeight / file.height;
    return min(scaleX, scaleY);
  }

  float getMinScale3() {
    float maxWidth = width;
    float maxHeight = height;
    float scaleX = maxWidth / file.width;
    float scaleY = maxHeight / file.height;
    return min(scaleX, scaleY);
  }

   void dessinerPlan2() {
    pushMatrix();
    scale(getMinScale());
    shape(file, 0, height/11.5);
    popMatrix();
    pushMatrix();
    float minScale = getMinScale();



    for (Table t : lstTable)
    {

      t.dessiner2();
    }
    popMatrix();
  }

  void placerEtudiantsAvecContraintes() {
    creerTablesSelonNombreEtudiants();

    ArrayList<Etudiant> shuffledStudents = new ArrayList<>();
    int cpt = 0;
    
    for(Etudiant student : listeEtu.getEtudiants()){
      println("Student");
      if(student.getTableEtu() == -1){
        shuffledStudents.add(student);
        cpt++;
      }else{
        println("Nope");
      }
    }

    sortByEloignementGroup(shuffledStudents);

    for (int i=0; i<shuffledStudents.size(); i++) {
      println(shuffledStudents.get(i).getNom());
    }

    createGraph();
    //tableGraph.printGraph();
    placerEtudiants(shuffledStudents);
  }

  void creerTablesSelonNombreEtudiants() {
    if (afficheTab && masalle != null) {

      if (listeEtu.getEtudiants().size() > lstTable.size()) {

        int tableManq = listeEtu.getEtudiants().size() - lstTable.size();
        String stringAddTable = "Il manque " + tableManq + " tables pour votre liste d'étudiants, voulez-vous les ajouter automatiquement ?";
        int confirmation = JOptionPane.showConfirmDialog(null, stringAddTable, "Tables manquantes", JOptionPane.YES_NO_OPTION);

        if (confirmation == JOptionPane.YES_OPTION) {
          for (int i = 0; i < tableManq; i++) {
            println("Table ajoutée automatiquement");
            Table t = new Table(masalle.getMinScale());
            masalle.addTable(t);
            masalle.dessinerPlan();
          }
        }
      }
    }
  }

  void placerEtudiants(ArrayList<Etudiant> shuffledStudents) {

    for (Etudiant student : shuffledStudents) {
      println(student.getPrenom());
      boolean tableValide = false;
      ;

      for (Table table : lstTable) {
        if (table.getEtu() != null) {
          continue;
        }

        if (student.getGroupeEloignement() != 0) {
          println(student.getNom());
          tableValide = table.hasAdjacentStudentsWithSameEloignement(student);

          if (tableValide) {
            println("table eloi find");
            table.addEtu(student);
            student.setTableEtu(table.getNumero());
            break;
          } else {
            println("Pas de place avec contrainte d'éloignement");
            continue;
          }
        } else {
          table.addEtu(student);
          student.setTableEtu(table.getNumero());
          break;
        }
      }
      if (!tableValide && student.getGroupeEloignement() != 0) {
        println("Last condition");
        for (Table table : lstTable) {

          if (table.getEtu() != null) {
            continue;
          }

          if (table.estDisponible()) {
            table.addEtu(student);
            student.setTableEtu(table.getNumero());
            break;
          } else {
            continue;
          }
        }
      }
    }
  }

  void sortByEloignementGroup(ArrayList<Etudiant> students) {
    Collections.sort(students, (e1, e2) -> Integer.compare(e2.getGroupeEloignement(), e1.getGroupeEloignement()));
  }
}
