import 'package:headache_app/persistence/dailyRecord/DailyRecord.dart';

class DailyRecordDb {
  final Map<int, Map<String, dynamic>> _records = {};

  Future<DailyRecord> save(DailyRecord dailyRecord) async {
    final record = dailyRecord.toMap();
    _records[dailyRecord.date] = record;
    return Future<DailyRecord>.value(DailyRecord.fromMap(record));
  }

  Future<DailyRecord?> findOneByDate(int date) async {
    final record = _records[date];
    if (record == null) {
      return Future<DailyRecord?>.value(null);
    }
    return Future<DailyRecord?>.value(DailyRecord.fromMap(record));
  }
}