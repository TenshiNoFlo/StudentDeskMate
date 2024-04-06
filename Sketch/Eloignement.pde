class Eloignement {

  private String nomEloignement;
  private color couleurEloignement;
  private ArrayList<Etudiant> lstEtuEloignement;
  private int nbEtu;

  public Eloignement(String nom, color couleur) {
    this.nomEloignement = nom;
    this.couleurEloignement = couleur;
    this.lstEtuEloignement = new ArrayList<Etudiant>();
    this.nbEtu = 0;
  }

  public Eloignement() {
    this.nomEloignement = "";
    this.couleurEloignement = color(255);
    this.lstEtuEloignement = new ArrayList<Etudiant>();
    this.nbEtu = 0;
  }

  public ArrayList<Etudiant> getEtudiantsEloignement() {
    return lstEtuEloignement;
  }

  public void addEtuEloignement(Etudiant etu) {
    this.lstEtuEloignement.add(etu);
    this.nbEtu++;
  }

  public void removeEtuEloignement(Etudiant etu) {
    this.lstEtuEloignement.remove(etu);
    this.nbEtu--;
  }

  public void removeEtuEloignement(int num) {
    for (Etudiant etu : this.lstEtuEloignement) {
      if (etu.getNum() == num) {
        this.lstEtuEloignement.remove(etu);
        this.nbEtu--;
      }
    }
  }

  public boolean estDansEloignement(Etudiant etu) {
    for (Etudiant e : lstEtuEloignement) {
      if (e == etu) {
        return true;
      }
    }
    return false;
  }

  public boolean estDansEloignement(int num) {
    for (Etudiant e : lstEtuEloignement) {
      if (e.getNum() == num) {
        return true;
      }
    }
    return false;
  }

  public String toStringEloignement() {
    return this.nomEloignement + " (#" + hex(this.couleurEloignement) + ")";
  }

  public String getNomEloignement() {
    return this.nomEloignement;
  }

  public color getCouleurEloignement() {
    return this.couleurEloignement;
  }

  public int getNombreEtudiants() {
    return lstEtuEloignement.size();
  }

  public ArrayList<Etudiant> getLstEtuEloignement() {
    return lstEtuEloignement;
  }

  public Etudiant getEtudiant(int index) {
    if (index >= 0 && index < lstEtuEloignement.size()) {
      return lstEtuEloignement.get(index);
    } else {
      return null;
    }
  }

  public int getNbEtu() {
    return this.nbEtu;
  }

  public color getColor() {
    return couleurEloignement;
  }

  public void setNomEloignement(String nom) {
    this.nomEloignement = nom;
  }

  public void setCouleurEloignement(color couleur) {
    this.couleurEloignement = couleur;
  }

  public void setNbEtu(int nb) {
    this.nbEtu = nb;
  }
}
