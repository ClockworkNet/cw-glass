cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/com.rossgerbasi.cordova.glass.core/www/cordova-glass-core.js",
        "id": "com.rossgerbasi.cordova.glass.core.GlassCore",
        "clobbers": [
            "com.rossgerbasi.cordova.glass.core"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.device/www/device.js",
        "id": "org.apache.cordova.device.device",
        "clobbers": [
            "device"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "com.rossgerbasi.cordova.glass.core": "0.0.2",
    "org.apache.cordova.device": "0.2.8"
}
// BOTTOM OF METADATA
});