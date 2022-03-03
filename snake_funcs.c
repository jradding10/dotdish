int snake[5][2] {{0,0}, {NULL, NULL}, {NULL, NULL}, {NULL, NULL}, {NULL, NULL}};

int len = 1;
int p = 0;
int hx = 0;
int hy = 0;

void move (x, y) {
    snake[p][0] = hx + x;
    snake[p][1] = hy + y;
    hx += x;
    hy += y;
}