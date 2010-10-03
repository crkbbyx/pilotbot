//Courage function
void P3()
{
    int courageVal = map(Virtues[Virtue3], 0, 1024, 1, 10);

    if(LeftDirection == fwd && RightDirection == fwd && PitchDirection == bwd)
    {
        if (courageVal >= 5)
        {
            if(RollDirection == Left)
            {
                RightSpeed = RightSpeed - ((courageVal - 4) * Attitude[Roll]/2);
                LeftSpeed = LeftSpeed + ((courageVal - 4) * Attitude[Roll]/2);
            }

            if(RollDirection == Right)
            {
                LeftSpeed = LeftSpeed - ((courageVal - 4) * Attitude[Roll]/2);
                RightSpeed = RightSpeed + ((courageVal - 4) * Attitude[Roll]/2);
            }
        }

        else if(courageVal < 5)
        {
            if(RollDirection == Left)
            {
                LeftSpeed = LeftSpeed - (2 * (5 - courageVal) * Attitude[Roll]/2);
                RightSpeed = RightSpeed + (2 * (5 - courageVal) * Attitude[Roll]/2);
            }

            if(RollDirection == Right)
            {
                RightSpeed = RightSpeed - (2 * (5 - courageVal) * Attitude[Roll]/2);
                LeftSpeed = LeftSpeed + (2 * (5 - courageVal) * Attitude[Roll]/2);
            }
        }
    }

    else if(LeftDirection == fwd && RightDirection == fwd && PitchDirection == fwd)
    {
        if(RollDirection == Left)
        {
            //RightSpeed = RightSpeed + ((courageVal - 4) * Attitude[Roll]/2);
            LeftSpeed = LeftSpeed - (5 * Attitude[Roll]);
        }

        if(RollDirection == Right)
        {
            //LeftSpeed = LeftSpeed + ((courageVal - 4) * Attitude[Roll]/2);
            RightSpeed = RightSpeed - (5 * Attitude[Roll]);
        }
    }

}