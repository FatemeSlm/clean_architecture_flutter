import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/city_entity.dart';
import '../repository/city_repository.dart';

class GetCityUseCase extends UseCase<DataState<City?>, String>{
  final CityRepository cityRepository;

  GetCityUseCase(this.cityRepository);

  @override
  Future<DataState<City?>> call(String params) {
    return cityRepository.findCityByName(params);
  }
}