import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/cubit.dart';
import '../../business_logic/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/styles/colors.dart';
import '../../shared/constants.dart';

class ProfileScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNoController = TextEditingController();
  final addressController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var userModel = AppCubit.get(context).userModel;

        nameController.text = userModel?.name ?? '';
        mobileNoController.text = userModel?.phone ?? '';
        addressController.text = userModel?.address ?? '';

        return BuildCondition(
          condition: AppCubit.get(context).userModel != null,
          builder: (context) {
            return Scaffold(
              appBar: DefaultAppBar(context: context, title: 'Profile'),
              body: Padding(
                padding: paddingAll,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: cubit.image == null
                                ? NetworkImage(
                                    '${userModel?.image}',
                                  )
                                : FileImage(cubit.image!) as ImageProvider,
                          ),
                          CircleAvatar(
                            radius: 18,
                            child: IconButton(
                              onPressed: () {
                                cubit.getImage();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (cubit.image != null) sizedBox15,
                      if (cubit.image != null)
                        DefaultButton(
                            title: 'Upload Picture',
                            width: 100,
                            onPressed: () {
                              cubit.uploadProfileImage(
                                name: nameController.text,
                                phone: mobileNoController.text,
                                address: addressController.text,
                              );
                              cubit.image = null;
                            }),
                      if (state is UploadProfileImageLoadingsState)
                        const SizedBox(height: 5.0),
                      if (state is UploadProfileImageLoadingsState)
                        const LinearProgressIndicator(),
                      sizedBox15,
                      Text(
                        'Hi ${userModel?.name?.split(" ").first}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DefaultTextButton(
                          child: 'Sign Out',
                          onPressed: () {
                            AppCubit.get(context).signOut(context);
                          }),
                      sizedBox12,
                      DefaultTextFormField(
                        context: context,
                        hintText: 'Name',
                        validator: (value) {},
                        controller: nameController,
                        type: TextInputType.name,
                      ),
                      sizedBox12,
                      DefaultTextFormField(
                        context: context,
                        hintText: 'Mobile No',
                        validator: (value) {},
                        controller: mobileNoController,
                        type: TextInputType.number,
                      ),
                      sizedBox12,
                      DefaultTextFormField(
                        context: context,
                        hintText: 'Address',
                        validator: (value) {},
                        controller: addressController,
                        type: TextInputType.streetAddress,
                      ),
                      sizedBox28,
                      if (state is UpdateProfileLoadingsState)
                        const LinearProgressIndicator(),
                      if (state is UpdateProfileLoadingsState)
                        const SizedBox(height: 5.0),
                      DefaultButton(
                        color: mainColor,
                        title: 'Save',
                        onPressed: () {
                          cubit.updateProfile(
                            name: nameController.text,
                            address: addressController.text,
                            phone: mobileNoController.text,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
