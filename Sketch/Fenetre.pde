import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.*;

public class Fenetre extends PApplet {

  protected PApplet fen;
  protected int wid, hei;
  protected boolean exist = false;

  public Fenetre(PApplet parent, int w, int h) {
    this.fen = parent;
    this.wid = w;
    this.hei = h;
  }

  public boolean exist() {
    return exist;
  }

  public void show() {
    exist = true;
    surface.setVisible(true);
  }

  public void exit() {
    //inPara = false;
    inGererEtu = false;
    eloiOpen = false;
    etuOpen = false;
    excelOpen = false;
    surface.setVisible(false);
    this.exist = false;
  }

  public void settings() {
    size(wid, hei);
  }
}
