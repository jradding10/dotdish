void Move { 
    
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


void Direction_change { // if interrupt detected

    if BTNU_RD == 1{
        y_mv = 1; //so we know direction is up
        x_mv = 0;
    }
    else if BTND_RD == 1{
        y_mv = -1; // direction is down
        x_mv = 0;
    }
    else if BTNL_RD == 1{
        x_mv = -1; // direction is down
        y_mv = 0;
    }
    else if BTNR_RD == 1{
        x_mv = -1; // direction is down
        y_mv = 0;
    }
}

void Delay{ // 250 milisecond dekat
    for (int i = 0; i<)
    {
        i+=1
        
    }


}
