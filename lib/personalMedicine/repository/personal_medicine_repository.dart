import 'package:get_it/get_it.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';

import '../../main.dart';

class PersonalMedicineRepository {

  Future<void> insertPersonalMedicine(
      PersonalMedicinesCompanion personalmedicinesCompanion) async {
    await GetIt.I<MyDatabase>().insertPersonalMedicine(personalmedicinesCompanion);
  }

  Future<void> updatePersonalMedicine(PersonalMedicine personalMedicine) async {
    await GetIt.I<MyDatabase>().updatePersonalMedicine(personalMedicine);
  }

  Future<void> deletePersonalMedicine(PersonalMedicine personalMedicine) async {
    await GetIt.I<MyDatabase>().deletePersonalMedicine(personalMedicine);
  }

  Future<List<PersonalMedicine>> getAllPersonalMedicines() async {
    return await GetIt.I<MyDatabase>().getAllPersonalMedicines();
  }
}