# Enable pyserial extensions
import pyftdi.serialext

# Open a serial port on the second FTDI device interface (IF/2) @ 3Mbaud
port = pyftdi.serialext.serial_for_url('ftdi://ftdi:232:AQ00RVZA/1', baudrate=115200, bytesize=8, stopbits=1, parity='N', xonxoff=False, rtscts=False)

#'ftdi://ftdi:2232h/2'
#ftdi://ftdi:232:AB0JNVIE/1
# Send bytes
for i in range(1,24024):
    port.write(b'U')
    print(i)

# Receive bytes
for i in range(1,1024):
    data = port.read(10)
    print(data)

