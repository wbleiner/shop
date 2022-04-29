import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  final _expandDuration = 300;

  @override
  Widget build(BuildContext context) {
    final _itemsHeigth = (widget.order.products.length * 24.0) + 10;
    return AnimatedContainer(
      height: _expanded ? _itemsHeigth + 80 : 80,
      duration: Duration(milliseconds: _expandDuration),
      child: Card(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: _expandDuration),
              height: _expanded ? _itemsHeigth : 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: ListView(
                children: widget.order.products.map(
                  (product) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${product.quantity}x R\$ ${product.price}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    );
                  },
                ).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
