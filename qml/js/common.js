

function isNull(exp) {
    if (!exp && typeof(exp) != "undefined" && exp != 0)
        return true
    return false
}

function isEmpty(obj){
    if(typeof obj == "undefined" || obj == null || obj == "")
        return true;
    return false;
}

function date2string(value) {
    var currentDate = new Date()
    var localeDate = new Date(value)
    var yesterday = new Date();
    yesterday.setDate(currentDate.getDate()-1)

    if (currentDate.getFullYear() !== localeDate.getFullYear() )
    {
        return localeDate.toLocaleString(Qt.locale("de_DE"), "yy/MM/dd");
    }

     if (currentDate.getMonth() === localeDate.getMonth() )
     {
         if(currentDate.getDate() === localeDate.getDate())
         {
             return localeDate.toLocaleString(Qt.locale("de_DE"), "HH:mm");
         }

         if (yesterday.getDate() === localeDate.getDate())
         {
             return qsTr("昨天");
         }
     }

    return localeDate.toLocaleString(Qt.locale("de_DE"), "MM/dd");
}
