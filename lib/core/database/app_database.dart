import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

class Transactions extends Table {
  TextColumn get transactionId => text()();
  TextColumn get reference => text().nullable()();
  RealColumn get amount => real()();
  TextColumn get currency => text()();
  TextColumn get paymentMethod => text()();
  TextColumn get providerId => text().nullable()();
  TextColumn get status => text()();
  TextColumn get correlationId => text()();
  TextColumn get traceId => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {transactionId};
}

class Providers extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  TextColumn get capabilitiesJson => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

class AuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get transactionId => text().nullable()();
  TextColumn get eventName => text()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get createdAt => dateTime()();
}

class AppDatabase {
  AppDatabase({QueryExecutor? executor})
      : executor = executor ?? driftDatabase(name: 'easypay');

  final QueryExecutor executor;
  final int schemaVersion = 1;
}
