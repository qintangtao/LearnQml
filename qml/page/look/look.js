
var lookwins = []

function length() {
    return lookwins.length
}

function addLookWindow(parent, info) {
    var obj = createLookWindow(parent, info)
    if (isNull(obj))
        return false

    lookwins.push(obj)
    return true
}

function delLookWindow(id) {
    var obj = getLookWindow(id)
    if (isNull(obj))
        return

    lookwins.remove(obj);

    obj.destroy()
}

function getLookWindow(id) {
    for(var i = 0, len=lookwins.length; i < len; i++) {
       // console.log("getLookInfo " + looks[i] + ", info " + looks[i].info)
        if(lookwins[i].info.id === id)
            return lookwins[i]
    }
    return null
}

function createLookWindow(parent, info) {
    var component = Qt.createComponent("LookWindow.qml")
    console.log("errorString " + component.errorString())
    if (component.status === Component.Ready) {
        var obj = component.createObject(parent, {"info": info})
        return obj
    }
    return;
}

function isNull(exp) {
    if (!exp && typeof(exp) != "undefined" && exp != 0)
        return true
    return false
}

Array.prototype.indexOf = function(val) {
    for (var i = 0, len = this.length; i < len; i++) {
        if (this[i] == val) return i;
    }
    return -1;
};

Array.prototype.remove = function(val) {
    var index = this.indexOf(val);
    if (index > -1)
        this.splice(index, 1);
};
