import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:golden_test/Screens/home_screen.dart';
import 'package:golden_test/Widgets/reusable_chip_sub_category.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect/multiselect.dart';

import '../../Backend/get_categories.dart';
import '../../Backend/signup.dart';
import '../../Controller/LonLatController/lonlat_controller.dart';
import '../../Core/colors.dart';
import '../../Core/constants.dart';
import '../../Core/functions.dart';
import '../../Widgets/reusable_button.dart';
import '../../Widgets/reusable_bg.dart';
import '../../Widgets/reusable_snack_bar.dart';
import '../../Widgets/reusable_text_field.dart';
import 'map_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController cityEditingController = TextEditingController();
  TextEditingController bankNameEditingController = TextEditingController();
  TextEditingController bankNumberEditingController = TextEditingController();
  TextEditingController locationEditingController = TextEditingController();
  TextEditingController globalCategoryEditingController =
      TextEditingController();
  double longitude = 0, latitude = 0;
  File? _profileImageFile;
  File? _residencyImageFile;
  final ImagePicker _picker = ImagePicker();

  List<String> cities = [
    'دمشق ( العاصمة )',
    ' ريف دمشق',
    'حلب ',
    'حمص',
    'حماه',
    'اللاذقية',
    'دير الزور',
    'إدلب',
    'الحسكة',
    'الرقة',
    'السويداء',
    'درعا',
    'طرطوس',
    'القنيطرة'
  ];
  String selectedCity='';

  List<Map<String, dynamic>> categoriesList = [];
  Map<String, dynamic> selectedItem = {};
  getCategoriesFromBackend() async {
    var p = await getCategories('');
    setState(() {
      categoriesList = List<Map<String, dynamic>>.from(p);
    });
  }

  List<String> subCategoriesNamesList = [];
  List subCategoriesIdsList = [];
  List<String> selectedSubCategories = [];
  getSubCategoriesFromBackend(String id) async {
    var p = await getCategories(id);
    if (p != []) {
      setState(() {
        for (var item in p) {
          subCategoriesNamesList.add('${item['name']['ar']}');
          subCategoriesIdsList.add('${item['id']}');
        }
        // isQuotationsInfoFetched = true;
      });
    }
  }

  @override
  void initState() {
    getCategoriesFromBackend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _loginForm(),
      ),
    );
  }

  Widget _loginForm() {
    return Stack(
      children: [
        const ReusableBg(),
        GetBuilder<LonLatController>(builder: (controller) {
          return Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35), color: kBgColor),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'تسجيل دخول',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'تسجيل جديد',
                                style: TextStyle(
                                    color: kBasicColor,
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      Stack(
                        children: [
                          _profileImageFile == null
                              ? const CircleAvatar(
                                  backgroundColor: kPhotoCircleBgColor,
                                  radius: 70,
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 70,
                                  child: ClipOval(
                                      child: Image.file(
                                    _profileImageFile!,
                                    fit: BoxFit.cover,
                                    height: 140,
                                    width: 140,
                                  )),
                                ),
                          Positioned(
                            bottom: 2.0,
                            right: 4.0,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) =>
                                        bottomSheet(isProfileImage: true)));
                              },
                              child: const Icon(
                                Icons.add_a_photo,
                                color: Colors.grey,
                                size: 30.0,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextField(
                        onChangedFunc: (value) {},
                        validationFunc: (String value) {
                          if (value.isEmpty) {
                            return 'هذا الحقل مطلوب';
                          }
                        },
                        hint: 'الإسم',
                        isPasswordField: false,
                        textEditingController: nameEditingController,
                        icon: Icons.person,
                      ),
                      ReusableTextField(
                        onChangedFunc: (value) {},
                        validationFunc: (String value) {
                          if (value.isEmpty) {
                            return 'هذا الحقل مطلوب';
                          }
                          if (!RegExp(r'[0-9]{10}').hasMatch(value)) {
                            return 'يجب أن يتكون الرقم من ١٠ أعداد';
                          }
                        },
                        hint: 'رقم الجوال',
                        isPasswordField: false,
                        textEditingController: phoneEditingController,
                        icon: Icons.phone_android,
                      ),
                      ReusableTextField(
                        onChangedFunc: (value) {},
                        validationFunc: (String value) {
                          if (value.isNotEmpty &&
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'صيغة الإيميل غير صحيحة';
                          }
                        },
                        hint: 'الإيميل',
                        isPasswordField: false,
                        textEditingController: emailEditingController,
                        icon: Icons.email,
                      ),
                      ReusableTextField(
                        onChangedFunc: (value) {},
                        validationFunc: (String value) {
                          if (value.isEmpty) {
                            return 'هذا الحقل مطلوب';
                          }
                          if (value.length<8) {
                            return 'كلمة المرور يجب ان تتكون من 8 محارف على الأقل';
                          }
                        },
                        hint: 'كلمة المرور',
                        isPasswordField: true,
                        textEditingController: passwordEditingController,
                        icon: Icons.lock,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: DropdownMenu<String>(
                          width: MediaQuery.of(context).size.width * 0.84,
                          enableSearch: true,
                          controller: cityEditingController,
                          hintText: 'المدينة',
                          inputDecorationTheme: InputDecorationTheme(
                            constraints:
                                BoxConstraints.tight(const Size.fromHeight(50)),
                            hintStyle: const TextStyle(color: kIconsColor),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 0, 25, 5),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kBorderColor, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(kRadius)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kBorderColor, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(kRadius)),
                            ),
                          ),
                          menuHeight: 250,
                          dropdownMenuEntries: cities
                              .map<DropdownMenuEntry<String>>(
                                  (String option) {
                            return DropdownMenuEntry<String>(
                              value: option,
                              label: option,
                            );
                          }).toList(),
                          // enableFilter: true,
                          onSelected: (String? val) async {
                            setState(() {
                              selectedCity = val!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: DropdownMenu<Map<String, dynamic>>(
                          width: MediaQuery.of(context).size.width * 0.84,
                          enableSearch: true,
                          controller: globalCategoryEditingController,
                          hintText: 'الخدمة العامة',
                          inputDecorationTheme: InputDecorationTheme(
                            constraints:
                                BoxConstraints.tight(const Size.fromHeight(50)),
                            hintStyle: const TextStyle(color: kIconsColor),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 0, 25, 5),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kBorderColor, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(kRadius)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kBorderColor, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(kRadius)),
                            ),
                          ),
                          menuHeight: 250,
                          dropdownMenuEntries: categoriesList
                              .map<DropdownMenuEntry<Map<String, dynamic>>>(
                                  (Map<String, dynamic> option) {
                            return DropdownMenuEntry<Map<String, dynamic>>(
                              value: option,
                              label: option['name']['ar'],
                            );
                          }).toList(),
                          // enableFilter: true,
                          onSelected: (Map<String, dynamic>? val) async {
                            setState(() {
                              selectedItem = val!;
                              subCategoriesNamesList = [];
                              selectedSubCategories = [];
                            });
                            await getSubCategoriesFromBackend(
                                '${selectedItem['id']}');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: DropDownMultiSelect(
                          onChanged: (List<String> val) {
                            setState(() {
                              selectedSubCategories = val;
                            });
                          },
                          options: subCategoriesNamesList,
                          selectedValues: selectedSubCategories,
                          enabled: subCategoriesNamesList.isNotEmpty,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 25, 5),
                            // outlineBorder: BorderSide(color: Colors.black,),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kBorderColor, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(kRadius)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kBorderColor, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(kRadius)),
                            ),
                          ),
                          hint: const Text('الخدمة الفرعية',
                              style:
                                  TextStyle(color: kIconsColor, fontSize: 15)),
                        ),
                      ),
                      subCategoriesNamesList.isNotEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${selectedItem['name']['ar']}:',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline),
                                  ),
                                  Wrap(
                                      spacing: 5.0,
                                      direction: Axis.horizontal,
                                      children: selectedSubCategories
                                          .map((element) =>
                                              ReusableChipSubCategory(
                                                  text: element,
                                                  onPressFunc: () {
                                                    setState(() {
                                                      selectedSubCategories
                                                          .remove(element);
                                                    });
                                                  }))
                                          .toList()),
                                ],
                              ))
                          : const SizedBox(),
                      ReusableTextField(
                        onChangedFunc: (value) {},
                        validationFunc: (String value) {
                          if (value.isEmpty) {
                            return 'هذا الحقل مطلوب';
                          }
                        },
                        hint: 'اسم البنك',
                        isPasswordField: false,
                        textEditingController: bankNameEditingController,
                        icon: Icons.food_bank_outlined,
                      ),
                      ReusableTextField(
                        onChangedFunc: (value) {},
                        validationFunc: (String value) {
                          if (value.isEmpty) {
                            return 'هذا الحقل مطلوب';
                          }
                        },
                        hint: 'رقم البنك',
                        isPasswordField: false,
                        textEditingController: bankNumberEditingController,
                        icon: Icons.tag,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.map,
                              color: kIconsColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                controller.long == 0.0
                                    ? 'الموقع الجغرافي'
                                    : 'الموقع الجغرافي : \n'
                                        'longitude : ${controller.long} \n latitude : ${controller.lat}',
                                style: const TextStyle(
                                    color: kIconsColor, fontSize: 16))
                          ]),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MapScreen(),
                            ));
                          },
                          child: Container(
                            height: 143,
                            // padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image:
                                    const AssetImage("assets/images/map.png"),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.white.withOpacity(0.4),
                                    BlendMode.dstATop),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            const Row(children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.insert_photo_outlined,
                                color: kIconsColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('صورة الإقامة',
                                  style: TextStyle(
                                      color: kIconsColor, fontSize: 16))
                            ]),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) =>
                                        bottomSheet(isProfileImage: false)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(kRadius),
                                    border: Border.all(color: kBorderColor)),
                                child: _residencyImageFile == null
                                    ? const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 25),
                                        child: Center(
                                          child: Icon(
                                            Icons.add_photo_alternate,
                                            color: kIconsColor,
                                            size: 35,
                                          ),
                                        ),
                                      )
                                    : Image.file(
                                        _residencyImageFile!,
                                        fit: BoxFit.cover,
                                        height: 120,
                                        width: 120,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ReusableButton(
                          btnText: 'تسجيل جديد',
                          onTapFunction: () async {
                            if (_formKey.currentState!.validate()) {
                              Uint8List profileImageFile =
                                  await _profileImageFile!.readAsBytes();
                              Uint8List residencyImageFile =
                                  await _residencyImageFile!.readAsBytes();
                              List subCategoriesIds = [];
                              for (var item in selectedSubCategories) {
                                var index =
                                    subCategoriesNamesList.indexOf(item);
                                setState(() {
                                  subCategoriesIds
                                      .add('${subCategoriesIdsList[index]}');
                                });
                              }
                              var p = await signUp(
                                name: nameEditingController.text,
                                password: passwordEditingController.text,
                                email: emailEditingController.text,
                                city: '${cities.indexOf(selectedCity)}',
                                bankName: bankNameEditingController.text,
                                iban: bankNumberEditingController.text,
                                phone: phoneEditingController.text,
                                latitude: '${controller.lat}',
                                longitude: '${controller.long}',
                                profileImageFile: profileImageFile,
                                residencyImageFile: residencyImageFile,
                                subCategoriesIds: subCategoriesIds,
                              );
                              if (p == 'success') {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                    (route) => false);
                              } else {
                                // ignore: use_build_context_synchronously
                                ReusableSnackBar().showSnackBarMessage(
                                    isErrorSnackBar: true,
                                    context: context,
                                    message:
                                        'هنالك خطأ, تأكد من القيم التي أدخلتها');
                              }
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget bottomSheet({required bool isProfileImage}) {
    return Container(
      height: 150.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            'اختر صورة',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.camera,
                      color: kBasicColor,
                      size: 35,
                    ),
                    onPressed: () async {
                      //await takePhoto(ImageSource.camera);
                      final pickedFile = await _picker.pickImage(
                        source: ImageSource.camera,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          if (isProfileImage) {
                            _profileImageFile = File(pickedFile.path);
                          } else {
                            _residencyImageFile = File(pickedFile.path);
                          }
                        });
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    "الكاميرا",
                  ),
                ],
              ),
              const SizedBox(
                width: 90,
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.image,
                      color: kBasicColor,
                      size: 35,
                    ),
                    onPressed: () async {
                      // await takePhoto(ImageSource.gallery);
                      final pickedFile = await _picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          if (isProfileImage) {
                            _profileImageFile = File(pickedFile.path);
                          } else {
                            _residencyImageFile = File(pickedFile.path);
                          }
                        });
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    "المعرض",
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Future<String> imageToBase64String(File? imageFile) async {
    final bytes = File(imageFile!.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    return img64;
  }

  imageFromBase64String(String base64String) {
    final bytes = const Base64Decoder().convert(base64String);
    return bytes;
  }
}
