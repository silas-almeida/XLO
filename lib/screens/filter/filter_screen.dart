import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx2/screens/filter/components/orderby_field.dart';
import 'package:xlo_mobx2/screens/filter/components/price_range_field.dart';
import 'package:xlo_mobx2/stores/filter_store.dart';
import 'package:xlo_mobx2/stores/home_store.dart';

import 'components/vendor_type_field.dart';

class FilterScreen extends StatelessWidget {
  final FilterStore filter = GetIt.I<HomeStore>().clonedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar Busca'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OrderByField(filter),
                PriceRangeField(filter),
                VendorTypeField(filter),
                Observer(
                  builder: (_) => Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: filter.isFormValid
                          ? () {
                              filter.save();
                              Navigator.of(context).pop();
                            }
                          : null,
                      child: Text(
                        'Filtrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.orange.withAlpha(150);
                          } else {
                            return Colors.orange;
                          }
                        }),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
