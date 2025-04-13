import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/core/constants/spacing.dart';
import 'package:stirred_app/core/extensions/widget_ref.dart';
import 'package:stirred_app/presentation/providers/current_data.dart';
import 'package:stirred_app/presentation/router.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_icon.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text.dart';
import 'package:go_router/go_router.dart';
import 'package:stirred_app/presentation/views/account/profile_edit_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProfileEditView extends ConsumerWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    final user = ref.watch(profileEditNotifierProvider).value;

    if (user == null) {
      return const Scaffold(
        body: Center(child: StirText.titleLarge('No user data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const StirText.titleLarge('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(StirSpacings.small16),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: StirSpacings.large64,
                    backgroundImage: user.picture != null 
                      ? NetworkImage(user.picture!) 
                      : null,
                    child: user.picture == null 
                      ? const StirIcon.large(iconData: Icons.person)
                      : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => ImagePickerDialog(
                            onImageSelected: (image) async {
                              if (image != null) {
                                await ref.read(profileEditNotifierProvider.notifier).updateProfilePicture(image.path);
                                if (context.mounted) {
                                  context.pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Profile picture updated successfully')),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: StirSpacings.medium24),
            // Name Field
            _buildProfileField(
              context: context,
              label: 'Name',
              value: user.name ?? '',
              onEdit: () => showDialog(
                context: context,
                builder: (context) => EditFieldDialog(
                  title: 'Edit Name',
                  initialValue: user.name ?? '',
                  onSave: (newName) async {
                    await ref.read(profileEditNotifierProvider.notifier).updateName(newName);
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: StirSpacings.medium24),
            // Email Field
            _buildProfileField(
              context: context,
              label: 'Email',
              value: user.email ?? '',
              onEdit: () => showDialog(
                context: context,
                builder: (context) => EditFieldDialog(
                  title: 'Edit Email',
                  initialValue: user.email ?? '',
                  onSave: (newEmail) async {
                    await ref.read(profileEditNotifierProvider.notifier).updateEmail(newEmail);
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                ),
              ),
            ),
            const Spacer(),
            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: StirSpacings.small16),
              child: InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => ref.read(currentDataNotifierProvider.notifier).logout(),
                child: StirText.titleSmall(
                  'Logout',
                  color: colors.error,
                  decoration: TextDecoration.underline,
                  decorationColor: colors.error,
                ),
              ),
            ),
            const SizedBox(height: StirSpacings.small16),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required BuildContext context,
    required String label,
    required String value,
    required VoidCallback onEdit,
  }) {
    return Container(
      padding: const EdgeInsets.all(StirSpacings.small16),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(StirSpacings.small8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StirText.bodySmall(label),
                const SizedBox(height: StirSpacings.small4),
                StirText.bodyLarge(value),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}

class ImagePickerDialog extends StatefulWidget {
  final Function(XFile?) onImageSelected;

  const ImagePickerDialog({
    super.key,
    required this.onImageSelected,
  });

  @override
  State<ImagePickerDialog> createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog> {
  final ImagePicker picker = ImagePicker();
  XFile? selectedImage;
  bool isLoading = false;

  static const previewSize = 200.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const StirText.titleLarge('Update Profile Picture'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selectedImage == null) ...[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: isLoading ? null : () async {
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 800,
                  maxHeight: 800,
                  imageQuality: 80,
                );
                if (image != null && mounted) {
                  setState(() => selectedImage = image);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: isLoading ? null : () async {
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                  maxWidth: 800,
                  maxHeight: 800,
                  imageQuality: 80,
                );
                if (image != null && mounted) {
                  setState(() => selectedImage = image);
                }
              },
            ),
          ] else ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(StirSpacings.small8),
              child: kIsWeb
                ? Image.network(
                    selectedImage!.path,
                    height: previewSize,
                    width: previewSize,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: previewSize,
                        width: previewSize,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.error_outline, size: StirSpacings.large48),
                        ),
                      );
                    },
                  )
                : Image.file(
                    File(selectedImage!.path),
                    height: previewSize,
                    width: previewSize,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: previewSize,
                        width: previewSize,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.error_outline, size: StirSpacings.large48),
                        ),
                      );
                    },
                  ),
            ),
            const SizedBox(height: StirSpacings.small16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: isLoading ? null : () {
                    setState(() => selectedImage = null);
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Choose Another'),
                ),
                TextButton.icon(
                  onPressed: isLoading ? null : () {
                    widget.onImageSelected(selectedImage);
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Confirm'),
                ),
              ],
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => context.pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

class EditFieldDialog extends StatefulWidget {
  const EditFieldDialog({
    super.key,
    required this.title,
    required this.initialValue,
    required this.onSave,
  });

  final String title;
  final String initialValue;
  final Future<void> Function(String) onSave;

  @override
  State<EditFieldDialog> createState() => _EditFieldDialogState();
}

class _EditFieldDialogState extends State<EditFieldDialog> {
  late final TextEditingController controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: StirText.titleLarge(widget.title),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => context.pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: isLoading ? null : () async {
            setState(() => isLoading = true);
            try {
              await widget.onSave(controller.text);
              if (mounted) {
                router.pop();
              }
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to update: $e')),
                );
              }
            } finally {
              if (mounted) {
                setState(() => isLoading = false);
              }
            }
          },
          child: isLoading
            ? const SizedBox(
                width: StirSpacings.small16,
                height: StirSpacings.small16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text('Save'),
        ),
      ],
    );
  }
} 