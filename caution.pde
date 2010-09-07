void P1()
{
    boolean thresholdTriggered = false;

    if(Attitude[Pitch] > 315 && thresholdTriggered == false)
    {
        LeftDirection = bwd;
        RightDirection = bwd;
        DriveDelay = 500;
        thresholdTriggered = true;
    }

    else if(Attitude[Pitch] <= 315 && thresholdTriggered == false)
    {
        LeftDirection = fwd;
        RightDirection = fwd;
    }

    if(thresholdTriggered == true && Attitude[Pitch] < 302)
    {
        LeftDirection = fwd;
        RightDirection = bwd;
        DriveDelay = 2000;
        thresholdTriggered = false;
    }
}