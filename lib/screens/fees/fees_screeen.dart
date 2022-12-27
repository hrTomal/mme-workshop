import 'package:flutter/material.dart';

import '../../models/fee_info.dart';
import '../../services/fees_data_service.dart';

class Fees extends StatefulWidget {
  const Fees({super.key});

  static const routeName = '/fees';

  @override
  State<Fees> createState() => _Fees();
}

class _Fees extends State<Fees> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  final _fees = FeesService().getUserFees();
  List<DataRow> _dataRows = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Meeting Me - Payments'),
        ),
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width * .2,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {},
              child: const FittedBox(
                child: Text('Pay Now'),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            Container(
              child: FutureBuilder(
                  future: _fees,
                  builder:
                      (BuildContext context, AsyncSnapshot<FeeInfo> snapshot) {
                    if (snapshot.hasData) {
                      var res = snapshot.data!.results;
                      var test = res!
                          .map(((e) => SingleFeeInfo(
                                id: e.id,
                                amount: e.roomFee!.fee!.amount,
                                feeMonth: e.roomFee!.feeMonth,
                                feeYear: e.roomFee!.year,
                              )))
                          .toList();

                      return SizedBox(
                        height: 400,
                        child: DataTable(
                          showCheckboxColumn: true,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text('Amount'),
                            ),
                            DataColumn(
                              label: Text('Month'),
                            ),
                            DataColumn(
                              label: Text('Year'),
                            ),
                          ],
                          rows: <DataRow>[
                            ...test.map(
                              (e) => DataRow(
                                  onSelectChanged: (value) => {},
                                  cells: [
                                    DataCell(Text(e.amount ?? '')),
                                    DataCell(Text(e.feeMonth ?? '')),
                                    DataCell(Text(e.feeYear.toString())),
                                  ]),
                            )
                          ],
                        ),
                      );
                    }

                    /// While is no data show this
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ),
        // body: SizedBox(
        //   width: double.infinity,
        //   child: DataTable(
        //     columns: const <DataColumn>[
        //        DataColumn(
        //   label: Text('Amount'),
        // ),
        // DataColumn(
        //   label: Text('Month'),
        // ),
        // DataColumn(
        //   label: Text('Year'),
        // ),
        //     ],
        //     rows: List<DataRow>.generate(
        //       numItems,
        //       (int index) => DataRow(
        //         color: MaterialStateProperty.resolveWith<Color?>(
        //             (Set<MaterialState> states) {
        //           // All rows will have the same selected color.
        //           if (states.contains(MaterialState.selected)) {
        //             return Theme.of(context)
        //                 .colorScheme
        //                 .primary
        //                 .withOpacity(0.08);
        //           }
        //           // Even rows will have a grey color.
        //           if (index.isEven) {
        //             return Colors.grey.withOpacity(0.3);
        //           }
        //           return null; // Use default value for other states and odd rows.
        //         }),
        //         cells: <DataCell>[DataCell(Text('Row $index'))],
        //         selected: selected[index],
        //         onSelectChanged: (bool? value) {
        //           setState(() {
        //             selected[index] = value!;
        //           });
        //         },
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

class SingleFeeInfo {
  final String? id;
  final String? amount;
  final int? feeYear;
  final String? feeMonth;

  SingleFeeInfo(
      {required this.id,
      required this.amount,
      required this.feeYear,
      required this.feeMonth});
}
