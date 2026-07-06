import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/core/data/local/storage.dart';
import 'package:caloriecounter/src/core/services/image_picker_service.dart';
import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../application/edit_profile_cubit/edit_profile_cubit.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditProfileCubit>(),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _obscurePassword = true;
  File? _pickedAvatarFile;

  @override
  void initState() {
    super.initState();
    final p = Storage.userProfile;
    _nameController = TextEditingController(text: p?.displayName ?? '');
    _emailController = TextEditingController(text: p?.email ?? '');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final file = await ImagePickerService.pickFromGallery();
    if (file != null && mounted) {
      setState(() => _pickedAvatarFile = file);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<EditProfileCubit>().submit(
      displayName: _nameController.text,
      email: _emailController.text,
      newPassword: _passwordController.text,
      localAvatarFilePath: _pickedAvatarFile?.path,
    );
  }

  @override
  Widget build(BuildContext context) {
    final existingAvatar = Storage.userProfile?.avatarUrl;

    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (msg) {
            AppDialogs.showSuccessSnackBar(
              message: msg,
            );
            context.router.maybePop();
          },
          failure: (msg) {
            AppDialogs.showErrorSnackBar(
              message: msg,
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'Edit profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.translucent,
          child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      _AvatarCircle(
                        pickedFile: _pickedAvatarFile,
                        networkUrl: existingAvatar,
                      ),
                      IconButton.filled(
                        onPressed: _pickAvatar,
                        icon: const Icon(Icons.camera_alt, size: 20),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(24),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Display name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    final t = v?.trim() ?? '';
                    if (t.length < 2) return 'At least 2 characters';
                    return null;
                  },
                ),
                const Gap(16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    final t = v?.trim() ?? '';
                    if (t.isEmpty) return 'Required';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(t)) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                const Gap(16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'New password (optional)',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                  validator: (v) {
                    final t = v?.trim() ?? '';
                    if (t.isEmpty) return null;
                    if (t.length < 8)
                      return 'Password must be at least 8 characters';
                    return null;
                  },
                ),
                const Gap(32),
                BlocBuilder<EditProfileCubit, EditProfileState>(
                  builder: (context, state) {
                    final saving = state.maybeWhen(
                      saving: () => true,
                      orElse: () => false,
                    );
                    return FilledButton(
                      onPressed: saving ? null : _save,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color(0xFF4285F4),
                      ),
                      child: saving
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Save'),
                    );
                  },
                ),
              ],
            ),
          ),
          ),
        ),
      ),
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  const _AvatarCircle({required this.pickedFile, required this.networkUrl});

  final File? pickedFile;
  final String? networkUrl;

  @override
  Widget build(BuildContext context) {
    if (pickedFile != null) {
      return CircleAvatar(radius: 48, backgroundImage: FileImage(pickedFile!));
    }
    final url = networkUrl;
    if (url != null && url.isNotEmpty) {
      return CircleAvatar(radius: 48, backgroundImage: NetworkImage(url));
    }
    return const CircleAvatar(
      radius: 48,
      backgroundColor: Color(0xFF4285F4),
      child: Icon(Icons.person, size: 48, color: Colors.white),
    );
  }
}
