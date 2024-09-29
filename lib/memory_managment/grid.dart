import 'package:flutter/material.dart';
import '../models/block.dart';

class MemoryGrid extends StatelessWidget {
  final List<MemoryBlock> memoryBlocks;

  MemoryGrid({required this.memoryBlocks});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10, // 10 blocks per row
      ),
      itemCount: memoryBlocks.length,
      itemBuilder: (context, index) {
        final block = memoryBlocks[index];
        return Container(
          margin: const EdgeInsets.all(2),
          color: block.isFree ? Colors.green : Colors.red,
          child: Center(
            child: Text(
              block.id,
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        );
      },
    );
  }
}
