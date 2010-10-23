// CrawlBot V2

// --------- VARIABLES ----------
const boolean Left = 1;
const boolean Right = 0;
const boolean Forward = 1;
const boolean Backward = 0;
const byte xPin = 0;
const byte yPin = 4;
const byte zPin = 5;
const byte xAxis = 0;
const byte yAxis = 1;
const byte zAxis = 2;
const byte virtue1Pin = 1;
const byte virtue2Pin = 2;
const byte virtue3Pin = 3;
const byte Caution = 0;
const byte Courage = 1;
const byte Patience = 2;
volatile boolean North = false;
int Virtues[3];
volatile int Attitude[3];
volatile boolean Flipped;
byte Roll;
byte Pitch;
int xCal;
int yCal;
int cautionVal;
int courageVal;
int patienceVal;
volatile boolean punchIt;
int redVal;
int greenVal;
int blueVal;

void setup()
{
	Serial.begin(9600);
	pinMode(2, INPUT);
	digitalWrite(2, HIGH);
	pinMode(4, OUTPUT);
	pinMode(5, OUTPUT);
	pinMode(6, OUTPUT);
	pinMode(7, OUTPUT);
	pinMode(10, OUTPUT);
	pinMode(11, INPUT);
	Flipped = true;
	punchIt = true;
	xCal = analogRead(xPin);	// Calibrates x-axis 
	yCal = analogRead(yPin);
	attachInterrupt(0, go, FALLING);
}



void loop()
{ 
	while(Flipped == true)
	{
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
		int tappedz = analogRead(5);

		if(tappedz > 400)
		{
			Flipped = false;
		}
	}

	while(Flipped == false)
	{
		getAttitude();
		Driver(cautionVal, courageVal, patienceVal);
		analogWrite(6, 0);
		analogWrite(5, 0);
		analogWrite(3, 0);
	}

	Stop();
}

void go()
{
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

