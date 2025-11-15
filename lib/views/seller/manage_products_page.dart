import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/auth_provider.dart';
import 'add_product_page.dart'; // Import the page to navigate to

class ManageProductsPage extends StatelessWidget {
  const ManageProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    // Get the currently logged-in user
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // --- Mock Logic for Seller Shop Name ---
    // In a real app, this shop name would be stored in the AppUser object.
    // For now, we'll check the mock email.
    final String sellerShopName;
    if (authProvider.currentUser?.email == 'seller@test.com') {
      // This email corresponds to the "Java Crafts" shop in the dummy data
      sellerShopName = 'Java Crafts';
    } else {
      // A default for any other user who became a seller
      sellerShopName = authProvider.currentUser?.email ?? 'My Shop';
    }
    // ------------------------------------

    // Filter the global product list to get only this seller's products
    final sellerProducts = productProvider.getProductsByShop(sellerShopName);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
      ),
      body: sellerProducts.isEmpty
          ? Center(
        child: Text(
          'You have not added any products yet.',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
        ),
      )
          : ListView.builder(
        itemCount: sellerProducts.length,
        itemBuilder: (context, index) {
          final product = sellerProducts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(product.imageUrl),
              // Fallback for broken images
              onBackgroundImageError: (e, s) => const Icon(Icons.image_not_supported),
            ),
            title: Text(product.name),
            subtitle: Text('Stock: ${product.stock}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // TODO: Navigate to Edit Product Page
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit product (not implemented yet)')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Show a confirmation dialog before deleting
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Are you sure?'),
                        content: Text('Do you want to delete ${product.name}?'),
                        actions: [
                          TextButton(
                            child: const Text('No'),
                            onPressed: () => Navigator.of(ctx).pop(),
                          ),
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () {
                              // Call the provider to delete the product
                              productProvider.deleteProduct(product.name);
                              Navigator.of(ctx).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the AddProductPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}