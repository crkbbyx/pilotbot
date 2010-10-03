/*
Caution Fxn
Slows the truck down in response to topography.
Reference - Drive(DriveDelay, LeftSpeed, LeftDirection, RightSpeed, RightDirection);
*/
void P1()
{
    int cautionVal = map(Virtues[Virtue1], 0, 1024, 1, 10);
    if(PitchDirection == bwd)
    {
        LeftSpeed = 255 - cautionVal * (Attitude[Roll] + (Attitude[Pitch]/2));

        if(LeftSpeed < 30)
        {
            LeftSpeed = 0;
        }

        RightSpeed = LeftSpeed;
    }
    
    else if(PitchDirection == fwd)
    {
        RightSpeed = 255;
        LeftSpeed = 255;
    }

    if(LeftDirection == bwd && RightDirection == bwd)
    {
        if(RollDirection == Left)
        {
            Stop();
            LeftDirection = bwd;
            RightDirection = fwd;
            DriveDelay = 800;
            delay(100);
            GetAttitude();
        }
        else
        {
            Stop();
            LeftDirection = fwd;
            RightDirection = bwd;
            DriveDelay = 800;
            delay(100);
            GetAttitude();
        }
    }

    else
    {
        LeftDirection = fwd;
        RightDirection = fwd;
        DriveDelay = 10;
    }

    if((Attitude[Pitch] + Attitude[Roll])/2 > 35 - (cautionVal * 3))
    {
        Stop();
        delay(200);
        GetAttitude();

        if((Attitude[Pitch] + Attitude[Roll])/2 > 35 - (cautionVal * 3))
        {
            LeftDirection = bwd;
            RightDirection = bwd;
            DriveDelay = Attitude[Pitch] * 30;
        }
    }

}