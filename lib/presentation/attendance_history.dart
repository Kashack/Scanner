import 'package:flutter/material.dart';
import 'package:scanner_attendance/components/my_dropdown.dart';

class Attendance extends StatelessWidget {
  List LevelList = ['--Select--', 'ND', 'HND'];
  List prgrammeType = ['--Select--', 'Part Time', 'Full Time'];
  String? Level;
  String? Program;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Attendance',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Level',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      child: MyDropdownButton(
                    itemList: LevelList,
                    callback: (value) => Level = LevelList[value],
                  ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Text('Program',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: MyDropdownButton(
                    itemList: prgrammeType,
                    callback: (value) => Program = prgrammeType[value],
                  ))
                ],
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFF203320),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  if(Level != null && Program != null){
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => AttendanceHistory(
                    //         Level: Level,
                    //         Program: Program,
                    //       ),
                    //     ));
                  }else{

                  }
                },
                child: Text('Proceed with Attendance History',
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
