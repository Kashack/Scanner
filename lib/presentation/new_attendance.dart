import 'package:flutter/material.dart';
import 'package:scanner_attendance/data/http_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'new_attendance_list.dart';

class NewAttendancePage extends StatefulWidget {
  String lectureId;

  NewAttendancePage(this.lectureId);

  @override
  State<NewAttendancePage> createState() => _NewAttendancePageState();
}

class _NewAttendancePageState extends State<NewAttendancePage> {
  bool visible = false;
  final HTTPApi _htppClient = HTTPApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Assign',style: TextStyle(color: Colors.black),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: _htppClient.LectureAssignCourse(widget.lectureId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.none) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: const Text('Connect To the Netwok'));
              }
              if (snapshot.hasData) {
                var data = snapshot.data['result']['courses'];
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(data[index]['courseTitle']),
                        tileColor: Colors.white,
                        subtitle: Text(data[index]['courseCode']),
                        onTap: () async{
                          String CourseCode = data[index]['courseCode'];
                          String CourseId = data[index]['courseId'];
                          await _htppClient.CreateAttendance(widget.lectureId, CourseId)
                              .then((value) async {
                            if (value['successful'] == false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(value['errorMessage'])));
                            }
                            String attendanceTitle = value['result']['title'];
                            String attendanceId = value['result']['id'];
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setString('currentAttendanceId', attendanceId);
                            await prefs.setString('currentCourseTitle', attendanceTitle);
                            await prefs.setString('currentCourseCode', CourseCode);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewAttendaceList(
                                      courseCode: CourseCode,
                                      courseTitle: attendanceTitle,
                                      attendanceId: attendanceId,
                                      lecturerId: widget.lectureId
                                  ),
                                ));
                          });
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       title: Text('Create a New Attendance'),
                          //       actions: [
                          //         TextButton(
                          //           onPressed: () {
                          //             Navigator.pop(context);
                          //           },
                          //           style: OutlinedButton.styleFrom(
                          //               shape: RoundedRectangleBorder(
                          //                   borderRadius:
                          //                   BorderRadius.circular(20))),
                          //           child: Text('Back'),
                          //         ),
                          //         TextButton(
                          //           onPressed: () async {
                          //             String CourseCode = data[index]['courseCode'];
                          //             String CourseId = data[index]['courseId'];
                          //           },
                          //           style: OutlinedButton.styleFrom(
                          //               shape:
                          //               RoundedRectangleBorder(
                          //                   borderRadius:
                          //                   BorderRadius
                          //                       .circular(
                          //                       20))),
                          //           child: Text('Confirm'),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                        },
                      ),
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
