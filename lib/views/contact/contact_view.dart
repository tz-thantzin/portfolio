import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/widgets/animated_slide_button.dart';
import 'package:portfolio/views/widgets/animated_text_field.dart';
import 'package:portfolio/views/widgets/text/content_text.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../../view_models/contact_view_model.dart';
import '../widgets/animated_fade_widget.dart';
import '../widgets/text/title_text.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;

  late AnimationController _nameAnimationController;
  late AnimationController _jobAnimationController;
  late AnimationController _emailAnimationController;
  late AnimationController _messageAnimationController;

  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  final _nameFocus = FocusNode();
  final _jobFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _messageFocus = FocusNode();

  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(vsync: this, duration: duration1000);

    _nameAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _jobAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _emailAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _messageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Focus listeners for animations + validation
    _nameFocus.addListener(() {
      _nameFocus.hasFocus
          ? _nameAnimationController.forward()
          : _nameAnimationController.reverse();
      if (!_nameFocus.hasFocus) context.read<ContactViewModel>().validate();
    });
    _jobFocus.addListener(() {
      _jobFocus.hasFocus
          ? _jobAnimationController.forward()
          : _jobAnimationController.reverse();
      if (!_jobFocus.hasFocus) context.read<ContactViewModel>().validate();
    });
    _emailFocus.addListener(() {
      _emailFocus.hasFocus
          ? _emailAnimationController.forward()
          : _emailAnimationController.reverse();
      if (!_emailFocus.hasFocus) context.read<ContactViewModel>().validate();
    });
    _messageFocus.addListener(() {
      _messageFocus.hasFocus
          ? _messageAnimationController.forward()
          : _messageAnimationController.reverse();
      if (!_messageFocus.hasFocus) context.read<ContactViewModel>().validate();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();

    _nameController.dispose();
    _jobController.dispose();
    _emailController.dispose();
    _messageController.dispose();

    _nameFocus.dispose();
    _jobFocus.dispose();
    _emailFocus.dispose();
    _messageFocus.dispose();

    _nameAnimationController.dispose();
    _jobAnimationController.dispose();
    _emailAnimationController.dispose();
    _messageAnimationController.dispose();

    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.45 && !_hasAnimated && mounted) {
      Future.delayed(duration500, () {
        if (mounted) _fadeController.forward();
      });
      _hasAnimated = true;
    }
  }

  Future<void> _sendMessage() async {
    final vm = context.read<ContactViewModel>();
    bool hasSent = await vm.sendMessage();

    if (hasSent) {
      _nameController.clear();
      _jobController.clear();
      _emailController.clear();
      _messageController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Message sent successfully!"),
          backgroundColor: kGreen,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to send message."),
          backgroundColor: kRed,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactViewModel>(
      builder: (context, vm, _) {
        return Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: context.screenHeight),
          color: kPrimary,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: context.autoAdaptive(s60),
            vertical: context.autoAdaptive(s65),
          ),
          child:
              [
                AnimatedFadeWidget(
                  controller: _fadeController,
                  start: 0.0,
                  end: 0.4,
                  child: TitleText(context.localization.get_in_touch),
                ),
                verticalSpaceLarge,
                AnimatedFadeWidget(
                  controller: _fadeController,
                  start: 0.5,
                  end: 1,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(context.autoAdaptive(s24)),
                    decoration: BoxDecoration(
                      color: kGrey100,
                      borderRadius: BorderRadius.circular(
                        context.autoAdaptive(s16),
                      ),
                      border: Border.all(color: kGrey700, width: 2),
                    ),
                    child:
                        [
                          Text(
                            context.localization.schedule_appointment,
                            style: context.titleSmall.copyWith(
                              color: kIndigo,
                              fontSize: context.autoAdaptive(s18),
                            ),
                          ),
                          verticalSpaceMedium,

                          Wrap(
                            spacing: context.autoAdaptive(s8),
                            runSpacing: context.autoAdaptive(s12),
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              ContentText(
                                "Hi there! I hope you are doing well. I'm ",
                                textColor: kBlack,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: context.autoAdaptive(s150),
                                  maxWidth: context.autoAdaptive(s250),
                                ),
                                child: AnimatedUnderlineTextField(
                                  hintText: "Your name",
                                  controller: _nameController,
                                  focusNode: _nameFocus,
                                  underlineColor: vm.nameError != null
                                      ? kRed
                                      : kPrimary,
                                  validator: (_) => vm.nameError,
                                  onChanged: (value) => vm.name = value,
                                  onEditingComplete: () {
                                    vm.name = _nameController.text;
                                  },
                                ),
                              ),

                              ContentText(
                                "and I’m looking for ",
                                textColor: kBlack,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: context.autoAdaptive(s150),
                                  maxWidth: context.autoAdaptive(s250),
                                ),
                                child: AnimatedUnderlineTextField(
                                  hintText: "Job type",
                                  controller: _jobController,
                                  focusNode: _jobFocus,
                                  underlineColor: vm.jobError != null
                                      ? kRed
                                      : kPrimary,
                                  validator: (_) => vm.jobError,
                                  onChanged: (value) => vm.job = value,
                                  onEditingComplete: () {
                                    vm.job = _jobController.text;
                                  },
                                ),
                              ),
                              ContentText(".", textColor: kBlack),

                              ContentText("Reach me at ", textColor: kBlack),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: context.autoAdaptive(s150),
                                  maxWidth: context.autoAdaptive(s250),
                                ),
                                child: AnimatedUnderlineTextField(
                                  hintText: "Your email",
                                  controller: _emailController,
                                  focusNode: _emailFocus,
                                  isEmail: true,
                                  underlineColor: vm.emailError != null
                                      ? kRed
                                      : kPrimary,
                                  validator: (_) => vm.emailError,
                                  onChanged: (value) => vm.email = value,
                                  onEditingComplete: () {
                                    vm.email = _emailController.text;
                                  },
                                ),
                              ),
                              ContentText("!", textColor: kBlack),

                              ContentText(
                                "Any additional info or special requests?",
                                textColor: kBlack,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: context.autoAdaptive(s250),
                                  maxWidth: context.autoAdaptive(s350),
                                ),
                                child: AnimatedUnderlineTextField(
                                  hintText: "Your message",
                                  controller: _messageController,
                                  focusNode: _messageFocus,
                                  isMultiline: true,
                                  underlineColor: vm.messageError != null
                                      ? kRed
                                      : kPrimary,
                                  validator: (_) => vm.messageError,
                                  onChanged: (value) => vm.message = value,
                                  onEditingComplete: () {
                                    vm.message = _messageController.text;
                                  },
                                ),
                              ),
                            ],
                          ),

                          verticalSpaceMedium,

                          Align(
                            alignment: Alignment.centerRight,
                            child: AnimatedSlideButton(
                              height: context.autoAdaptive(s40),
                              width: context.autoAdaptive(
                                context.isMobile ? s200 : s120,
                              ),
                              title: 'Send Message',
                              buttonColor: vm.isFormValid ? kBlack : kGrey500,
                              borderColor: kGrey900,
                              onHoverColor: kWhite70,
                              isLoading: vm.isSending,
                              iconData: Icons.send,
                              onPressed: vm.isFormValid ? _sendMessage : null,
                            ),
                          ),
                        ].addColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                  ),
                ),
              ].addColumn(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
        );
      },
    ).addVisibilityDetector(onDetectVisibility: _onVisibilityChanged);
  }
}
