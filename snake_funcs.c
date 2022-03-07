int snake[5][2] {{0,0}, {NULL, NULL}, {NULL, NULL}, {NULL, NULL}, {NULL, NULL}};

int len = 1;
int p = 0;
int hx = 0;
int hy = 0;

void snakeMove (x, y) {
    snake[p][0] = hx + x; //Replaces oldest value with new location
    snake[p][1] = hy + y;
    hx += x; //Moves the head pointer
    hy += y;
    if (p == len) //Rotates array pointer
        p = 0;
    else
        p += 1;
}

void eat (x,y) {
    int oldX = snake[p][0]; //Saves current location data
    int oldY = snake[p][1];
    snake[p][0] = hx+x; //Overwrites data
    snake[p][1] = hy+y;
    for (i=p;i<=len+1;i++) { //Iterates through all items in array after current location pushing back one location
        nextX = snake[i+1][0];
        nextY = snake[i+1][1];
        snake[i+1][0] = oldX;
        snake[i+1][1] = oldY;
        oldX = nextX;
        oldY = nextY;
    }
    hx += x; //Moves the head pointer
    hy += y;
    if (p == len) //Rotates array pointer 
        p = 0;
    else
        p += 1;
    len += 1; //Adds 1 to length
}

