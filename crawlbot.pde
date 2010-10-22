// Pin Mapping - TB1244FNG motor driver
const byte PwmA = 9;            // Right speed pwm signal
const byte PwmB = 10;           // Left speed pwm signal
const byte Ain1 = 7;            // H-bridge logic for right side
const byte Ain2 = 8;            // H-bridge logic for right side
const byte Bin1 = 13;           // H-bridge logic for left side3
const byte Bin2 = 12;           // H-bridge logic for left side
const byte Stby = 4;            // Turns motor driver on or off, HIGH is on

// Pin Mapping - accelerometer
const byte PitchPin = 0;        // Analog pin reads pitch
const byte RollPin = 4;         // Analog pin reads roll
const byte ZPin = 5;            // Analog pin reads Z axis (up and down)

// Pin Mapping  - potentiometers & buttons
const byte Virtue1Pin = 1;      // Analog pin reads left pot
const byte Virtue2Pin = 2;      // Analog pin reads center pot
const byte Virtue3Pin = 3;      // Analog pin reads right pot
const byte GoButton = 2;        // Go Button pin, digital

// Pin Mapping - LED
const byte RedPin = 6;          // Pwm output for the red LED channel
const byte GreenPin = 5;        // Pwm output for the green LED channel
const byte BluePin = 3;         // Pwm output for the blue LED channel

// Pin Mapping - beacon
const byte NorthPin = 11;       // Input for North beacon output

// State Variables
const byte Pitch = 0;           // Abstraction for Pitch array address
const byte Roll = 1;            // Abstraction for Roll array address
const byte Zaxis = 2;           // Abstraction for Z-axis array address
const byte Virtue1 = 0;         // Abstraction for Virtue 1 array address
const byte Virtue2 = 1;         // Abstraction for Virtue 2 array address
const byte Virtue3 = 2;         // Abstraction for Virtue 3 array address
int Attitude[3];                // Array that holds the X,Y, and Z readings processed by the getAttitude fxn
int Virtues[3];                 // Array that holds the 3 pot values
boolean PitchDirection;         // Which direction, fwd or bwd?
boolean RollDirection;          // Which direction, left or right?
const byte Left = 0;            // Abstraction for roll direction
const byte Right = 1;           // Abstrction for roll direction
int CalibratePitch;             // Level value for pitch, set when powered on
int CalibrateRoll;              // Level value for roll, set when powered on
int CalibrateZ;                 // Level value for Z-axis, set when powered on
volatile boolean Flipped = true;// Toggles between the Drive loop and the Tune loop. Volatile due to use with interrupt

//Drive Variables
const boolean fwd = 1;          // Abstraction for forward
const boolean bwd = 0;          // Abstraction for backward
int LeftSpeed = 255;            // Speed for left wheels, starts at maximum
boolean LeftDirection = fwd;    // Direction for left wheels, starts at forward
int RightSpeed = 255;           // Speed for right wheels, starts at maximum
boolean RightDirection = fwd;   // Direction for right wheels, starts at forward
int DriveDelay = 10;            // Time in microseconds to carry out drive fxn, starts at 10us


void setup()
{
    //Serial.begin(9600);
    pinMode(GoButton, INPUT);
    digitalWrite(GoButton, HIGH);           // Enable pulldown resistor on interrupt pin
    pinMode(BluePin, OUTPUT);
    pinMode(GreenPin, OUTPUT);
    pinMode(RedPin, OUTPUT);
    pinMode(PwmA, OUTPUT);
    pinMode(PwmB, OUTPUT);
    pinMode(Stby, OUTPUT);
    pinMode(Ain1, OUTPUT);
    pinMode(Ain2, OUTPUT);
    pinMode(Bin1, OUTPUT);
    pinMode(Bin2, OUTPUT);
    GetAttitude();
    CalibratePitch = Attitude[Pitch];  // Measures pitch at startup, assumed to be level 
    CalibrateRoll = Attitude[Roll];    // Measures roll at startup, assumed to be level
    CalibrateZ = analogRead(ZPin);          // Measures Z-axis at startup, assumed to be gravity
    attachInterrupt(0, go, FALLING);        // Attaches fxn "go" to the Go Button on pin 2
}

void loop()
{   
// Tuning Loop.
// While Flipped is true, it stops the motors and scans Virtue1, Virtue2, and Virtue3 pots for values.
// Also outputs tuning values to the RGB LED.  
    while(Flipped == true)
    {
        Stop();                                                             // Stop the motors
        analogWrite(RedPin, map(analogRead(Virtue1Pin), 1024,0,0,255));     // Reads, maps, and writes Virtue1 to the red LED
        analogWrite(GreenPin, map(analogRead(Virtue2Pin), 1024,0,0,255));   // Reads, maps, and writes Virtue2 to the green LED
        analogWrite(BluePin, map(analogRead(Virtue3Pin), 1024,0,0,255));    // Reads, maps, and writes Virtue3 to the blue LED
        Virtues[Virtue1] = map(analogRead(Virtue1Pin), 1024,0,0,1024);      // Writes pot to array.Inverts so left
        Virtues[Virtue2] = map(analogRead(Virtue2Pin), 1024,0,0,1024);      // Writes pot to array.Inverts so left
        Virtues[Virtue3] = map(analogRead(Virtue3Pin), 1024,0,0,1024);      // Writes pot to array.Inverts so left

        if(analogRead(ZPin) > 400)                                          // Checks to see if Go Tap received 
        {
            Flipped = false;                                                // If received, exits Tuning Loop
        }
    }

// Drive Loop.
// While Flipped is false, executes Drive fxn and Virtue fxns.
    while(Flipped == false)
    {
        Drive(DriveDelay, LeftSpeed, LeftDirection, RightSpeed, RightDirection);
        GetAttitude();
        P1();
        P2();
        P3();
    }
}

// Go fxn atatched to interrupt. Toggles between Tuning and Drive loops.
// Stops the motor and toggles the Flipped variable.
void go()
{
    static unsigned long last_interrupt_time = 0;       // Debounce code
    unsigned long interrupt_time = millis();            // debounce code
    if (interrupt_time - last_interrupt_time > 200)     // Debounce code
    {
        if (Flipped == false)                           // Checks to see if already flipped
        {
            Stop();                                     // If not flipped, stops motors
        }
        Flipped = !Flipped;                             // Toggles flipped state
        DriveDelay = 10;
        LeftSpeed = 255;
        RightSpeed = 255;
        LeftDirection = fwd;
        RightDirection = fwd;
    }
    last_interrupt_time = interrupt_time;               // Debounce code
}