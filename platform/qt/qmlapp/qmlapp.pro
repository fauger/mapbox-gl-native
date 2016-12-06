TARGET = qmapboxgl-qmlapp

TEMPLATE = app

QT += location qml

CONFIG += c++14

SOURCES += \
    main.cpp

RESOURCES += \
    ../resources/common.qrc \
    qml.qrc

INCLUDEPATH += \
    ../include

LIBS += \
    ../build/libqmapboxgl.a \
    -licuuc \
    -lz
