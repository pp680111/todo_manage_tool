import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../model/todo_thing_progress/todo_thing_progress_dto.dart';

class ProgressItem extends StatelessWidget {
  TodoThingProgressDTO progress;

  ProgressItem(this.progress, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        progress.content,
        style: const TextStyle(
          fontSize: 14,
        ),
        maxLines: 10,
      ),
      trailing: _ProgressItemTrailing(progress),
    );
  }
}

class _ProgressItemTrailing extends StatefulWidget {
  TodoThingProgressDTO progress;

  _ProgressItemTrailing(this.progress);

  @override
  State<StatefulWidget> createState() {
    return _ProgressItemTrailingState();
  }
}

class _ProgressItemTrailingState extends State<_ProgressItemTrailing> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: widget.progress.isFinished,
          onChanged: (value) {
            setState(() {
              widget.progress.isFinished = value!;
            });
          },
          visualDensity: VisualDensity.comfortable,
        ),
        IconButton(
          onPressed: () {

          },
          icon: const Icon(Icons.delete),
          iconSize: 20,
        )
      ],
    );
  }
}