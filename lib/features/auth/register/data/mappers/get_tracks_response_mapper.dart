import 'package:explaino/core/shared/data/mappers/auth/user_mapper.dart';
import 'package:explaino/features/auth/register/data/models/response/get_tracks_response_model.dart';
import 'package:explaino/features/auth/register/domain/entities/response/get_tracks_response_entity.dart';

extension GetTracksResponseMapper on GetTracksResponseModel {
  GetTracksResponseEntity toEntity() {
    return GetTracksResponseEntity(
      count: count,
      tracks: results.map((e) => e.toEntity()).toList(),
    );
  }
}
