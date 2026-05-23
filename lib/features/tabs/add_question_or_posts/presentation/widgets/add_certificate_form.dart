import 'dart:io';

import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/helpers/image_picker_helper.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/certificate_text_field.dart';
import 'package:explaino/features/tabs/add_question_or_posts/presentation/widgets/pick_image_placeholder.dart';
import 'package:flutter/material.dart';

class AddCertificateForm extends StatelessWidget {
  const AddCertificateForm({
    super.key,
    required this.certificateNameController,
    required this.organizationNameController,
    required this.selectedImage,
    required this.onImagePicked,
  });

  final TextEditingController certificateNameController;
  final TextEditingController organizationNameController;
  final File? selectedImage;
  final ValueChanged<File> onImagePicked;

  Future<void> _pickImage(BuildContext context) async {
    final image = await showImagePickerDialog(context);
    if (image == null || !context.mounted) return;
    onImagePicked(image);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      children: [
        CertificateTextField(
          label: AppTextConstants.certificateName,
          hint: AppTextConstants.writeCertificateName,
          controller: certificateNameController,
        ),
        const SizedBox(height: 22),
        CertificateTextField(
          label: AppTextConstants.organizationName,
          hint: AppTextConstants.writeCertificateOrganizationName,
          controller: organizationNameController,
        ),
        const SizedBox(height: 22),
        Text(
          AppTextConstants.certificateImage,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => _pickImage(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 140,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.inputBorder),
            ),
            child: selectedImage == null
                ? const PickImagePlaceholder()
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(selectedImage!, fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: AppColors.black.withValues(alpha: .55),
                          child: Text(
                            AppTextConstants.changeCertificateImage,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
