import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx2/screens/filter/components/section_title.dart';
import 'package:xlo_mobx2/stores/filter_store.dart';

class OrderByField extends StatelessWidget {
  OrderByField(this.filter);

  final FilterStore filter;

  @override
  Widget build(BuildContext context) {
    Widget buildOption(String title, OrderBy option) {
      return GestureDetector(
        onTap: () {
          filter.setOrderBy(option);
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color:
                  filter.orderBy == option ? Colors.purple : Colors.transparent,
              border: Border.all(
                  color:
                      filter.orderBy == option ? Colors.purple : Colors.grey)),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                color: filter.orderBy == option ? Colors.white : Colors.black),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Ordernar por'),
        Observer(
          builder: (_) => Row(
            children: [
              buildOption('Data', OrderBy.DATE),
              const SizedBox(
                width: 12,
              ),
              buildOption('Preço', OrderBy.PRICE),
            ],
          ),
        )
      ],
    );
  }
}
