import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/userinput.dart';
import 'package:flutter_application_3/constant/theme.dart';
import 'package:flutter_application_3/database/collegedatabase.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

class PostDataPage extends StatefulWidget {
  const PostDataPage({super.key});

  @override
  State<PostDataPage> createState() => _PostDataPageState();
}

class _PostDataPageState extends State<PostDataPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController regController = TextEditingController();
  TextEditingController deptController = TextEditingController();
  TextEditingController collegeController = TextEditingController();

  CollegeDataBase collegeDataBase = Get.put(CollegeDataBase());
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          size: 20,
          color: white,
        ),
        backgroundColor: orange,
        centerTitle: false,
        title: Text(
          "Students Data",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Row(
            children: [
              const Gap(20),
              UserInputBar(
                txt: 'Enter Name',
                type: TextInputType.name,
                height: screensize.height * 0.06,
                width: screensize.width * 0.4,
                controller: nameController,
              ),
              const Gap(10),
              UserInputBar(
                txt: 'Enter Register Number',
                type: TextInputType.name,
                height: screensize.height * 0.06,
                width: screensize.width * 0.4,
                controller: regController,
              )
            ],
          ),
          const Gap(30),
          UserInputBar(
            txt: 'Enter Department',
            type: TextInputType.text,
            height: screensize.height * 0.06,
            width: screensize.width * 0.8,
            controller: deptController,
          ),
          const Gap(30),
          UserInputBar(
            txt: 'Enter College',
            type: TextInputType.text,
            height: screensize.height * 0.06,
            width: screensize.width * 0.8,
            controller: collegeController,
          ),
          const Gap(30),
          InkWell(
              onTap: () async {
                Map<String, dynamic> userdata = {
                  'name': nameController.text,
                  'reg': regController.text,
                  'department': deptController.text,
                  'college': collegeController.text,
                };
                await collegeDataBase.InsertData(userdata);
              },
              child: Container(
                height: screensize.height * 0.06,
                width: screensize.width * 0.4,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Submit",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w600, color: white),
                ),
              )),
        ]),
      ),
    );
  }
}
