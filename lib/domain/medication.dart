import 'package:trialing/domain/simple_text.dart';

class Medication {
  final String id;
  final String name;
  final String description;
  final SimpleText? prospectus;
  final String? indications;

  Medication({
    required this.id,
    required this.name,
    required this.description,
    this.prospectus,
    this.indications,
  });
}
