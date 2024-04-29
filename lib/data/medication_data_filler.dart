import 'package:trialing/data/database.dart';
import 'package:trialing/domain/medication.dart';
import 'package:trialing/resoruces/medication_id.dart';

class MedicationDataFiller {
  final Database database;

  MedicationDataFiller(this.database);

  fillDatabaseWithData() {
    Medication omeprazole = Medication(
      id: MedicationId.omeprazole,
      name: "omeprazole",
      description: "omeprazole_description",
      indications: "omeprazole_indications",
    );

    database.addMedication(omeprazole);

    Medication ibuprofen = Medication(
      id: MedicationId.ibuprofen,
      name: "ibuprofen",
      description: "ibuprofen_description",
    );

    database.addMedication(ibuprofen);

    Medication acetaminophen = Medication(
      id: MedicationId.acetaminophen,
      name: "acetaminophen",
      description: "acetaminophen_description",
    );

    database.addMedication(acetaminophen);

    Medication diazepam = Medication(
      id: MedicationId.diazepam,
      name: "diazepam",
      description: "diazepam_description",
      indications: "diazepam_indications",
    );

    database.addMedication(diazepam);
  }
}
