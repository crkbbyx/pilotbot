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
    Attitude[Pitch] = analogRead(PitchPin);                     // Read the raw pitch value
    Attitude[Roll] = analogRead(RollPin);                       // Read the raw roll value
    Attitude[Zaxis] = analogRead(ZPin);                         // read the raw Z value

    if (Attitude[Pitch] >= CalibratePitch)                      // Is pitch greater than or equal to level value?
    {
        Attitude[Pitch] = Attitude[Pitch] - CalibratePitch;     // Calculate degree from level
        PitchDirection = bwd;                                   // Set backward flag
    }

    else                                                        // If pitch is less than level
    {
        Attitude[Pitch] = CalibratePitch - Attitude[Pitch];     // Calculate degree from level
        PitchDirection = fwd;                                   // Set forward flag
    }

    if (Attitude[Roll] >= CalibrateRoll)                        // Is roll greater than or equal to level value?
    {
        Attitude[Roll] = Attitude[Roll] - CalibrateRoll;        // Calculate degree from level
        RollDirection = Right;                                  // Set right flag
    }

    else                                                        // If roll is less than level
    {
        Attitude[Roll] = CalibrateRoll - Attitude[Roll];        // Calculate degree from level
        RollDirection = Left;                                   // Set left flag
    }

    if(Attitude[Zaxis] > 330)                                   // Has the truck been flipped?
    {
        Flipped = true;                                         // If so, set flipped to true
    }
}