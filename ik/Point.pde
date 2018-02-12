//自記の位置
class MyPoint {
  public float x;
  public float y;
  
  MyPoint(float x, float y){
    this.x = x;
    this.y = y;
  }
}

//関節
class Node {
  
  //座標
  public float x;
  public float y;
  
  //回転角
  public float r;
  
  Node(float x, float y, float r){
    this.x = x;
    this.y = y;
    this.r = r;
  }
}

//関節間のベクトルの計算
class JoinVector {
  
  //ベクトルのx方向,y方向
  public float x;
  public float y;
  
  //内積を保存する
  float n;

  //内積の計算
  public void cal_dot(float dx, float dy){
    float v_length = sqrt(this.x*this.x + this.y*this.y);
    if (v_length == 0){
      this.n = 0;
      return;
    }
    float x = this.x/v_length;
    float y = this.y/v_length;
    this.n = dx*x + dy*y;
  }
  
  //回転行列
  public JoinVector cal_spin(float sin, float cos) {
    float x = this.x*cos - this.y*sin;
    float y = this.x*sin + this.y*cos;
    JoinVector v = new JoinVector();
    v.x = x;
    v.y = y;
    return v;
  }
}