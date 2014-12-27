import 'package:redstone/server.dart' as app;
import 'dart:convert';
import 'package:redstone/mocks.dart';
import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:OpenRaceTiming/ort_service.dart';
import 'package:OpenRaceTiming/storage/mongo_storage.dart';
import 'package:event_commander/event_commander.dart';
import 'package:redstone_mapper_mongo/manager.dart';
import 'package:redstone_mapper/plugin.dart';

main() {

  //load handlers in 'services' library
  setUp(() {
    var dbManager = new MongoDbManager("mongodb://localhost/ort", poolSize: 3);
    app.addPlugin(getMapperPlugin(dbManager));

//    app.addModule(new Module().bind());
    app.setUp([#ort]);
  });

  //remove all loaded handlers
  tearDown(() => app.tearDown());


  test("Query string", () {

  });

  test("Insert, query, delete event", () {

    var req = new MockRequest("/rest/event", method:app.POST, bodyType:app.JSON, body:JSON.decode("{\"name\":\"Lenin\"}"), contentType:"application/json");
    return app.dispatch(req).then((resp) {

      expect(resp.statusCode, equals(200), reason: "Insert failed");
      expect(resp.mockContent, contains("1.0"), reason:"Insert reqult <> 1");
      var req = new MockRequest("/rest/event", queryParams:{
          "queryString":"Lenin", "queryAttribute":"name"
      });

      return app.dispatch(req).then((resp) {
        expect(resp.statusCode, equals(200), reason:"query failed");
        expect(resp.mockContent, contains("name"), reason:"Query finding failed");
        print(resp.mockContent);
        List records = JSON.decode(resp.mockContent);

        // expect(records.length,1,reason:"Too many records in DB: ${records.length}");

        for (var one in records) {
          var id = one["_id"].split("\"")[1];
          print("To delete id:$id");

          var req = new MockRequest("/rest/event/$id", method: app.DELETE);

          app.dispatch(req).then((resp) {
            expect(resp.statusCode, equals(200), reason:"detele failed");
          });
        }

      });

    });
  });

  test("query", () {
    var req = new MockRequest("/rest/event");

    return app.dispatch(req).then((resp) {
      expect(resp.statusCode, equals(200));
      expect(resp.mockContent, contains("name"));
    });

  });

  appTearDown() => app.tearDown();
}