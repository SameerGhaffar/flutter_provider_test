import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/api_profile_data_model.dart';
import 'package:flutter_provider_test/ui/profile/profile_provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileProvider providerData;

  @override
  void initState() {
    super.initState();

    providerData = context.read<ProfileProvider>();
    providerData.getProfileList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data coming from Api"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => providerData.pagingController.refresh(),
        child: PagedListView<int, ProfileUserData>(
          pagingController: providerData.pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            firstPageProgressIndicatorBuilder: (context) =>
                const Center(child: CircularProgressIndicator()),
            itemBuilder: (context, item, index) {
              return buildCard(item);
            },
          ),
        ),
      ),
    );
  }

  Card buildCard(ProfileUserData item) {
    return Card(
      elevation: 5,
      child: Container(
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
