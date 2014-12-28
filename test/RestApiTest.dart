import 'package:redstone/server.dart' as app;
import 'dart:convert';
import 'package:redstone/mocks.dart';
import 'package:unittest/unittest.dart';
import 'package:OpenRaceTiming/ort_service.dart';  // must be used for ort service initialization
import 'package:redstone_mapper_mongo/manager.dart';
import 'package:redstone_mapper/plugin.dart';
import 'package:logging/logging.dart';


/// REST API test with mocks. MongoDB must be up to success
main() {

  //load handlers in 'services' library
  setUp(() {
    var dbManager = new MongoDbManager("mongodb://localhost/ort", poolSize: 1);
    app.addPlugin(getMapperPlugin(dbManager));
    app.setupConsoleLog(Level.WARNING);
    app.setUp([#ort]);
  });

  //remove all loaded handlers
  tearDown(() => app.tearDown());

  test("Upsert / delete / query test",() {
    var id = "123215454578782366565589";
    var name = "Putin"; // this should not be used ever
    var req = new MockRequest("/rest/event/$id", method:app.PUT, bodyType:app.JSON, body:JSON.decode("{\"name\":\"$name\"}"), contentType:"application/json");
    return app.dispatch(req).then((resp) {

      var req = new MockRequest("/rest/event/$id", method: app.DELETE);

      app.dispatch(req).then((resp) {
        expect(resp.statusCode, equals(200), reason:"detele failed");

        var req = new MockRequest("/rest/event/$id", method:app.GET);
        return app.dispatch(req).then((resp) {
            expect(resp.statusCode,equals(200));
            expect(resp.mockContent,equals('[]'));
        });
      });
    });
  });

  test("Upsert event and delete/cleanup", () {
    var id = "123215458789856256895555";
    var name = "Stalin"; // this should not be used ever

    var req = new MockRequest("/rest/event/$id", method:app.PUT, bodyType:app.JSON, body:JSON.decode("{\"name\":\"$name\"}"), contentType:"application/json");
    return app.dispatch(req).then((resp) {
      expect(resp.statusCode,equals(200),reason:"Upsert failed");

      // cleanup $name
      var req = new MockRequest("/rest/event/$id", method: app.DELETE);

      app.dispatch(req).then((resp) {
        expect(resp.statusCode, equals(200), reason:"detele failed");
      });

    });
  });

  test("Insert, query, delete event", () {
    var name = "Lenin"; // this should not be used ever

    var req = new MockRequest("/rest/event", method:app.POST, bodyType:app.JSON, body:JSON.decode("{\"name\":\"$name\"}"), contentType:"application/json");
    return app.dispatch(req).then((resp) {

      expect(resp.statusCode, equals(200), reason: "Insert failed");
      expect(resp.mockContent, contains("1.0"), reason:"Insert reqult <> 1");
      var req = new MockRequest("/rest/event", queryParams:{
          "queryString":"$name", "queryAttribute":"name"
      });

      return app.dispatch(req).then((resp) {
        expect(resp.statusCode, equals(200), reason:"query failed");
        expect(resp.mockContent, contains("name"), reason:"Query finding failed");
        List records = JSON.decode(resp.mockContent);

        for (var one in records) {
          var id = one["_id"].split("\"")[1];
//          print("To delete id:$id");

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