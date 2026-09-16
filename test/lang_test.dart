import 'package:flutter_test/flutter_test.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_state.dart';

void main() {
  test('todo state can be restored from its database key', () {
    for (final state in TodoThingState.values) {
      expect(TodoThingState.fromKey(state.key), state);
    }
  });
}
