import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/controllers/auth/signup_controller.dart';
import 'package:superapp/widgets/auth_social_button.dart';
import 'package:superapp/widgets/auth_text_form_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              SizedBox(
                height: 150,
                child: Center(
                  child: Image.asset(
                    'assets/signup_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Create Your Account',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: AuthTextFormField(
                      controller: controller.firstName,
                      hint: 'First Name',
                      prefixIcon: Icons.person_outline,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AuthTextFormField(
                      controller: controller.lastName,
                      hint: 'Last Name',
                      prefixIcon: Icons.person_outline,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              AuthTextFormField(
                controller: controller.email,
                hint: 'Enter your email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 10),

              Obx(() {
                return AuthTextFormField(
                  controller: controller.password,
                  hint: 'Enter your password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: controller.obscurePassword.value,
                  suffixIcon: controller.obscurePassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  onSuffixTap: controller.showPassword,
                  textInputAction: TextInputAction.done,
                );
              }),

              const SizedBox(height: 8),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Checkbox(
                      value: controller.agreeTerms.value,
                      onChanged: controller.termsEvent,
                      activeColor: theme.colorScheme.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: const VisualDensity(
                        horizontal: -3,
                        vertical: -3,
                      ),
                    );
                  }),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: RichText(
                        text: TextSpan(
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF6B7280),
                            height: 1.3,
                            fontSize: 11.5,
                          ),
                          children: [
                            const TextSpan(
                              text: 'By signing up, you agree to the ',
                            ),
                            TextSpan(
                              text: 'Terms of service',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: ' and\n'),
                            TextSpan(
                              text: 'Privacy policy',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: controller.signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFF6B7280))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'or',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF6B7280),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: Color(0xFF6B7280))),
                ],
              ),

              const SizedBox(height: 12),

              SocialButton(
                text: 'Sign up with Google',
                icon: 'assets/google.png',
                onTap: controller.signUpWithGoogle,
              ),
              const SizedBox(height: 10),

              SocialButton(
                text: 'Sign up with Apple',
                icon: 'assets/apple.png',
                onTap: controller.signUpWithApple,
              ),

              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.goTosignIn(),
                    child: Text(
                      'Sign in',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
