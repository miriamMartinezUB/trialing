import 'package:trialing/data/database.dart';
import 'package:trialing/domain/medication_schedule.dart';
import 'package:trialing/domain/pill_taken_hour.dart';
import 'package:trialing/resoruces/medication_id.dart';

class MedicationScheduleDataFiller {
  final Database database;

  MedicationScheduleDataFiller(this.database);

  fillDatabaseWithData() {
    MedicationSchedule omeprazole = MedicationSchedule(
      medicationId: MedicationId.omeprazole,
      startDate: DateTime(2024, 4, 1),
      timesOfTheDay: [TimeOfTheDay.lunchTime, TimeOfTheDay.dinner],
      dosage: 1,
      frequency: Frequency.daily,
    );

    database.addMedicationSchedule(omeprazole);

    MedicationSchedule ibuprofen = MedicationSchedule(
      medicationId: MedicationId.ibuprofen,
      startDate: DateTime(2024, 4, 1),
      endDate: DateTime(2024, 5, 5),
      timesOfTheDay: [TimeOfTheDay.breakfast, TimeOfTheDay.snack, TimeOfTheDay.beforeBedTime],
      dosage: 1,
      frequency: Frequency.weekly,
    );

    database.addMedicationSchedule(ibuprofen);

    MedicationSchedule acetaminophen = MedicationSchedule(
      medicationId: MedicationId.acetaminophen,
      startDate: DateTime(2024, 4, 1),
      timesOfTheDay: [TimeOfTheDay.lunchTime, TimeOfTheDay.dinner],
      dosage: 1,
      frequency: Frequency.personified,
      frequencyPersonifiedInDays: [WeekDays.monday, WeekDays.wednesday, WeekDays.friday],
    );

    database.addMedicationSchedule(acetaminophen);

    MedicationSchedule diazepam = MedicationSchedule(
      medicationId: MedicationId.diazepam,
      startDate: DateTime(2024, 4, 1),
      timesOfTheDay: [TimeOfTheDay.beforeBedTime],
      dosage: 1,
      frequency: Frequency.daily,
    );

    database.addMedicationSchedule(diazepam);
  }
}
