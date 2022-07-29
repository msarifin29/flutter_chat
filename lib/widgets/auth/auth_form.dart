import 'dart:io';

import 'package:chat/constants/app_colors.dart';
import 'package:chat/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';
import '../../commons/custom_button.dart';
import '../../constants/app_size.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.submitFn, required this.isLoading})
      : super(key: key);

  final void Function(String email, String userName, String password,
      bool isLogin, File? image, BuildContext ctx) submitFn;
  final bool isLoading;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _userName = '';
  // ignore: unused_field
  String _userEmail = '';
  // ignore: unused_field
  String _userPassword = '';
  bool _isLogin = true;
  File? _userImageFile;

  // Upload image from device to storage
  void _uploadImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick an image'),
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      // Use those values to send our auth request
      widget.submitFn(_userEmail.trim(), _userName.trim(), _userPassword.trim(),
          _isLogin, _userImageFile, context);
    }
  }

  TextStyle customStyle() {
    return const TextStyle(color: blueColor, fontSize: Sizes.s16);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(Sizes.s20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Sizes.s10),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.s10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin)
                    UserImagePicker(
                      pickImageFn: _uploadImage,
                    ),
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text('Email Address'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(Sizes.s20),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  h10,
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      decoration: const InputDecoration(
                        label: Text('Username'),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(Sizes.s20)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length <= 4) {
                          return 'Please enter at last 4 character';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  h10,
                  TextFormField(
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(
                      label: Text('Password'),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(Sizes.s20)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length <= 7) {
                        return 'Password must be at least 7 character';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  h10,
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    customButton(_isLogin ? 'Login' : 'Signup', _trySubmit),
                  h10,
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(
                          () {
                            _isLogin = !_isLogin;
                          },
                        );
                      },
                      child: Text(
                        _isLogin
                            ? 'Create new account'
                            : 'I already have an account',
                        style: customStyle(),
                      ),
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
