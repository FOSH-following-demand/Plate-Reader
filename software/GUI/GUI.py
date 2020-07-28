import sys

from PySide2.QtCore import QObject, QUrl, Signal, Slot, QSettings
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine


class GUI(QObject):
    result = Signal('QVariant')
    running = Signal(str)
    open = Signal(bool)

    def __init__(self, *args, **kwargs):
        self._open = False
        self._running = False
        super().__init__(*args, **kwargs)


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
