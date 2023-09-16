import 'package:bloc/bloc.dart';
import 'package:clean_arcitecture_flutter_sample/features/feature_bookmark/presentation/bloc/save_city_status.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../../domain/usecases/delete_city_use_case.dart';
import '../../domain/usecases/get_all_city_usecase.dart';
import '../../domain/usecases/get_city_use_case.dart';
import '../../domain/usecases/save_city_use_case.dart';
import 'delete_city_status.dart';
import 'get_all_city_status.dart';
import 'get_city_status.dart';

part 'bookmark_event.dart';

part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  GetCityUseCase getCityUseCase;
  SaveCityUseCase saveCityUseCase;
  GetAllCityUseCase getAllCityUseCase;
  DeleteCityUseCase deleteCityUseCase;

  BookmarkBloc(
      this.getCityUseCase,
      this.saveCityUseCase,
      this.getAllCityUseCase,
      this.deleteCityUseCase
      ) : super(BookmarkState(
      getCityStatus: GetCityLoading(),
      saveCityStatus: SaveCityInitial(),
      getAllCityStatus: GetAllCityLoading(),
      deleteCityStatus: DeleteCityInitial()
  )) {

    /// City Delete Event
    on<DeleteCityEvent>((event, emit) async {
      /// emit Loading state
      emit(state.copyWith(newDeleteCityStatus: DeleteCityLoading()));

      DataState dataState = await deleteCityUseCase(event.name);

      /// emit Complete state
      if(dataState is DataSuccess){
        emit(state.copyWith(newDeleteCityStatus: DeleteCityCompleted(dataState.data)));
      }

      /// emit Error state
      if(dataState is DataFailed){
        emit(state.copyWith(newDeleteCityStatus: DeleteCityError(dataState.error)));
      }
    });

    /// get All city
    on<GetAllCityEvent>((event, emit) async {

      /// emit Loading state
      emit(state.copyWith(newGetAllCityStatus: GetAllCityLoading()));

      DataState dataState = await getAllCityUseCase(NoParams());

      /// emit Complete state
      if(dataState is DataSuccess){
        emit(state.copyWith(newGetAllCityStatus: GetAllCityCompleted(dataState.data)));
      }

      /// emit Error state
      if(dataState is DataFailed){
        emit(state.copyWith(newGetAllCityStatus: GetAllCityError(dataState.error)));
      }
    });


    /// get city By name event
    on<GetCityByNameEvent>((event, emit) async {

      /// emit Loading state
      emit(state.copyWith(newCityStatus: GetCityLoading()));

      DataState dataState = await getCityUseCase(event.cityName);

      /// emit Complete state
      if(dataState is DataSuccess){
        emit(state.copyWith(newCityStatus: GetCityCompleted(dataState.data)));
      }

      /// emit Error state
      if(dataState is DataFailed){
        emit(state.copyWith(newCityStatus: GetCityError(dataState.error)));
      }
    });


    /// Save City Event
    on<SaveCwEvent>((event, emit) async {

      /// emit Loading state
      emit(state.copyWith(newSaveStatus: SaveCityLoading()));

      DataState dataState = await saveCityUseCase(event.name);

      /// emit Complete state
      if(dataState is DataSuccess){
        emit(state.copyWith(newSaveStatus: SaveCityCompleted(dataState.data)));
      }

      /// emit Error state
      if(dataState is DataFailed){
        emit(state.copyWith(newSaveStatus: SaveCityError(dataState.error)));
      }
    });

    /// set to init again SaveCity
    on<SaveCityInitialEvent>((event, emit) async {
      emit(state.copyWith(newSaveStatus: SaveCityInitial()));
    });

  }
}
