import 'package:clean_arcitecture_flutter_sample/core/resources/data_state.dart';
import 'package:clean_arcitecture_flutter_sample/core/usecase/use_case.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_bookmark/domain/repository/city_repository.dart';

class SaveCityUseCase extends UseCase<DataState<City>, String>{
  final CityRepository cityRepository;

  SaveCityUseCase(this.cityRepository);

  @override
  Future<DataState<City>> call(String params) {
    return cityRepository.saveCityToDB(params);
  }
}