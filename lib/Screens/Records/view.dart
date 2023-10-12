import 'package:flutter/material.dart';

class ViewTable extends StatefulWidget {

  final Map<String, Map<String, dynamic>> history;
  const ViewTable({
      super.key,
      required this.history,
  });

  @override
  State<ViewTable> createState() => _ViewTableState();
}

class _ViewTableState extends State<ViewTable> {

  void getDataRow(List dr, Map<String, Map<String, dynamic>> history){
  history.forEach((key, value) {
    // print(value[1]['payment_amount']);
    dr.add(DataRow(
      cells: <DataCell>[
        DataCell(Text(key.split('-').reversed.join('-'))),
        DataCell(Text(value['payment_amount'].toString())),
        DataCell(Text(value['payment_mode'])),
      ],
    ));
  });
}

  @override
  Widget build(BuildContext context) {
    List<DataRow> dr = <DataRow>[];
    getDataRow(dr, widget.history);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: DataTable(
            columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Date',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Amount',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Mode',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            ], 
            rows: dr
            ),
          ),
        ),
      ),
    );
  }
}