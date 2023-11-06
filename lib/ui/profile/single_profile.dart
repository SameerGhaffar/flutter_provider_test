import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/api_profile_data_model.dart';
import 'package:flutter_provider_test/ui/profile/profile_provider.dart';
import 'package:provider/provider.dart';

class SingleProfileView extends StatefulWidget {
  const SingleProfileView({super.key});

  @override
  State<SingleProfileView> createState() => _SingleProfileViewState();
}

class _SingleProfileViewState extends State<SingleProfileView> {
  late ProfileProvider providerData;

  @override
  void initState() {
    super.initState();

    providerData = context.read<ProfileProvider>();
    providerData.getSingleProfileFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Single Profile from Api")),
        body: Consumer<ProfileProvider>(
          builder: (BuildContext context,data, Widget? child) {
            providerData=data;
            return  providerData.singleProfileData == null ? const Center(child: CircularProgressIndicator()): Center(child: buildCard(providerData.singleProfileData!.data));

          },
        ));
  }

  Card buildCard(ProfileUserData item) {
    return Card(
      elevation: 5,
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.withOpacity(0.3),
              maxRadius: 90,
              minRadius: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Image.network(
                  item.networkImage,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(item
                  .firstName), //Text(providerData.getProfileData(index).firstName),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(item.lastName),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(item.email),
            ),
          ],
        ),
      ),
    );
  }
}
