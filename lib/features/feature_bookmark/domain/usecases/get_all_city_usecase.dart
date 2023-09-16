import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/city_entity.dart';
import '../repository/city_repository.dart';

class GetAllCityUseCase extends UseCase<DataState<List<City>>, NoParams>{
  final CityRepository cityRepository;

  GetAllCityUseCase(this.cityRepository);

  @override
  Future<DataState<List<City>>> call(NoParams params) {
    return cityRepository.getAllCityFromDB();
  }
}