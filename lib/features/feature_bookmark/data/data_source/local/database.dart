import 'dart:async';
import 'package:floor/floor.dart';
import '../../../domain/entities/city_entity.dart';
import 'city_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [City])
abstract class AppDatabase extends FloorDatabase {
  CityDao get cityDao;
}
