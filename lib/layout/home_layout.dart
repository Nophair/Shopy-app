import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_app/components/components.dart';
import 'package:shopy_app/cubit/cubit.dart';
import 'package:shopy_app/cubit/states.dart';
import 'package:shopy_app/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) { },
      builder: (context, state)
      {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Shopy',
              style: TextStyle(
              fontFamily: 'NoyhR',
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
            ),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen(),);
                  },
                  icon: Icon(
                      Icons.search,
                  ),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index)
              {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                    ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.apps,
                    ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite_outline,
                    ),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle_outlined,
                    ),
                  label: 'Profile',
                ),
              ],
          ),
        );
      },
    );
  }
}
