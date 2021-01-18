import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/search/search.dart';
import 'package:share_ute/search_options/search_options.dart';
import 'package:share_ute/search_owner_tags/search_owner_tags.dart';
import 'package:share_ute/search_popular_tags/search_popular_tags.dart';
import 'package:share_ute/search_premium/search_premium.dart';
import 'package:search_repository/search_repository.dart';

class SearchPremiumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchPopularTagsCubit>(
          create: (context) => SearchPopularTagsCubit(
            searchCubit: context.read<SearchCubit>(),
            searchRepository: SearchRepository(),
          ),
        ),
        BlocProvider<SearchOwnerTagsCubit>(
          create: (context) => SearchOwnerTagsCubit(
            searchCubit: context.read<SearchCubit>(),
          ),
        ),
        BlocProvider<SearchOptionsCubit>(
          create: (context) => SearchOptionsCubit(
            searchCubit: context.read<SearchCubit>(),
            searchRepository: SearchRepository(),
          ),
        ),
      ],
      child: SearchPremiumForm(),
    );
  }
}
