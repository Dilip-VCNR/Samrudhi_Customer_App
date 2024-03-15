
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/api_calls.dart';
import '../../../auth/provider/auth_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/url_constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final editFormKey = GlobalKey<FormState>();
  bool isFirstTimeLoading = true;

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder:
          (BuildContext context, AuthProvider authProvider, Widget? child) {
        authProvider.editProfilePageContext = context;
        if (isFirstTimeLoading) {
          isFirstTimeLoading = false;
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Form(
                  key: editFormKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: authProvider.getImageFromGallery,
                        child: Stack(
                          children: [
                            authProvider.selectedImage != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: authProvider
                                                .selectedImage !=
                                            null
                                        ? FileImage(authProvider.selectedImage!)
                                        : null,
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey,
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            Positioned(
                                bottom: 2,
                                right: 2,
                                child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.grey.shade400,
                                    child: IconButton(
                                        onPressed:
                                            authProvider.getImageFromGallery,
                                        icon: const Icon(
                                          Icons.file_upload_outlined,
                                          size: 15,
                                        ),
                                        color: Colors.black)))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                        maxLength: 75,
                        textCapitalization: TextCapitalization.sentences,
                        controller: authProvider.editFirstNameController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter your first name';
                          }
                          if (authProvider.isNotValidName(value.trim())) {
                            return "Please enter valid first name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          labelText: 'First Name',
                          hintText: 'First Name',
                          counterText: "",
                          isCollapsed: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.secondaryColor,
                                width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                        maxLength: 75,
                        textCapitalization: TextCapitalization.sentences,
                        controller: authProvider.editLastNameController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter your last name';
                          }
                          if (authProvider.isNotValidName(value.trim())) {
                            return "Please enter valid last name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          labelText: 'Last Name',
                          hintText: 'Last Name',
                          counterText: "",
                          isCollapsed: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.secondaryColor,
                                width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                        controller: authProvider.editEmailController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (authProvider.isNotValidEmail(value)) {
                            return "Please enter valid email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          labelText: 'Email',
                          hintText: 'Email',
                          counterText: "",
                          isCollapsed: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.secondaryColor,
                                width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // TextFormField(
                      //           autovalidateMode:
                      //               AutovalidateMode.onUserInteraction,
                      //   controller:
                      //       authProvider.editStoreReferralCodeController,
                      //   decoration: InputDecoration(
                      //     prefixIcon: const Icon(Icons.store),
                      //     labelText: 'Store referral code (Optional)',
                      //     hintText: 'Store referral code (Optional)',
                      //     counterText: "",
                      //     isCollapsed: true,
                      //     filled: true,
                      //     fillColor: AppColors.inputFieldColor,
                      //     // Set the fill color to grey
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       // Set the border radius
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     contentPadding:
                      //         const EdgeInsets.symmetric(vertical: 16.0),
                      //   ),
                      //   textAlignVertical: TextAlignVertical.center,
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (editFormKey.currentState!.validate()) {
                            await authProvider.updateProfile();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 13.0),
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Update',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
