import 'package:flutter/cupertino.dart';
import 'package:module_a1/src/screens/main/basket/basket_model.dart';
import 'package:module_a1/src/screens/main_screen.dart';
import 'package:provider/provider.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final basket = Provider.of<BasketModel>(context);
    final int cost = 24000;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Корзина'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.trash),
          onPressed: () {
            // Очистка корзины полностью
            basket.clearBasket();
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: basket.items.isEmpty
                  ? const Center(child: Text('Корзина пуста'))
                  : ListView.builder(
                      itemCount: basket.items.length,
                      itemBuilder: (context, index) {
                        final product = basket.items[index];

                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: CupertinoColors.systemGrey3,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['name'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${cost} ₸',
                                        style: const TextStyle(
                                            color: CupertinoColors.systemGrey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: const Icon(CupertinoIcons.trash,
                                        size: 30,
                                        color: CupertinoColors.systemRed),
                                    onPressed: () =>
                                        basket.removeProductCompletely(product),
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: const Icon(
                                        CupertinoIcons.minus_circled,
                                        size: 30,
                                        color: CupertinoColors.systemGrey),
                                    onPressed: () => basket.removeItem(product),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      '${product['quantity']} шт',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: const Icon(
                                        CupertinoIcons.add_circled,
                                        size: 30,
                                        color: CupertinoColors.activeBlue),
                                    onPressed: () => basket.addItem(product),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            if (basket.items.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: CupertinoColors.white,
                  border: Border(
                      top: BorderSide(
                          color: CupertinoColors.systemGrey4, width: 1)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Вся сумма',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${basket.totalPrice} ₸',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton.filled(
                        child: const Text('Оформить заказ'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            if (basket.items.isEmpty)
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    child: const Text('Перейти в каталог'),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => MainScreen()),
                          (route) => false);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
