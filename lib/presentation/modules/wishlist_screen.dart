import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_app/business_logic/cubit/cubit.dart';
import 'package:talabat_app/business_logic/cubit/states.dart';
import 'package:talabat_app/data/models/favorite_model.dart';
import 'package:talabat_app/shared/components/components.dart';
import 'package:talabat_app/shared/constants.dart';

class WhishListScreen extends StatelessWidget {
  const WhishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        var favorites = AppCubit.get(context).favoriteProducts;

        return Scaffold(
          appBar: DefaultAppBar(title: 'Whish List', context: context),
          body: Padding(
            padding: paddingAll,
            child: ListView.separated(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: buildFavoriteItem(context, favorites[index]),
              ),
              separatorBuilder: (context, index) => const MyDivider(),
              itemCount: favorites.length,
            ),
          ),
        );
      },
    );
  }

  Widget buildFavoriteItem(BuildContext context, FavoriteModel model) {
    return SizedBox(
      height: 100.0,
      child: Row(
        children: [
          SizedBox(
            width: 150.0,
            height: 120.0,
            child: Image(
              image: NetworkImage(model.image),
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${model.price}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context)
                            .removeFavoriteProduct(model.productId);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: AppCubit.get(context)
                                .favorites
                                .contains(model.productId)
                            ? Colors.red
                            : Colors.grey,
                        child: const Icon(
                          Icons.favorite_outlined,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
