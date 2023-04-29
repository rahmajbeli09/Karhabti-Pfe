import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

abstract class HomePageTechController extends GetxController{
 late CalendarFormat calendarFormat;
  late DateTime focusedDay;
  DateTime? selectedDate;

}
class  HomePageTechControllerImp extends  HomePageTechController{

  @override
  void onInit() {
    super.onInit();
    calendarFormat = CalendarFormat.month;
    focusedDay = DateTime.now();
    selectedDate = focusedDay;
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDate = selectedDay;
    update();
  }
}