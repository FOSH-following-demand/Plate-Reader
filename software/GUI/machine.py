# from Arduino import Arduino
from Arduino import Arduino


class Machine(object):
    def __init__(self, *args, **kwargs):
        self.arduino = Arduino()

    def open_plate(self, position):
        '''
        Open/Close plate reader. Only one axis possible
        '''
        pass

    def move_sensor(self, x_position, y_position):
        '''
        Move photooptometer to the desired location
        '''
        self.arduino.write(f"{x_position}, {y_position}")

    def scan_well(self):
        '''
        Receive sensor reading from specified well
        '''
        pass

    def close(self):
        '''
        Close Arduino and shutdown machine
        '''
        self.arduino.close()

    def set_rgb(self, value):
        '''
        Set rgb color value
        '''
        self.arduino.write()
