class Legende {

  private ArrayList<Groupe> lst;
  
  public Legende() { this.lst = new ArrayList<Groupe>(); }
  
  public void ajouterGroupe(Groupe g) { this.lst.add(g); }
  public void supprimerGroupe(Groupe g) { this.lst.remove(g); }
  
  public ArrayList<Groupe> getLst() { return this.lst; }
  public void setGroupe(ArrayList<Groupe> lst) { this.lst = lst; }
  
  public boolean exist(Groupe g) {
    for (Groupe grp : this.lst) {
      if (grp.getNom().equals(g.getNom()))
        return true;
    }
    return false;
  }
  
  public void clearGrp() { this.lst.clear(); }
  
  public String toString() {
    return "-- LEGENDE -----\n" +
           this.lst.toString();
  }
  
  public void show() {
    textAlign(LEFT, CENTER);
    toString();
    float y = height-height*0.2;
    fill(197);
    roundedRect(0, y, width, height*0.2, 0,primaryColor);
    fill(textColor);
    textSize(42);
    text("Légende", 100, y+30);
    textSize(24);
    textAlign(LEFT, CENTER);
    
    float posX = 200, posY = y+80;
    
    for (int i = 0; i < this.lst.size(); i++) {
      if (i != 0 && i % 3 == 0) {
        posX += 300;
        posY = y+80;
      }
      fill(this.lst.get(i).getColor());
      rect(posX - 50, posY-10, 30, 20);
      fill(textColor);
      text(this.lst.get(i).getNom(), posX, posY);

      posY += 50;
    }
    textAlign(LEFT, CENTER);
  }

}
