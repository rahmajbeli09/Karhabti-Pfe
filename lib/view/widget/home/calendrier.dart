import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../controller/client/rendezvouscontroller.dart';

// ignore: must_be_immutable
class Calendrier extends StatelessWidget {
   Calendrier({Key? key}) : super(key: key);
    RendezVousControllerImp controller = Get.put(RendezVousControllerImp());


  @override
  Widget build(BuildContext context) {
    return TableCalendar(
              
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
          );
  }
}