import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanner_attendance/presentation/attendance_history.dart';
import 'package:scanner_attendance/presentation/new_attendance.dart';
import 'package:scanner_attendance/presentation/new_attendance_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? currentAttendanceId;
  String? currentCourseTitle;
  String? currentCourseCode;
  String? lectureId;
  final ImagePicker _picker = ImagePicker();

  getCurrent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentAttendanceId = prefs.getString('currentAttendanceId');
    lectureId = prefs.getString('lectureId');
    currentCourseTitle = prefs.getString('currentCourseTitle');
    currentCourseCode = prefs.getString('currentCourseCode');
  }

  @override
  initState() {
    super.initState();
    getCurrent();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xFF203320),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(100),
                )),
            child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: FutureBuilder(
                    future: null,
                    builder: (context, snapshot) {
                      return Row(
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 80,
                              width: 80,
                              margin: EdgeInsets.all(16),
                              child: Icon(Icons.person,
                                  color: Colors.white, size: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                            )
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi,',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Mr Ogundele',
                                // snapshot.data!.get('Full Name'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                'Lecturer',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Quick Actions',
              style: TextStyle(
                color: Color(0xFF006600),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    currentAttendanceId == null
                        ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewAttendancePage(lectureId!),
                      ),
                    )
                        : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewAttendaceList(
                          courseTitle: currentCourseTitle!,
                          courseCode: currentCourseCode!,
                          attendanceId: currentAttendanceId!,
                          lecturerId: lectureId!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset('assets/icons/scan.svg'),
                        ),
                        Text(
                          'New Attendance',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset('assets/icons/note.svg'),
                        ),
                        Text(
                          'Attendance History',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Attendance(),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}
