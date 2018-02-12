//与えられた座標からIKの計算を行う
//今回は腕の長さをそれぞれ固定するので内積を用いて計算していく
class JoinCal {
  Node[] moveJoin(Node[] node, float move_rad, float distance, float x, float y) {
    //node 関節集合
    //move_rad 一回の呼び出しで回転する角度
    //distance 腕の長さ
    //x 自分のx座標
    //y 自分のy座標
    
    //先端の座標の取得
    int num = node.length-1;
    Node nTip = node[num];
    
    float sin = sin(radians(move_rad));
    float cos = cos(radians(move_rad));
    float _sin = sin(radians(-1*move_rad));
    float _cos = cos(radians(-1*move_rad));
    
    //前半の処理
    //先端→根元の順に回転角度を求めていく
    
    for (int i = num-1; i>=0; i--) {
      /*
      Node n = node[i];
      */
      //関節から自分へのベクトルを計算する
      float vx = x - node[i].x;
      float vy = y - node[i].y;
      
      //回転しない場合のベクトル
      JoinVector nJoin = new JoinVector();
      nJoin.x = node[num].x - node[i].x;
      nJoin.y = node[num].y - node[i].y;
      nJoin.cal_dot(vx, vy);
      
      //右回りのベクトル
      JoinVector rJoin;
      rJoin = nJoin.cal_spin(_sin, _cos);
      rJoin.cal_dot(vx, vy);
      
      //左回りのベクトル
      JoinVector lJoin;
      lJoin = nJoin.cal_spin(sin, cos);
      lJoin.cal_dot(vx, vy);
      
      //println("n : "+nJoin.n+" r : "+rJoin.n+" l : "+lJoin.n);
      if (rJoin.n > nJoin.n && rJoin.n > lJoin.n){
        //右回り
        node[i].r -= radians(move_rad);
        node[num].x = node[i].x + rJoin.x;
        node[num].y = node[i].y + rJoin.y;
      }else if(lJoin.n > nJoin.n){
        //左周り
        node[i].r += radians(move_rad);
        node[num].x = node[i].x + lJoin.x;
        node[num].y = node[i].y + lJoin.y;    
      }
      
    }
    
    //後半処理
    //座標を決めていく
    //根本→先端
    //移動→回転の繰り返し
    
    //回転させるベクトル
    float px = distance;
    float py = 0;
    for (int i = 1; i<num; i++){
      /*
      Node n1 = node[i-1];
      Node n2 = node[i];
      */
      float c_cos = cos(node[i-1].r);
      float c_sin = sin(node[i-1].r);
      float dx = px*c_cos - py*c_sin;
      float dy = py*c_cos + px*c_sin;
      node[i].x = node[i-1].x + dx;
      node[i].y = node[i-1].y + dy;
      px = dx;
      py = dy;
      //println(i + ":" + node[i-1].r + ":" + node[i-1].r + " distance : " + distance);
    }
    
    return node;
  }
}