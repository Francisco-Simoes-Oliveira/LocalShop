import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final IconData icon;
  final Color color;

  CategoryModel({required this.name, required this.icon, required this.color});
}

class CategoryCarousel extends StatelessWidget {
  const CategoryCarousel({
    super.key,
    this.categories,
    this.onCategoryTap,
    this.onViewAllTap,
  });

  final List<CategoryModel>? categories;
  final Function(CategoryModel)? onCategoryTap;
  final VoidCallback? onViewAllTap;

  List<CategoryModel> get defaultCategories => [
    CategoryModel(
      name: 'Alimentação',
      icon: Icons.restaurant,
      color: const Color(0xFF2563EB),
    ),
    CategoryModel(
      name: 'Roupas',
      icon: Icons.shopping_bag,
      color: const Color(0xFF2563EB),
    ),
    CategoryModel(
      name: 'Eletrônicos',
      icon: Icons.devices,
      color: const Color(0xFF2563EB),
    ),
    CategoryModel(
      name: 'Casa',
      icon: Icons.home,
      color: const Color(0xFF2563EB),
    ),
    CategoryModel(
      name: 'Beleza',
      icon: Icons.spa,
      color: const Color(0xFF2563EB),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final categoriesList = categories ?? defaultCategories;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categorias',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: onViewAllTap,
                child: Text(
                  'Ver todas',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(
                categoriesList.length,
                (index) => _CategoryItem(
                  category: categoriesList[index],
                  onTap: () => onCategoryTap?.call(categoriesList[index]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({required this.category, required this.onTap});

  final CategoryModel category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(category.icon, color: Colors.grey.shade700, size: 36),
            ),
            const SizedBox(height: 10),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
