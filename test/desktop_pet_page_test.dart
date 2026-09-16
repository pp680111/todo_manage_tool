import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_manage/model/todo_thing/todo_thing_dto.dart';
import 'package:todo_manage/widget/desktop_pet/desktop_pet_page.dart';
import 'package:todo_manage/widget/desktop_pet/task_bubble_page.dart';

void main() {
  testWidgets('single click toggles the independent task bubble',
      (tester) async {
    var toggleCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: DesktopPetPage(
          onOpenMainWindow: () async {},
          onToggleTaskBubble: () async {
            toggleCount++;
          },
        ),
      ),
    );

    await tester.tap(find.byKey(const ValueKey('desktop-pet-icon')));
    await tester.pump();

    expect(toggleCount, 1);
  });

  testWidgets('two quick clicks open the main window', (tester) async {
    var mainWindowOpenCount = 0;
    var toggleCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: DesktopPetPage(
          onOpenMainWindow: () async {
            mainWindowOpenCount++;
          },
          onToggleTaskBubble: () async {
            toggleCount++;
          },
        ),
      ),
    );

    final pet = find.byKey(const ValueKey('desktop-pet-icon'));
    await tester.tap(pet);
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(pet);
    await tester.pump();

    expect(mainWindowOpenCount, 1);
    expect(toggleCount, 1);
  });

  testWidgets('independent bubble renders its empty task state',
      (tester) async {
    var closeCount = 0;
    var loadCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: TaskBubblePage(
          onClose: () async {
            closeCount++;
          },
          onOpenMainWindow: () async {},
          taskLoader: () async {
            loadCount++;
            return <TodoThingDTO>[];
          },
        ),
      ),
    );
    await tester.pump();

    expect(find.text('今日未完成'), findsOneWidget);
    expect(find.text('今天的任务都完成啦'), findsOneWidget);
    expect(loadCount, 1);

    await tester.tap(find.byTooltip('刷新'));
    await tester.pump();
    expect(loadCount, 2);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byTooltip('关闭'));
    await tester.pump();
    expect(closeCount, 1);
  });
}
