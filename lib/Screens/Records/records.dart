// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:syncfusion_flutter_datagrid_export/export.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';

// class Records extends StatefulWidget {
//   const Records({super.key});

//   @override
//   State<Records> createState() => _RecordsState();
// }

// class _RecordsState extends State<Records> {

//   final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

//     void exportDataGridToExcel()async {
//     final xlsio.Workbook workbook = _key.currentState!.exportToExcelWorkbook();
//     final List<int> bytes = workbook.saveAsStream();
//     workbook.dispose();

//     final String path = (await getApplicationSupportDirectory()).path;
//     final String fileName = '$path/Record.xlsx';
//     final File file = File(fileName);
//     await file.writeAsBytes(bytes);
    
//   }

//     void exportDataGridToPdf() async {
//     final PdfDocument document =
//         _key.currentState!.exportToPdfDocument();

//     final List<int> bytes = await document.save();
//     File('DataGrid.pdf').writeAsBytes(bytes);
//     document.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Syncfusion Flutter DataGrid Export',
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             margin: const EdgeInsets.all(12.0),
//             child: Row(
//               children: <Widget>[
//                 SizedBox(
//                   height: 40.0,
//                   width: 150.0,
//                   child: MaterialButton(
//                       color: Colors.blue,
//                       onPressed: exportDataGridToExcel,
//                       child: const Center(
//                           child: Text(
//                         'Show in Excel',
//                         style: TextStyle(color: Colors.white),
//                       ))),
//                 ),
//                 const Padding(padding: EdgeInsets.all(20)),
//                 SizedBox(
//                   height: 40.0,
//                   width: 150.0,
//                   child: MaterialButton(
//                       color: Colors.blue,
//                       onPressed: exportDataGridToPdf,
//                       child: const Center(
//                           child: Text(
//                         'Export to PDF',
//                         style: TextStyle(color: Colors.white),
//                       ))),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SfDataGrid(
//               key: _key,
//               source: employeeDataSource,
//               columns: <GridColumn>[
//                 GridColumn(
//                     columnName: 'ID',
//                     label: Container(
//                         padding: const EdgeInsets.all(16.0),
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'ID',
//                         ))),
//                 GridColumn(
//                     columnName: 'Name',
//                     label: Container(
//                         padding: const EdgeInsets.all(8.0),
//                         alignment: Alignment.center,
//                         child: const Text('Name'))),
//                 GridColumn(
//                     columnName: 'Designation',
//                     label: Container(
//                         padding: const EdgeInsets.all(8.0),
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'Designation',
//                           overflow: TextOverflow.ellipsis,
//                         ))),
//                 GridColumn(
//                     columnName: 'Salary',
//                     label: Container(
//                         padding: const EdgeInsets.all(8.0),
//                         alignment: Alignment.center,
//                         child: const Text('Salary'))),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }