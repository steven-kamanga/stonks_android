import 'package:flutter/material.dart';
import '../models/trade_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TradeDetailsPage extends StatelessWidget {
  final Trade trade;

  const TradeDetailsPage({super.key, required this.trade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SfDataGrid(
          source: TradeDetailsDataSource(trade),
          columns: <GridColumn>[
            GridColumn(columnName: 'Price', label: const Text('Price')),
            GridColumn(columnName: 'Quantity', label: const Text('Quantity')),
            GridColumn(columnName: 'Date', label: const Text('Date')),
            GridColumn(columnName: 'Time', label: const Text('Time')),
          ],
        ),
      ),
    );
  }
}

class TradeDetailsDataSource extends DataGridSource {
  TradeDetailsDataSource(this.trade);

  final Trade trade;

  @override
  List<DataGridRow> get rows => <DataGridRow>[
        DataGridRow(cells: <DataGridCell>[
          DataGridCell<String>(
              columnName: 'Price', value: trade.price.toString()),
          DataGridCell<String>(
              columnName: 'Quantity', value: trade.quantity.toString()),
          DataGridCell<String>(columnName: 'Date', value: trade.date),
          DataGridCell<String>(columnName: 'Time', value: trade.time),
        ]),
      ];

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((dataGridCell) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(right: 2.0),
          child: Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }
}
