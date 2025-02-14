import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:module_a1/src/screens/main/basket/basket_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final basket = Provider.of<BasketModel>(context);
    final isInBasket =
        basket.items.any((item) => item['name'] == product['name']);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(product['name']),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey3,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Icon(
                CupertinoIcons.photo,
                size: 60,
                color: CupertinoColors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text('Цена'),
                  const SizedBox(height: 20),
                  Text(
                    product['description'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: isInBasket
                  ? const Text(
                      'Товар уже есть в корзине',
                      style: TextStyle(
                        fontSize: 18,
                        color: CupertinoColors.systemGrey,
                      ),
                    )
                  : CupertinoButton.filled(
                      child: const Text('Добавить в корзину'),
                      onPressed: () {
                        basket.addItem(product);
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: const Text('Успешно'),
                              content:
                                  Text('${product['name']} добавлен в корзину'),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
