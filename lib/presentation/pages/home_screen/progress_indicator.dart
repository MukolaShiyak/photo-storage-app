import 'package:flutter/material.dart';

import '/data/datasource/photo_upload_api.dart';

class UploadProgressIndicator extends StatefulWidget {
  const UploadProgressIndicator({
    Key? key,
    required this.progressStream,
  }) : super(key: key);

  final StreamProgressIndicator progressStream;

  @override
  _UploadProgressIndicatorState createState() =>
      _UploadProgressIndicatorState();
}

class _UploadProgressIndicatorState extends State<UploadProgressIndicator> {
  @override
  void dispose() {
    widget.progressStream.counterStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.progressStream.counterStream.stream,
      builder: (context, snapshot) {
        final double value =
            snapshot.data != null ? snapshot.data as double : 0;
        final double progress = value / 100;
        return LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey,
          color: Colors.green,
          minHeight: 6,
        );
      },
    );
  }
}
