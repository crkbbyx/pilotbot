// ---------- DRIVE FXN ----------

void Drive(int driveDelay, int leftSpeed, boolean leftDirection, int rightSpeed, boolean rightDirection)
{
    digitalWrite(Stby, HIGH);                               // Turns on motor driver

    if(leftDirection == fwd && rightDirection == fwd)       // Forward
    {
        digitalWrite(Bin1, LOW);
        digitalWrite(Bin2, HIGH);
        analogWrite(PwmB, leftSpeed);
        digitalWrite(Ain2, LOW);
        digitalWrite(Ain1, HIGH);
        analogWrite(PwmA, rightSpeed);
    }

    else if(leftDirection == bwd && rightDirection == bwd)  // Backward
    {
        digitalWrite(Bin1, HIGH);
        digitalWrite(Bin2, LOW);
        analogWrite(PwmB, leftSpeed);
        digitalWrite(Ain2, HIGH);
        digitalWrite(Ain1, LOW);
        analogWrite(PwmA, rightSpeed);
    }

    else if(leftDirection == fwd && rightDirection == bwd)  // Right rotate
    {
        digitalWrite(Bin1, LOW);
        digitalWrite(Bin2, HIGH);
        analogWrite(PwmB, leftSpeed);
        digitalWrite(Ain2, HIGH);
        digitalWrite(Ain1, LOW);
        analogWrite(PwmA, rightSpeed);
    }

    else if(leftDirection == bwd && rightDirection == fwd)  // Left rotate
    {
        digitalWrite(Bin1, HIGH);
        digitalWrite(Bin2, LOW);
        analogWrite(PwmB, leftSpeed);
        digitalWrite(Ain2, LOW);
        digitalWrite(Ain1, HIGH);
        analogWrite(PwmA, rightSpeed);
    }

    delay(driveDelay);                                      // How long?
}

// ---------- STOP FXN ----------
void Stop()
{
    digitalWrite(Ain1, LOW);
    digitalWrite(Ain1, LOW);

    digitalWrite(Bin1, LOW);
    digitalWrite(Bin2, LOW);

    analogWrite(PwmA, 0);
    analogWrite(PwmB, 0);

    digitalWrite(Stby, LOW);                                // Turns off motor driver
}

// ---------- GETATTITUDE FXN ----------
void GetAttitude()
{
    Attitude[Pitch] = analogRead(PitchPin);
    Attitude[Roll] = analogRead(RollPin);
    Attitude[Zaxis] = analogRead(ZPin);
    
    if (Attitude[Pitch] >= CalibratePitch)
    {
        Attitude[Pitch] = Attitude[Pitch] - CalibratePitch;
        PitchDirection = bwd;
    }
    
    else
    {
        Attitude[Pitch] = CalibratePitch - Attitude[Pitch];
        PitchDirection = fwd;
    }
    
    if (Attitude[Roll] >= CalibrateRoll)
    {
        Attitude[Roll] = Attitude[Roll] - CalibrateRoll;
        RollDirection = Right;
    }
    
    else
    {
        Attitude[Roll] = CalibrateRoll - Attitude[Roll];
        RollDirection = Left;
    }
    
    if(Attitude[Zaxis] > 330)
    {
        Flipped = true;
    }
}










