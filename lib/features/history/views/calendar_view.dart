import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/domain/event.dart';
import 'package:trialing/features/history/views/card_event_view.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/texts.dart';

class CalendarView extends StatelessWidget {
  final DateTime firstDate;
  final DateTime lastDay;
  final CalendarFormat calendarFormat;
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final Function(CalendarFormat format) onFormatChanged;
  final List<MedicationLogEvent> Function(DateTime day) getEventsForDay;
  final List<MedicationLogEvent> eventsForDay;
  final String notEvents;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  CalendarView({
    Key? key,
    required this.firstDate,
    required this.lastDay,
    this.calendarFormat = CalendarFormat.week,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.getEventsForDay,
    required this.eventsForDay,
    required this.notEvents,
    DateTime? focusedDay,
    DateTime? selectedDay,
  }) : super(key: key) {
    _focusedDay = focusedDay ?? DateTime.now();
    _selectedDay = selectedDay ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    final String currentLanguageCode = locator<LanguageService>().currentLanguageCode;
    final TextStyle tinyTextStyle = getTextStyle(paletteColors: paletteColors, type: TextTypes.tinyBody);
    final TextStyle smallTextStyle = getTextStyle(paletteColors: paletteColors, type: TextTypes.smallBody);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TableCalendar(
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: tinyTextStyle,
            weekendStyle: tinyTextStyle,
          ),
          locale: currentLanguageCode,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleTextStyle: getTextStyle(paletteColors: paletteColors),
            leftChevronIcon: Icon(
              Icons.arrow_back_ios,
              color: paletteColors.text,
              size: Dimens.iconSmall,
            ),
            rightChevronIcon: Icon(
              Icons.arrow_forward_ios,
              color: paletteColors.text,
              size: Dimens.iconSmall,
            ),
          ),
          firstDay: firstDate,
          lastDay: lastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          calendarFormat: calendarFormat,
          eventLoader: getEventsForDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            markerDecoration: BoxDecoration(
              color: paletteColors.text.withOpacity(0.7),
              borderRadius: BorderRadius.circular(Dimens.radiusLarge),
            ),
            todayDecoration: BoxDecoration(
              color: paletteColors.primary.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: paletteColors.primary,
              shape: BoxShape.circle,
            ),
            outsideDaysVisible: false,
            defaultTextStyle: smallTextStyle,
            weekendTextStyle: smallTextStyle,
            disabledTextStyle: getTextStyle(
              paletteColors: paletteColors,
              type: TextTypes.smallBody,
              color: paletteColors.textSubtitle.withOpacity(0.5),
            ),
            selectedTextStyle: getTextStyle(
              paletteColors: paletteColors,
              type: TextTypes.smallBody,
              color: paletteColors.textButton,
            ),
          ),
          onDaySelected: onDaySelected,
          onFormatChanged: onFormatChanged,
          onPageChanged: (focusedDay) => focusedDay = focusedDay,
        ),
        const SizedBox(height: Dimens.paddingLarge),
        if (eventsForDay.isEmpty)
          AppText(translate(notEvents))
        else
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: eventsForDay.length,
            itemBuilder: (context, index) {
              return CardEventView(event: eventsForDay[index]);
            },
          ),
      ],
    );
  }
}
