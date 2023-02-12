import 'package:flutter/material.dart';
import 'package:scanner_attendance/presentation/main_page.dart';
import 'package:scanner_attendance/presentation/qr_scan_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewAttendaceList extends StatefulWidget {
  final String courseTitle;
  final String courseCode;
  final String attendanceId;
  final String lecturerId;

  NewAttendaceList(
      {required this.courseTitle,
      required this.lecturerId,
      required this.courseCode,
      required this.attendanceId});

  @override
  State<NewAttendaceList> createState() => _NewAttendaceListState();
}

class _NewAttendaceListState extends State<NewAttendaceList> {
  final String program = 'full time';
  SharedPreferences? prefs;

  DateTime currentDate = DateTime.now();

  exitCurrent() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  initState() {
    super.initState();
    exitCurrent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.courseCode} \n ${widget.courseTitle}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        actions: [
          TextButton(
              onPressed: () async {
                await prefs!.remove('currentAttendanceId');
                await prefs!.remove('currentCourseTitle');
                await prefs!.remove('currentCourseCode');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                    (route) => false);
              },
              child: Text('Exit'))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '${currentDate.day}/${currentDate.month}/${currentDate.year}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFF203320),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QrScanPage(),
                      ));
                },
                child:
                    Text('Scan QrCode', style: TextStyle(color: Colors.white)),
              ),
              // Expanded(
              //   child: StreamBuilder(
              //     stream: _firestore
              //         .collection('lecture')
              //         .doc(_auth.currentUser!.uid)
              //         .collection('attendance')
              //         .doc(widget.attendanceId)
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasError) {
              //         return Center(child: const Text('Something went wrong'));
              //       }
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         // return Center(child: CircularProgressIndicator());
              //       }
              //       if (snapshot.connectionState == ConnectionState.none) {
              //         // return Center(child: CircularProgressIndicator());
              //       }
              //       if (snapshot.hasData && !snapshot.data!.exists) {
              //         return Container();
              //       }
              //       if (snapshot.hasData) {
              //         Map<String, dynamic> getAttendance = snapshot.data!.data() as Map<String, dynamic>;
              //         if(getAttendance.containsKey('StudentList')){
              //           List studentList = getAttendance['StudentList'];
              //           return StudentAttendanceList(studentList: studentList, firestore: _firestore);
              //         }
              //         return Center(child: Text('Attendance Yet to be taken'));
              //       }
              //       return Center(child: CircularProgressIndicator());
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

// class StudentAttendanceList extends StatelessWidget {
//   const StudentAttendanceList({
//     Key? key,
//     required this.studentList,
//     required FirebaseFirestore firestore,
//   }) : _firestore = firestore, super(key: key);
//
//   final List studentList;
//   final FirebaseFirestore _firestore;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: studentList.length,
//       itemBuilder: (context, index) {
//         return FutureBuilder(
//           future: _firestore
//               .collection('student')
//               .doc(studentList[index])
//               .get(),
//           builder: (context, newSnapshot) {
//             if (newSnapshot.hasError) {
//               return Container();
//             }
//             if (newSnapshot.connectionState ==
//                 ConnectionState.waiting) {
//               return Container();
//             }
//             if (newSnapshot.connectionState == ConnectionState.none) {
//               return Container();
//             }
//             if (!newSnapshot.data!.exists) {
//               return Container();
//             }
//             // Map<String, dynamic> studentData = newSnapshot.data!.data() as Map<String, dynamic>;
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: ListTile(
//                 tileColor: Colors.white,
//                 leading: CircleAvatar(
//                   backgroundColor: Colors.black,
//                   radius: 30,
//                   child:
//                   Icon(Icons.person, color: Colors.white, size: 40),
//                 ),
//                 title: Text(
//                   'Samuel',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 // subtitle: 'Samuel',
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
