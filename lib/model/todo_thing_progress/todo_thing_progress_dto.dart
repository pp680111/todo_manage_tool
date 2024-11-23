import 'package:todo_manage/model/todo_thing_progress/todo_thing_progress_db.dart';

class TodoThingProgressDTO {
  int id;
  int todoThingId;
  String content;
  bool isFinished;
  DateTime createTime;
  DateTime updateTime;

  TodoThingProgressDTO(this.id, this.todoThingId, this.content, this.isFinished, this.createTime, this.updateTime);

  factory TodoThingProgressDTO.mapToDTO(TodoThingProgressData todoThingProgress) {
    return TodoThingProgressDTO(
      todoThingProgress.id,
      todoThingProgress.todoThingId,
      todoThingProgress.content,
      todoThingProgress.isFinished,
      todoThingProgress.createTime,
      todoThingProgress.updateTime
    );
  }
}