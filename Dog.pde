class Player {
  int playerX = 500;
  int playerY = 500;

  int millis_Hurt;
  int millis_Switch;


  boolean hurt;


  void movePlayer() {
    int playerX_wasHere = playerX;
    if (theKeyboard.holdingLeft) {
      playerX -= 4;
    }
    if (theKeyboard.holdingRight) {
      playerX += 4;
    }    


    for (int i=0; i<speakers.size(); i++) {
      Speaker oneSpeaker = (Speaker)speakers.get(i);
      if (oneSpeaker.soundCheck(playerX, playerY)) {
      }
    }

    for (int i=0; i<cats.size(); i++) {
      Cat oneCat = (Cat)cats.get(i);
      if (oneCat.soundCheck(playerX, playerY)) {
      }
    }


    if (hurt) {  
      for (int i=0; i<cats.size(); i++) {
        Cat oneCat = (Cat)cats.get(i);
        if (oneCat.deathCheck(playerX, playerY)) {
          if (life >= 1) {
            if (life != 1) {
              dog_hurt.trigger();
            }
            life -= 1;
            millis_Hurt = millis() + 2000;
            millis_Switch = millis() + 100;
            hurt = false;
          }
          if (life < 1) {
            dog_dead.trigger();
            dead = true;
          }
        }
      }
    }

    if (millis_Hurt < millis()) {
      hurt = true;
    }

    if (playerX < 0) {
      playerX = playerX_wasHere;
    }
    if (playerX >= width) {
      playerX = playerX_wasHere-30;
    }

    playerX_wasHere = playerX; // remember to update saved X position in case x movement worked
    int playerY_wasHere = playerY;
    if (theKeyboard.holdingUp) {
      playerY -= 2;
    }
    if (theKeyboard.holdingDown) {
      playerY += 2;
    }

    if (playerY < 0) {
      playerY = playerY_wasHere;
    }
    if (playerY >= height) {
      playerY = playerY_wasHere-26;
    }
  }

  boolean hurtHurt;

  void drawPlayer() {

    if (hurt) {
      image(dog, playerX, playerY);
    } 
    else {

      if (hurtHurt) {
        image(dog, playerX, playerY);
      }
      if (millis_Switch < millis()) {
        hurtHurt = !hurtHurt;
        millis_Switch = millis() + 100;
      }
    }
  }

  void update() {
    movePlayer();
    drawPlayer();
  }
} // end of Player class

