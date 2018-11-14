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
boolean keyDown = false;
boolean shootLimit; // used to limit Items to one per click
int gameStatus = 0;

// game constants
final int startScreen = 0;
final int playingGame = 1;
final int gameOver = 2;
final int gameWon = 3;

final color palette1 = color(48, 63, 66 );
final color palette2 = color(85, 103, 106 );
final color palette3 = color(108, 122, 125 );
final color palette4 = color(0, 0, 0 );

//Grid
int GuardArrayH[] = {200, 400, 600, 800, 1000};
int GuardArrayV[] = {200, 400, 600, 800, 1000};
int RackArrayH[] = {75, 275, 475, 675, 875};
int RackArrayV[] = {75, 275, 475, 675, 875};

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
  //Create instances of all the game objects 
  
      //position the thief in the game 
  myThief = new Thief(width/2, height/2, 20, .5, .9);
  
  
    //position racks around the game 
    Racks = new ArrayList<Rack>();
  for (int m = 0; m < 1000; m++) {
    int RackArrayHorizontal = RackArrayH[ (int) random(GuardArrayH.length)];
    int RackArrayVertical = RackArrayV[ (int) random(GuardArrayV.length)];
    PVector RacksPosition = new PVector(RackArrayVertical, RackArrayHorizontal);
    PVector RacksDirection = new PVector(0, 0);
    Racks.add(new Rack(RacksPosition, RacksDirection));
    }
  
    // Randomly position Items around the game 
  Items = new ArrayList<Item>();
  for (int i = 0; i < 6; i++) {
    PVector ItemsPosition = new PVector(random(width), random(height));
    float minimumDistance =  ItemsPosition.dist(myThief.position);
   
    // check that the game always starts with a minimum distance between player and items
    while (minimumDistance <= 200) {
      ItemsPosition.set(random(width), random(height));
      minimumDistance =  ItemsPosition.dist(myThief.position);
    }
    // check that the game always starts with a minimum distance between racks and items

    while (minimumDistance <= 5) {
      ItemsPosition.set(random(width), random(height));
      minimumDistance =  ItemsPosition.dist(myThief.position);
    }
    PVector ItemsDirection = new PVector(0, 0);
    Items.add(new Item(ItemsPosition, ItemsDirection));
    }

    //position horizontal moving guards around the game 
  GuardsHorizontal = new ArrayList<Guard>();
  for (int i = 0; i < 3; i++) {
    int GuardArrayHorizontal = GuardArrayH[ (int) random(GuardArrayH.length)];
    PVector GuardsPositionH = new PVector(GuardArrayHorizontal, GuardArrayHorizontal);
    //PVector GuardsPositionH = new PVector(random(200, 800), random(200, 400));
    //value = GuardArrayH[int(random(0, GuardArrayH.length))];
    float minimumDistanceH =  GuardsPositionH.dist(myThief.position);
    // check that the game always starts with a minimum distance between player and Guards
    while (minimumDistanceH <= 50) {
      GuardsPositionH.set(GuardArrayHorizontal, random(height));
      minimumDistanceH =  GuardsPositionH.dist(myThief.position);
    }
    PVector GuardsDirectionH = new PVector(20, 0);
    float diameterH = random(30)+20;
    float speedH = 2;
    float damperH = 1;
    GuardsHorizontal.add(new Guard(GuardsPositionH, GuardsDirectionH, diameterH, speedH, damperH));
    }
    
  // position vertical moving Guards around the game     
      GuardsVertical = new ArrayList<Guard>();
  for (int i = 0; i < 3; i++) {
        int GuardArrayVertical = GuardArrayV[ (int) random(GuardArrayV.length)];
    PVector GuardsPositionV = new PVector(GuardArrayVertical, GuardArrayVertical);
    //PVector GuardsPosition = new PVector(random(width), random(height));
    float minimumDistance =  GuardsPositionV.dist(myThief.position);
    // check that the game always starts with a minimum distance between player and Guards
    while (minimumDistance <= 50) {
      GuardsPositionV.set(random(width), random(height));
      minimumDistance =  GuardsPositionV.dist(myThief.position);
    }
    PVector GuardsDirection = new PVector(0, 20);
    float diameter = random(30)+20;
    float speed = 2;
    float damper = 1;
    GuardsVertical.add(new Guard(GuardsPositionV, GuardsDirection, diameter, speed, damper));
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
  text("PRESS ENTER TO START\nCOLLECT ALL ITEMS AND\nAVOID THE SECURITY GUARDS", width/2, height/2);
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
    if (keyDown) {
    myThief.updateSpeedInverse();
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
    }
      // check horizontal Guard against Thief
  for (int i = 0; i < GuardsHorizontal.size(); i++) {
    Guard object1  = GuardsHorizontal.get(i);
    if (object1.checkCollision(myThief)) {
      gameStatus = gameOver;
    }
        // check vertical Guard against Thief
      for (int k = 0; k < GuardsVertical.size(); k++) {
    Guard object3  = GuardsVertical.get(k);
    if (object3.checkCollision(myThief)) {
      gameStatus = gameOver;
    }
  }
  }
        //check Thief against racks
    for (int l = 0; l < Racks.size(); l++) {
    Rack object4  = Racks.get(l);
    if (object4.checkCollision(myThief)) {
    myThief.updateSpeedInverse();
    } 
    }
}


//*************
// game events
//*************

void keyPressed() {

  if (keyCode == UP  ||key == 'W'||key == 'w') {
    keyUp = true;
  }
   if (keyCode == DOWN  ||key == 'S'||key == 's') {
    keyDown = true;
  } 
  if (keyCode == LEFT || key == 'A'|| key == 'a') {
    keyLeft = true;
  } 
  if (keyCode == RIGHT || key == 'D'|| key== 'd') {
    keyRight = true;
  }
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
    if (keyCode == UP || key == 'W'|| key == 'w') {
    keyDown = false;
    }
  if (keyCode == LEFT || key == 'A'|| key == 'a') {
    keyLeft = false;
  }
  if (keyCode == RIGHT || key == 'D'|| key == 'd') {
    keyRight = false;
  }
}
