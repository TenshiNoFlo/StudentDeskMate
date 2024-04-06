class Etudiant {

  private int num;
  private String nom;
  private String prenom;
  private boolean tierTemps;
  private ArrayList<Groupe> lstGroupes;
  private PImage photo;
  private boolean visible = true;
  private int groupeEloignement;
  private int nbTableEtu;

  public Etudiant(int num, String nom, String prenom, PImage photo) {
    this.num = num;
    this.nom = nom;
    this.prenom = prenom;
    this.tierTemps = false;
    this.lstGroupes = new ArrayList<Groupe>();
    this.photo = photo;
    this.groupeEloignement = 0;
    this.nbTableEtu = -1;
  }

  public Etudiant(int num, String nom, String prenom, PImage photo, ArrayList<Groupe> groupes) {
    this.num = num;
    this.nom = nom;
    this.prenom = prenom;
    this.photo = photo;
    this.lstGroupes = groupes;
    this.nbTableEtu = -1;
  }

  public Etudiant(int num, String nom, String prenom, boolean tierTemps, ArrayList<Groupe> lstGroupes, PImage photo, boolean visible) {
    this.num = num;
    this.nom = nom;
    this.prenom = prenom;
    this.tierTemps = tierTemps;
    this.lstGroupes = lstGroupes;
    this.photo = photo;
    this.visible = visible;
    this.nbTableEtu = -1;
  }

  public Etudiant(int num, String nom, String prenom, boolean tierTemps, ArrayList<Groupe> lstGroupes, PImage photo, boolean visible, int nbTable, int eloignement) {
    this.num = num;
    this.nom = nom;
    this.prenom = prenom;
    this.tierTemps = tierTemps;
    this.lstGroupes = lstGroupes;
    this.photo = photo;
    this.visible = visible;
    this.nbTableEtu = nbTable;
    this.groupeEloignement = eloignement;
  }

  public void ajouterGroupe(Groupe g) {
    this.lstGroupes.add(g);
  }

  public void supprimerGroupe(Groupe g) {
    this.lstGroupes.remove(g);
  }

  public String toString() {
    return "##############################\n" +
      "NUMERO\t: " + this.num + "\n" +
      "NOM\t: " + this.nom + "\n" +
      "PRENOM\t: " + this.prenom + "\n" +
      "TIER-TEMPS\t: " + (this.tierTemps ? "OUI" : "NON") + "\n" +
      "GROUPE(S)\t: " + (this.lstGroupes.isEmpty() ? "AUCUN" : this.lstGroupes.toString()) + "\n" +
      "PHOTO\t: " + (this.photo != null ? "OUI" : "NON") + "\n" +
      "##############################\n";
  }

  public int getNum() {
    return this.num;
  }

  public String getNom() {
    return this.nom;
  }

  public String getPrenom() {
    return this.prenom;
  }

  public boolean getTierTemps() {
    return this.tierTemps;
  }

  public ArrayList<Groupe> getGroupe() {
    return this.lstGroupes;
  }

  public PImage getPhoto() {
    return this.photo;
  }

  public boolean isVisible() {
    return visible;
  }

  public String getNumString() {
    return String.valueOf(this.num);
  }

  public String getGroupeString() {
    if (lstGroupes.isEmpty()) {
      return "AUCUN";
    } else {
      StringBuilder groupeString = new StringBuilder();
      for (Groupe groupe : lstGroupes) {
        groupeString.append(groupe.getNom()).append(", ");
      }
      return groupeString.substring(0, groupeString.length() - 2);
    }
  }

  public String getInfo() {
    return num + "\t" + nom.toUpperCase() + "\t" + prenom + "\t";
  }

  public String getPrenomAbrege() {
    return prenom + " " + nom.charAt(0);
  }

  public int getGroupeEloignement() {
    return this.groupeEloignement;
  }

  public int nombreGroupesCommuns(Etudiant autreEtudiant) {
    ArrayList<Groupe> groupesAutreEtudiant = autreEtudiant.getGroupe();
    int nbGroupesCommuns = 0;

    for (Groupe groupeEtudiantActuel : this.lstGroupes) {
      if (groupesAutreEtudiant.contains(groupeEtudiantActuel)) {
        nbGroupesCommuns++;
      }
    }

    return nbGroupesCommuns;
  }

  public String getGroupeEloignementString() {
    if (groupeEloignement == 0) {
      return "Aucun";
    } else {
      return str(this.groupeEloignement);
    }
  }

  public int getTableEtu() {
    return this.nbTableEtu;
  }

  public void setNum(int num) {
    this.num = num;
  }

  public void setNom(String nom) {
    this.nom = nom;
  }

  public void setPrenom(String prenom) {
    this.prenom = prenom;
  }

  public void setTierTemps(boolean tierTemps) {
    this.tierTemps = tierTemps;
  }

  public void setPhoto(PImage photo) {
    this.photo = photo;
  }

  public void setVisible(boolean visible) {
    this.visible = visible;
  }

  public void setGroupeEloignement(int groupeEloignement) {
    this.groupeEloignement = groupeEloignement;
  }

  public void setTableEtu(int nbTable) {
    this.nbTableEtu = nbTable;
  }
  
  public color getColorGrpMin(){
    Groupe min = lstGroupes.get(0);
    for(Groupe g : lstGroupes){
      
      if(g.siz()<min.siz()){
        
        min=g; 
      }   
    }
    return min.getColor();
  }
}
