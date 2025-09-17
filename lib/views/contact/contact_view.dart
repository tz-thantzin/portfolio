import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/widget_ex.dart';
import 'package:portfolio/views/contact/widgets/animated_text_field.dart';
import 'package:portfolio/views/contact/widgets/hover_slide_button.dart';
import 'package:portfolio/views/widgets/text/content_text.dart';
import 'package:provider/provider.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';
import '../../view_models/contact_view_model.dart';
import '../widgets/text/title_text.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView>
    with TickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  final _nameFocus = FocusNode();
  final _jobFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _messageFocus = FocusNode();

  late AnimationController _nameAnimationController;
  late AnimationController _jobAnimationController;
  late AnimationController _emailAnimationController;
  late AnimationController _messageAnimationController;

  @override
  void initState() {
    super.initState();

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

    // Validate when focus is lost
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

  Future<void> _sendMessage() async {
    final vm = context.read<ContactViewModel>();
    bool hasSent = await vm.sendMessage();

    if (hasSent) {
      // Clear the fields
      _nameController.clear();
      _jobController.clear();
      _emailController.clear();
      _messageController.clear();

      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Message sent successfully!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to send message. "),
          backgroundColor: Colors.red,
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
          padding: EdgeInsets.symmetric(vertical: s40.h, horizontal: s24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleText(context.localization.get_in_touch),
              SizedBox(height: s24.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(s16.w),
                decoration: BoxDecoration(
                  gradient: kSoftTealGradient,
                  borderRadius: BorderRadius.circular(s16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleText(
                      context.localization.schedule_appointment,
                      textColor: kIndigo,
                    ),
                    SizedBox().verticalSpaceSmall,

                    Wrap(
                      spacing: s8.w,
                      runSpacing: s12.h,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ContentText("Hi there! I'm ", textColor: kBlack),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: context.isMobile ? s100.w : s50.w,
                            maxWidth: context.isMobile ? s150.w : s100.w,
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

                        ContentText("and I’m looking for ", textColor: kBlack),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: context.isMobile ? s100.w : s50.w,
                            maxWidth: context.isMobile ? s150.w : s100.w,
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
                            minWidth: context.isMobile ? s100.w : s50.w,
                            maxWidth: context.isMobile ? s150.w : s100.w,
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
                            minWidth: context.isMobile ? s150.w : s100.w,
                            maxWidth: context.isMobile ? s200.w : s150.w,
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

                    SizedBox(height: s16.h),

                    // Send Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: HoverSlideButton(
                        height: s50.h,
                        title: 'Send Message',
                        isLoading: vm.isSending,
                        buttonColor: vm.isFormValid ? kBlack : kGrey500,
                        onPressed: vm.isFormValid
                            ? _sendMessage
                            : null, // disable if not valid
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
