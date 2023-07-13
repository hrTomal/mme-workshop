import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/models/workshop/workshop_list_model.dart';
import 'package:meetingme/screens/workshop/details.dart';
import 'package:meetingme/services/workshop/workshop_data_service.dart';
import 'package:meetingme/widgets/alert_image_viewer.dart';
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
      backgroundColor: ConstantColors.primaryColor,
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
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingAnimationWidget.inkDrop(
                              color: ConstantColors.primaryColor,
                              size: 100,
                            ),
                            const WhiteDivider(),
                            const Text(
                              'Loading...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      var allData = snapshot.data!.results;
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: allData.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: ConstantColors.primaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(width * .05),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: ConstantColors.primaryColor,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert_image_viewer(
                                            width: width,
                                            height: height,
                                            url: allData[index].image ??
                                                'https://www.dl.dropboxusercontent.com/s/fynems0yxeemorj/meetingme.png',
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      // color: Colors.white,
                                      margin:
                                          EdgeInsets.only(right: width * .01),
                                      width: width * .2,
                                      height: height * .15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(width * .05),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(width * .05),
                                        child: Image.network(
                                          allData[index].image ??
                                              'https://www.dl.dropboxusercontent.com/s/fynems0yxeemorj/meetingme.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * .70,
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
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                          height: height * .035,
                                          margin: EdgeInsets.symmetric(
                                            vertical: height * .01,
                                          ),
                                          child: ElevatedButton(
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
                                                      Color>(Colors.orange),
                                            ),
                                            child: const Text(
                                                'SCHEDULE & DETAILS'),
                                          ),
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
