// ignore_for_file: use_build_context_synchronously

import 'package:etag/cors/routes/routes.dart';
import 'package:etag/cors/shared/styles/styles.dart';
import 'package:etag/cors/shared/widgets/icon_button_widget.dart';
import 'package:etag/cors/shared/widgets/text_widget.dart';
import 'package:etag/ui/view/widgets/badge_widget.dart';
import 'package:etag/domain/model/category_model.dart';
import 'package:etag/ui/controller/option_controller.dart';
import 'package:etag/ui/controller/ordered_controller.dart';
import 'package:etag/ui/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class ProductPage extends StatelessWidget {
  final CategoryModel categoryModel;

  const ProductPage({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final product = Modular.get<ProductController>();
    final option = Modular.get<OptionController>();
    final ordered = Modular.get<OrderedControler>();
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    return Scaffold(
      backgroundColor: Styles.black,
      appBar: AppBar(
        title: const TextWidget(
          title: 'Produto',
        ),
        leading: IconButtonWidget(
          onPressed: () {
            product.clearListProduct();
            Modular.to.pop();
          },
          icon: Icons.chevron_left_outlined,
        ),
        actions: const [
          BadgeWidget(),
        ],
      ),
      body: FutureBuilder(
        future: product.getListProduct(
          valueCollum: categoryModel.idCategory,
        ),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.7,
                    ),
                    itemCount: product.listProduct.length,
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
                            await option.getListOption(productModel: product.listProduct[index]);
                            if (option.productSelect?.listOption.isNotEmpty ?? false) {
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
                                                  onTap: () {
                                                    option.setOption(index);
                                                    ordered.setOrderedItem(
                                                      productModel: product.listProduct[index],
                                                    );
                                                    Modular.to.pushNamed(Routes.ordered);
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
                              ordered.setOrderedItem(
                                productModel: product.listProduct[index],
                              );
                              Modular.to.pushNamed(Routes.ordered);
                            }
                          },
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                title: product.listProduct[index].name,
                                fontSize: 18,
                              ),
                              TextWidget(
                                title: product.listProduct[index].type,
                                fontSize: 16,
                              ),
                              TextWidget(
                                title: real.format(product.listProduct[index].value),
                                fontSize: 18,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
