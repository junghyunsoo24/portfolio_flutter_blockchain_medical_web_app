import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/model/alarm.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/model/symptom.dart';

part 'drift_database.g.dart';


LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
    tables: [
        Alarms, Symptoms
])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.

  Future<int> addAlarm(Alarm alarm) {
    return into(alarms).insert(alarm);
  }

  // Future<List<Alarm>> get allAlarm => select(alarms).get();
  Future<List<Alarm>> getAllAlarms() {
    return select(alarms).get();
  }

  Future delAlarm(data) {
    return delete(alarms).delete(data);
  }
  Future<void> updateAlarm(Alarm alarm) async {
    await update(alarms)
        .replace(alarm);
  }
  Future<int> insertSymptom(Symptom symptom) {
    return into(symptoms).insert(symptom);
  }

  Future<void> updateSymptom(Symptom symptom) async {
    await update(symptoms).replace(symptom);
  }

  Future<void> deleteSymptom(Symptom symptom) async {
    await delete(symptoms).delete(symptom);
  }

  Future<List<Symptom>> getAllSymptoms() async {
    return await select(symptoms).get();
  }


  @override
  int get schemaVersion => 1;

}