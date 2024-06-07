import 'package:etag/cors/routes/routes.dart';
import 'package:etag/cors/shared/styles/styles.dart';
import 'package:etag/cors/shared/widgets/icon_button_widget.dart';
import 'package:etag/cors/shared/widgets/text_widget.dart';
import 'package:etag/ui/controller/ordered_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class OrderedPage extends StatelessWidget {
  const OrderedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ordered = Modular.get<OrderedControler>();
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    return ListenableBuilder(
      listenable: ordered,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Styles.black,
          appBar: AppBar(
            title: const TextWidget(
              title: 'Pedido',
            ),
            leading: IconButtonWidget(
              onPressed: () {
                Modular.to.pushNamed(Routes.home);
              },
              icon: Icons.chevron_left_outlined,
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              child: ordered.orderedSelect?.listOrderedItem.isEmpty ?? false
                  ? SizedBox(
                      height: size.height * 0.7,
                      child: Center(
                        child: Text(
                          'Seu carrinho está vazio',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Styles.grey,
                          ),
                        ),
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (_, __) => const Padding(padding: EdgeInsets.all(8)),
                      shrinkWrap: true,
                      itemCount: ordered.orderedSelect?.listOrderedItem.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: Styles.sky,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                title: ordered.orderedSelect?.listOrderedItem[index].productModel.name ?? '',
                                                fontSize: 18,
                                              ),
                                              const SizedBox(height: 5),
                                              if (ordered.orderedSelect?.listOrderedItem[index].productModel.listOption.isNotEmpty ?? false)
                                                TextWidget(
                                                  title:
                                                      '  + ${ordered.orderedSelect?.listOrderedItem[index].productModel.listOption[0].quantity ?? 0.00} ${ordered.orderedSelect?.listOrderedItem[index].productModel.listOption[0].name ?? ''} ',
                                                  fontSize: 16,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      TextWidget(
                                        title: real.format(ordered.orderedSelect?.listOrderedItem[index].valueItem ?? 0.00),
                                        fontSize: 18,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              IconButtonWidget(
                                                onPressed: () {
                                                  ordered.decreaseQuantity(index);
                                                },
                                                icon: Icons.remove,
                                              ),
                                              TextWidget(
                                                title: '${ordered.orderedSelect?.listOrderedItem[index].quantity}',
                                                fontSize: 18,
                                              ),
                                              IconButtonWidget(
                                                onPressed: () {
                                                  ordered.increaseQuantity(index);
                                                },
                                                icon: Icons.add,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Styles.grey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  title: 'Total: ${real.format(ordered.orderedSelect?.valueTotal ?? 0.00)}',
                  fontSize: 18,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: Styles.sky,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.transparent),
                      shadowColor: WidgetStateProperty.all(Colors.transparent),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (ordered.orderedSelect?.listOrderedItem.isNotEmpty ?? false) {
                        // await ordered.setOrderedService();
                        // await ordered.setOrderedItemService();
                        await ordered.clearOrder();
                        await Modular.to.pushNamed(Routes.home);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: const Text('Seu carrinho está vazio. Adicione itens para continuar.'), backgroundColor: Styles.red),
                        );
                      }
                    },
                    child: const TextWidget(
                      title: 'Finalizar Carrinho',
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
