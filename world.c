#include <stdio.h>

void snakeMove (x, y, int snake[]) {
    world[snake[0]][snake[1]] = 0;
    snake[0] = hx + x; //Replaces oldest value with new location
    snake[1] = hy + y;
    world[snake[0]][snake[1]] = 1;
    hx += x; //Moves the head pointer
    hy += y;
}

void eat (x,y) {
    world[snake[0]][snake[1]] = 0;
    snake[0] = hx+x; //Overwrites data
    snake[1] = hy+y;
    world[snake[0]][snake[1]] = 1;
    hx += x; //Moves the head pointer
    hy += y;
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

    int world[80][60];

    int apples[10][2] = { {15, 11},
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

    int snake[2] = {0,0};

    int len = 1;
    int hx = 0;
    int hy = 0;

    world[snake[0]][snake[1]] = 1;
    world[apples[a][0]][apples[a][1]] = 1;

    int done = 0;
    
    while (done == 0) {
        if (BTND_RD == 1 | BTNU_RD == 1 | BTNL_RD == 1 | BTNR_RD == 1)
        {
            int y_mv = 0;
            int x_mv = 0;
            if (BTNU_RD == 1){
                y_mv = 1; //so we know direction is up
                x_mv = 0;
            }
            else if (BTND_RD == 1){
                y_mv = -1; // direction is down
                x_mv = 0;
            }
            else if (BTNL_RD == 1){
                x_mv = -1; // direction is left
                y_mv = 0;
            }
            else if (BTNR_RD == 1){
                x_mv = 1; // direction is right
                y_mv = 0;
    }
    snakeMove(x_mv, y_mv, snake)
        }
        else{
            Delay()
        }
    }

}

void Direction_change () { // if interrupt detected
    
}

void delay () { // 250 milisecond dekat
    for (int i = 0; i<)
    {
        i+=1
        
    }
}