import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';
import 'package:portfolio/views/widgets/text/body_text.dart';
import 'package:portfolio/views/widgets/text/label_text.dart';

import '../../core/di/providers.dart';
import '../../core/routing/routes.dart';
import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../presentations/configs/duration.dart';
import '../../utils/extensions/context_ex.dart';
import '../../utils/extensions/layout_adapter_ex.dart';
import '../../utils/extensions/widget_ex.dart';
import '../../view_models/contact_view_model.dart';
import '../../views/footer/footer_view.dart';
import '../../views/widgets/animated_slide_button.dart';
import '../widgets/animated_fade_widget.dart';
import '../widgets/animated_text_field.dart';
import '../widgets/text/app_text.dart';
import '../wrapper.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
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

    // Add listeners
    _addFocusListener(_nameFocus, _nameAnimationController);
    _addFocusListener(_jobFocus, _jobAnimationController);
    _addFocusListener(_emailFocus, _emailAnimationController);
    _addFocusListener(_messageFocus, _messageAnimationController);

    // Start fade animation after delay
    Future.delayed(duration1500, () {
      if (mounted) _fadeController.forward();
    });
  }

  void _addFocusListener(FocusNode focusNode, AnimationController controller) {
    focusNode.addListener(() {
      if (!mounted) return;
      if (focusNode.hasFocus) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _nameAnimationController.dispose();
    _jobAnimationController.dispose();
    _emailAnimationController.dispose();
    _messageAnimationController.dispose();

    _nameController.dispose();
    _jobController.dispose();
    _emailController.dispose();
    _messageController.dispose();

    _nameFocus.dispose();
    _jobFocus.dispose();
    _emailFocus.dispose();
    _messageFocus.dispose();

    super.dispose();
  }

  Future<void> _sendMessage(WidgetRef ref) async {
    final vm = ref.read(contactViewModelProvider);
    vm.validate();

    final success = await vm.sendMessage();

    if (!mounted) return;

    if (success) {
      _nameController.clear();
      _jobController.clear();
      _emailController.clear();
      _messageController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: BodyText(
            "Message sent successfully!",
            fontSize: FontSize.small,
          ),
          backgroundColor: kGreen,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: BodyText(
            "Failed to send message.",
            fontSize: FontSize.small,
          ),
          backgroundColor: kRed,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      selectedRoute: RoutePaths.contact,
      selectedPageName: RouteName.contact,
      child:
          Column(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final vm = ref.watch(contactViewModelProvider);
                  return _buildInputForm(context, vm, ref);
                },
              ),
              const FooterView(isShowWorkTogether: false),
            ],
          ).addScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
          ),
    );
  }

  Widget _buildInputForm(
    BuildContext context,
    ContactViewModel vm,
    WidgetRef ref,
  ) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: context.screenHeight),
      margin: EdgeInsets.only(top: context.appBarHeight),
      padding: EdgeInsets.symmetric(
        horizontal: context.autoAdaptive(42),
        vertical: context.autoAdaptive(16),
      ),
      child:
          [
            AnimatedFadeWidget(
              controller: _fadeController,
              start: 0.0,
              end: 0.4,
              child: LabelText(
                context.localization.get_in_touch.toUpperCase(),
                fontSize: FontSize.small,
              ),
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
                      BodyText(
                        context.localization.schedule_appointment,
                        color: kIndigo,
                        fontWeight: semiBold,
                      ),
                      verticalSpaceMedium,
                      Wrap(
                        spacing: context.autoAdaptive(s8),
                        runSpacing: context.autoAdaptive(s12),
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          BodyText(
                            "Hi there! I hope you are doing well. I'm ",
                            color: kBlack,
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
                            ),
                          ),
                          BodyText("and I’m looking for ", color: kBlack),
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
                            ),
                          ),
                          BodyText(".", color: kBlack),
                          BodyText("Reach me at ", color: kBlack),
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
                            ),
                          ),
                          BodyText("!", color: kBlack),
                          BodyText(
                            "Any additional info or special requests?",
                            color: kBlack,
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
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceEnormous,
                      const Divider(color: kBlack),
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
                          onPressed: vm.isFormValid
                              ? () => _sendMessage(ref)
                              : null,
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
  }
}
