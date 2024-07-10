import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/routes/routes_names.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final dynamic data;
  const HomeScreen({super.key, this.data});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewmodel = HomeViewViewModel();
  @override
  void initState() {
    homeViewmodel.fetchMoviesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPrefrence = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        actions: [
          InkWell(
              onTap: () {
                userPrefrence.removeUser().then((value) {
                  Navigator.pushNamed(context, RoutesNames.login);
                });
              },
              child: const Icon(Icons.logout))
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewmodel,
        child: Consumer<HomeViewViewModel>(
          builder: (context, value, child) {
            switch (value.moviesLIst.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.COMPLETED:
                return ListView.builder(
                    itemCount: value.moviesLIst.data!.movies!.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image(
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              value.moviesLIst.data!.movies![index].posterurl
                                  .toString(),
                            ),
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),
                          title: Text(value
                              .moviesLIst.data!.movies![index].title
                              .toString()),
                          subtitle: Text(value
                              .moviesLIst.data!.movies![index].year
                              .toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(Utils.averageRating(value
                                      .moviesLIst.data!.movies![index].ratings!)
                                  .toStringAsFixed(2)),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                            ],
                          ),
                        ),
                      );
                    }));
              default:
                return Center(child: Text(value.moviesLIst.message.toString()));
            }
          },
        ),
      ),
    );
  }
}
