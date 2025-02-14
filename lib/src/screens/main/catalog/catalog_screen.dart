import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:module_a1/src/screens/main/catalog/product_detail_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> filteredProducts = [];
  bool isLoading = true;
  String? errorMessage;

  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final Dio dio = Dio();
      final response = await dio.get('http://10.0.2.2:53000/products');

      if (response.statusCode == 200 && response.data is List) {
        setState(() {
          products = List<Map<String, dynamic>>.from(response.data);
          filteredProducts = products;
        });
      } else {
        setState(() {
          errorMessage = 'Error to loading';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filteredProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product['name']?.toLowerCase().contains(query.toLowerCase()) ??
              false ||
                  product['description']
                      ?.toLowerCase()
                      .contains(query.toLowerCase()) ??
              false)
          .toList();
    });
  }

  void _navigateToProductScreen(Map<String, dynamic> product) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Каталог'),
        ),
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CupertinoTextField(
                placeholder: 'Поиск',
                controller: searchController,
                obscureText: false,
                onChanged: _filteredProducts,
              ),
            ),
            if (isLoading)
              Center(
                child: CupertinoActivityIndicator(),
              )
            else if (errorMessage != null)
              Center(
                child: Text(errorMessage!),
              )
            else if (filteredProducts.isEmpty)
              Center(
                child: Text('Нет товаров соответствущих запросу'),
              )
            else
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return CupertinoButton(
                        padding: EdgeInsets.all(3),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey3,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(
                                  CupertinoIcons.photo,
                                  size: 40,
                                  color: CupertinoColors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      product['description'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: CupertinoColors.systemGrey,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          _navigateToProductScreen(product);
                        },
                      );
                    }),
              ))
          ],
        )));
  }
}
