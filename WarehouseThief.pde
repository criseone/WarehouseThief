// game objects  //<>//
Thief myThief;
ArrayList<Guard> GuardsHorizontal;
ArrayList<Guard> GuardsVertical;
ArrayList<Item> Items;
ArrayList<Rack> Racks;

// game variables  
boolean keyLeft = false;
boolean keyRight = false;
boolean keyUp = false;
boolean shootLimit; // used to limit Items to one per click
int gameStatus = 0;

// game constants
final int startScreen = 0;
final int playingGame = 1;
final int gameOver = 2;
final int gameWon = 3;

final color palette1 = color(69, 92, 123);
final color palette2 = color(218, 114, 126);
final color palette3 = color(255, 188, 103);
final color palette4 = color(104, 92, 121);


void setup()
{
  size(1000, 600); 
  //fullScreen(); 
  setupGame();
  noStroke();

}

void draw() {
  switch(gameStatus) {
  case startScreen:
    drawStartScreen();
    break;
  case playingGame:
    drawGame();
    break;
  case gameOver:
    drawGameOverScreen();
    break;
  case gameWon:
    drawGameWonScreen();
    break;
  }
}


void setupGame()

{
  //Creat instances of all the game objects 
  
  //myThief = new Thief(width/2, height/2, 20, .5, .9);
  myThief = new Thief(Boy, width/2, height/2, 30, 30);
  
    Racks = new ArrayList<Rack>();
  // Randomly position racks around the game 
  for (int m = 0; m < 6; m++) {
    PVector RacksPosition = new PVector(random(width), random(height));
    PVector RacksDirection = new PVector(0, 0);
    Racks.add(new Rack(RacksPosition, RacksDirection));
    }
  
  Items = new ArrayList<Item>();
  // Randomly position Items around the game 
  for (int i = 0; i < 6; i++) {
    PVector ItemsPosition = new PVector(random(width), random(height));
    float minimumDistance =  ItemsPosition.dist(myThief.position);
    // check that the game always starts with a minimum distance between player and items
    while (minimumDistance <= 200) {
      ItemsPosition.set(random(width), random(height));
      minimumDistance =  ItemsPosition.dist(myThief.position);
    }
    PVector ItemsDirection = new PVector(0, 0);
    Items.add(new Item(ItemsPosition, ItemsDirection));
    }
  
  GuardsHorizontal = new ArrayList<Guard>();
  // Randomly position Guards around the game 
  for (int i = 0; i < 1; i++) {
    PVector GuardsPosition = new PVector(0, 300);
    float minimumDistance =  GuardsPosition.dist(myThief.position);
    // check that the game always starts with a minimum distance between player and Guards
    while (minimumDistance <= 100) {
      GuardsPosition.set(random(width), random(height));
      minimumDistance =  GuardsPosition.dist(myThief.position);
    }
    PVector GuardsDirection = new PVector(random(1), 0);
    float diameter = random(30)+20;
    float speed = 2;
    float damper = 1;
    GuardsHorizontal.add(new Guard(GuardsPosition, GuardsDirection, diameter, speed, damper));
    }
    
      GuardsVertical = new ArrayList<Guard>();
  // Randomly position Guards around the game 
  for (int i = 0; i < 1; i++) {
    PVector GuardsPosition = new PVector(500, 0);
    float minimumDistance =  GuardsPosition.dist(myThief.position);
    // check that the game always starts with a minimum distance between player and Guards
    while (minimumDistance <= 100) {
      GuardsPosition.set(random(width), random(height));
      minimumDistance =  GuardsPosition.dist(myThief.position);
    }
    PVector GuardsDirection = new PVector(0, random(1));
    float diameter = random(30)+20;
    float speed = 2;
    float damper = 1;
    GuardsHorizontal.add(new Guard(GuardsPosition, GuardsDirection, diameter, speed, damper));
    }
    
}


//*************
// game screens
//*************

void drawStartScreen() {
  background(palette1);
  textAlign(CENTER);
  textSize(40);
  fill(palette2);
  text("PRESS ENTER TO START\nPRESS SPACE TO SHOOT", width/2, height/2);
}

void drawGameOverScreen() {
  background(palette1);
  textAlign(CENTER);
  textSize(40);
  fill(palette2);
  text("GAME OVER\nPRESS ENTER TO RESTART", width/2, height/2);
}

void drawGameWonScreen() {
  background(palette1);
  textAlign(CENTER);
  textSize(40);
  fill(palette2);
  text("YOU WON!\nPRESS ENTER TO RESTART", width/2, height/2);
}

void drawGame() {
  background(palette1);
  // call the display function on all objects 
  
  //rect(50, 50, 50, 50);
  
  myThief.display();
  for (Guard object : GuardsHorizontal) {
    object.display();
  }
    for (Guard object : GuardsVertical) {
    object.display();
  }
  for (Item object : Items) {
    object.display();
  }
    for (Rack object : Racks) {
    object.display();
  }
  // key control
  if (keyUp) {
    myThief.updateSpeed();
  }
  if (keyRight) {
    myThief.updateAngle(.05);
  }
  if (keyLeft) {
    myThief.updateAngle(-.05);
  }
   //if all the Items are gone, then game has been won  
  if (Items.size() == 0) {
    gameStatus = gameWon;
  }
  checkCollisions();
}

//*************
//Collision Detection
//*************

void checkCollisions() {
  
      //check Thief against Items
    for (int j = 0; j < Items.size(); j++) {
      Item object2  = Items.get(j);
      if (object2.checkCollision(myThief)) {
        Items.remove(object2);
      } 
      //else if (object1.checkCollision(object2)) {
      //  GuardsHorizontal.remove(object1);
      //  Items.remove(object2);
      //}
    }
  
  for (int i = 0; i < GuardsHorizontal.size(); i++) {
    Guard object1  = GuardsHorizontal.get(i);
    // check horizontal Guard against Thief
    if (object1.checkCollision(myThief)) {
      gameStatus = gameOver;
    }
      for (int k = 0; k < GuardsVertical.size(); k++) {
    Guard object3  = GuardsVertical.get(k);
    // check vertical Guard against Thief
    if (object3.checkCollision(myThief)) {
      gameStatus = gameOver;
    }
  }
  }
        //check Thief against racks
    //for (int l = 0; l < Racks.size(); l++) {
    //  Rack object4  = Racks.get(l);
    //  if (object4.checkCollision(myThief)) {
    //    myThief = 
    //  } 
    //}
}


//*************
// game events
//*************

void keyPressed() {

  if (keyCode == UP  ||key == 'W'||key == 'w') {
    keyUp = true;
  } 
  if (keyCode == LEFT || key == 'A'|| key == 'a') {
    keyLeft = true;
  } 
  if (keyCode == RIGHT || key == 'D'|| key== 'd') {
    keyRight = true;
  }
  //if (key == ' ' && gameStatus == playingGame && shootLimit == false) {
  //  myThief.shoot();
  //  shootLimit = true;
  //}
  if (key == ENTER) {
    if (gameStatus != playingGame) {
      setupGame();
      gameStatus = playingGame;
    }
  }
} 

void keyReleased() {
  if (keyCode == UP || key == 'W'|| key == 'w') {
    keyUp = false;
  } 
  if (keyCode == LEFT || key == 'A'|| key == 'a') {
    keyLeft = false;
  }
  if (keyCode == RIGHT || key == 'D'|| key == 'd') {
    keyRight = false;
  }
  //if (key == ' ' && gameStatus == playingGame) {
  //  shootLimit = false;
  //}
}
