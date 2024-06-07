import 'package:etag/cors/routes/routes.dart';
import 'package:etag/cors/shared/styles/styles.dart';
import 'package:etag/cors/shared/widgets/text_widget.dart';
import 'package:etag/ui/controller/option_controller.dart';
import 'package:etag/ui/view/widgets/badge_widget.dart';
import 'package:etag/cors/shared/widgets/text_field_form_wdiget.dart';
import 'package:etag/ui/controller/home_controller.dart';
import 'package:etag/ui/controller/ordered_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  final dynamic args;
  const HomePage({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final home = Modular.get<HomeController>();
    final ordered = Modular.get<OrderedControler>();
    final option = Modular.get<OptionController>();
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    return FutureBuilder(
      future: home.filterListEvent(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Styles.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                const TextWidget(
                  title: 'eTag',
                ),
                const SizedBox(
                  width: 15,
                ),
                TextWidget(
                  title: '${home.eventSelect?.name ?? ''} ${home.eventSelect?.date ?? ''}',
                  fontSize: 14,
                ),
              ],
            ),
            actions: const [
              BadgeWidget(),
            ],
          ),
          body: AnimatedBuilder(
            animation: home,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFieldFormWidget(
                      controller: home.search,
                      hintText: 'Buscar por nome',
                      icon: Icons.search,
                      onTap: () async {
                        await home.filterListProduct();
                      },
                      onPressed: () async {
                        await home.clearSearch();
                        await home.clearListFilterProduct();
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    if (home.listFilterProduct.isNotEmpty)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.7,
                                ),
                                itemCount: home.listFilterProduct.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: Styles.sky,
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: ListTile(
                                      onTap: () async {
                                        if (ordered.orderedSelect?.listOrderedItem.isNotEmpty != true) {
                                          await ordered.setOrdered();
                                        }
                                        await option.getListOption(productModel: home.listFilterProduct[index]);
                                        await ordered.setOrderedItem(productModel: home.listFilterProduct[index]);
                                        if (home.listFilterProduct[index].listOption.isNotEmpty) {
                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Container(
                                                  width: size.width * 1,
                                                  height: size.height * 0.3,
                                                  padding: const EdgeInsets.all(18),
                                                  color: Styles.black,
                                                  child: Column(
                                                    children: [
                                                      TextWidget(
                                                        title: 'Escolha o acompanhamento para o combo ${option.productSelect?.name ?? ''}',
                                                        fontSize: 18,
                                                      ),
                                                      const SizedBox(height: 16),
                                                      GridView.builder(
                                                        padding: EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          childAspectRatio: 2,
                                                        ),
                                                        itemCount: option.productSelect?.listOption.length,
                                                        itemBuilder: (context, index) {
                                                          return Container(
                                                            margin: const EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: Styles.sky,
                                                                begin: Alignment.centerLeft,
                                                                end: Alignment.centerRight,
                                                              ),
                                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                            ),
                                                            child: ListTile(
                                                              onTap: () async {
                                                                await option.setOption(index);
                                                                await home.clearSearch();
                                                                await home.clearListFilterProduct();
                                                                await Modular.to.pushNamed(Routes.ordered);
                                                              },
                                                              title: TextWidget(
                                                                title: option.productSelect?.listOption[index].name ?? '',
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          await home.clearSearch();
                                          await home.clearListFilterProduct();
                                          await Modular.to.pushNamed(Routes.ordered);
                                        }
                                      },
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            title: home.listFilterProduct[index].name,
                                            fontSize: 18,
                                          ),
                                          TextWidget(
                                            title: home.listFilterProduct[index].type,
                                            fontSize: 16,
                                          ),
                                          TextWidget(
                                            title: real.format(home.listFilterProduct[index].value),
                                            fontSize: 18,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (home.listFilterProduct.isEmpty)
                      FutureBuilder(
                        future: home.getListCategory(),
                        builder: (context, snapshot) {
                          return Expanded(
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: home.listCategory.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: size.height * 0.065,
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: Styles.sky,
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                                    child: ListTile(
                                      onTap: () {
                                        if (ordered.orderedSelect?.listOrderedItem.isNotEmpty != true) {
                                          ordered.setOrdered();
                                        }
                                        Modular.to.pushNamed(
                                          Routes.product,
                                          arguments: {
                                            'categoryModel': home.listCategory[index],
                                          },
                                        );
                                      },
                                      title: TextWidget(
                                        title: home.listCategory[index].type,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
