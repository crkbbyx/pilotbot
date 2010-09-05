// ---------- DRIVE FXN ----------

void Drive(int distance, boolean driveDirection, int leftSpeed, int rightSpeed)
{
	digitalWrite(4, HIGH);
	switch (driveDirection)
	{
		case Forward:
		digitalWrite(8, LOW);
		digitalWrite(7, HIGH);

		digitalWrite(13, LOW);
		digitalWrite(12, HIGH);

		analogWrite(9, rightSpeed);
		analogWrite(10, leftSpeed);
		delay(distance);
		break;

		case Backward:
		digitalWrite(8, HIGH);
		digitalWrite(7, LOW);

		digitalWrite(13, HIGH);
		digitalWrite(12, LOW);

		analogWrite(9, rightSpeed);
		analogWrite(10, leftSpeed);
		delay(distance);
		break;
	}
}


// ---------- ROTATE FXN ----------

void Rotate(int rotateAngle, boolean turnDirection, int turnSpeed)
{
	digitalWrite(4, HIGH);
	switch (turnDirection)
	{
		case Left:
		digitalWrite(8, LOW);
		digitalWrite(7, HIGH);

		digitalWrite(13, HIGH);
		digitalWrite(12, LOW);

		analogWrite(9, turnSpeed);
		analogWrite(10, turnSpeed);
		delay(rotateAngle);
		break;

		case Right:
		digitalWrite(8, HIGH);
		digitalWrite(7, LOW);

		digitalWrite(13, LOW);
		digitalWrite(12, HIGH);

		analogWrite(9, turnSpeed);
		analogWrite(10, turnSpeed);
		delay(rotateAngle);
		break;
	}
	Stop();
}

// ---------- STOP FXN ----------
void Stop()
{
	digitalWrite(8, LOW);
	digitalWrite(7, LOW);

	digitalWrite(13, LOW);
	digitalWrite(12, LOW);

	analogWrite(9, 0);
	analogWrite(10, 0);

	digitalWrite(4, LOW);
}

// ---------- GETATTITUDE FXN ----------
// 
int getAttitude()
{
	float val[90];
	float valSum=0;
	float valAvg=0;

	for (int i=0; i<=89; i++)             // Sample xPin
	{
		val[i] = analogRead(xPin);
		valSum = (val[i]+valSum);
	}

	Attitude[0] = (valSum / 90);          // Average samples

	if(Attitude[0] > xCal)                 // which direction tilted?
	{
		Pitch = Backward;
		Attitude[0] = (Attitude[0] - xCal);   // Variation from level (300)
	}
	else
	{
		Pitch = Forward;
		Attitude[0] = (xCal - Attitude[0]);   // Tilted other direction
	}

	valSum = 0;
	for (int i=0; i<=89; i++)              // Sample yPin
	{
		val[i] = analogRead(yPin);
		valSum = (val[i]+valSum);
	}
	Attitude[1] =(valSum / 90);            // Average samples

	if(Attitude[1] > yCal)                 // which direction tilted?
	{
		Roll = Left;
		Attitude[1] = (Attitude[1] - yCal);   // Variation from level (300)
	}
	else
	{
		Roll = Right;
		Attitude[1] = (yCal - Attitude[1]);   // Tilted other direction
	}


	Attitude[2] = analogRead(zPin);
	if(Attitude[2] > 330)
	{
		Flipped = true; 
	}
}

// ---------- GET VIRTUES ----------
int getVirtues()
{
	Virtues[Caution] = 500;//analogRead(virtue1Pin);
	Virtues[Patience] = 500; //analogRead(virtue2Pin);
	Virtues[Courage] = 500;// analogRead(virtue3Pin);
}