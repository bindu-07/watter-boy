import 'package:flutter/material.dart';

class DeliveryBoy {
  final String name;
  final double distance; // in km
  final double rate; // in currency
  final String imageUrl;

  final double rating;

  DeliveryBoy({
    required this.name,
    required this.distance,
    required this.rate,
    required this.imageUrl,
    required this.rating,
  });
}

class DeliveryBoySelector extends StatefulWidget {
  const DeliveryBoySelector({super.key});

  @override
  State<DeliveryBoySelector> createState() => _DeliveryBoySelectorState();
}

class _DeliveryBoySelectorState extends State<DeliveryBoySelector> {
  final List<DeliveryBoy> _deliveryBoys = [
    DeliveryBoy(
        name: "John",
        imageUrl: "https://i.pravatar.cc/150?img=1",
        distance: 1.2,
        rate: 40,
        rating: 4.8),
    DeliveryBoy(
        name: "Aamir",
        imageUrl: "https://i.pravatar.cc/150?img=2",
        distance: 2.0,
        rate: 30,
        rating: 4.5),
    DeliveryBoy(
        name: "Priya",
        imageUrl: "https://i.pravatar.cc/150?img=3",
        distance: 0.8,
        rate: 45,
        rating: 4.9),
    DeliveryBoy(
        name: "Kiran",
        imageUrl: "https://i.pravatar.cc/150?img=4",
        distance: 3.5,
        rate: 35,
        rating: 4.6),
  ];

  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _deliveryBoys.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final boy = _deliveryBoys[index];
          final isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 160,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.shade50 : Colors.white,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.shade200,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  CircleAvatar(
                    backgroundImage: NetworkImage(boy.imageUrl),
                    radius: 26,
                  ),
                  const SizedBox(height: 8),

                  // Name
                  Text(
                    boy.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 4),

                  // Distance and Rate
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("📍 ${boy.distance} km",
                          style: const TextStyle(fontSize: 12)),
                      Text("₹${boy.rate}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12)),
                    ],
                  ),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star,
                          color: Colors.amber, size: 14),
                      Text(
                        boy.rating.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),

                  const Spacer(),

                  if (isSelected)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.check_circle,
                          color: Colors.blue, size: 20),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}