class Groupe {
  private String nom;
  private color couleur;
  private ArrayList<Etudiant> lstEtu;
  
  public Groupe(String nom, color couleur) {
    this.nom = nom;
    this.couleur = couleur;
    this.lstEtu = new ArrayList<Etudiant>();
    if (!legende.exist(this)) {
      gestionGrp.ajouterGroupe(this);
      if (flag_json) legende.ajouterGroupe(this);
    }
    nbGroupe++;
  }
  
  public Groupe() {
    this.nom = "";
    this.couleur = color(255);
    this.lstEtu = new ArrayList<Etudiant>();
  }
  
  public ArrayList<Etudiant> getEtudiants() {
    return lstEtu;
  }
  
  public void addEtu(Etudiant etu) {
    this.lstEtu.add(etu);
  }
  
  public void addEtu(int num, String nom, String prenom) {
    this.lstEtu.add(new Etudiant(num, nom, prenom, null));
  }
  
  public void removeEtu(Etudiant etu) {
    this.lstEtu.remove(etu);
  }
  
  public void removeEtu(int num) {
    Iterator<Etudiant> iterator = this.lstEtu.iterator();
    while (iterator.hasNext()) {
      Etudiant etu = iterator.next();
      if (etu.getNum() == num) {
        iterator.remove();
      }
    }
  }
  
  public boolean estDans(Etudiant etu) {
    for (Etudiant e : lstEtu) {
      if (e == etu) {
        return true;
      }
    }
    return false;
  }
  
  public boolean estDans(int num) {
    for (Etudiant e : lstEtu) {
      if (e.getNum() == num) {
        return true;
      }
    }
    return false;
  }
  
  public String toString() {
    return this.nom + " (#" + hex(this.couleur) + ")";
  }
  
  public String getNom() {
    return this.nom;
  }
  
  public color getColor() {
    return this.couleur;
  }
  
  public void setNom(String nom) {
    this.nom = nom;
  }
  
  public void setColor(color couleur) {
    this.couleur = couleur;
  }
  
  public int siz(){
    return lstEtu.size();
  }
  
}
