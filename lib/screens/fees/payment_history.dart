import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/models/fee/payment_history.dart';
import 'package:meetingme/services/fees_data_service.dart';
import 'package:meetingme/widgets/constant_widgets.dart';

class PaymentHistory extends StatefulWidget {
  PaymentHistory({super.key});

  static const routeName = '/payment-history';

  Future<PaymentHistoryModel> history = FeesService().getUserPaymentHistory();

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Me - Payment History'),
        backgroundColor: Color.fromRGBO(26, 55, 77, 1),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder(
        future: widget.history,
        builder: (BuildContext context,
            AsyncSnapshot<PaymentHistoryModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                color: ConstantColors.primaryColor,
                size: 100,
              ),
            );
          }
          if (snapshot.hasData) {
            var historyValue = snapshot.data!.results;
            return ListView.builder(
              itemCount: historyValue!.length,
              itemBuilder: (BuildContext context, int index) {
                var dueDate =
                    DateTime.parse(historyValue[index].updatedAt ?? '')
                        .toLocal();
                var dayString = dueDate.day.toString();
                var monthString = dueDate.month.toString();
                var yearString = dueDate.year.toString();
                var hourString = dueDate.hour.toString();
                var minuteString = dueDate.minute.toString();
                var secondString = dueDate.second.toString();

                return Card(
                  color: ConstantColors.widgetColor,
                  margin: EdgeInsets.symmetric(
                    horizontal: width * .04,
                    vertical: width * .01,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(width * .04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Amount: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(historyValue[index].amount ?? '',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        WhiteDivider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Paid on: '),
                            Text(
                              '$dayString-$monthString-$yearString $hourString:$minuteString:$secondString',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        //Text(historyValue[index].transaction ?? ''),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
                child: Text('No Transaction Found For this user.'));
          }

          // return LoadingAnimationWidget.inkDrop(
          //   color: ConstantColors.primaryColor,
          //   size: 100,
          // );
        },
      ),
    );
  }
}
