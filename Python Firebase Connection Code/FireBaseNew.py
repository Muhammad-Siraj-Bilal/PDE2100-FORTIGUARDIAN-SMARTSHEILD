import serial.tools.list_ports
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import serial
import re

ser = serial.Serial('COM11', 115200)
ser.flushInput()

# Initialize Firebase with your credentials
cred = credentials.Certificate("D:\BILAL\Downloads\esp8266-values-d231f-firebase-adminsdk-l7pro-af91df96e6.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://esp8266-values-d231f-default-rtdb.firebaseio.com/'
})

while True:
    try:
        ser_bytes = ser.readline().decode("utf-8").strip() # Reads a line from the serial port and decodes it from bytes to a UTF-8 string
        dis, ldr, fire = ser_bytes.split(',') # Splits the string where there is a ',' and assings the values to the variables
        print("Value 1: ", dis)
        print("Value 2: ", ldr)
        print("Value 3: ", fire)
        ref = db.reference("Values") # Refers to the node
        new_data = {
            "Distance": dis,
            "Light": ldr,
            "Fire": fire
            }
        print(ref.update(new_data)) # Updates the database with the new values
    except Exception as e:
        raise ValueError("An error occured") from e
        
