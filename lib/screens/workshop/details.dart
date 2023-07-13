import 'package:flutter/material.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/models/workshop/workshop_list_model.dart';
import 'package:meetingme/screens/fees/payment_screen.dart';
import 'package:meetingme/screens/workshop/wp_Details.dart';
import 'package:meetingme/services/common/CommonDateFormatter.dart';
import 'package:meetingme/services/common/show_toast.dart';
import 'package:meetingme/services/workshop/workshop_data_service.dart';
import 'package:meetingme/widgets/constant_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WorkshopDetails extends StatefulWidget {
  const WorkshopDetails({
    super.key,
    required this.singleWorkhopModel,
  });

  final Results singleWorkhopModel;

  static const routeName = '/workshop_details';

  @override
  State<WorkshopDetails> createState() => _WorkshopDetailsState();
}

class _WorkshopDetailsState extends State<WorkshopDetails> {
  late final WebViewController _controller;
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String? selectedId;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var rooms = widget.singleWorkhopModel.batchRooms;

    var discountPercantage = widget.singleWorkhopModel.charge! /
        widget.singleWorkhopModel.chargeBefore! *
        100;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workshop Details"),
        backgroundColor: ConstantColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            rooms == null
                ? Container()
                : Container(
                    height: height * .05,
                    width: width * 1,
                    margin: EdgeInsets.symmetric(
                      vertical: height * .02,
                      horizontal: width * .1,
                    ),
                    decoration: BoxDecoration(
                      color: ConstantColors.widgetColor,
                      borderRadius: BorderRadius.circular(
                        width * .03,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Choose your Flexible Time',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            rooms == null
                ? Container()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: rooms!.length,
                    itemBuilder: (context, int index) {
                      return RadioListTile(
                        title: Card(
                          child: Padding(
                            padding: EdgeInsets.all(width * .02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  CommonDateFormatter.getMonthandDate(
                                      rooms[index].startDate ?? ''),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${CommonDateFormatter.get12hr(rooms[index].startTime ?? '')} - ${CommonDateFormatter.get12hr(rooms[index].endTime ?? '')}',
                                    ),
                                    Text(
                                      rooms[index].days ?? '',
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        value: widget.singleWorkhopModel.batchRooms![index].id,
                        groupValue: selectedId,
                        onChanged: (val) {
                          setState(() {
                            selectedId = val;
                          });
                        },
                      );
                    },
                  ),
            WhiteDivider(),
            rooms == null
                ? Container()
                : Container(
                    padding: EdgeInsets.symmetric(vertical: height * .003),
                    margin: EdgeInsets.symmetric(horizontal: width * .05),
                    decoration: BoxDecoration(
                      color: ConstantColors.widgetColor,
                      borderRadius: BorderRadius.circular(
                        width * .03,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          child: const Text('Enroll Now'),
                          onPressed: () {
                            print(selectedId);
                            if (selectedId == null) {
                              ShowToast.ShowErrorToast(
                                  'Please Select Your Time.');
                            } else {
                              CreateTempUser(
                                  context,
                                  selectedId,
                                  calculateCharge(
                                      widget.singleWorkhopModel.charge));
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange)),
                        ),
                        Column(
                          children: [
                            Text(
                              '\u09F3${widget.singleWorkhopModel.charge}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * .06,
                                  color: Colors.amber),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${discountPercantage.toInt()}% off',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * .04,
                                      color: Colors.green),
                                ),
                                VerticalDivider(
                                  width: width * .02,
                                ),
                                Text(
                                  '\u09F3${widget.singleWorkhopModel.chargeBefore}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: width * .04),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * .03),
              child: Row(
                children: [
                  Container(
                    height: height * .1,
                    width: height * .1,
                    margin: EdgeInsets.symmetric(
                        vertical: height * .02, horizontal: width * .02),
                    child: ClipOval(
                      child: Image.network(
                        widget.singleWorkhopModel.instructor!.photo ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: width * .68,
                    child: Column(
                      children: [
                        Text(
                          widget.singleWorkhopModel.instructor!.name ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        WhiteDivider(),
                        Text(
                          widget.singleWorkhopModel.instructor!.designation ??
                              '',
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: height * .02, horizontal: width * .03),
              margin: EdgeInsets.symmetric(horizontal: width * .05),
              decoration: BoxDecoration(
                color: ConstantColors.widgetColor,
                borderRadius: BorderRadius.circular(
                  width * .03,
                ),
              ),
              child: Text(
                widget.singleWorkhopModel.description ?? '',
                textAlign: TextAlign.justify,
                style: TextStyle(),
              ),
            ),
            ElevatedButton(
              child: const Text('More Details'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  WPDetails.routeName,
                  arguments: widget.singleWorkhopModel.wpUrl,
                );
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      ConstantColors.primaryColor)),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> CreateTempUser(
      BuildContext context, String? _selectedId, charge) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(hintText: 'First Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email address';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _phoneController,
                    maxLength: 11,
                    decoration: const InputDecoration(hintText: 'Phone'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                        return 'Please enter a valid 11-digit phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      ElevatedButton(
                        child: const Text('Pay'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final firstName = _firstNameController.text;
                            final lastName = _lastNameController.text;
                            final email = _emailController.text;
                            final phone = _phoneController.text;

                            WorkshopDataService()
                                .CreateTempUser(firstName, lastName, email,
                                    phone, _selectedId)
                                .then((value) => {
                                      Navigator.pushNamed(
                                          context, PaymentWebView.routeName,
                                          arguments: value //payment url
                                          //charge, //temporary passed charge throug url string
                                          )
                                    });
                            // Close the dialog
                            // Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  String calculateCharge(charge) {
    var res = charge + (charge * 1.5 / 100);
    return res.toString();
  }
}
