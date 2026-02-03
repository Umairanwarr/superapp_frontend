import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/controllers/auth/set_new_password_controller.dart';
import 'package:superapp/widgets/auth_text_form_field.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _newConfirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SetNewPasswordController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: TextButton(
                  onPressed: () => controller.back(),
                  child: Text(
                    'Back',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Text(
                'Set a new password',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Create a new password. Ensure it differs from\nprevious ones for security',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 20),

              Obx(() {
                return AuthTextFormField(
                  controller: _newPasswordController,
                  hint: 'Enter your new password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: controller.obscureNew.value,
                  suffixIcon: controller.obscureNew.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  onSuffixTap: controller.showNewPassword,
                  textInputAction: TextInputAction.next,
                );
              }),

              const SizedBox(height: 15),

              Obx(() {
                return AuthTextFormField(
                  controller: _newConfirmPasswordController,
                  hint: 'Re-enter password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: controller.obscureConfirm.value,
                  suffixIcon: controller.obscureConfirm.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  onSuffixTap: controller.showConfirmPassword,
                  textInputAction: TextInputAction.done,
                );
              }),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: controller.updatePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Update Password',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
