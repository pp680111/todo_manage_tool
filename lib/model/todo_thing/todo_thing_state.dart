enum TodoThingState {
  NOT_START(0, '未开始'),
  EXECUTING(1, '执行中'),
  FINISHED(2, '已完成'),
  EXPIRED(3, '已超时');

  final int key;
  final String text;

  const TodoThingState(this.key, this.text);
}