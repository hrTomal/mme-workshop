import 'package:flutter/material.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/models/workshop/single_workshop_model.dart';
import 'package:meetingme/models/workshop/workshop_list_model.dart';
import 'package:meetingme/screens/workshop/details.dart';
import 'package:meetingme/services/workshop/workshop_data_service.dart';
import 'package:meetingme/widgets/constant_widgets.dart';
import 'package:meetingme/widgets/not_login_app_bar.dart';

class WorkshopList extends StatefulWidget {
  const WorkshopList({super.key});

  static const routeName = '/workshop_list';

  @override
  State<WorkshopList> createState() => _WorkshopListState();

  static fromJson(jsonMap) {}
}

class _WorkshopListState extends State<WorkshopList> {
  late Future<WorkshopListModel> workshops;

  @override
  void initState() {
    // TODO: implement initState
    workshops = WorkshopDataService().getAllWorkshops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Live Workshops'),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            MMEAppBarNotLoggedIn(
              scaffoldKey: _scaffoldKey,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(width * .005),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(width * .05),
                    topLeft: Radius.circular(width * .05),
                  ),
                ),
                child: FutureBuilder(
                  future: workshops,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      var allData = snapshot.data!.results;
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: allData.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              color: ConstantColors.primaryColor,
                              child: Row(
                                children: [
                                  Container(
                                    // color: Colors.white,
                                    margin: EdgeInsets.only(right: width * .01),
                                    width: width * .2,
                                    height: height * .15,
                                    child: Image.network(
                                      allData[index].image ??
                                          'https://www.dl.dropboxusercontent.com/s/fynems0yxeemorj/meetingme.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                    width: width * .75,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: width * .02),
                                          child: Text(
                                            allData[index].title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const WhiteDivider(),
                                        Text(
                                          'Instructor: ' +
                                              allData[index].instructor.name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const WhiteDivider(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * .02,
                                              vertical: width * .01),
                                          child: Text(
                                            allData[index].description,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        ElevatedButton(
                                          child:
                                              Text('VIEW SCHEDULE AND DETAILS'),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              WorkshopDetails.routeName,
                                              arguments: allData[index],
                                            );
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.orange)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: Text('Currently No Live Workshops Available'),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
