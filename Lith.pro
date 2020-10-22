QT += qml quick widgets webview multimedia quickcontrols2

CONFIG += c++11

SOURCES += main.cpp \
    qmlobjectlist.cpp \
    weechat.cpp

#RESOURCES += qml.qrc
RESOURCES += mobile/mobile.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

ios: {
  QMAKE_INFO_PLIST = Info.plist
  QMAKE_TARGET_BUNDLE_PREFIX=cz.rtinbriza.ma
#  QMAKE_DEVELOPMENT_TEAM="Z52EFCPL6D"
#  QMAKE_CODE_SIGN_IDENTITY="Martin Briza"
#  QMAKE_PROVISIONING_PROFILE=61f84d3f-1729-4bb5-a058-54896936692b
  QMAKE_ASSET_CATALOGS=$$PWD/icons/Assets.xcassets
  QMAKE_ASSET_CATALOGS_APP_ICON = "AppIcon"
}

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    qmlobjectlist.h \
    weechat.h
