// Get the port from the url fragment
var port = parseInt(document.location.hash.substring(1));

if (port > 0) {
//
//QUnit.tapServerReady = false;
//
//QUnit.testStart = function (name) {
//    if (QUnit.tapServerReady == false) {
//        
//        $.get( {
//    
//        "url": "http://localhost:"+port+"/", 
//        "async": false,
//        "cache": false,
//        "type": "GET",
//        "data": { "type":"startup"},
//        "success": function(xhr, msg) {
//            if (msg === 'success') {
//                QUnit.tapServerReady = true;
//            }
//        }
//        });
//    };
//
//};
//
//

QUnit.log = function (result, message) { $.get("http://localhost:"+port, { "type": "one-test", "result": result, "message":message});
};

QUnit.done = function (failures, total) { $.get("http://localhost:"+port, { "type": "done", "total": total, "fail": failures}); };

}

