import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/city_repository.dart';

class DeleteCityUseCase extends UseCase<DataState<String>, String>{
  final CityRepository cityRepository;

  DeleteCityUseCase(this.cityRepository);

  @override
  Future<DataState<String>> call(String params) {
    return cityRepository.deleteCityByName(params);
  }
}