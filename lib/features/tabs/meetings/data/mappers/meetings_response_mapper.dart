import 'package:explaino/features/schedule_meeting/data/mappers/schedule_metting_response_mapper.dart';
import 'package:explaino/features/tabs/meetings/data/models/response/meetings_response_model.dart';
import 'package:explaino/features/tabs/meetings/domain/entities/response/meetings_response_entity.dart';

extension MeetingsResponseMapper on MeetingsResponseModel {
  MeetingsResponseEntity toEntity() {
    return MeetingsResponseEntity(
      count: count,
      next: next,
      previous: previous,
      results: results.map((e) => e.toEntity()).toList(),
    );
  }
}
