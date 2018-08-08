
float angle1, angle2 = 0;
P4Vector[][][][] cube;

P4Vector[][][][] makeCube4(float r) {
  P4Vector[][][][] cube = new P4Vector[2][2][2][2];
  for (int x = 0; x < 2; x++) {
    for (int y = 0; y < 2; y++) {
      for (int z = 0; z < 2; z++) {
        for (int w = 0; w < 2; w++) {
          cube[x][y][z][w] = new P4Vector((x-0.5)*r, (y-0.5)*r, (z-0.5)*r, (w-0.5)*r);
        }
      }
    }
  }
  return cube;
}

void setup() {
  size(800, 800, P3D);
  cube = makeCube4(1);
}


void draw() {
  background(0);
  translate(width/2, height/2);
  rotateX(-PI/2);
  //rotateY(PI/2);
  //rotateZ(angle1);
  strokeWeight(9);
  stroke(255);

  PVector[][][][] projected3d = new PVector[2][2][2][2];
  for (int x = 0; x < 2; x++) {
    for (int y = 0; y < 2; y++) {
      for (int z = 0; z < 2; z++) {
        for (int w = 0; w < 2; w++) {
          projected3d[x][y][z][w] = project3d(cube[x][y][z][w]);
        }
      }
    }
  }

  for (int x = 0; x < 2; x++) {
    for (int y = 0; y < 2; y++) {
      for (int z = 0; z < 2; z++) {
        for (int w = 0; w < 2; w++) {
          if (w == 0) stroke(212, 175, 55);
          else stroke(75, 0, 130);
          point(projected3d[x][y][z][w].x, projected3d[x][y][z][w].y, projected3d[x][y][z][w].z);
        }
      }
    }
  }

  connections(projected3d);


  angle1 += 0.015;
  angle2 += 0.015;
}


PVector project3d(P4Vector v) {

  Matrix double_rot = new Matrix(new float[][] {
    {cos(angle2), -sin(angle2), 0, 0}, 
    {sin(angle2), cos(angle2), 0, 0}, 
    {0, 0, cos(angle2), -sin(angle2)}, 
    {0, 0, sin(angle2), cos(angle2)}
    });

  //Matrix rotationXW = new Matrix(new float[][] {
  //  { cos(angle2), 0, 0, -sin(angle2)}, 
  //  {0, 1, 0, 0}, 
  //  {0, 0, 1, 0}, 
  //  {sin(angle2), 0, 0, cos(angle2)}, 
  //  });


  //Matrix rotationZY = new Matrix(new float[][] {
  //  {1, 0, 0, 0}, 
  //  {0, cos(angle2), 0, -sin(angle2)}, 
  //  {0, 0, 1, 0}, 
  //  {0, sin(angle2), 0, cos(angle2)}, 
  //  });

  Matrix rotationZW = new Matrix(new float[][] {
    {1, 0, 0, 0}, 
    {0, 1, 0, 0}, 
    {0, 0, cos(angle2), -sin(angle2)}, 
    {0, 0, sin(angle2), cos(angle2)}
    });

  Matrix p1 = new Matrix(new float[][] {{v.x}, {v.y}, {v.z}, {v.w}});
  Matrix a1 = double_rot.mult(p1);
  float temp_w = 1.0 / (1-a1.data[3][0]);

  Matrix projection = new Matrix(new float[][] {
    {temp_w, 0, 0, 0}, 
    {0, temp_w, 0, 0}, 
    {0, 0, temp_w, 0}, 
    });


  //a1 = rotationZW.mult(a1);
  //a1 = rotationZX.mult(a1);
  Matrix p2 = projection.mult(a1);
  PVector result = new PVector(p2.data[0][0], p2.data[1][0], p2.data[2][0]);
  result.mult(150);
  return result;
}


void connect(PVector a, PVector b) {
  line(a.x, a.y, a.z, b.x, b.y, b.z);
}
void connections(PVector[][][][] projected3d) {
  strokeWeight(2);
  stroke(49, 137, 180);

  // CUBE 1
  connect(projected3d[0][0][0][0], projected3d[1][0][0][0]);
  connect(projected3d[0][0][0][0], projected3d[0][1][0][0]);
  connect(projected3d[0][0][0][0], projected3d[0][0][1][0]);
  connect(projected3d[0][0][0][0], projected3d[0][0][0][1]);

  connect(projected3d[1][0][0][0], projected3d[1][1][0][0]);
  connect(projected3d[1][0][0][0], projected3d[1][0][1][0]);
  connect(projected3d[1][0][0][0], projected3d[1][0][0][1]);

  connect(projected3d[0][1][0][0], projected3d[1][1][0][0]);
  connect(projected3d[0][1][0][0], projected3d[0][1][1][0]);
  connect(projected3d[0][1][0][0], projected3d[0][1][0][1]);

  connect(projected3d[0][0][1][0], projected3d[1][0][1][0]);
  connect(projected3d[0][0][1][0], projected3d[0][1][1][0]);
  connect(projected3d[0][0][1][0], projected3d[0][0][1][1]);

  connect(projected3d[0][0][0][1], projected3d[1][0][0][1]);
  connect(projected3d[0][0][0][1], projected3d[0][1][0][1]);
  connect(projected3d[0][0][0][1], projected3d[0][0][1][1]);

  connect(projected3d[1][1][0][0], projected3d[1][1][1][0]);
  connect(projected3d[1][1][0][0], projected3d[1][1][0][1]);

  connect(projected3d[1][0][1][0], projected3d[1][1][1][0]);
  connect(projected3d[1][0][1][0], projected3d[1][0][1][1]);

  connect(projected3d[1][0][0][1], projected3d[1][1][0][1]);
  connect(projected3d[1][0][0][1], projected3d[1][0][1][1]);

  connect(projected3d[0][1][1][0], projected3d[1][1][1][0]);
  connect(projected3d[0][1][1][0], projected3d[0][1][1][1]);

  connect(projected3d[0][0][1][1], projected3d[1][0][1][1]);
  connect(projected3d[0][0][1][1], projected3d[0][1][1][1]);

  connect(projected3d[0][1][0][1], projected3d[1][1][0][1]);
  connect(projected3d[0][1][0][1], projected3d[0][1][1][1]);

  connect(projected3d[0][1][1][1], projected3d[1][1][1][1]);
  connect(projected3d[1][0][1][1], projected3d[1][1][1][1]);
  connect(projected3d[1][1][0][1], projected3d[1][1][1][1]);
  connect(projected3d[1][1][1][0], projected3d[1][1][1][1]);
}
