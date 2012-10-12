void dline(float _x1, float _y1, float _x2, float _y2, float _res) {
  float res = _res;

  float d = dist(_x1, _y1, _x2, _y2);
  int cnt = 0;
  for (float l = (frameCount)%(res*2);l < d ; l += res) {

    if (cnt%2==0) {
      float pos1 = map(l, 0, d, 0, 1);
      float pos2 = map(l+res, 0, d, 0, 1);
      line(lerp(_x1, _x2, pos1), lerp(_y1, _y2, pos1), lerp(_x1, _x2, pos2), lerp(_y1, _y2, pos2));
    }
    cnt++;
  }
}
