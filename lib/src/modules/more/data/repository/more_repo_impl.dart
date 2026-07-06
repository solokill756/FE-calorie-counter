import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/more_repo.dart';

@Injectable(as: MoreRepository)
class MoreRepositoryImpl implements MoreRepository {
  MoreRepositoryImpl(Dio dio);
}
