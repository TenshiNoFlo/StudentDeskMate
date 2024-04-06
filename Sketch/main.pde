import processing.pdf.*; //<>//
 //<>//
import controlP5.*;

import java.awt.Frame;
import java.awt.FileDialog;
import javax.swing.JOptionPane;

import java.util.Collections;
import processing.sound.*;

import java.util.Comparator;
import java.util.Iterator;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import javax.imageio.ImageIO;

void setup() {
  fullScreen();

  cp5 = new ControlP5(this);
  cp5Para = new ControlP5(this);
  cp5Conn = new ControlP5(this);
  cipi5 = new ControlP5(this);
  cepe5 = new ControlP5(this);
  cp5Elo = new ControlP5(this);
  
  para.createUIParametre();
  gesteloi.createUIEloignement();
  connexionMode.createUIConnexionMode();
  
  
  ajouterEtudiant.createUIAjouterEtudiant();
  ajouterEtudiant.hideAll();  
  
  ouvrirExcel.createUIOuvrirExcel();
  ouvrirExcel.hideAll();
  
  themes.hide();
  statusLegend.hide();
  leavePara.hide();
  idConnexion.hide();
  lgConnexion.hide();
  connButton.hide();
  deconnButton.hide();
  leaveConnexion.hide();
  createRectangleButton.hide();
  removeEtudiantButton.hide();
  removeButton.hide();
  addEtudiantButton.hide();
  ajoutEtudiantDeroulant.hide();
  leaveEloi.hide();
  createUI();


  colonneWidth = (width * 0.25) / 4;

  maPolice = createFont("data/Montserrat-Regular.ttf", 32);
  textFont(maPolice);

  contextMenu = new ContextMenu(200, 30);
  sonAlerte = new SoundFile(this, "sons/sonAlerte.mp3");
  sonAlerte.amp(0.3);
  derniereActivite = millis();
  imgBerger = loadImage("PROFIL/berger.png");
  imgBerger.resize(150, 150);
  // Charger et redimensionner l'image pour Tellez
  imgTellez = loadImage("PROFIL/tellez.png");
  imgTellez.resize(150, 150);

  // Charger et redimensionner l'image pour Faru
  imgFaru = loadImage("PROFIL/faru.png");
  imgFaru.resize(150, 150);

  // Charger et redimensionner l'image pour Karim
  imgKarim = loadImage("PROFIL/karim.png");
  imgKarim.resize(150, 150);

  // Charger et redimensionner l'image pour Valette
  imgValette = loadImage("PROFIL/valette.png");
  imgValette.resize(150, 150);

  // Charger et redimensionner l'image pour Boutin
  imgBoutin = loadImage("PROFIL/boutin.png");
  imgBoutin.resize(150, 150);
}

void detecterInactivite() {
  if (millis() - derniereActivite > 5000) { 
    etat = 1;
  } else {
    etat = 0; // Sinon, garder l'état à 0
  }
}

void mouseMoved() {
  derniereActivite = millis();
  ouvrirExcel.mouseMovedUpload();
}

void drawFilterWindow() {
  fill(200);
  rect(50, 50, 200, 300);
}


void draw() {


  switch(etat) {

  case 0:
    detecterInactivite();
    noTint();

    showAllCP5Elements();
    quitHovering();
    // affichage principale
    affichage();

    contextMenu.draw();
    if (!generateGrpEloig) {
      genererCouleur();
      generateGrpEloig=true;
    }
    break;

  case 1:
    detecterInactivite();
    modeVeille();
    moveAndBounceImages();
    break;


  case 2:
    //fenetre ajouter etu
    ajouterEtudiant.drawAjouterEtudiant();
    ajouterEtudiant.updateEtuSelection();
    break;

  case 3:
    //println("3");
    para.drawParametre();
    break;

  case 4:
    //fenetre csv
    ouvrirExcel.drawOuvrirExcel();
    ouvrirExcel.drawExcel();
    break;

  case 5:
    //fenetre modif etu
    break;

  case 6:
    //fenetre grp
    break;

  case 7:
    gesteloi.drawEloignement();
    gesteloi.drawGEloignement();
    break;

    //fenetre connexion
  case 8:
    connexionMode.drawConnexionMode();
    break;
  }
}

void mouseWheel(MouseEvent event) {
  if (afficheTab) {

    if (mouseX > width * 0.75 && mouseX < width && mouseY > height / 20 + widthFiltreFull + 20 + yOffset * 2 &&
      mouseY < height) {
      float e = event.getCount();
      if (e==1) {

        if (scrollListEtu < listeEtu.getEtudiants().size()) {
          scrollListEtu++;
        }
      } else {
        if (scrollListEtu-1 >= 0) {
          scrollListEtu--;
        }
      }
      afficherTableauEtudiant(listeEtu);
    }
  }
}
