import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/component/components.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchModel? searchModel = SearchCubit.get(context).searchModel;
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: defaultTextField(
                      controller: searchController,
                      hint: 'Search',
                      prefix: Icons.search,
                      validFunction: (value){
                        if(value.isEmpty){
                          return 'Enter text to search';
                        }
                        return null;
                      },
                      submitFunction: (value){
                        if(formKey.currentState!.validate()){
                          SearchCubit.get(context).searchProduct(value);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if(state is SearchLoadingState)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: LinearProgressIndicator(),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  if(searchModel != null)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => productListBuilder(searchModel.data!.data![index], context,isSearch: true),
                        separatorBuilder: (context, index) =>
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[300],
                              margin: EdgeInsets.symmetric(horizontal: 15),
                            ),
                        itemCount: searchModel.data!.data!.length,
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
