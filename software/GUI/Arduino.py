'''
Detect connection to arduino
'''

import warnings
import serial
import serial.tools.list_ports
import platform


class Arduino(object):
    def __init__(self, parent=None):
        if platform.system() == 'Windows':
            ser_ports = [
                p.device
                for p in serial.tools.list_ports.comports()
                if 'Arduino' in p.description
            ]
        elif platform.system() == 'Darwin':
            ser_ports = [
                p.device
                for p in serial.tools.list_ports.comports()
                if 'Arduino' in p.description
            ]
            if not ser_ports:
                ser_ports = [
                    p.device
                    for p in serial.tools.list_ports.comports()
                    if 'Generic CDC' in p.description
                ]
        elif platform.system() == 'Linux':
            ser_ports = [
                p.device
                for p in serial.tools.list_ports.comports()
                if 'ACM' in p.description
            ]
        if not ser_ports:
            raise IOError("No ser found")
        else:
            self.ser = serial.Serial(ser_ports[0], 9600, timeout=0)

    def write(self, string):
        self.ser.write(bytes(string, 'utf-8'))

    def read(self):
        signal = self.ser.readline()
        return str(signal, 'utf-8')

    def close(self):
        self.ser.close()
