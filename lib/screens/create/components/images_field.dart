import 'dart:io';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx2/stores/create_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx2/screens/create/components/image_source_modal.dart';
import 'package:xlo_mobx2/screens/create/components/image_dialog.dart';

class ImagesField extends StatelessWidget {
  final CreateStore createStore;

  ImagesField(this.createStore);

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      createStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          height: 120,
          child: Observer(
            builder: (_) => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: createStore.images.length < 5
                  ? createStore.images.length + 1
                  : createStore.images.length,
              itemBuilder: (_, index) {
                if (index == createStore.images.length ?? true) {
                  return GestureDetector(
                    onTap: () {
                      if (Platform.isAndroid) {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => ImageSourceModal(onImageSelected),
                        );
                      } else {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (_) => ImageSourceModal(onImageSelected),
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        8,
                        16,
                        index == 4 ? 8 : 0,
                        16,
                      ),
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.grey[400],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => ImageDialog(
                          image: createStore.images[index],
                          onDelete: () => createStore.images.removeAt(index),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 7),
                      child: CircleAvatar(
                        radius: 44,
                        backgroundImage: FileImage(createStore.images[index]),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Observer(builder: (_) {
          if (createStore.imagesError != null)
            return Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
              decoration: BoxDecoration(
                  border: const Border(
                top: BorderSide(color: Colors.red),
              )),
              child: Text(
                createStore.imagesError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            );
          else
            return SizedBox();
        })
      ],
    );
  }
}
