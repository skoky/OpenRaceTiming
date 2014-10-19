import 'dart:html' as dom;
import 'package:polymer/polymer.dart';
import 'package:bwu_datagrid/datagrid/helpers.dart';
import 'package:bwu_datagrid/bwu_datagrid.dart';
import 'package:bwu_datagrid/editors/editors.dart';
import 'package:bwu_datagrid/core/core.dart';
import 'package:bwu_datagrid/plugins/cell_selection_model.dart';

@CustomTag('app-element')
class AppElement extends PolymerElement {
    AppElement.created() : super.created();

    BwuDatagrid grid;
    List<Column> columns = [
      new Column(id: 'name', name: 'Event Name', field: 'name',editor: new TextEditor()),
      new Column(id: 'date', name: 'Date', field: 'date',editor: new DateEditor(), width: 80),
      new Column(id: 'location', name: 'Location', field: 'location',editor: new TextEditor()),
    ];

    var gridOptions = new GridOptions(
        editable: true,
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
          data.items.add(new MapDataItem({
            'name': 'Event ${i}',
            'date': '2009-01-01',
            'location': 'Praha'
          }));
        }

        grid.setup(dataProvider: data, columns: columns, gridOptions: gridOptions).then((_) {
          grid.setSelectionModel = new CellSelectionModel();
          grid.onBwuAddNewRow.listen(addnewRowHandler);
        });

      } on NoSuchMethodError catch (e) {
        print('$e\n\n${e.stackTrace}');
      }  on RangeError catch (e) {
        print('$e\n\n${e.stackTrace}');
      } on TypeError catch(e) {
        print('$e\n\n${e.stackTrace}');
      } catch(e) {
        print('$e');
      }
    }

    void enableAutoEdit(dom.MouseEvent e, dynamic details, dom.HtmlElement target) {
      grid.setGridOptions = new GridOptions.unitialized()..autoEdit = true;
    }
    void disableAutoEdit(dom.MouseEvent e, dynamic details, dom.HtmlElement target) {
      grid.setGridOptions = new GridOptions.unitialized()..autoEdit = false;
    }

    void addnewRowHandler(AddNewRow e) {
      var item = e.item;
      grid.invalidateRow(data.items.length);
      data.items.add(item);
      grid.updateRowCount();
      grid.render();
    }
}