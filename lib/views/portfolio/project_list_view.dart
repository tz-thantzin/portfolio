import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/di/providers.dart';
import '../../models/project.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_data.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/constants.dart';
import '../../presentations/configs/duration.dart';
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
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(s42),
        vertical: context.autoAdaptive(s16),
      ),
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

          _ProjectsAnimatedSection(
            projectList: projectList,
            isDesktop: isDesktop,
          ),
        ],
      ),
    );
  }
}

class _ProjectsAnimatedSection extends StatefulWidget {
  final List<Project> projectList;
  final bool isDesktop;

  const _ProjectsAnimatedSection({
    required this.projectList,
    required this.isDesktop,
  });

  @override
  State<_ProjectsAnimatedSection> createState() =>
      _ProjectsAnimatedSectionState();
}

class _ProjectsAnimatedSectionState extends State<_ProjectsAnimatedSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration2000);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 &&
        _controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const ValueKey('projects-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: widget.isDesktop
          ? _buildDesktopGrid(widget.projectList, _controller)
          : _buildMobileList(widget.projectList, _controller),
    );
  }

  Widget _buildDesktopGrid(
    List<Project> projectList,
    AnimationController controller,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 420,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.5,
      ),
      itemCount: projectList.length,
      itemBuilder: (context, index) {
        return _AnimatedProjectCard(
          key: ValueKey(projectList[index].projectName),
          index: index,
          controller: controller,
          child: ProjectCard(projectList[index]),
        );
      },
    );
  }

  Widget _buildMobileList(
    List<Project> projectList,
    AnimationController controller,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projectList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _AnimatedProjectCard(
            index: index,
            controller: controller,
            child: ProjectCard(projectList[index]),
          ),
        );
      },
    );
  }
}

class _AnimatedProjectCard extends StatefulWidget {
  final Widget child;
  final int index;
  final AnimationController controller;

  const _AnimatedProjectCard({
    super.key,
    required this.child,
    required this.index,
    required this.controller,
  });

  @override
  State<_AnimatedProjectCard> createState() => _AnimatedProjectCardState();
}

class _AnimatedProjectCardState extends State<_AnimatedProjectCard>
    with TickerProviderStateMixin {
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(
          (widget.index * 0.15).clamp(
            0.0,
            0.9,
          ), // max ~1 second delay for many items
          1.0,
          curve: Curves.easeOutCubic,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: widget.controller,
                curve: Curves.easeOutCubic,
              ),
            ),
        child: widget.child,
      ),
    );
  }
}
