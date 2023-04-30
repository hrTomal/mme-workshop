import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/screens/fees/payment_screen.dart';
import 'package:meetingme/screens/fees/payment_screen_sdk.dart';

import '../../models/fee/fee_info.dart';
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

  Future<List<FeeInfo>> _fees = FeesService().getUserFees();
  List<DataRow> _dataRows = [];

  late List<SingleFeeInfo> selectedFees;
  late List<String> selectedFeeIds;

  @override
  void initState() {
    selectedFeeIds = [];
    super.initState();
  }

  onSelectedRow(bool selected, SingleFeeInfo fee) async {
    setState(() {
      if (selected) {
        selectedFeeIds.add(fee.id!);
      } else {
        selectedFeeIds.remove(fee.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Meeting Me - Payments'),
          backgroundColor: Color.fromRGBO(26, 55, 77, 1),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width * .2,
          height: MediaQuery.of(context).size.height * .15,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Color.fromRGBO(26, 55, 77, 1),
              onPressed: () async {
                var aamarpayUrl =
                    await FeesService().getAamarPayUrl(selectedFeeIds);
                //print(aamarpayUrl.paymentUrl);
                Navigator.pushNamed(
                  context,
                  PaymentWebView.routeName,
                  arguments: aamarpayUrl.paymentUrl,
                );
              },
              child: const FittedBox(
                child: Text('Pay Now'),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            SizedBox(
              child: FutureBuilder(
                  future: _fees,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<FeeInfo>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.inkDrop(
                          color: ConstantColors.primaryColor,
                          size: 100,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      var res = snapshot.data;
                      var fees = res!
                          .map(((e) => SingleFeeInfo(
                              id: e.id,
                              amount: e.roomFee!.fee!.amount,
                              feeMonth: e.roomFee!.feeMonth,
                              feeYear: e.roomFee!.year)))
                          .toList();

                      return SizedBox(
                        height: MediaQuery.of(context).size.height * .8,
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
                            ...fees.map(
                              (e) => DataRow(
                                  selected: selectedFeeIds.contains(e.id),
                                  onSelectChanged: (value) {
                                    onSelectedRow(value!, e);
                                  },
                                  onLongPress: () {
                                    onSelectedRow(true, e);
                                  },
                                  cells: [
                                    DataCell(Text(e.amount ?? '')),
                                    DataCell(Text(e.feeMonth ?? '')),
                                    DataCell(Text(e.feeYear.toString())),
                                  ]),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No fees assigned.'),
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
