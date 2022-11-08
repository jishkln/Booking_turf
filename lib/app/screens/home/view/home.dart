import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/home/controller/geolocator.dart';
import 'package:truff_majestic/app/screens/home/view/detail_page.dart';
import 'package:truff_majestic/app/screens/home/widget/coustom_details.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/constants/size_constants.dart';
import 'package:truff_majestic/app/utils/initsatate.dart';
import 'package:truff_majestic/app/utils/navigation.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context);

    return StatefulWrapper(
      onInit: () {
        provider.locationCurent(context);
        provider.viewNreabyTurf();

        provider.locationCurent(context);

        provider.allTruff();
      },
      child: Scaffold(
        backgroundColor: backGrountColor,
        appBar: AppBar(
          title: Selector<LocationProvider, bool>(
              selector: (context, isLoaging) => isLoaging.isLoading,
              builder: (context, isLoading, _) {
                return isLoading
                    ? const CupertinoActivityIndicator()
                    : Text("${provider.currentAddress}");
              }),
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
        ),
        body: SafeArea(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          color: backGrountColor,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              const SizedBox(
                width: double.infinity,
                height: 50,
                child: CupertinoSearchTextField(
                  
                ),
              ),
              kHight20,
              Card(
                color: backGrountColor,
                elevation: 0,
                child: ListTile(
                  style: ListTileStyle.drawer,
                  tileColor: bgCntnrColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 0.0),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    maxRadius: 70,
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: Colors.blue,
                    ),
                  ),
                  title: Text(
                    "Sayana",
                    style: TurffTheme.lightTextTheme.headline2,
                  ),
                  subtitle: Text(
                    "Welcome",
                    style: TurffTheme.lightTextTheme.headline4,
                  ),
                ),
              ),
              kHight30,
              Text(
                "NearBy Turf",
                style: TurffTheme.lightTextTheme.headline2,
              ),
              kHight20,
              Selector<LocationProvider, bool>(
                  selector: (context, isLoading) => isLoading.isLoading,
                  builder: (context, isLoading, _) {
                    if (isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    } else {
                      return provider.nearTurfList.isEmpty
                          ? const Center(child: Text("No Nearest Turf"))
                          : Consumer<LocationProvider>(
                              builder: (context, value, _) {
                              return GridView.builder(
                                itemCount: value.nearTurfList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // crossAxisSpacing: 10.0,
                                  // mainAxisSpacing: 10.0,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  final data = provider.nearTurfList[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: InkWell(
                                      onTap: () {
                                        NavigationServices.push(
                                            screen: DetailPage(data: data));
                                      },
                                      child: CoustomContainerWidget(
                                        image: data.turfLogo.toString(),
                                        location:
                                            "${data.turfPlace},${data.turfMunicipality}"
                                                .toString(),
                                        title: data.turfName.toString(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                    }
                  }),
              kHight10,
              Text(
                "All Turf",
                style: TurffTheme.lightTextTheme.headline2,
              ),
              kHight10,
              Selector<LocationProvider, bool>(
                  selector: (context, isLoading) => isLoading.isLoading,
                  builder: (context, isLoading, _) {
                    return isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Consumer<LocationProvider>(
                            builder: (context, value, _) {
                            return GridView.builder(
                              itemCount: value.turfList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // crossAxisSpacing: 10.0,
                                // mainAxisSpacing: 10.0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                final data = provider.turfList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: InkWell(
                                    onTap: () {
                                      NavigationServices.push(
                                          screen: DetailPage(data: data));
                                    },
                                    child: CoustomContainerWidget(
                                      image: data.turfLogo.toString(),
                                      location:
                                          "${data.turfPlace},${data.turfMunicipality}"
                                              .toString(),
                                      title: data.turfName.toString(),
                                    ),
                                  ),
                                );
                              },
                            );
                          });
                  })
            ],
          ),
        )),
      ),
    );
  }
}
