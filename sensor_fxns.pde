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


