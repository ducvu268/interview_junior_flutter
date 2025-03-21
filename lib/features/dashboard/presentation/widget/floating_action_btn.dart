import 'package:flutter/material.dart';

class FloatingActionBtn extends StatelessWidget {
  const FloatingActionBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        // color: const Color(0xFFCF0000),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 177, 24, 1),
            Color.fromARGB(255, 190, 45, 5),
          ],
          stops: [0, 1],
          begin: AlignmentDirectional(1, -1),
          end: AlignmentDirectional(-1, 1),
        ),
        borderRadius: BorderRadius.circular(500),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 8,
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(child: Icon(Icons.add, color: Colors.white, size: 36)),
    );
  }
}
