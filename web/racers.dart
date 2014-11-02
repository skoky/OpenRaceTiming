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

MapDataItemProvider data = new MapDataItemProvider();


@CustomTag('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  BwuDatagrid grid;
  List<Column> columns = [
      new Column(id: 'racerName', name: 'Racers name', field: 'racerName', editor: new TextEditor()),
      new Column(id: 'transponderId', name: 'Transponder ID', field: 'transponderId', editor: new TextEditor(), width: 80),
      new Column(id: 'category', name: 'Category', field: 'category', editor: new TextEditor()),
  ];

  var gridOptions = new GridOptions(
      editable: true,
      enableAddRow: true,
      enableCellNavigation: true,
      asyncEditorLoading: false,
      autoEdit: false
  );

  @override
  void attached() {
    super.attached();

    try {
      grid = $['myGrid'];

      new Connector().connect();

      grid.setup(dataProvider: data, columns: columns, gridOptions: gridOptions).then((_) {
        grid.setSelectionModel = new CellSelectionModel();
        grid.onBwuAddNewRow.listen(addnewRowHandler);
        grid.onBwuSelectedRowsChanged.listen(rowChangedHandler);
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
    print(e.item);
  }

  void rowChangedHandler(SelectedRowsChanged e) {
    print("row changed"+e.rows.toString());

  }

}


class Connector {

  static const Duration RECONNECT_DELAY = const Duration(milliseconds: 500);
  DivElement statusElement = querySelector('#status');

  Connector() {
    setStatus('constructor2');
  }

  bool connectPending = false;

  void connect() {
    connectPending = false;
    setStatus("connecting...");

    var url = "http://127.0.0.1:8082/racers";

    // call the web server asynchronously
    var request = HttpRequest.getString(url).then(onDataLoaded);
  }

  // print the raw json response text from the server
  void onDataLoaded(String responseText) {
    var jsonString = responseText;
    print(jsonString);
    setStatus(jsonString);
    List parsedList = JSON.decode(jsonString);
    data.items.add(new MapDataItem(parsedList));
  }

  void setStatus(String status) {
    statusElement.innerHtml = status;
  }

  void handleMessage(data) {
    setStatus('data received');
    var json = JSON.decode(data);
    setStatus("Json received:${json}");
  }


}