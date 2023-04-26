import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../controller/technicien/homepagetechcontroller.dart';

class HomeTechPage extends StatelessWidget {
  final HomePageTechControllerImp controller = Get.put(HomePageTechControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 203, 30),
        elevation: 0.0,
        title: Center(
          child: Text(
            'Karhabti',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 0),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: Color.fromARGB(255, 255, 203, 30),
              
            ),
            child: Column(
              children: [
                Icon(
                  Icons.person_rounded,
                  size: 60,
                ),
                Text(
                  'Hello Rahma',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text("consulez vos rendez-vous",style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),textAlign: TextAlign.center,),
          TableCalendar(
              calendarStyle: CalendarStyle(
    outsideDaysVisible: false,
    todayDecoration: BoxDecoration(
      color: Color.fromARGB(255, 255, 203, 30),
      shape: BoxShape.circle,
    ),
    selectedDecoration: BoxDecoration(
      color: Color.fromARGB(255, 173, 172, 166),
      shape: BoxShape.circle,
    ),
  ),
            calendarFormat: controller.calendarFormat,
            focusedDay: controller.focusedDay,
            firstDay: DateTime(2023),
            lastDay: DateTime(2024),
            selectedDayPredicate: (day) =>
                isSameDay(day, controller.selectedDate),
            onDaySelected: (selectedDay, focusedDay) =>
                controller.onDaySelected(selectedDay, focusedDay),
          ),
        ],
      ),
    );
  }
}
