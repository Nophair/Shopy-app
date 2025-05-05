import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_app/components/components.dart';
import 'package:shopy_app/components/constants.dart';
import 'package:shopy_app/cubit/app_cubit.dart';
import 'package:shopy_app/cubit/app_states.dart';
import 'package:shopy_app/layout/home_layout.dart';
import 'package:shopy_app/modules/register/register_screen.dart';
import 'package:shopy_app/network/local/cache_helper.dart';
import 'package:shopy_app/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState)
          {
            final loginModel = state.loginModel;
            if (loginModel.status ?? false)
            {
              print(loginModel.message);
              print(loginModel.data?.token);

              CacheHelper.saveData(
                key: 'token',
                value: loginModel.data?.token,
              ).then((value) {
                token = loginModel.data?.token;
                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });
            } else
            {
                print(loginModel.message ?? 'Unknown error occurred');
                showToast(
                  text: loginModel.message ?? 'Unknown error occurred',
                    state: ToastStates.ERROR,
                );
              }
          }
        },
        builder: (context, state)
        {
          final isDarkMode = AppCubit.get(context).isDark;
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/welcome.png',
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 40.0,
                              color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          'Login now to Browse our hot offers',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey,),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email Address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label:  Text(
                              'Email Address',
                              style: TextStyle(color: Colors.red),
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
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
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) {
                            if(formKey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          obscureText: ShopLoginCubit.get(context).isPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: ()
                              {
                                ShopLoginCubit.get(context).changePasswordVisibility();
                                },
                              icon: Icon(Icons.visibility_outlined),
                              color: Colors.red,
                            ),
                            label:  Text(
                              'Password',
                              style: TextStyle(color: Colors.red),
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
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
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            width: double.infinity,
                            background: defaultColor,
                            onPressed: ()
                            {
                              if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                            },
                            text: 'Login',
                            isUpperCase: true,
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              'Don\'t have an account?',
                               style: TextStyle(color: Colors.grey),
                            ),
                            defaultTextButton(
                              onPressed: (){
                                navigateTo(
                                  context,
                                  const RegisterScreen(),
                                );
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
