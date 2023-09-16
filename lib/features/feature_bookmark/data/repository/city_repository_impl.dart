import 'package:clean_arcitecture_flutter_sample/core/resources/data_state.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_bookmark/data/data_source/local/city_dao.dart';

import 'package:clean_arcitecture_flutter_sample/features/feature_bookmark/domain/entities/city_entity.dart';

import '../../domain/repository/city_repository.dart';

class CityRepositoryImpl extends CityRepository {
  final CityDao cityDao;

  CityRepositoryImpl(this.cityDao);

  @override
  Future<DataState<String>> deleteCityByName(String name) async {
    try{
      await cityDao.deleteCityByName(name);
      return DataSuccess(name);
    }catch(exp){
      return DataFailed(exp.toString());
    }
  }

  @override
  Future<DataState<City?>> findCityByName(String name) async{
    try{
      City? city = await cityDao.findCityByName(name);
      return DataSuccess(city);
    }catch(exp){
      return DataFailed(exp.toString());
    }
  }

  @override
  Future<DataState<List<City>>> getAllCityFromDB() async{
    try{
      List<City> cities = await cityDao.getAllCity();
      return DataSuccess(cities);
    }catch(exp){
      return DataFailed(exp.toString());
    }
  }

  @override
  Future<DataState<City>> saveCityToDB(String cityName) async {
    try {
      /// check city exist or not
      City? checkCity = await cityDao.findCityByName(cityName);
      if (checkCity != null) {
        return DataFailed('$cityName has already exist.');
      }

      /// insert city to db
      City city = City(name: cityName);
      await cityDao.insertCity(city);
      return DataSuccess(city);
    } catch (exp) {
      return DataFailed(exp.toString());
    }
  }
}
