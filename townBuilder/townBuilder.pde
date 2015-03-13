
int[][] array = new int[640/32][640/32];
PImage sprites;
int spriteColumn, spriteRow;
PrintWriter output;

int newValue;
void setup() {

  output = createWriter("array.txt");

  size(1024, 1024, P3D);
  sprites = loadImage("sprite1.png");
  for (int i = 0; i < array.length; i++) {
    for (int j = 0; j < array.length; j++) {
      array[i][j] = 999;
    }
  }
  // output.print("{");
}

void draw() {
  background(0);
  image(sprites, 0, 0, 1024, 96);


  for (int i = 0; i < array.length; i++) {
    for (int j = 0; j < array.length; j++) {
      doSpriteRow(array[i][j]);
      stroke(255);
      noFill();
      beginShape(QUADS);
      if(array[i][j] < 999)
      texture(sprites);

      vertex(0+32*i, 100+32*j, 0+32*spriteColumn, 0+32*spriteRow);
      vertex(0+32*i+32, 100+32*j, 32+32*spriteColumn, 0+32*spriteRow);
      vertex(0+32*i+32, 100+32*j+32, 32+32*spriteColumn, 32+32*spriteRow);
      vertex(0+32*i, 100+32*j+32, 0+32*spriteColumn, 32+32*spriteRow);

      endShape(CLOSE);
    }
  }
  println("PosX: "+mouseX+"PosY: "+(mouseY-100));
}

void mousePressed() {
  if (mouseY < 100) {
    // spriteColumn
    newValue = (mouseX/16) + ((mouseY/16)*64);
  }

  if (mouseY > 100 && mouseX < array.length*32)
    array[mouseX/32][(mouseY/32)-3] = newValue;
}

void keyPressed() {
  if(key == 'S' || key == 's'){
  output.print("{");
  for (int i = 0; i < array.length; i++) {
    for (int j = 0; j < array.length; j++) {

      if (j%20 == 0 && i > 0) {
        output.println("},");
        output.print("{");
      }
      else {
        output.print(",");
      }
      output.print(array[j][i]);
    }
  }
  output.print("}");
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
  }
  
}


void doSpriteRow(int value) {
  if(value < 999){
  spriteColumn = value-64*(value/64); //calculate which sprite to display based on tile's value
  spriteRow = floor(value/64); //calculae row of sprite sheet based pn tile's value
  }
}

