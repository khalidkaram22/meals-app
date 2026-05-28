import 'package:flutter/material.dart';
import 'package:meals_app/core/styles/app_colors.dart';

class MenuButtonWidget extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool haveAdd;

  const MenuButtonWidget({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.onAdd,
    this.haveAdd = true,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, color: AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onSelected: (value) {
          if (value == 'edit') {
            onEdit();
          } else if (value == 'delete') {
            onDelete();
          } else if (value == 'add') {
            onAdd();
          }
        },
        itemBuilder: (context) => [
          if (haveAdd)
            const PopupMenuItem(
              value: 'add',
              child: Text('Add'),
            ),

          // const PopupMenuItem(
          //   value: 'edit',
          //   child: Text('Edit'),
          // ),

          const PopupMenuItem(
            value: 'delete',
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}