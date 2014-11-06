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

  @app.Route("/racers", methods: const [app.GET])
  getRacers() {
    Map mapResponse = new Map();
    mapResponse["racerName"] = "Michal";
    mapResponse["transponderId"] = "123344";
    mapResponse["category"] = "Beginner";

    String jsonData = JSON.encode(mapResponse);

    return jsonData;
  }

  @app.Route("/modules/all", methods: const [app.GET])
  getAllModules() {
    Map mapResponse = new Map();

    String jsonData = JSON.encode(mapResponse);

    return jsonData;
  }
  
}