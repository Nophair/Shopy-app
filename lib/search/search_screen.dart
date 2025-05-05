import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopy_app/components/components.dart';
import 'package:shopy_app/search/cubit/cubit.dart';
import 'package:shopy_app/search/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {  },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children:
                  [
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Text to Search';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        SearchCubit.get(context).search(value);
                      },
                      decoration: InputDecoration(
                        label: const Text(
                          'Search',
                          style: TextStyle(color: Colors.red),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
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
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(color: Colors.red,),
                    if(state is SearchSuccessState && SearchCubit.get(context).model != null && SearchCubit.get(context).model!.data.data.isNotEmpty)
                      Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model!.data.data[index], context, isOldPrice: false, isSearch: false),
                        separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15.0,),
                          child: Divider(color: Colors.white,),
                        ),
                        itemCount: SearchCubit.get(context).model!.data.data.length ,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
