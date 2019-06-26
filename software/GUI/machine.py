import time
from Arduino import Arduino
from PySide2.QtCore import QCoreApplication


class Machine(object):
    def __init__(self, *args, **kwargs):
        self.arduino = Arduino()

    def open_plate(self, state):
        '''
        Open/Close plate reader. Only one axis possible
        '''
        cmd = 'OP' if state=='open' else 'CP'  # OP to open plate reader. CP to close plate reader
        self.arduino.write(cmd)
        res = ''
        current = ''
        while not current.endswith('\n'):
            current = self.arduino.read()
            res += current
            QCoreApplication.processEvents()
        if res.startswith('Done'):
            return res

    def move_sensor(self, x_position, y_position):
        '''Move photooptometer to the desired location

        Parameters
        ---------
        x_position: float
            x-coordinate to move sensor to.
        y_position: float
            y-coordinate to move sensor to.

        Returns
        -------
        str
            feedback string. "Done" represents completion without any errors.
        '''
        cmd = 'MS'
        cmd += f"{x_position}, {y_position}"
        self.arduino.write(cmd)
        res = ''
        current = ''
        while not current.endswith('\n'):
            current = self.arduino.read()
            res += current
            QCoreApplication.processEvents()
        if res.startswith('Done'):
            return res

    def scan_well(self):
        '''
        Receive sensor reading from specified well
        '''
        cmd = 'SW'
        self.arduino.write(cmd)
        res = ''
        current = ''
        while not current.endswith('\n'):
            current = self.arduino.read()
            res += current
            QCoreApplication.processEvents()
        repr(res)
        return float(res)

    def close(self):
        '''
        Close Arduino and shutdown machine
        '''
        return self.arduino.close()

    def set_rgb(self, value):
        '''
        Set rgb color value
        '''
        cmd = 'SR'
        cmd += b'{value}'
        self.arduino.write(cmd)
        res = ''
        current = ''
        while not current.endswith('\n'):
            current = self.arduino.read()
            res += current
            QCoreApplication.processEvents()
        if res.startswith('Done'):
            return res
