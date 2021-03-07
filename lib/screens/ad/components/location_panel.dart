import 'package:flutter/material.dart';
import 'package:xlo_mobx2/models/ad.dart';

class LocationPanel extends StatelessWidget {
  LocationPanel(this.ad);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 12),
          child: Text(
            'Localização',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CEP', style: TextStyle(fontWeight: FontWeight.w500),),
                    SizedBox(height: 12),
                    Text('Município', style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(height: 12),
                    Text('Bairro', style: TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${ad.address.cep}',
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      '${ad.address.city.name}',
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      ad.address.district != ''
                          ? '${ad.address.district}'
                          : '-',
                    ),
                    SizedBox(
                      height: 12,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
