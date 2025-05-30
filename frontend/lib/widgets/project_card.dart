import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/app_colors.dart';
import '../models/project_model.dart';
import '../screens/projects/kanban_board_screen.dart';
import 'dart:math';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  // Generate a random blended color between the project color and light grey
  Color _getBlendedColor(Color baseColor) {
    final random = Random();
    final grey = Colors.grey[400]!;

    // Random blend factor between 0.3 and 0.7
    final blendFactor = 0.3 + (random.nextDouble() * 0.4);

    return Color.lerp(baseColor, grey, blendFactor)!;
  }

  @override
  Widget build(BuildContext context) {
    final progress = project.progress / 100;
    final bannerColor = project.getBannerColor();
    final progressColor = _getBlendedColor(bannerColor);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KanbanBoardScreen(projectId: project.id),
          ),
        );
      },
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(right: 16, bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project banner
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: bannerColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
            ),

            // Project details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project title
                  Text(
                    project.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Progress indicator
                  Row(
                    children: [
                      // Progress Circle
                      SizedBox(
                        width: 38,
                        height: 38,
                        child: Stack(
                          children: [
                            CircularProgressIndicator(
                              value: progress,
                              backgroundColor: AppColors.cardColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                progressColor,
                              ),
                              strokeWidth: 5,
                            ),
                            Center(
                              child: Text(
                                '${project.progress}%',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Task count and date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${project.completedTasks}/${project.totalTasks} tasks',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.secondaryTextColor,
                              ),
                            ),
                            Text(
                              project.deadline != null
                                  ? 'Due: ${DateFormat('MMM d').format(project.deadline!)}'
                                  : 'No deadline',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
