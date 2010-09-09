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
    // Serial.print(Attitude[Roll]);
    // Serial.print("\t");
    // Serial.print(Attitude[Pitch]);
    // Serial.print("\t");
    // Serial.print(LeftSpeed);
    // Serial.print("\t");
    // Serial.println(cautionVal);
}