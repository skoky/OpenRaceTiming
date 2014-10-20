library ort;

import 'package:redstone/server.dart' as app;
import 'dart:convert';

@app.Group('/')
class OrtService {
  
  @app.Route("/record", methods: const [app.GET])
  getRecord() {
    Map mapResponse = new Map();
    mapResponse["passingId"] = "1";
    mapResponse["passingNumber"] = "120";
    mapResponse["time"] = (new DateTime.now()).toString();
    
    String jsonData = JSON.encode(mapResponse);
    
    return jsonData;
  }
  
}