 
/**
 * from Warren "Hackers delight" p 248
 */
PVector hilbert(int s, int n) {
    int state,x,y,row;
    state = row = x = y = 0;
    for(int i = 2 *n -2; i >= 0; i -=2) {
    row = 4 * state | (s >> i) & 3;
    x = (x << 1) | (0x936C >> row)&1;
    y = (y << 1) | (0x39C6 >> row)&1;
    state = (0x3E6B94C1 >> 2*row) & 3;
    }
    return new PVector(x,y);
}
