import 'package:clean_arcitecture_flutter_sample/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class CityDao {
  @Query('select * from City')
  Future<List<City>> getAllCity();

  @Query('select * from City where name = :name')
  Future<City?> findCityByName(String name);

  @insert
  Future<void> insertCity(City city);

  @Query('delete from City where name = :name')
  Future<void> deleteCityByName(String name);
}
