import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superapp/controllers/auth/set_new_password_controller.dart';
import 'package:superapp/widgets/auth_text_form_field.dart';

class SetNewPasswordScreen extends StatelessWidget {
  const SetNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SetNewPasswordController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: controller.back,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    'Back',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Text(
                'Set a new password',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Create a new password. Ensure it differs from\nprevious ones for security',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 16),

              Obx(() {
                return AuthTextFormField(
                  controller: controller.newPass,
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

              const SizedBox(height: 10),

              Obx(() {
                return AuthTextFormField(
                  controller: controller.confirmPass,
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

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                height: 46,
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
