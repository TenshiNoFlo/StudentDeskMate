void drawListeEtudiants2() {
  if (afficheTab) {
    if (afficherSal) {
      String filePath = "data/saved/impression_" + day() + "-" + month() + "-" + year() + "_" + hour() + "" + minute() + "" + second() + ".pdf";
      pdf = (PGraphicsPDF) beginRecord(PDF, filePath);
      println("Tableau");
      background(255);

      int startX = 100;
      int startY = 50;
      int x = startX;
      int y = startY;
      int lineHeight = 25;
      int lineSpacing = 5;
      int columnWidth = 350;
      int tableNumberWidth = 50;
      int maxY = height - 50;
      int tableNumber = 1;

      textSize(lineHeight);

      for (Etudiant etudiant : listeEtu.getEtudiants()) {
        stroke(0);
        line(x + tableNumberWidth - 5, y - lineHeight, x + tableNumberWidth - 5, y + 5);
        line(x - 5, y - lineHeight, x - 5, y + 5);
        line(x + tableNumberWidth + columnWidth, y - lineHeight, x + tableNumberWidth + columnWidth, y + 5);
        line(x - 5, y + 5, x + columnWidth + tableNumberWidth, y + 5);
        line(x - 5, startY - lineHeight, x + columnWidth + tableNumberWidth, startY - lineHeight);

        fill(0);
        tableNumber = etudiant.getTableEtu();
        text(tableNumber, x, y);

        text(etudiant.getNom() + " " + etudiant.getPrenom(), x + tableNumberWidth, y);
        y += lineHeight + lineSpacing;

        if (y > maxY) {
          y = startY;
          x += columnWidth + tableNumberWidth + 40;
          tableNumber++;
        }
      }
    }

    pdf.nextPage();
    float minX = 0;
    float maxX = width * 0.75;
    float minY = height / 20;
    float mmaxY = height - height * 0.2;

    background(255);

    masalle.dessinerPlan2();

    PImage screenshot = get(int(minX), int(minY), int(maxX), int(mmaxY));

    screenshot.resize(width, height);

    image(screenshot, 0, 0);

    endRecord();
  }
}
