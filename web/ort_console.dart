import 'dart:html' as dom;
import 'package:polymer/polymer.dart';
import 'package:bwu_datagrid/datagrid/helpers.dart';
import 'package:bwu_datagrid/bwu_datagrid.dart';
import 'package:bwu_datagrid/editors/editors.dart';
import 'package:bwu_datagrid/core/core.dart';
import 'package:bwu_datagrid/plugins/cell_selection_model.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';


@CustomTag('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();


  BwuDatagrid grid;
  List<Column> columns = [
      new Column(id: 'id', name: 'Passing ID', field: 'passingId', editor: new TextEditor()),
      new Column(id: 'racerName', name: 'Racer Name', field: 'racerName', editor: new TextEditor(), width: 80),
      new Column(id: 'laps', name: 'Laps', field: 'laps', editor: new TextEditor()),
  ];

  var gridOptions = new GridOptions(
      editable: false,
      enableAddRow: true,
      enableCellNavigation: true,
      asyncEditorLoading: false,
      autoEdit: false
  );

  MapDataItemProvider data = new MapDataItemProvider();

  @override
  void attached() {
    super.attached();

    try {
      grid = $['myGrid'];


      for (var i = 0; i < 10; i++) {
        int x = i ^ 2;
        data.items.add(new MapDataItem({
            'passingId': '${i}',
            'racerName': 'Racer ${i}',
            'laps': '${x}'
        }));
      }

      new Connector().connect();

      grid.setup(dataProvider: data, columns: columns, gridOptions: gridOptions).then((_) {
        grid.setSelectionModel = new CellSelectionModel();
        grid.onBwuAddNewRow.listen(addnewRowHandler);
      });

    } on NoSuchMethodError catch (e) {
      print('$e\n\n${e.stackTrace}');
    } on RangeError catch (e) {
      print('$e\n\n${e.stackTrace}');
    } on TypeError catch (e) {
      print('$e\n\n${e.stackTrace}');
    } catch (e) {
      print('$e');
    }
  }

  void enableAutoEdit(dom.MouseEvent e, dynamic details, dom.HtmlElement target) {
    grid.setGridOptions = new GridOptions.unitialized()
      ..autoEdit = true;
  }

  void disableAutoEdit(dom.MouseEvent e, dynamic details, dom.HtmlElement target) {
    grid.setGridOptions = new GridOptions.unitialized()
      ..autoEdit = false;
  }

  void addnewRowHandler(AddNewRow e) {
    var item = e.item;
    grid.invalidateRow(data.items.length);
    data.items.add(item);
    grid.updateRowCount();
    grid.render();
  }
}


class Connector {

  static const Duration RECONNECT_DELAY = const Duration(milliseconds: 500);
  DivElement statusElement = querySelector('#status');

  void setStatus(String status) {
    statusElement.innerHtml = status;
  }


  Connector() {
    setStatus('constructor2');
  }

  bool connectPending = false;

  WebSocket webSocket;

  void connect() {
    connectPending = false;
    setStatus("connecting...");

    var url = "http://127.0.0.1:8082/record";
    var request = HttpRequest.getString(url).then(onDataLoaded);

    connectPending = false;
    setStatus("connecting...");
    webSocket = new WebSocket('ws://127.0.0.1:8083/ws');
    webSocket.onOpen.first.then((_) {
      setStatus('before connected');
      onConnected();
      webSocket.onClose.first.then((_) {
        setStatus('no connection');
        onDisconnected();
      });
    });
    webSocket.onError.first.then((_) {
      setStatus("Failed to connect to ${webSocket.url}. "
      "Run bin/server.dart and try again.");
      onDisconnected();
    });
  }


  void handleMessage(data) {
    setStatus('data received');
    var json = JSON.decode(data);
    setStatus("Json received:${json}");
  }

  void onDataLoaded(AddNewRow r) {
    setStatus(r.toString());
  }

  void onConnected() {
    setStatus('connected');
    webSocket.onMessage.listen((e) {
      handleMessage(e.data);
    });
  }

  void onDisconnected() {
    setStatus('disconnected');
    if (connectPending) return;
    connectPending = true;
    setStatus('Disconnected. Start \'bin/server.dart\' to continue.');
    new Timer(RECONNECT_DELAY, connect);
  }

}