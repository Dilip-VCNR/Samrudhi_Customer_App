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
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
        authProvider.editProfilePageContext = context;
        if(isFirstTimeLoading){
          authProvider.editFirstNameController.text = prefModel.userData!.firstName!;
          authProvider.editLastNameController.text = prefModel.userData!.lastName!;
          authProvider.editEmailController.text = prefModel.userData!.emailId!;
          authProvider.editStoreReferralCodeController.text = prefModel.userData!.storeReferralCode??'';
          isFirstTimeLoading = false;
        }
        return GestureDetector(
          onTap: (){
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
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Form(
                  key: editFormKey,
                  child: Column(
                    children: [

                      GestureDetector(
                        onTap: authProvider.getImageFromGallery,
                        child: Stack(
                          children: [
                            authProvider.selectedImage!=null?CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey,
                              backgroundImage: authProvider.selectedImage != null
                                  ? FileImage(authProvider.selectedImage!)
                                  : null,
                            ):CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey,
                              backgroundImage:
                              NetworkImage('${UrlConstant.imageBaseUrl}${prefModel.userData!.profileImgArray![0]['imageURL']}'),
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
                                        onPressed: authProvider.getImageFromGallery,
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
                        textCapitalization: TextCapitalization.sentences,
                        controller: authProvider.editFirstNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';
                          }
                          if (authProvider.isNotValidName(value)) {
                            return "Please enter valid first name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          hintText: 'First Name',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: authProvider.editLastNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your last name';
                          }
                          if (authProvider.isNotValidName(value)) {
                            return "Please enter valid last name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          hintText: 'Last Name',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: authProvider.editEmailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (authProvider.isNotValidEmail(value)) {
                            return "Please enter valid email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: 'Email',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: authProvider.editStoreReferralCodeController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.store),
                          hintText: 'Store referral code (Optional)',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: AppColors.inputFieldColor,
                          // Set the fill color to grey
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // Set the border radius
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // TextFormField(
                      //   controller: authProvider.operatorCodeController,
                      //   decoration: InputDecoration(
                      //     prefixIcon: const Icon(Icons.settings_input_antenna),
                      //     hintText: 'Operator code (Optional)',
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
                      //     contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                      //   ),
                      //   textAlignVertical: TextAlignVertical.center,
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // TextFormField(
                      //   controller: authProvider.operatorTypeController,
                      //   decoration: InputDecoration(
                      //     prefixIcon: const Icon(Icons.settings_input_antenna),
                      //     hintText: 'Operator type (Optional)',
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
                      //     contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                      //   ),
                      //   textAlignVertical: TextAlignVertical.center,
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // TextFormField(
                      //   controller: authProvider.cableSubscriberIdController,
                      //   decoration: InputDecoration(
                      //     prefixIcon: const Icon(Icons.tv),
                      //     hintText: 'Cable subscriber Id (Optional)',
                      //     counterText: "",
                      //     isCollapsed: true,
                      //     filled: true,
                      //     fillColor: AppColors.inputFieldColor,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                      //   ),
                      //   textAlignVertical: TextAlignVertical.center,
                      // ),
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
                                'Continue',
                                style: TextStyle(color: Colors.white, fontSize: 17),
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
