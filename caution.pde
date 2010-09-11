/*
Caution Fxn
Slows the truck down in response to topography.
Reference - Drive(DriveDelay, LeftSpeed, LeftDirection, RightSpeed, RightDirection);
*/
void P1()
{
    int cautionVal = map(Virtues[Virtue1], 0, 1024, 1, 10);
    LeftSpeed = 255 - cautionVal * (Attitude[Roll] + (Attitude[Pitch]/2));

    if(LeftSpeed < 30)
    {
        LeftSpeed = 0;
    }

    RightSpeed = LeftSpeed;
    
    if(LeftDirection == bwd && RightDirection == bwd)
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
        LeftDirection = fwd;
        RightDirection = fwd;
        DriveDelay = 10;
    }

    if(Attitude[Pitch] > 35 - (cautionVal * 3))
    {
        Stop();
        delay(100);
        GetAttitude();

        if(Attitude[Pitch] > 35 - (cautionVal * 3))
        {
            LeftDirection = bwd;
            RightDirection = bwd;
            DriveDelay = Attitude[Pitch] * 30;
        }
    }

}