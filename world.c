bool world[80][60];

int apples[10][2] { {15, 11},
                    {60, 30},
                    {25, 42},
                    {45, 47},
                    {3,  20},
                    {74, 49},
                    {23, 78},
                    {28, 77},
                    {43, 27},
                    {69, 13}};

int a = 0;

int snake[5][2] {{0,0}, {NULL, NULL}, {NULL, NULL}, {NULL, NULL}, {NULL, NULL}};

int len = 1;
int p = 0;
int hx = 0;
int hy = 0;

world[snake[p][0]][snake[p][1]] = 1;
world[apples[a][0]][apples[a][1]] = 1;

void snakeMove (x, y) {
    world[snake[p][0]][snake[p][1]] = 0;
    snake[p][0] = hx + x; //Replaces oldest value with new location
    snake[p][1] = hy + y;
    world[snake[p][0]][snake[p][1]] = 1;
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
    world[snake[p][0]][snake[p][1]] = 1;
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
    world[apples[a][0]][apples[a][1]] = 0;
    a += 1;
    world[apples[a][0]][apples[a][1]] = 1;

}

int BTND_RD = 0;
int BTNU_RD = 0;
int BTNR_RD = 0;
int BTNL_RD = 0;


void main () {
    
    if BTND_RD == 1 or BTNU_RD == 1 or BTNL_RD == 1 or BTNR_RD == 1
    {
        Directionchange()
    }
    else{
    Delay()
    }
    s_xcor += x_mv; // move based on the set direction
    s_ycor += y_mv;// move y 
}

void Direction_change () { // if interrupt detected
    int y_mv = 0;
    int x_mv = 0;
    if BTNU_RD == 1{
        y_mv = 1; //so we know direction is up
        x_mv = 0;
    }
    else if BTND_RD == 1{
        y_mv = -1; // direction is down
        x_mv = 0;
    }
    else if BTNL_RD == 1{
        x_mv = -1; // direction is left
        y_mv = 0;
    }
    else if BTNR_RD == 1{
        x_mv = 1; // direction is right
        y_mv = 0;
    }
    snakeMove(x_mv, y_mv)
}

void delay () { // 250 milisecond dekat
    for (int i = 0; i<)
    {
        i+=1
        
    }
}