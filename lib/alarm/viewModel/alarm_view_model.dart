import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/alarm/repository/alarm_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/database/drift_database.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/medication/repository/prescription_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/personalMedicine/repository/personal_medicine_repository.dart';
import 'package:portfolio_flutter_blockchain_medical_web_app/symptom/repository/symptom_repository.dart';

class AlarmViewModel extends ChangeNotifier {
  final ValueNotifier<List<Alarm>> _alarm = ValueNotifier<List<Alarm>>([]);

  final _repository = AlarmRepository();
  Alarm? _currentAlarm;
  final MyDatabase _database;
  AlarmViewModel(this._database);

  void updateAlarm(Alarm alarm) {
    _currentAlarm = alarm;
    notifyListeners();
  }

  ValueNotifier<List<Alarm>> get alarm => _alarm;

  Future<void> loadAlarms() async {
    final alarmList = await getAlarms();
    _alarm.value = alarmList;
  }
  Future<int> saveAlarm(String medicationName, String dosage, DateTime time, bool isEnabled) async {
    final id = await _database.insertAlarm(AlarmsCompanion(
      medicationName: Value(medicationName),
      dosage: Value(dosage),
      time: Value(time),
      isEnabled: Value(isEnabled),
    ));
    loadAlarms();
    return id.toInt(); // 반환된 ID를 int로 변환하여 반환
  }

  // Future<void> saveAlarm(String medicationName, String dosage, DateTime time, bool isEnabled,
  //     ) async {
  //   await _database.insertAlarm(AlarmsCompanion(
  //       medicationName: Value(medicationName),
  //       dosage : Value(dosage),
  //       time: Value(time),
  //       isEnabled: Value(isEnabled),
  //       // takeTime: takeTime != null ? Value(takeTime) : const Value.absent(),
  //   ));
  //   loadAlarms();
  //
  // }
  Future<List<Alarm>> getAlarms() async {
    return await _repository.getAllAlarms();
  }
  Future<void> confirmTakeMedication(Alarm alarm) async {
    final updatedAlarm = alarm.copyWith(
      takeTime: Value(DateTime.now()),
    );
    await _database.updateAlarm(updatedAlarm);
    notifyListeners();
  }
  Future<void> deleteAlarm(Alarm alarm) async {
    try {
      await _repository.deleteAlarm(alarm);
    } catch (e) {
      rethrow;
    }
  }
}