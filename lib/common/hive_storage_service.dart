import 'package:hive_flutter/hive_flutter.dart';
import 'package:trialing/resoruces/storage_box_name.dart';

class HiveStorageService {
  late Box<String> _boxTakenMedications;
  late Box<String> _boxLog;

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(StorageBoxName.takenMedications);
    await Hive.openBox<String>(StorageBoxName.logMedications);
    _boxTakenMedications = Hive.box(StorageBoxName.takenMedications);
    _boxLog = Hive.box(StorageBoxName.logMedications);
  }

  Box<String> get takenMedicationsBox => _boxTakenMedications;

  Box<String> get logBox => _boxLog;
}
