import 'package:get/get.dart';
import 'package:karhabti_pfe/core/constant/routes.dart';
import 'package:table_calendar/table_calendar.dart';

abstract class RendezVousController extends GetxController{
  goToRendezVous();
  goToAnnonces();
   late CalendarFormat calendarFormat;
  late DateTime focusedDay;
  DateTime? selectedDate;
}
class RendezVousControllerImp extends RendezVousController{
 
    @override
  void onInit() {
    super.onInit();
    calendarFormat = CalendarFormat.month;
    focusedDay = DateTime.now();
    selectedDate = focusedDay;
  }
  @override
  goToRendezVous() {
    Get.toNamed(AppRoute.rendezvous);
  }
  
  @override
  goToAnnonces() {
    Get.toNamed(AppRoute.annonces);
  }
void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDate = selectedDay;
    update();
  }
}
