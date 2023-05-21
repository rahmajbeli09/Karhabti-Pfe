import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendrier extends StatelessWidget {
  final EventController _eventController = Get.put(EventController());

  bool isSameDay(DateTime dayA, DateTime dayB) {
    return dayA.year == dayB.year && dayA.month == dayB.month && dayA.day == dayB.day;
  }

  bool hasEvents(DateTime day) {
    final eventController = Get.find<EventController>();
    final events = eventController.events;
    return events.any((event) =>
        event.date.year == day.year && event.date.month == day.month && event.date.day == day.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          'Consulter vos rendez-vous',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white.withAlpha(0),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset("assets/images/rendez-vous.png"),
                ),
                Text(
                  "Mes \n Rendez-Vous",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: "Comfortaa",
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            Expanded(
              child: TableCalendar<Event>(
                availableGestures: AvailableGestures.all,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _eventController.selectedDate.value,
                onDaySelected: (selectedDay, focusedDay) {
                  Get.defaultDialog(
                    titlePadding: EdgeInsets.only(top: 20),
                    title: "Mes rendez-vous dans ${DateFormat('dd/MM/yyyy').format(selectedDay)}",
                    titleStyle: TextStyle(
                      fontFamily: "Comfortaa",
                      fontWeight: FontWeight.w700
                    ),
                    content: Expanded(
                      child: Obx(() {
                        final selectedEvents = _eventController.selectedEvents;
                        return ListView.builder(
                          itemCount: selectedEvents.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ListTile(
                                title: Text(selectedEvents[index].title , style: TextStyle( fontFamily: "Comfortaa", fontWeight: FontWeight.w600),),
                                subtitle: Text(selectedEvents[index].description, style: TextStyle( fontFamily: "Comfortaa", fontWeight: FontWeight.w500),),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  );
                  _eventController.onDaySelected(selectedDay, focusedDay);
                },
                onRangeSelected: (start, end, focusedDay) {
                  _eventController.onRangeSelected(start!, end!, focusedDay);
                },
                selectedDayPredicate: (day) {
                  final selectedDateTime = DateTime(
                    _eventController.selectedDate.value.year,
                    _eventController.selectedDate.value.month,
                    _eventController.selectedDate.value.day,
                  );
                  return isSameDay(day, selectedDateTime);
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.red, 
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  formatButtonShowsNext: true,
                ),
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Mois',
                },
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, events) {
                    final hasEvents = _eventController.hasEvents(date);
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: hasEvents ? Colors.white : null,
                        shape: BoxShape.circle,
                        border: hasEvents ? Border.all(color: Colors.black) : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${date.day}',
                            style: TextStyle(
                              color: hasEvents ? Colors.black : Color.fromARGB(255, 116, 104, 104),
                            ),
                          ),
                          if (hasEvents)
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                  selectedBuilder: (context, date, events) {
                    final hasEvents = _eventController.hasEvents(date);
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 87, 164, 199), 
                        shape: BoxShape.circle,
                        border: hasEvents ? Border.all(color: Colors.black) : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${date.day}',
                            style: TextStyle(
                              color: hasEvents ? Colors.black : Colors.white,
                            ),
                          ),
                          if (hasEvents)
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Boutton(
              onPressed: () {
                Get.to(AddEventPage());
              },
              color: Colors.amber,
              text: "Ajouter un événement",
            ),
          ],
        ),
      ),
    );
  }
}

class AddEventPage extends StatelessWidget {
  final EventController _eventController = Get.find();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          'Ajouter un événement',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white.withAlpha(0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                Image.asset("assets/images/image22.png"),
                Container(
                 padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Color.fromARGB(255, 159, 153, 153),
                    ),
                  ),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: '  Titre..',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Color.fromARGB(255, 159, 153, 153),
                    ),
                  ),
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: '  Description..',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Boutton(
                  text: "Ajouter",
                  color: Colors.amber,
                  onPressed: () {
                    _eventController.addEvent(
                      Event(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        date: _eventController.selectedDate.value,
                      ),
                    );
                    Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final String description;
  final DateTime date;

  Event({
    required this.title,
    required this.description,
    required this.date,
  });
}

class EventController extends GetxController {
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final events = <Event>[].obs;

  List<Event> get selectedEvents =>
      events.where((event) => isSameDay(event.date, selectedDate.value)).toList();

  bool hasEvents(DateTime day) {
    return events.any((event) => isSameDay(event.date, day));
  }

  bool isSameDay(DateTime dayA, DateTime dayB) {
    final dateFormatter = DateFormat('yyyy-MM-dd');
    return dateFormatter.format(dayA) == dateFormatter.format(dayB);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDate.value = selectedDay;
  }

  void onRangeSelected(DateTime start, DateTime end, DateTime focusedDay) {
    final selectedDays = _getDaysInRange(start, end);
    selectedDate.value = focusedDay;
    events.addAll(selectedDays);
  }

  List<Event> _getDaysInRange(DateTime start, DateTime end) {
    final days = <Event>[];
    for (var i = 0; i <= end.difference(start).inDays; i++) {
      final day = start.add(Duration(days: i));
      days.add(
        Event(
          title: 'Rendez-vous',
          description: 'Description du rendez-vous',
          date: day,
        ),
      );
    }
    return days;
  }

  void addEvent(Event event) {
    events.add(event);
  }
}

class CalendarController extends GetxController {
  final focusedDate = DateTime.now().obs;

  void onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    focusedDate.value = first;
  }
}

class Boutton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String text;

  Boutton({required this.onPressed, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              fontFamily: "Comfortaa"
            ),
          ),
        ),
      ),
    );
  }
}