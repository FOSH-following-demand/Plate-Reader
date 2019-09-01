import sys

from PySide2.QtCore import QObject, QUrl, Signal, Slot
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine

from machine import Machine


class GUI(QObject):
    result = Signal('QVariant')
    running = Signal(str)
    open = Signal(bool)

    xd = 9.0  # well x spacing
    yd = 9.0  # well y spacing
    x0 = 0.0  # x position of first well
    y0 = 0.0  # y position of first well

    def __init__(self, *args, **kwargs):
        self._open = False
        self._running = False
        super().__init__(*args, **kwargs)
        self.machine = Machine()
        self._selectedWells = []

    @Slot()
    def open_close(self):
        if self._open:
            self.machine.open_plate('close')
            self._open = False
            self.open.emit(False)
        else:
            self.machine.open_plate('open')
            self._open = True
            self.open.emit(True)

    @Slot()
    def run(self):
        self._running = True
        self.running.emit('running')
        while self._running:
            for well in self._selectedWells:
                well_position = self.calculate_well_position(well)
                self.machine.move_sensor(*well_position)
                scan_result = self.machine.scan_well()
                # scan_result = 4.2
                self.result.emit({'identifier': well, 'result': scan_result})
            self._running = False
            self.running.emit('stopped')

    def calculate_well_position(self, well):
        '''
        Calculates well position from well identification string

        :param well: well identification string in the regex format ^[A-H][0-9]{1,2}$ eg A12
        :return: tuple of floats representing the x and y coordinates of the well
        '''
        well_char = well[0]
        well_num = int(well[1:])
        x = self.x0 + (ord(well_char) - ord('A')) * self.xd
        y = self.y0 + (well_num - 1) * self.yd
        return x, y

    @Slot()
    def pause(self):
        print("Pause clicked")
        self._running = False
        self.running.emit('paused')

    @Slot()
    def play(self):
        self._running = True
        self.running.emit('running')
        print("play called")

    @Slot()
    def stop(self):
        self.running.emit('stopped')
        print("stop called")

    @Slot(str)
    def well_selected(self, name):
        if name not in self._selectedWells:
            self._selectedWells.append(name)
        else:
            self._selectedWells.remove(name)
        self._selectedWells.sort()


def main():
    app = QGuiApplication(sys.argv)
    url = QUrl("./QML/main.qml")

    engine = QQmlApplicationEngine()

    gui = GUI(engine)

    context = engine.rootContext()
    context.setContextProperty("ui", gui)

    engine.load(url)

    if not engine.rootObjects():
        sys.exit(-1)

    app.exec_()


if __name__ == '__main__':
    sys.argv += ['--style', 'fusion']
    main()
