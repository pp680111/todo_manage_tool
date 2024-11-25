

class TodoThingProgressDTO {
  int id;
  int todoThingId;
  String content;
  bool isFinished;
  DateTime createTime;
  DateTime updateTime;

  TodoThingProgressDTO(this.id, this.todoThingId, this.content, this.isFinished, this.createTime, this.updateTime);
}