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

