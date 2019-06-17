import sys

from PySide2.QtCore import QObject, QUrl, Slot
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine


class GUI(QObject):
    _selectedWells = []
    def __init__(self, engine, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        self.window = engine.rootObjects()[0]
        self.window.runClicked.connect(self.run)
        self.window.openCloseClicked.connect(self.openClose)
        self.window.pauseClicked.connect(self.pause)
        self.window.playClicked.connect(self.play)
        self.window.stopClicked.connect(self.stop)
        self.window.wellSelected.connect(self.wellSelected)

    @Slot()
    def openClose(self):
        print("Open/Close called")

    @Slot()
    def run(self):
        print("Run called")

    @Slot()
    def pause(self):
        print("Pause clicked")

    @Slot()
    def play(self):
        print("play called")

    @Slot()
    def stop(self):
        print("stop called")

    @Slot(str)
    def wellSelected(self, name):
        if not name in self._selectedWells:
            self._selectedWells.append(name)
        else:
            self._selectedWells.remove(name)
        self._selectedWells.sort()
        print(self._selectedWells)

def main():
    app = QGuiApplication(sys.argv)
    url = QUrl("./QML/main.qml")
    
    engine = QQmlApplicationEngine()
    engine.load(url)
    
    context = engine.rootContext()

    if not engine.rootObjects():
        sys.exit(-1)
    
    gui = GUI(engine)

    app.exec_()


if __name__ == '__main__':
    sys.argv += ['--style', 'fusion']
    main()