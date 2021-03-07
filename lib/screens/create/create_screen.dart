import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx2/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx2/components/error_box.dart';
import 'package:xlo_mobx2/models/ad.dart';
import 'package:xlo_mobx2/screens/create/components/category_field.dart';
import 'package:xlo_mobx2/screens/create/components/cep_field.dart';
import 'package:xlo_mobx2/screens/create/components/hide_fone_field.dart';
import 'package:xlo_mobx2/screens/myads/my_ads_screen.dart';
import 'package:xlo_mobx2/stores/create_store.dart';
import 'package:xlo_mobx2/stores/page_store.dart';
import 'components/images_field.dart';

class CreateScreen extends StatefulWidget {
  final Ad ad;

  CreateScreen({this.ad});

  @override
  _CreateScreenState createState() => _CreateScreenState(ad);
}

class _CreateScreenState extends State<CreateScreen> {
  _CreateScreenState(Ad ad)
      : editing = ad != null,
        createStore = CreateStore(ad ?? Ad());

  final CreateStore createStore;

  bool editing;

  @override
  void initState() {
    super.initState();
    when((_) => createStore.savedAd, () {
      if (editing) {
        Navigator.of(context).pop(true);
      } else {
        GetIt.I<PageStore>().setPage(0);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MyAdsScreen(
              initialPage: 1,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = const TextStyle(
        fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18);
    final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(editing ? 'Editar Anúncio' : 'Criar Anúncio'),
          centerTitle: true,
        ),
        drawer: editing ? null : CustomDrawer(),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Card(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    (16),
                  ),
                ),
                child: Observer(builder: (_) {
                  if (createStore.loading) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            'Salvando Anúncio',
                            style:
                                TextStyle(fontSize: 18, color: Colors.purple),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.purple),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ImagesField(createStore),
                        Observer(
                          builder: (_) {
                            return TextFormField(
                              initialValue: createStore.title,
                              decoration: InputDecoration(
                                labelText: 'Título *',
                                labelStyle: labelStyle,
                                contentPadding: contentPadding,
                                errorText: createStore.titleError,
                              ),
                              onChanged: createStore.setTitle,
                            );
                          },
                        ),
                        Observer(
                          builder: (_) => TextFormField(
                            initialValue: createStore.description,
                            onChanged: createStore.setDescription,
                            decoration: InputDecoration(
                              labelText: 'Descrição *',
                              labelStyle: labelStyle,
                              contentPadding: contentPadding,
                              errorText: createStore.descriptionError,
                            ),
                            maxLines: null,
                          ),
                        ),
                        CategoryField(createStore),
                        CepField(createStore),
                        Observer(
                          builder: (_) => TextFormField(
                            initialValue: createStore.priceText,
                            onChanged: createStore.setPrice,
                            decoration: InputDecoration(
                                errorText: createStore.priceError,
                                labelText: 'Preço *',
                                labelStyle: labelStyle,
                                contentPadding: contentPadding,
                                prefixText: 'R\$ '),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              RealInputFormatter(centavos: true),
                            ],
                          ),
                        ),
                        HidePhoneField(createStore),
                        Observer(
                          builder: (_) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            child: ErrorBox(
                              message: createStore.error,
                            ),
                          ),
                        ),
                        Observer(
                          builder: (_) => SizedBox(
                            height: 50,
                            child: GestureDetector(
                              onTap: createStore.invalidSendPressed,
                              child: ElevatedButton(
                                onPressed: createStore.sendPressed,
                                child: Text(
                                  'Enviar',
                                  style: TextStyle(fontSize: 18),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.orange.withAlpha(150);
                                    } else {
                                      return Colors.orange;
                                    }
                                  }),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                })),
          ),
        ),
      ),
    );
  }
}
