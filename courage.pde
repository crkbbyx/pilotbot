//Courage function
void P3()
{
    int courageVal = map(Virtues[Virtue3], 0, 1024, 1, 10);

    if(LeftDirection == fwd && RightDirection == fwd)
    {
        if (courageVal >= 5)
        {
            if(RollDirection == Left)
            {
                RightSpeed = RightSpeed - ((courageVal - 4) * Attitude[Roll]);
            }

            if(RollDirection == Right)
            {
                LeftSpeed = RightSpeed - ((courageVal - 4) * Attitude[Roll]);
            }
        }

        else if(courageVal < 5)
        {
            if(RollDirection == Left)
            {
                LeftSpeed = RightSpeed - (2 * (5 - courageVal) * Attitude[Roll]);
            }

            if(RollDirection == Right)
            {
                RightSpeed = RightSpeed - (2 * (5 - courageVal) * Attitude[Roll]);
            }
        }
    }
}