import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result with _$Result {
  const factory Result(
      {@Default(ActionType.none) ActionType actionType, List? items}) = _Result;
}
