// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ClientDBTable extends ClientDB
    with TableInfo<$ClientDBTable, ClientDBData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientDBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _identificationNumberMeta =
      const VerificationMeta('identificationNumber');
  @override
  late final GeneratedColumn<String> identificationNumber =
      GeneratedColumn<String>(
        'identification_number',
        aliasedName,
        true,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 11,
          maxTextLength: 11,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 8,
      maxTextLength: 8,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    identificationNumber,
    phoneNumber,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'client_d_b';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClientDBData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('identification_number')) {
      context.handle(
        _identificationNumberMeta,
        identificationNumber.isAcceptableOrUnknown(
          data['identification_number']!,
          _identificationNumberMeta,
        ),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClientDBData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientDBData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      identificationNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}identification_number'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
    );
  }

  @override
  $ClientDBTable createAlias(String alias) {
    return $ClientDBTable(attachedDatabase, alias);
  }
}

class ClientDBData extends DataClass implements Insertable<ClientDBData> {
  final int id;
  final String name;
  final String? identificationNumber;
  final String? phoneNumber;
  const ClientDBData({
    required this.id,
    required this.name,
    this.identificationNumber,
    this.phoneNumber,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || identificationNumber != null) {
      map['identification_number'] = Variable<String>(identificationNumber);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    return map;
  }

  ClientDBCompanion toCompanion(bool nullToAbsent) {
    return ClientDBCompanion(
      id: Value(id),
      name: Value(name),
      identificationNumber: identificationNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(identificationNumber),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
    );
  }

  factory ClientDBData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientDBData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      identificationNumber: serializer.fromJson<String?>(
        json['identificationNumber'],
      ),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'identificationNumber': serializer.toJson<String?>(identificationNumber),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
    };
  }

  ClientDBData copyWith({
    int? id,
    String? name,
    Value<String?> identificationNumber = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
  }) => ClientDBData(
    id: id ?? this.id,
    name: name ?? this.name,
    identificationNumber: identificationNumber.present
        ? identificationNumber.value
        : this.identificationNumber,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
  );
  ClientDBData copyWithCompanion(ClientDBCompanion data) {
    return ClientDBData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      identificationNumber: data.identificationNumber.present
          ? data.identificationNumber.value
          : this.identificationNumber,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientDBData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('identificationNumber: $identificationNumber, ')
          ..write('phoneNumber: $phoneNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, identificationNumber, phoneNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientDBData &&
          other.id == this.id &&
          other.name == this.name &&
          other.identificationNumber == this.identificationNumber &&
          other.phoneNumber == this.phoneNumber);
}

class ClientDBCompanion extends UpdateCompanion<ClientDBData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> identificationNumber;
  final Value<String?> phoneNumber;
  const ClientDBCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.identificationNumber = const Value.absent(),
    this.phoneNumber = const Value.absent(),
  });
  ClientDBCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.identificationNumber = const Value.absent(),
    this.phoneNumber = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ClientDBData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? identificationNumber,
    Expression<String>? phoneNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (identificationNumber != null)
        'identification_number': identificationNumber,
      if (phoneNumber != null) 'phone_number': phoneNumber,
    });
  }

  ClientDBCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? identificationNumber,
    Value<String?>? phoneNumber,
  }) {
    return ClientDBCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      identificationNumber: identificationNumber ?? this.identificationNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (identificationNumber.present) {
      map['identification_number'] = Variable<String>(
        identificationNumber.value,
      );
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientDBCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('identificationNumber: $identificationNumber, ')
          ..write('phoneNumber: $phoneNumber')
          ..write(')'))
        .toString();
  }
}

class $PaymentDBTable extends PaymentDB
    with TableInfo<$PaymentDBTable, PaymentDBData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentDBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES client_d_b (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _expirationDateMeta = const VerificationMeta(
    'expirationDate',
  );
  @override
  late final GeneratedColumn<DateTime> expirationDate =
      GeneratedColumn<DateTime>(
        'expiration_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [id, clientId, date, expirationDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_d_b';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentDBData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('expiration_date')) {
      context.handle(
        _expirationDateMeta,
        expirationDate.isAcceptableOrUnknown(
          data['expiration_date']!,
          _expirationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expirationDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentDBData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentDBData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      expirationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiration_date'],
      )!,
    );
  }

  @override
  $PaymentDBTable createAlias(String alias) {
    return $PaymentDBTable(attachedDatabase, alias);
  }
}

class PaymentDBData extends DataClass implements Insertable<PaymentDBData> {
  final int id;
  final int clientId;
  final DateTime date;
  final DateTime expirationDate;
  const PaymentDBData({
    required this.id,
    required this.clientId,
    required this.date,
    required this.expirationDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<int>(clientId);
    map['date'] = Variable<DateTime>(date);
    map['expiration_date'] = Variable<DateTime>(expirationDate);
    return map;
  }

  PaymentDBCompanion toCompanion(bool nullToAbsent) {
    return PaymentDBCompanion(
      id: Value(id),
      clientId: Value(clientId),
      date: Value(date),
      expirationDate: Value(expirationDate),
    );
  }

  factory PaymentDBData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentDBData(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int>(json['clientId']),
      date: serializer.fromJson<DateTime>(json['date']),
      expirationDate: serializer.fromJson<DateTime>(json['expirationDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int>(clientId),
      'date': serializer.toJson<DateTime>(date),
      'expirationDate': serializer.toJson<DateTime>(expirationDate),
    };
  }

  PaymentDBData copyWith({
    int? id,
    int? clientId,
    DateTime? date,
    DateTime? expirationDate,
  }) => PaymentDBData(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    date: date ?? this.date,
    expirationDate: expirationDate ?? this.expirationDate,
  );
  PaymentDBData copyWithCompanion(PaymentDBCompanion data) {
    return PaymentDBData(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      date: data.date.present ? data.date.value : this.date,
      expirationDate: data.expirationDate.present
          ? data.expirationDate.value
          : this.expirationDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentDBData(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('date: $date, ')
          ..write('expirationDate: $expirationDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clientId, date, expirationDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentDBData &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.date == this.date &&
          other.expirationDate == this.expirationDate);
}

class PaymentDBCompanion extends UpdateCompanion<PaymentDBData> {
  final Value<int> id;
  final Value<int> clientId;
  final Value<DateTime> date;
  final Value<DateTime> expirationDate;
  const PaymentDBCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.date = const Value.absent(),
    this.expirationDate = const Value.absent(),
  });
  PaymentDBCompanion.insert({
    this.id = const Value.absent(),
    required int clientId,
    this.date = const Value.absent(),
    required DateTime expirationDate,
  }) : clientId = Value(clientId),
       expirationDate = Value(expirationDate);
  static Insertable<PaymentDBData> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<DateTime>? date,
    Expression<DateTime>? expirationDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (date != null) 'date': date,
      if (expirationDate != null) 'expiration_date': expirationDate,
    });
  }

  PaymentDBCompanion copyWith({
    Value<int>? id,
    Value<int>? clientId,
    Value<DateTime>? date,
    Value<DateTime>? expirationDate,
  }) {
    return PaymentDBCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      date: date ?? this.date,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (expirationDate.present) {
      map['expiration_date'] = Variable<DateTime>(expirationDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentDBCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('date: $date, ')
          ..write('expirationDate: $expirationDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientDBTable clientDB = $ClientDBTable(this);
  late final $PaymentDBTable paymentDB = $PaymentDBTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [clientDB, paymentDB];
}

typedef $$ClientDBTableCreateCompanionBuilder =
    ClientDBCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> identificationNumber,
      Value<String?> phoneNumber,
    });
typedef $$ClientDBTableUpdateCompanionBuilder =
    ClientDBCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> identificationNumber,
      Value<String?> phoneNumber,
    });

final class $$ClientDBTableReferences
    extends BaseReferences<_$AppDatabase, $ClientDBTable, ClientDBData> {
  $$ClientDBTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PaymentDBTable, List<PaymentDBData>>
  _paymentDBRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.paymentDB,
    aliasName: $_aliasNameGenerator(db.clientDB.id, db.paymentDB.clientId),
  );

  $$PaymentDBTableProcessedTableManager get paymentDBRefs {
    final manager = $$PaymentDBTableTableManager(
      $_db,
      $_db.paymentDB,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentDBRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientDBTableFilterComposer
    extends Composer<_$AppDatabase, $ClientDBTable> {
  $$ClientDBTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get identificationNumber => $composableBuilder(
    column: $table.identificationNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> paymentDBRefs(
    Expression<bool> Function($$PaymentDBTableFilterComposer f) f,
  ) {
    final $$PaymentDBTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentDB,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentDBTableFilterComposer(
            $db: $db,
            $table: $db.paymentDB,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientDBTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientDBTable> {
  $$ClientDBTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get identificationNumber => $composableBuilder(
    column: $table.identificationNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientDBTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientDBTable> {
  $$ClientDBTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get identificationNumber => $composableBuilder(
    column: $table.identificationNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  Expression<T> paymentDBRefs<T extends Object>(
    Expression<T> Function($$PaymentDBTableAnnotationComposer a) f,
  ) {
    final $$PaymentDBTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentDB,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentDBTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentDB,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientDBTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientDBTable,
          ClientDBData,
          $$ClientDBTableFilterComposer,
          $$ClientDBTableOrderingComposer,
          $$ClientDBTableAnnotationComposer,
          $$ClientDBTableCreateCompanionBuilder,
          $$ClientDBTableUpdateCompanionBuilder,
          (ClientDBData, $$ClientDBTableReferences),
          ClientDBData,
          PrefetchHooks Function({bool paymentDBRefs})
        > {
  $$ClientDBTableTableManager(_$AppDatabase db, $ClientDBTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientDBTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientDBTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientDBTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> identificationNumber = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
              }) => ClientDBCompanion(
                id: id,
                name: name,
                identificationNumber: identificationNumber,
                phoneNumber: phoneNumber,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> identificationNumber = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
              }) => ClientDBCompanion.insert(
                id: id,
                name: name,
                identificationNumber: identificationNumber,
                phoneNumber: phoneNumber,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClientDBTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({paymentDBRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (paymentDBRefs) db.paymentDB],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (paymentDBRefs)
                    await $_getPrefetchedData<
                      ClientDBData,
                      $ClientDBTable,
                      PaymentDBData
                    >(
                      currentTable: table,
                      referencedTable: $$ClientDBTableReferences
                          ._paymentDBRefsTable(db),
                      managerFromTypedResult: (p0) => $$ClientDBTableReferences(
                        db,
                        table,
                        p0,
                      ).paymentDBRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.clientId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ClientDBTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientDBTable,
      ClientDBData,
      $$ClientDBTableFilterComposer,
      $$ClientDBTableOrderingComposer,
      $$ClientDBTableAnnotationComposer,
      $$ClientDBTableCreateCompanionBuilder,
      $$ClientDBTableUpdateCompanionBuilder,
      (ClientDBData, $$ClientDBTableReferences),
      ClientDBData,
      PrefetchHooks Function({bool paymentDBRefs})
    >;
typedef $$PaymentDBTableCreateCompanionBuilder =
    PaymentDBCompanion Function({
      Value<int> id,
      required int clientId,
      Value<DateTime> date,
      required DateTime expirationDate,
    });
typedef $$PaymentDBTableUpdateCompanionBuilder =
    PaymentDBCompanion Function({
      Value<int> id,
      Value<int> clientId,
      Value<DateTime> date,
      Value<DateTime> expirationDate,
    });

final class $$PaymentDBTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentDBTable, PaymentDBData> {
  $$PaymentDBTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientDBTable _clientIdTable(_$AppDatabase db) => db.clientDB
      .createAlias($_aliasNameGenerator(db.paymentDB.clientId, db.clientDB.id));

  $$ClientDBTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<int>('client_id')!;

    final manager = $$ClientDBTableTableManager(
      $_db,
      $_db.clientDB,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentDBTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentDBTable> {
  $$PaymentDBTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientDBTableFilterComposer get clientId {
    final $$ClientDBTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientDB,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientDBTableFilterComposer(
            $db: $db,
            $table: $db.clientDB,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentDBTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentDBTable> {
  $$PaymentDBTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientDBTableOrderingComposer get clientId {
    final $$ClientDBTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientDB,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientDBTableOrderingComposer(
            $db: $db,
            $table: $db.clientDB,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentDBTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentDBTable> {
  $$PaymentDBTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => column,
  );

  $$ClientDBTableAnnotationComposer get clientId {
    final $$ClientDBTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clientDB,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientDBTableAnnotationComposer(
            $db: $db,
            $table: $db.clientDB,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentDBTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentDBTable,
          PaymentDBData,
          $$PaymentDBTableFilterComposer,
          $$PaymentDBTableOrderingComposer,
          $$PaymentDBTableAnnotationComposer,
          $$PaymentDBTableCreateCompanionBuilder,
          $$PaymentDBTableUpdateCompanionBuilder,
          (PaymentDBData, $$PaymentDBTableReferences),
          PaymentDBData,
          PrefetchHooks Function({bool clientId})
        > {
  $$PaymentDBTableTableManager(_$AppDatabase db, $PaymentDBTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentDBTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentDBTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentDBTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> expirationDate = const Value.absent(),
              }) => PaymentDBCompanion(
                id: id,
                clientId: clientId,
                date: date,
                expirationDate: expirationDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int clientId,
                Value<DateTime> date = const Value.absent(),
                required DateTime expirationDate,
              }) => PaymentDBCompanion.insert(
                id: id,
                clientId: clientId,
                date: date,
                expirationDate: expirationDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentDBTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (clientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clientId,
                                referencedTable: $$PaymentDBTableReferences
                                    ._clientIdTable(db),
                                referencedColumn: $$PaymentDBTableReferences
                                    ._clientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PaymentDBTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentDBTable,
      PaymentDBData,
      $$PaymentDBTableFilterComposer,
      $$PaymentDBTableOrderingComposer,
      $$PaymentDBTableAnnotationComposer,
      $$PaymentDBTableCreateCompanionBuilder,
      $$PaymentDBTableUpdateCompanionBuilder,
      (PaymentDBData, $$PaymentDBTableReferences),
      PaymentDBData,
      PrefetchHooks Function({bool clientId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientDBTableTableManager get clientDB =>
      $$ClientDBTableTableManager(_db, _db.clientDB);
  $$PaymentDBTableTableManager get paymentDB =>
      $$PaymentDBTableTableManager(_db, _db.paymentDB);
}
