/****************************************************************************
** Meta object code from reading C++ file 'reciver.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.8.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../reciver.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#include <QtCore/QVector>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'reciver.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.8.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_reciver_t {
    QByteArrayData data[30];
    char stringdata0[464];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_reciver_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_reciver_t qt_meta_stringdata_reciver = {
    {
QT_MOC_LITERAL(0, 0, 7), // "reciver"
QT_MOC_LITERAL(1, 8, 18), // "isConnectedChanged"
QT_MOC_LITERAL(2, 27, 0), // ""
QT_MOC_LITERAL(3, 28, 17), // "deviceNameChanged"
QT_MOC_LITERAL(4, 46, 21), // "deviceSendPortChanged"
QT_MOC_LITERAL(5, 68, 23), // "deviceRecivePortChanged"
QT_MOC_LITERAL(6, 92, 17), // "dataVectorChanged"
QT_MOC_LITERAL(7, 110, 9), // "upDataNow"
QT_MOC_LITERAL(8, 120, 23), // "processPendingDatagrams"
QT_MOC_LITERAL(9, 144, 16), // "WriteRawDataFile"
QT_MOC_LITERAL(10, 161, 21), // "closeClientConnection"
QT_MOC_LITERAL(11, 183, 15), // "initConnectinon"
QT_MOC_LITERAL(12, 199, 20), // "sendStartSendDataCmd"
QT_MOC_LITERAL(13, 220, 23), // "sendParameterSettingCmd"
QT_MOC_LITERAL(14, 244, 25), // "sendGetCurrenParameterCmd"
QT_MOC_LITERAL(15, 270, 19), // "sendStopSendDataCmd"
QT_MOC_LITERAL(16, 290, 4), // "getY"
QT_MOC_LITERAL(17, 295, 5), // "index"
QT_MOC_LITERAL(18, 301, 11), // "isConnected"
QT_MOC_LITERAL(19, 313, 10), // "deviceName"
QT_MOC_LITERAL(20, 324, 14), // "deviceSendPort"
QT_MOC_LITERAL(21, 339, 16), // "deviceRecivePort"
QT_MOC_LITERAL(22, 356, 10), // "dataVector"
QT_MOC_LITERAL(23, 367, 12), // "QVector<int>"
QT_MOC_LITERAL(24, 380, 8), // "CmdTypes"
QT_MOC_LITERAL(25, 389, 11), // "QueryStatus"
QT_MOC_LITERAL(26, 401, 16), // "ParameterSetting"
QT_MOC_LITERAL(27, 418, 18), // "GetCurrenParameter"
QT_MOC_LITERAL(28, 437, 13), // "StartSendData"
QT_MOC_LITERAL(29, 451, 12) // "StopSendData"

    },
    "reciver\0isConnectedChanged\0\0"
    "deviceNameChanged\0deviceSendPortChanged\0"
    "deviceRecivePortChanged\0dataVectorChanged\0"
    "upDataNow\0processPendingDatagrams\0"
    "WriteRawDataFile\0closeClientConnection\0"
    "initConnectinon\0sendStartSendDataCmd\0"
    "sendParameterSettingCmd\0"
    "sendGetCurrenParameterCmd\0sendStopSendDataCmd\0"
    "getY\0index\0isConnected\0deviceName\0"
    "deviceSendPort\0deviceRecivePort\0"
    "dataVector\0QVector<int>\0CmdTypes\0"
    "QueryStatus\0ParameterSetting\0"
    "GetCurrenParameter\0StartSendData\0"
    "StopSendData"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_reciver[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      15,   14, // methods
       5,  106, // properties
       1,  126, // enums/sets
       0,    0, // constructors
       0,       // flags
       6,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   89,    2, 0x06 /* Public */,
       3,    0,   90,    2, 0x06 /* Public */,
       4,    0,   91,    2, 0x06 /* Public */,
       5,    0,   92,    2, 0x06 /* Public */,
       6,    0,   93,    2, 0x06 /* Public */,
       7,    0,   94,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       8,    0,   95,    2, 0x08 /* Private */,
       9,    0,   96,    2, 0x08 /* Private */,

 // methods: name, argc, parameters, tag, flags
      10,    0,   97,    2, 0x02 /* Public */,
      11,    0,   98,    2, 0x02 /* Public */,
      12,    0,   99,    2, 0x02 /* Public */,
      13,    0,  100,    2, 0x02 /* Public */,
      14,    0,  101,    2, 0x02 /* Public */,
      15,    0,  102,    2, 0x02 /* Public */,
      16,    1,  103,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int, QMetaType::Int,   17,

 // properties: name, type, flags
      18, QMetaType::Bool, 0x00495103,
      19, QMetaType::QString, 0x00495103,
      20, QMetaType::UShort, 0x00495103,
      21, QMetaType::UShort, 0x00495103,
      22, 0x80000000 | 23, 0x0049510b,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       4,

 // enums: name, flags, count, data
      24, 0x0,    5,  130,

 // enum data: key, value
      25, uint(reciver::QueryStatus),
      26, uint(reciver::ParameterSetting),
      27, uint(reciver::GetCurrenParameter),
      28, uint(reciver::StartSendData),
      29, uint(reciver::StopSendData),

       0        // eod
};

void reciver::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        reciver *_t = static_cast<reciver *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->isConnectedChanged(); break;
        case 1: _t->deviceNameChanged(); break;
        case 2: _t->deviceSendPortChanged(); break;
        case 3: _t->deviceRecivePortChanged(); break;
        case 4: _t->dataVectorChanged(); break;
        case 5: _t->upDataNow(); break;
        case 6: _t->processPendingDatagrams(); break;
        case 7: _t->WriteRawDataFile(); break;
        case 8: _t->closeClientConnection(); break;
        case 9: _t->initConnectinon(); break;
        case 10: _t->sendStartSendDataCmd(); break;
        case 11: _t->sendParameterSettingCmd(); break;
        case 12: _t->sendGetCurrenParameterCmd(); break;
        case 13: _t->sendStopSendDataCmd(); break;
        case 14: { int _r = _t->getY((*reinterpret_cast< const int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (reciver::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&reciver::isConnectedChanged)) {
                *result = 0;
                return;
            }
        }
        {
            typedef void (reciver::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&reciver::deviceNameChanged)) {
                *result = 1;
                return;
            }
        }
        {
            typedef void (reciver::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&reciver::deviceSendPortChanged)) {
                *result = 2;
                return;
            }
        }
        {
            typedef void (reciver::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&reciver::deviceRecivePortChanged)) {
                *result = 3;
                return;
            }
        }
        {
            typedef void (reciver::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&reciver::dataVectorChanged)) {
                *result = 4;
                return;
            }
        }
        {
            typedef void (reciver::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&reciver::upDataNow)) {
                *result = 5;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 4:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QVector<int> >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        reciver *_t = static_cast<reciver *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = _t->isConnected(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->deviceName(); break;
        case 2: *reinterpret_cast< quint16*>(_v) = _t->deviceSendPort(); break;
        case 3: *reinterpret_cast< quint16*>(_v) = _t->deviceRecivePort(); break;
        case 4: *reinterpret_cast< QVector<int>*>(_v) = _t->dataVector(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        reciver *_t = static_cast<reciver *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setIsConnected(*reinterpret_cast< bool*>(_v)); break;
        case 1: _t->setDeviceName(*reinterpret_cast< QString*>(_v)); break;
        case 2: _t->setDeviceSendPort(*reinterpret_cast< quint16*>(_v)); break;
        case 3: _t->setDeviceRecivePort(*reinterpret_cast< quint16*>(_v)); break;
        case 4: _t->setDataVector(*reinterpret_cast< QVector<int>*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject reciver::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_reciver.data,
      qt_meta_data_reciver,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *reciver::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *reciver::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_reciver.stringdata0))
        return static_cast<void*>(const_cast< reciver*>(this));
    return QObject::qt_metacast(_clname);
}

int reciver::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 15)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 15;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 15)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 15;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 5;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void reciver::isConnectedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, Q_NULLPTR);
}

// SIGNAL 1
void reciver::deviceNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, Q_NULLPTR);
}

// SIGNAL 2
void reciver::deviceSendPortChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, Q_NULLPTR);
}

// SIGNAL 3
void reciver::deviceRecivePortChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, Q_NULLPTR);
}

// SIGNAL 4
void reciver::dataVectorChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, Q_NULLPTR);
}

// SIGNAL 5
void reciver::upDataNow()
{
    QMetaObject::activate(this, &staticMetaObject, 5, Q_NULLPTR);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
