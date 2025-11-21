import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../models/project.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_data.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/constants.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../views/portfolio/project_card.dart';
import '../widgets/animated_text_button.dart';

class ProjectListView extends ConsumerWidget {
  const ProjectListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectList = projects();
    final isDesktop = context.isDesktop;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: context.screenHeight * 0.8),
      padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: isDesktop ? Alignment.centerRight : Alignment.centerLeft,
            child: AnimatedTextButton(
              context.localization.see_github_project,
              hoverColor: kGrey700,
              textColor: kBlack,
              fontSize: isDesktop ? 12.0 : 14.0,
              onPressed: () =>
                  ref.read(homeViewModelProvider).onLaunchUrl(kGithubRepo),
            ),
          ),

          verticalSpaceMassive,

          // Projects Grid / List
          isDesktop
              ? _buildDesktopGrid(projectList)
              : _buildMobileList(projectList),
        ],
      ),
    );
  }

  Widget _buildDesktopGrid(List<Project> projectList) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 420,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.95,
      ),
      itemCount: projectList.length,
      itemBuilder: (context, index) {
        return ProjectCard(projectList[index]);
      },
    );
  }

  Widget _buildMobileList(List<Project> projectList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projectList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ProjectCard(projectList[index]),
        );
      },
    );
  }
}
