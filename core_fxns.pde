// // ---------- DRIVE FXN ----------
// 
// void Drive(int delay, boolean driveDirection, int leftSpeed, int rightSpeed)
// {
// 	digitalWrite(Stby, HIGH);
// 	switch (driveDirection)
// 	{
// 		case Forward:
// 		digitalWrite(Ain2, LOW);
// 		digitalWrite(Ain1, HIGH);
// 
// 		digitalWrite(Bin1, LOW);
// 		digitalWrite(Bin2, HIGH);
// 
// 		analogWrite(PwmA, rightSpeed);
// 		analogWrite(PwmB, leftSpeed);
// 		delay(distance);
// 		break;
// 
// 		case Backward:
// 		digitalWrite(Ain2, HIGH);
// 		digitalWrite(Ain1, LOW);
// 
// 		digitalWrite(Bin1, HIGH);
// 		digitalWrite(Bin2, LOW);
// 
// 		analogWrite(PwmA, rightSpeed);
// 		analogWrite(PwmB, leftSpeed);
// 		delay(distance);
// 		break;
// 	}
// }
// 
// 
// // ---------- ROTATE FXN ----------
// 
// void Rotate(int rotateAngle, boolean turnDirection, int turnSpeed)
// {
// 	digitalWrite(Stby, HIGH);
// 	switch (turnDirection)
// 	{
// 		case Left:
// 		digitalWrite(Ain1, LOW);
// 		digitalWrite(Ain1, HIGH);
// 
// 		digitalWrite(Bin1, HIGH);
// 		digitalWrite(Bin2, LOW);
// 
// 		analogWrite(PwmA, turnSpeed);
// 		analogWrite(PwmB, turnSpeed);
// 		delay(rotateAngle);
// 		break;
// 
// 		case Right:
// 		digitalWrite(Ain1, HIGH);
// 		digitalWrite(Ain1, LOW);
// 
// 		digitalWrite(Bin1, LOW);
// 		digitalWrite(Bin2, HIGH);
// 
// 		analogWrite(PwmA, turnSpeed);
// 		analogWrite(PwmB, turnSpeed);
// 		delay(rotateAngle);
// 		break;
// 	}
// 	Stop();
// }
// 
// // ---------- STOP FXN ----------
// void Stop()
// {
// 	digitalWrite(Ain1, LOW);
// 	digitalWrite(Ain1, LOW);
// 
// 	digitalWrite(Bin1, LOW);
// 	digitalWrite(Bin2, LOW);
// 
// 	analogWrite(PwmA, 0);
// 	analogWrite(PwmB, 0);
// 
// 	digitalWrite(Stby, LOW);
// }
// 
// // ---------- GETATTITUDE FXN ----------
// // 
// int getAttitude()
// {
// 	float val[90];
// 	float valSum=0;
// 	float valAvg=0;
// 
// 	for (int i=0; i<=89; i++)             // Sample xPin
// 	{
// 		val[i] = analogRead(xPin);
// 		valSum = (val[i]+valSum);
// 	}
// 
// 	Attitude[0] = (valSum / 90);          // Average samples
// 
// 	if(Attitude[0] > xCal)                 // which direction tilted?
// 	{
// 		Pitch = Backward;
// 		Attitude[0] = (Attitude[0] - xCal);   // Variation from level (300)
// 	}
// 	else
// 	{
// 		Pitch = Forward;
// 		Attitude[0] = (xCal - Attitude[0]);   // Tilted other direction
// 	}
// 
// 	valSum = 0;
// 	for (int i=0; i<=89; i++)              // Sample yPin
// 	{
// 		val[i] = analogRead(yPin);
// 		valSum = (val[i]+valSum);
// 	}
// 	Attitude[1] =(valSum / 90);            // Average samples
// 
// 	if(Attitude[1] > yCal)                 // which direction tilted?
// 	{
// 		Roll = Left;
// 		Attitude[1] = (Attitude[1] - yCal);   // Variation from level (300)
// 	}
// 	else
// 	{
// 		Roll = Right;
// 		Attitude[1] = (yCal - Attitude[1]);   // Tilted other direction
// 	}
// 
// 
// 	Attitude[2] = analogRead(zPin);
// 	if(Attitude[2] > 330)
// 	{
// 		Flipped = true; 
// 	}
// }
// 
// // ---------- GET VIRTUES ----------
// int getVirtues()
// {
// 	Virtues[Caution] = 500;//analogRead(virtue1Pin);
// 	Virtues[Patience] = 500; //analogRead(virtue2Pin);
// 	Virtues[Courage] = 500;// analogRead(virtue3Pin);
// }