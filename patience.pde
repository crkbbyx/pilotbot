// Patience function

void P2()
{
    if(LeftDirection == bwd && RightDirection == fwd)
    {
        int patienceVal = map(Virtues[Virtue2], 0, 1024, 2000, 300);
        DriveDelay = patienceVal; 
    }
}