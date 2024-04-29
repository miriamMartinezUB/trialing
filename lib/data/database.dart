import 'package:flutter/widgets.dart';
import 'package:trialing/data/medication_data_filler.dart';
import 'package:trialing/data/medication_schedule_data_filler.dart';
import 'package:trialing/domain/medication.dart';
import 'package:trialing/domain/medication_schedule.dart';

class Database {
  final Map<String, Medication> _medications = {};
  final MedicationPlan _medicationPlan = MedicationPlan(creationDate: DateTime.now());

  Database() {
    MedicationDataFiller(this).fillDatabaseWithData();
    MedicationScheduleDataFiller(this).fillDatabaseWithData();
  }

  void addMedication(Medication medication) {
    _medications[medication.id] = medication;
  }

  Medication getMedicationById(String medicationId) {
    if (_medications.containsKey(medicationId)) {
      return _medications[medicationId]!;
    }
    throw FlutterError('Not activity for id: $medicationId');
  }

  void addMedicationSchedule(MedicationSchedule medicationSchedule) {
    List<MedicationSchedule> medications = _medicationPlan.medications;
    medications.add(medicationSchedule);
    _medicationPlan.copyWith(medications: medications);
  }

  void get medicationPlan => _medicationPlan;

  List<Medication> get medications => _medications.values.toList();
}
