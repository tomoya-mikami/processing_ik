Node[] n;
Node[] n1;
Node[] n2;
Node[] n3;
Node[] n4;
MyPoint m;
JoinCal j;

int loop_count;
float distance;

void setup () {
  size(1280, 720);
  distance = 30;
  loop_count = 15;
  
  m = new MyPoint(0, 0);
  n = new Node[10];
  n1 = new Node[7];
  n2 = new Node[7];
  n3 = new Node[7];
  n4 = new Node[7];
  for (int i = 0; i<n.length; i++) {
    n[i] = new Node(distance*i, 0, 0);
  }
  for (int i=0; i<n1.length; i++) {
    n1[i] = new Node(distance*i - width/2, -1*height/2, 0);
  }
  for (int i=0; i<n2.length; i++) {
    n2[i] = new Node(distance*i + width/2, -1*height/2, 0);
  }
  for (int i=0; i<n3.length; i++) {
    n3[i] = new Node(distance*i - width/2, height/2, 0);
  }
  for (int i=0; i<n4.length; i++) {
    n4[i] = new Node(distance*i + width/2, height/2, 0);
  }
  j = new JoinCal();
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  m.x = mouseX-width/2;
  m.y = mouseY-height/2;
  //自分
  fill(0, 0, 255);
  ellipse(m.x, m.y, 20, 20);
  //動く関節
  fill(255, 0, 0);
  for (int i=0; i<n.length; i++) {
    ellipse(n[i].x, n[i].y, distance, distance);
  }
  for (int i=0; i<n1.length; i++) {
    ellipse(n1[i].x, n1[i].y, distance, distance);
  }
  for (int i=0; i<n2.length; i++) {
    ellipse(n2[i].x, n2[i].y, distance, distance);
  }
  for (int i=0; i<n3.length; i++) {
    ellipse(n3[i].x, n3[i].y, distance, distance);
  }
  for (int i=0; i<n4.length; i++) {
    ellipse(n4[i].x, n4[i].y, distance, distance);
  }
  popMatrix();
  for (int i =0; i<loop_count; i++){
    n = j.moveJoin(n, 1, distance, m.x, m.y);
    n1 = j.moveJoin(n1, 1, distance, m.x, m.y);
    n2 = j.moveJoin(n2, 1, distance, m.x, m.y);
    n3 = j.moveJoin(n3, 1, distance, m.x, m.y);
    n4 = j.moveJoin(n4, 1, distance, m.x, m.y);
  }
  //saveFrame("frames/######.tif");
}

//以下画像保存用
int count = 1;

void keyPressed() {

  // Pのキーが入力された時に保存
  if(key == 'p' || key == 'P') {

    // デスクトップのパスを取得
    String path  = System.getProperty("user.home") + "/Desktop/screenshot" + count + ".jpg";

    // 保存
    save(path);

    // 番号を加算
    count++;

    // ログ用途
    println("screen saved." + path); 
  }
}