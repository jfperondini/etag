import 'package:etag/cors/routes/routes.dart';
import 'package:etag/cors/shared/styles/styles.dart';
import 'package:etag/cors/shared/widgets/icon_button_widget.dart';
import 'package:etag/cors/shared/widgets/text_widget.dart';
import 'package:etag/ui/controller/ordered_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:badges/badges.dart' as badges;

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ordered = Modular.get<OrderedControler>();
    return ListenableBuilder(
      listenable: ordered,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            badgeAnimation: const badges.BadgeAnimation.slide(
              disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
              curve: Curves.easeInCubic,
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: Styles.red,
            ),
            badgeContent: TextWidget(
              title: '${ordered.orderedSelect?.listOrderedItem.length ?? ''}',
              fontSize: 14,
            ),
            child: IconButtonWidget(
              onPressed: () {
                Modular.to.pushNamed(
                  Routes.ordered,
                );
              },
              icon: Icons.shopping_cart,
            ),
          ),
        );
      },
    );
  }
}
