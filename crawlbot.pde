// Pin Mapping - TB1244FNG motor driver
const byte PwmA = 9;				// Right speed pwm signal
const byte PwmB = 10;			// Left speed pwm signal
const byte Ain1 = 7;				// H-bridge logic for right side
const byte Ain2 = 8;				// H-bridge logic for right side
const byte Bin1 = 1;				// H-bridge logic for left side3
const byte Bin2 = 12;			// H-bridge logic for left side
const byte Stby = 4;				// Turns motor driver on or off, HIGH is on

// Pin Mapping - accelerometer
const byte PitchPin = 0;			// Analog pin reads pitch
const byte RollPin = 4;			// Analog pin reads roll
const byte ZPin = 5;				// Analog pin reads Z axis (up and down)

// Pin Mapping  - potentiometers
const byte Virtue1Pin = 1;		// Analog pin reads left pot
const byte Virtue2Pin = 2;		// Analog pin reads center pot
const byte Virtue3Pin = 3;		// Analog pin reads right pot

// Pin Mapping - LED
const byte RedPin = 6;			// Pwm output for the red LED channel
const byte GreenPin = 5;			// Pwm output for the green LED channel
const byte BluePin = 3;			// Pwm output for the blue LED channel

// State Variables
byte Pitch = 0;				// Abstraction for Pitch array address
byte Roll = 1;				// Abstraction for Roll array address
byte Zaxis = 2;				// Abstraction for Z-axis array address
byte Virtue1 = 0;			// Abstraction for Virtue 1 array address
byte Virtue2 = 1;			// Abstraction for Virtue 2 array address
byte Virtue3 = 2;			// Abstraction for Virtue 3 array address
bool Flipped = true;		// Toggles betwen two main loops, the Drive loop and the Tune loop
int Attitude[3];			// Array that holds the X,Y, and Z readings processed by the getAttitude fxn
int Virtues[3];				// Array that holds the 3 pot values

//Drive Variables
bool fwd = 1;				// Abstraction for forward
bool bwd = 0;				// Abstraction for backward
int LeftSpeed = 255;		// Speed for left wheels, starts at maximum
bool Leftdirection = fwd;	// Direction for left wheels, starts at forward
int RightSpeed = 255;		// Speed for right wheels, starts at maximum
bool RightDirection = fwd;	// Direction for right wheels, starts at forward
int DriveDelay = 10;		// Time in microseconds to carry out drive fxn, starts at 10us


void setup()
{
	// Serial.begin(9600);
	pinMode(2, OUTPUT);
	pinMode(4, OUTPUT);
	pinMode(5, OUTPUT);
	pinMode(6, OUTPUT);
	pinMode(7, OUTPUT);
	pinMode(10, OUTPUT);
	pinMode(11, OUTPUT);
	Flipped = true;
	punchIt = true;
	xCal = analogRead(xPin);	// Calibrates x-axis 
	yCal = analogRead(yPin);
	attachInterrupt(0, go, RISING);
}



void loop()
{ 
	while(Flipped == true)
	{
		Stop();

		redVal = analogRead(1);
		greenVal = analogRead(2);
		blueVal = analogRead(3);
		redVal = map(redVal, 1024, 0, 0, 255);
		greenVal = map(greenVal, 1024, 0, 0, 255);
		blueVal = map(blueVal, 1024, 0, 0, 255);
		analogWrite(6, redVal);
		analogWrite(5, greenVal);
		analogWrite(3, blueVal);

		cautionVal = map(analogRead(1), 0, 1024, 10, 35);
		patienceVal = map(analogRead(2), 0, 1024, 100, 800);
		courageVal = map(analogRead(3), 0, 1024, 11, 1);
		punchIt = true;

		if(analogRead(5) > 400)
		{
			Flipped = false;
		}
	}

	while(Flipped == false)
	{
		getAttitude();
		p1();
		p2();
		p3();
		Drive();
	}

	void go()
	{
		static unsigned long last_interrupt_time = 0;
		unsigned long interrupt_time = millis();
	// If interrupts come faster than 200ms, assume it's a bounce and ignore
		if (interrupt_time - last_interrupt_time > 200)
		{
			if (Flipped == false)
			{
				Stop(); 
			}
			Flipped = !Flipped;
		}
		last_interrupt_time = interrupt_time;
	}
}

