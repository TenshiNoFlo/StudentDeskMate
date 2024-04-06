class ContextMenu {
  private String[] options;
  private int width, heightPerOption;
  private boolean isVisible;
  private float x, y;

  ContextMenu(int width, int heightPerOption) {

    String[] menuOptions = {"Suprimer etudiant", "Supprimer", "Vérouillé", "Inexploitable"};
    this.options = menuOptions;
    this.width = width;
    this.heightPerOption = heightPerOption;
    this.isVisible = false;
  }

  boolean survoleContextMenu(float mouseX, float mouseY) {
    return isVisible &&
      mouseX >= x && mouseX <= x + width &&
      mouseY >= y && mouseY <= y + options.length * heightPerOption;
  }

  void show(float x, float y, Table selectedTable) {
    if (selectedTable.getEtu() != null) {
      this.options[0] = "Enlever " + selectedTable.getEtu().getPrenomAbrege();
    } else {
      this.options[0] = "Indisponible";
    }

    this.options[2] = selectedTable.isVerrouille() ? "Déverrouillé" : "Verrouillé";
    this.options[3] = selectedTable.isExploitable() ? "Rendre Inexploitable" : "Rendre Exploitable";

    this.x = x;
    this.y = y;
    this.isVisible = true;
  }

  void hide() {
    this.isVisible = false;
  }

  void draw() {
    if (isVisible) {
      textSize(15);
      stroke(0);
      for (int i = 0; i < options.length; i++) {
        float texteY = y + i * heightPerOption;
        if (options[i].equals("Indisponible")) {
          fill(255, 0, 0);
          rect(x, texteY, width, heightPerOption);
        } else if (mouseX >= x && mouseX <= x + width && mouseY >= texteY && mouseY < texteY + heightPerOption) {
          fill(200);
          rect(x, texteY, width, heightPerOption);
        } else {
          fill(255);
          rect(x, texteY, width, heightPerOption);
        }

        fill(0);
        textAlign(LEFT, CENTER);
        text(options[i], x + 10, texteY + heightPerOption / 2);
      }
    }
  }

  int getSelectedOption(float mouseX, float mouseY) {
    if (!isVisible) return -1;

    int selectedOption = (int) ((mouseY - y) / heightPerOption);

    if (selectedOption >= 0 && selectedOption < options.length) {
      if (mouseX >= x && mouseX <= x + width) {
        return selectedOption;
      }
    }
    return -1;
  }
}
