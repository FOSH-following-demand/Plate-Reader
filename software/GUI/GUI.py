import sys

from PySide2.QtCore import QObject, QUrl, Slot
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine


class GUI(QObject):
    def __init__(self, url, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        engine = QQmlApplicationEngine()
        context = engine.rootContext()
        engine.load(url)

        if not engine.rootObjects():
            print("Something happend")
            sys.exit(-1)
        
        self.window = engine.rootObjects()[0]
        self.window.runClicked.connect(self.run)
        self.window.openCloseClicked.connect(self.openClose)
        self.window.pauseClicked.connect(self.pause)
        self.window.playClicked.connect(self.play)
        self.window.stopClicked.connect(self.stop)

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


def main():
    app = QGuiApplication(sys.argv)
    url = QUrl("./QML/main.qml")

    gui = GUI(url)

    app.exec_()
