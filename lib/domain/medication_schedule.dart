import 'package:flutter/material.dart';
import 'package:trialing/domain/pill_taken_hour.dart';

class MedicationPlan {
  late DateTime lastUpdate;
  final DateTime creationDate;
  late List<MedicationSchedule> medications;

  MedicationPlan({
    DateTime? lastUpdate,
    required this.creationDate,
    List<MedicationSchedule>? medications,
  }) {
    if (lastUpdate == null) {
      this.lastUpdate = creationDate;
    }
    if (medications == null) {
      this.medications = [];
    }
  }

  MedicationPlan copyWith({required List<MedicationSchedule> medications}) {
    return MedicationPlan(
      lastUpdate: DateTime.now(),
      creationDate: creationDate,
      medications: medications,
    );
  }
}

class MedicationSchedule {
  ///The medication id allows us to obtain information about it.
  final String medicationId;

  ///Indicates when to start taking the medicine
  final DateTime startDate;

  ///Indicates when the treatment ends, if the value is null it means that it is a chronic medication.
  final DateTime? endDate;

  ///This is the list of times when the patient should take the medication.
  ///For example, one before breakfast and one before bedtime.
  final List<TimeOfTheDay> timesOfTheDay;

  ///Number of pills to take at one time, if you need different dosage you can create another schedule
  final double dosage;

  ///Indicates the frequency with which the medicine has to be taken.
  final Frequency frequency;

  ///If the frequency indicated above is ‘personified’ it is allowed to indicate how often the medicine should be taken.
  ///This includes the case of use where a person has to take pills only on Monday, Wednesday and Friday for example.
  final List<WeekDays>? frequencyPersonifiedInDays;

  final String? extraIndications;

  MedicationSchedule({
    required this.medicationId,
    required this.startDate,
    this.endDate,
    required this.timesOfTheDay,
    required this.dosage,
    required this.frequency,
    this.frequencyPersonifiedInDays,
    this.extraIndications,
  }) {
    if (frequency == Frequency.personified && frequencyPersonifiedInDays == null) {
      throw FlutterError("You must indicate the frequencyPersonifiedInDays if the frequency is personified");
    }
  }
}

enum WeekDays {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

enum Frequency { monthly, weekly, daily, personified }
