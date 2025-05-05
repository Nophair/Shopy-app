import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_app/components/constants.dart';
import 'package:shopy_app/cubit/app_cubit.dart';
import 'package:shopy_app/cubit/cubit.dart';
import 'package:shopy_app/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        final isDarkMode = AppCubit.get(context).isDark;
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(color: Colors.red,),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label:  Text(
                          'Name',
                          style: TextStyle(color: Colors.red),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.red,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label:  Text(
                          'Email Address',
                          style: TextStyle(color: Colors.red),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.red,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label:  Text(
                          'Phone',
                          style: TextStyle(color: Colors.red),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.red,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                        10.0,
                       ),
                        color: Colors.red,
                      ),
                      child: MaterialButton(
                        height: 50.0,
                        onPressed: ()
                        {
                          if(formKey.currentState!.validate())
                          {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        child: Text(
                          'UPDATE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        color: Colors.red,
                      ),
                      child: MaterialButton(
                        height: 50.0,
                        onPressed: ()
                        {
                          signOut(context);
                        },
                        child: Text(
                          'LOGOUT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0,),
                            color: Colors.red,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Darkmode',
                              style: TextStyle(
                                fontFamily: 'NoyhR',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child: IconButton(
                            color: isDarkMode ? Colors.white : Colors.black,
                            icon: Icon(
                              AppCubit.get(context).isDark ? Icons.dark_mode : Icons.dark_mode_outlined,
                            ),
                            onPressed: ()
                            {
                              AppCubit.get(context).changeAppMode(fromShared: null);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.red,)),
        );
      },
    );
  }
}
