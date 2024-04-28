import 'package:flutter/cupertino.dart';

class MedicationPlan {
  final DateTime lastUpdate;
  final DateTime creationDate;
  final List<MedicationSchedule> medications;

  MedicationPlan({
    required this.lastUpdate,
    required this.creationDate,
    required this.medications,
  });
}

class MedicationSchedule {
  ///The medication id allows us to obtain information about it.
  final String medicationId;

  ///Indicates when to start taking the medicine
  final DateTime startDate;

  ///Indicates when the treatment ends, if the value is null it means that it is a chronic medication.
  final DateTime? endDate;

  ///Indicates the exact time at which the medicine should be taken, if applicable
  final DateTime? exactHour;

  ///If there is no exact time to take the medicine, it is indicated whether it is in the morning or in the evening,
  ///if it is in the morning, the user will be notified at 8:00 a.m. If it is in the evening, the user will be notified at 9:00 p.m.
  final TimeOfDay? timeOfDay;

  ///Number of pills to take at one time
  final double dosage;

  ///Indicate how many hours the medicine has to be taken if applicable at the frequency indicated below.
  final double? everyXHours;

  ///Indicates the frequency with which the medicine has to be taken.
  final Frequency frequency;

  ///If the frequency indicated above is ‘personified’ it is allowed to indicate how often the medicine should be taken.
  ///This includes the case of use where a person has to take pills only on Monday, Wednesday, Friday and Sunday for example.
  final int? frequencyPersonifiedInDays;

  MedicationSchedule({
    required this.medicationId,
    required this.startDate,
    this.endDate,
    this.exactHour,
    this.timeOfDay,
    required this.dosage,
    this.everyXHours,
    required this.frequency,
    this.frequencyPersonifiedInDays,
  }) {
    if (frequency == Frequency.personified && frequencyPersonifiedInDays == null) {
      throw FlutterError("You must indicate the frequencyPersonifiedInDays if the frequency is personified");
    }
  }
}

enum Frequency { monthly, weekly, daily, personified }

enum TimeOfDay { daytime, nightTime }
