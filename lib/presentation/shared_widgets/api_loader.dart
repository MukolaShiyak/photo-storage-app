import 'package:flutter/material.dart';

class ApiLoader extends StatelessWidget {
  const ApiLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      color: Colors.black12,
      child: const CircularProgressIndicator(),
    );
  }
}