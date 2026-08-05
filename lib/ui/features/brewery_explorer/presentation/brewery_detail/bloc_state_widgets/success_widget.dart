import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tech_challenge/core/navigation/url_helper.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/domain/brewery_detail_entity.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/brewery_detail/local_widgets/favorite_button.dart';
import 'package:tech_challenge/ui/features/brewery_explorer/presentation/constants/detail_consts.dart';

import '../local_widgets/detail_component.dart';
import '../local_widgets/website_component.dart';

class SuccessDetail extends StatelessWidget {
  const SuccessDetail({super.key, required this.brewery});

  final BreweryDetail brewery;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 28,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FavoriteButton(brewery: brewery),
                  SvgPicture.asset(
                    BreweryDetailUxHelper().beerAsset(brewery.name),
                    width: 90,
                    height: 90,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    brewery.name,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Divider(),
                  const SizedBox(height: 12),
                  if (brewery.addresses.isNotEmpty)
                    DetailComponent(
                      title: 'Addresses',
                      icon: Icons.location_on_outlined,
                      data: brewery.addresses,
                    ),
                  if (_hasValue(brewery.phone))
                    DetailComponent(
                      title: 'Phone',
                      icon: Icons.phone_outlined,
                      data: [brewery.phone!],
                    ),
                  if (_hasValue(brewery.website))
                    WebsiteComponent(
                      brewery: brewery,
                      onTap: () => _openWebsite(context),
                    ),
                  const SizedBox(height: 24),
                  Transform.rotate(
                    angle: 3.14159,
                    child: Opacity(
                      opacity: 0.55,
                      child: SvgPicture.asset(
                        BreweryDetailUxHelper().beerAsset(brewery.name),
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _hasValue(String? value) => value != null && value.trim().isNotEmpty;

  Future<void> _openWebsite(BuildContext context) async {
    final opened = await UrlHelper.openWebsite(brewery.website!);

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unable to open website')));
    }
  }
}
