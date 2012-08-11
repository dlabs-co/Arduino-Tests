#include <string.h>

   int timesToSend = 1;        // Numbers of calls to make
   int count = 0;
   
   char inData[1024]={'\0'}; // Allocate some space for the string
   char inChar=-1; // Where to store the character read
   int index = 0; // Index into array; where to store the character
   //byte index = 0; // Index into array; where to store the character

   void testModule(){
   Serial.flush();
   Serial3.flush();
   }
   
//Functions
//HiLo GPRS library
//By DegeneratedLabs
char * serial_read(void) {
  //Serial.println("entrando en serial_read");
  
    inData[0]=0;
    index=0;

    
    while (Serial3.available() > 0)
    {
            inChar = Serial3.read(); // Read a character
            inData[index] = inChar; // Store it
            index++; // Increment where to write next
            inData[index] = '\0'; // Null terminate the string
            delay(50);
    }

    return inData;

}

int pin(char*pin_number){
  Serial.print("entrando en pin()");
  char* at_response;
  char* parsed_response[20];
  int i=0,j=0,k=0;
  if(!strcmp(pin_number,"")){
      Serial3.println("AT+CPIN?");
      while (Serial3.available()==0);
      at_response=serial_read();
      k=strlen(at_response);
      for(i=0;i<k;i++){
        if (at_response[i]=='\x0d') at_response[i]='\x00';
        if (at_response[i]=='\x0a'&& at_response[i+1]!='\x00'){
          parsed_response[j]=&at_response[i+1];
          Serial.println(at_response[i+1]);
          j++;
        }
        if (at_response[i]=='\x0a'&& at_response[i+1]=='\0') at_response[i]='\0';
      }
      Serial.println(at_response);
      Serial.println(parsed_response[0]);
      Serial.println(parsed_response[1]);
      Serial.println(parsed_response[2]);
  }
}

// int is_ringing(void)
// return 1 if it's ringing and 0 if it's no ringing
int is_ringing(void){
  if (Serial3.available()>0){
    if(strcmp("\x0d\x0aRING\x0d\x0a",serial_read())==0) return 1;
  }
  return 0;
}

// int answer_call(void)
// return 0 if answer OK and 1 if it's an error
int answer_call(void){
  Serial3.println("ATA");
  while (Serial3.available()==0);
  if(strcmp("\x0d\x0aOK\x0d\x0a",serial_read())==0) return 0;
  if(strcmp("\x0d\x0aERROR\x0d\x0a",serial_read())==0) return 1;
}

int hangup(void){
  Serial3.println("AT+CHUP");
  while (Serial3.available()==0);
  if(strcmp("\x0d\x0aOK\x0d\x0a",serial_read())==0) return 0;
  return 1;
}

//bastante optimizable, es bloqueante
int dial(char*number){
  Serial3.print("ATD");
  Serial3.print(number);
  Serial3.println(";");
  while (Serial3.available()==0);
  if(strcmp("\x0d\x0aOK\x0d\x0a",serial_read())==0) return 0;
  if(strcmp("\x0d\x0aNO ANSWER\x0d\x0a",serial_read())==0) return 1;
  if(strcmp("\x0d\x0aNO CARRIER\x0d\x0a",serial_read())==0) return 2;
  if(strcmp("\x0d\x0aBUSY\x0d\x0a",serial_read())==0) return 3;
  if(strcmp("\x0d\x0aNO DIALTONE\x0d\x0a",serial_read())==0) return 4;
}

void setup(){
   Serial.begin(9600);                // the GPRS baud rate
   Serial3.begin(9600);
   Serial.println("Entrando en el setup");
   Serial.println("Saliendo del setup"); 
}

void loop(){
   
   while (count < timesToSend){
      delay(1500);
      Serial3.flush();
      
      Serial.println("Mandando AT");
      Serial3.println("AT");
      while (Serial3.available()==0);
      Serial.println(serial_read());
      
      Serial.println("Mandando AT+CPIN?");
      Serial3.println("AT+CPIN?");
      while (Serial3.available()==0);
      Serial.println(serial_read());
      
      Serial.println("Mandando AT+CREG?");
      Serial3.println("AT+CREG?");
      while (Serial3.available()==0);
      Serial.println(serial_read());

      Serial.println("Mandando AT+CCLK?");
      Serial3.println("AT+CCLK?");
      delay(500);
      while (Serial3.available()==0);
      Serial.println(serial_read());
      
      Serial.println("Mandando AT+CGSN");
      Serial3.println("AT+CGSN");
      delay(500);
      while (Serial3.available()==0);
      Serial.println(serial_read());
      
      pin("");
      
      //dial("686039261");
      
      while(1);
      
      while(1){
        if (is_ringing()){
          Serial.print("Estan llamando");
          hangup();
          delay(10000);
          answer_call();
          delay(3000);
          hangup();
          //while (Serial3.available()==0);
          //Serial.println(serial_read());
        }
      }
      
      
      while(1);
      
      Serial.println("Mandando ATD686039261;");      // ********* is the number to call
      Serial3.println("ATD686039261;");      // ********* is the number to call
      while (Serial.available()==0);
      Serial.println(serial_read());
      
      while (Serial3.available()==0);
      Serial.println(serial_read());

      delay(15000);

      Serial.println("Mandando ATH");              // disconnect the call
      Serial3.println("ATH");              // disconnect the call
         
      delay(5000);

      count++;
   }
}
