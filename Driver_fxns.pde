//comment
void Driver(int caution, int courage, int patience)
{
	int leftSpeed;
	int rightSpeed;
	int lastTurn;
	int thisTurn;
	if(Pitch == Backward)
	{
		if(Roll == Left && courage > 5)  // Slows down as vehicle rolls and pitches. Can turn into or away from roll.
		{
			leftSpeed     = (255 - (4*Attitude[0] + 4*Attitude[1]));// * 3 );   // 
			rightSpeed    = (255 - (4*Attitude[0] + courage*Attitude[1]));// * (courage - 4) );
			leftSpeed     = constrain(leftSpeed, 50, 255);
			rightSpeed    = constrain(rightSpeed, 50, 255);
		}
		else if(Roll == Left && courage <= 5)
		{
			leftSpeed     = (255 - (4*Attitude[0] + (11-courage)*Attitude[1]));// * (7 - courage) );
			rightSpeed    = (255 - (4*Attitude[0] + 4*Attitude[1]));// * 3 );
			leftSpeed     = constrain(leftSpeed, 50, 255);
			rightSpeed    = constrain(rightSpeed, 50, 255);
		}
		else if(Roll == Right && courage > 5)
		{
			leftSpeed     = (255 - (4*Attitude[0] + courage*Attitude[1]));// * (courage - 4) );
			rightSpeed    = (255 - (4*Attitude[0] + 4*Attitude[1]));// * 3 );
			leftSpeed     = constrain(leftSpeed, 50, 255);
			rightSpeed    = constrain(rightSpeed, 50, 255);
		}
		else if(Roll == Right && courage <= 5)
		{
			leftSpeed     = (255 - (4*Attitude[0] + 4*Attitude[1]));// * 3 );
			rightSpeed    = (255 - (4*Attitude[0] + (11-courage)*Attitude[1]));// * (7 - courage) );
			leftSpeed     = constrain(leftSpeed, 50, 255);
			rightSpeed    = constrain(rightSpeed, 50, 255);
		}
	}
	else
	{
		if(Roll == Left && courage > 5)  // Slows down as vehicle rolls and pitches. Can turn into or away from roll.
		{
			rightSpeed    = 2*(255 - (3*Attitude[0] + 4*Attitude[1]));// * 3 );   // 
			leftSpeed     = 2*(255 - (3*Attitude[0] + courage*Attitude[1]));// * (courage - 4) );
			leftSpeed     = constrain(leftSpeed, 50, 255);
			rightSpeed    = constrain(rightSpeed, 50, 255);
		}
		else if(Roll == Left && courage <= 5)
		{
			leftSpeed     = 2*(255 - (3*Attitude[0] + (11-courage)*Attitude[1]));// * (7 - courage) );
			rightSpeed    = 2*(255 - (3*Attitude[0] + 4*Attitude[1]));// * 3 );
			leftSpeed     = constrain(leftSpeed, 50, 255);
			rightSpeed    = constrain(rightSpeed, 50, 255);
		}
		else if(Roll == Right && courage > 5)
		{
			rightSpeed    = 2*(255 - (3*Attitude[0] + courage*Attitude[1]));// * (courage - 4) );
			leftSpeed     = 2*(255 - (3*Attitude[0] + 4*Attitude[1]));// * 3 );
			leftSpeed     = constrain(leftSpeed, 50, 255);
			rightSpeed    = constrain(rightSpeed, 50, 255);
		}
		else if(Roll == Right && courage <= 5)
		{
			leftSpeed     = 2*(255 - (3*Attitude[0] + 4*Attitude[1]));// * 3 );
			rightSpeed    = 2*(255 - (3*Attitude[0] + (11-courage)*Attitude[1]));// * (7 - courage) );
			leftSpeed     = constrain(leftSpeed, 50, 255);
			rightSpeed    = constrain(rightSpeed, 50, 255);
		}	
	}
	Drive(100, Forward, rightSpeed, leftSpeed); // Drive forward... primary instruction
	getAttitude();
	if(Pitch == Backward && Attitude[0] > caution || Attitude[1] > caution-5 || ((Attitude[0] + Attitude[1]) / 2) > caution && Pitch == Backward)   // Checks for maximum roll and pitch
	{
		int lastRoll   = Roll;
		delay(100);    //wait for accelerometer to settle
		getAttitude(); // check accelerometer again

		if(Pitch == Backward && Attitude[0] > caution || Attitude[1] > caution-5 || ((Attitude[0] + Attitude[1]) / 2) > caution && Pitch == Backward) // Retest for max roll and pitch
		{
			if(Pitch == Backward)
			{
				Drive(((Attitude[0] + Attitude[1]) * 20), Backward, leftSpeed, rightSpeed);
				Stop();
				delay(300);
			}
	// Punch-It Routine----------------
			if(Attitude[1] < 10 && punchIt == true)
			{
				analogWrite(6, 255);
				analogWrite(5, 0);
				analogWrite(3, 0);
				getAttitude();
				int time     = 0;
				while(Attitude[0] < 29 && Attitude[1] < 25 && time<=courage*caution*5 && Flipped == false)
				{    
					Drive(10, Forward, 255,255);
					delay(10);
					getAttitude();
					time        = time+20;
					Stop();
					punchIt     = false;
				}
			}
			else if(Pitch == Backward)
			{
				punchIt     = true;
				if(lastRoll == Left && courage > 5)
				{
					Rotate(patience*2, Left, leftSpeed);
				}
				if (lastRoll == Left && courage <= 5)
				{
					Rotate(patience*2, Right, leftSpeed);
				}
				else if (lastRoll == Right && courage > 5)
				{
					Rotate(patience*2, Right, leftSpeed);
				}
				else if (lastRoll == Right && courage <= 5)
				{
					Rotate(patience*2, Left, leftSpeed);
				}
			}
		}
	}
}




