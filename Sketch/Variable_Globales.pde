// - SONS - //
SoundFile sonAlerte;

// - IMAGES - //
int widthReloadFull;
int widthFiltreFull;
PImage logo, reload, filtre, quit, quit2, cadena, defaultProfil, ontoggle, offtoggle;
PImage berger;

String connect[] = {"Login", "false", "empty"};

// - COULEURS - //
color primaryColor = #5D6D7E;
color secondaryColor = #E74C3C;
color activeColor = #E70000;
color backgroundColor = #ECF0F1;
color menuColor = #34495E;
color fillColorLight = #BDC3C7;
color fillColorDark = #95A5A6;
color textColor = #FFFFFF;
color accentColor = #F39C12;
color warningColor = #C0392B;
color whiteColor = #FFFFFF;
color hoverColor = #85929E;
color selecColor = #F0F3F4;
color textColorField = color(0);

boolean couleurFondClaire = true;

color tableInutilise_C=primaryColor;
color tableSelected_C=color(189, 0, 65);
color couleurInexploitable=color(255, 20, 0);

// - PALETTES DE COULEURS - //
// Palette Défault
color[] paletteDefault = { #5D6D7E, #E74C3C, #E70000, #ECF0F1, #34495E, #BDC3C7, #95A5A6, #FFFFFF, #F39C12, #C0392B, #FFFFFF, #85929E, #F0F3F4};
// Palette Claire
color[] paletteClair = { #B0B0B0, #C0C0C0, #B4B4B4, #CCCCCC, #DDDDDD, #AAAAAA, #FFFFFF, #000000, #FFC0CB, #8B008B, #FFFFFF, #F0F3F4, #F0F3F4};
// Palette Sombre
color[] paletteSombre = { #000000, #333333, #666666, #999999, #4D4D4D, #808080, #666666, #FFFFFF, #BDC3C7, #979C9F, #FFFFFF, #ECF0F1, #F0F3F4};
// Palette Girly
color[] paletteGirly = { #FF007F, #FF69B4, #FF1493, #FFB6C1, #FF00FF, #FFC0CB, #FFA07A, #FFDAB9, #FFC0CB, #FF69B4, #FFB6C1, #FFA07A, #FFDAB9};


color[] listeCouleursGrpEloig = { #000000, #000000, #000000, #000000, #000000, #000000, #000000, #000000, #000000, #000000, #000000, #000000};

// - VARIABLES GLOBALES - //

// Paramètres d'affichage
int etat = 0;
int derniereActivite;

int rectY = 0;

boolean majAff = true;
boolean afficheTab = false;
boolean afficherSal = false;
boolean excelOpen = false;
boolean etuOpen = false;
boolean eloiOpen = false;

//boolean inPara = false;
boolean inGererEtu = false;

ControlP5 cp5EtuSelec;
ControlP5 cp5Elo;
ControlP5 cepe5;
ControlP5 cp5Para;
ControlP5 cipi5;
ControlP5 cp5Conn;

ControlP5 cp5;

PFont maPolice;


// - SPAWN DES TABLES - //
int spawnPointX = 20;
int spawnPointY = 150;
int longueurTable = 50; // 1px=1cm
int largeurTable = 100;
Table selectedTable;
ContextMenu contextMenu;

Graph tableGraph;

//- COMPTEUR DES TABLES - //
int compteurTables = 1;

// Salle courante dans le main//
String[] svgSalleToString;
Salle masalle;

// Pour Imprimer - TOUJOURS LAISSER A FALSE
PGraphicsPDF pdf;
PGraphics pdf2;
boolean record = false;

// - LEGENDE - //
Legende legende = new Legende();
boolean flag_json = false;

// - GESTION PARAMETRES - //
Parametre para = new Parametre();

ConnexionMode connexionMode = new ConnexionMode();

// - GESTION ETUDIANT - //
EtudiantSelection gereretu = new EtudiantSelection(this, 700, 350);

// - GESTION GROUPES - //
int nbGroupe = 0;
int scrollGestionGrp = 0;
GestionGroupe gestionGrp = new GestionGroupe(this, 1000, 500);
HashMap<String, Etudiant> mapEtudiant = new HashMap<String, Etudiant>();

// - GESTION ELOIGNEMENT - //
GestionEloignement gesteloi = new GestionEloignement();
int nombreGroupesEloignement = 3;
Eloignement[] listElo = new Eloignement[10];
boolean generateGrpEloig = false;
Button removeEtudiantButton;
ListBox etudiantsListBox;
Button createRectangleButton;
DropdownList ajoutEtudiantDeroulant;
Button leaveEloi;
Button removeButton;
Button addEtudiantButton;

// - GESTION IMPRIMER - //
boolean inImp = false;
boolean impOk = false;
PGraphicsPDF pdfListe;

boolean pPressed = false;
boolean oPressed = false;
boolean shiftPressed = false;

// - OUVRIR EXCEL -- //
OuvrirExcel ouvrirExcel = new OuvrirExcel();
PImage upload, upload_hover;
boolean uploadSurvol = false;

// - AJOUTER ÉTUDIANT -- //
AjouterEtudiant ajouterEtudiant = new AjouterEtudiant();
boolean ajoutEtudiant = false;

// - LISTE ETUDIANT - //
ListeEtu listeEtu;
int lastEtudiant = 0;

String selectedFilePath = "";
int etudiantSelectionne = -1;
Etudiant etuSelec;
boolean selecEtu = false;
int colonneSelectionnee = -1;
color colorSelectionnee = #555555;
float colonneWidth;
float xOffset = 50;
float yOffset = 15;
boolean dragDropEtu = false;
int scrollListEtu = 0;

// - IU - //
Textfield rechercheTF;
Textfield prenomTf;
Textfield nomTf;
Textfield numTf;
Textfield grpTf;
Textfield grpElTf;
Textfield idConnexion;
Textfield lgConnexion;
ListBox fichier;
ListBox ajouter;
ListBox tri;
ListBox salle;
ListBox themes;
Toggle statusLegend;

ListBox gestion;
Numberbox tableWidth;
Numberbox tableHeight;

Button tiersTemps;
Button FichierChoix;
Button parametre;
Button reloadBtn;
Button leavePara;
Button leaveAddEtu;
Button leaveOpenExcel;
Button connButton;
Button connectButton;
Button deconnButton;
Button leaveConnexion;

Slider largTable;
Slider longTable;

PImage imgBerger;
PImage imgBoutin;
PImage imgValette;
PImage imgTellez;
PImage imgFaru;
PImage imgKarim;
PImage imgEdiz;

int x = 50; // Position horizontale initiale
int y = 50; // Position verticale initiale
int diameter = 30; // Diamètre du cercle
int speedX = 5; // Vitesse horizontale
int speedY = 5; // Vitesse verticale
int x2 = 600; // Position horizontale initiale
int y2 = 600; // Position verticale initiale
int diameter2 = 30; // Diamètre du cercle
int speedX2 = -5; // Vitesse horizontale
int speedY2 = 5; // Vitesse verticale


String recherche;

String textConnect = "Login";

boolean tiertemps;
boolean hoverTt;
boolean stopGrpshow = false;
boolean ErrorNumModif = false;
boolean isHovering = false;
boolean firstin = true;
boolean excelIn = false;


String url = "jdbc:mysql://iutbg-lamp.univ-lyon1.fr:3306/p2202519";
String utilisateur = "p2202519";
String motDePasse = "12202519";

Connection connexion = null;
Statement statement = null;
ResultSet resultat = null;
