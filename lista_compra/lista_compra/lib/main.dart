import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 70, 99, 224),
        )
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage ({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final TextEditingController _textFieldController = TextEditingController();       // Creamos un controlador del TextField que usaremos para acceder el campo
  final List<String> _productos = [];                                               // Creamos la lista que usaremos para guardar los productos añadidos

  void _addItemToList(String producto) {                                                 // Declaramos esta función que será la encargada de añadir las entradas a la lista
    setState(() {                                                                   // Llamamos a esta función para avisar a Flutter de que van a cambiar los valores
      _productos.add(producto);
      _textFieldController.clear();                                                 // Limpiamos el textField una vez añadido el producto
    });
  }
  void _removeItemFromList() {                                                 // Declaramos esta función que será la encargada de añadir las entradas a la lista
    setState(() {     
        _productos.clear();
    });
}

  // Ahora creamos el widget y la imagen que tendrá
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de la compra'),
      ),
      body: Elementos(
        textFieldController: _textFieldController,
        productos: _productos,
        addToList: _addItemToList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _removeItemFromList();
        },
        child: const Icon(
          Icons.delete,
        ),
      ),
    );
  }
}

class Elementos extends StatelessWidget {
  const Elementos({super.key, required this.textFieldController, required this.productos, required this.addToList});
  
  final TextEditingController textFieldController;
  final List<String> productos;
  final Function(String) addToList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: TextField(
            controller: textFieldController,
            decoration: const InputDecoration(
              labelText: 'Añade un producto...',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Color.fromARGB(255, 122, 122, 122)),
            ),
            onSubmitted: (String text) {
              if (text.isNotEmpty) {
                text = text[0].toUpperCase() + text.substring(1);
                addToList(text);
              }
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: productos.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 236, 236),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.add_shopping_cart,
                              color: Color.fromARGB(255, 118, 238, 122),
                              ),
                            Text(
                              productos[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )
                            ),
                          ],
                        ),
                        const Cantidades(),
                      ]
                    )
                  )
                )
              );
            }
          )
        )
      ]
    );
  }
}

// Gestión de la cantidad de producto en la lista

class Cantidades extends StatefulWidget {
  const Cantidades ({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Cantidades createState() => _Cantidades(); // Lógica
}

class _Cantidades extends State<Cantidades> {
  int contador = 1;

  void incrementa() {
    setState(() {
      contador++;
    });
  }
  void decrementa() {
    setState(() {
      if (contador > 0) {
        contador--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(contador.toString()),
        Column(
          children: [
            IconButton(
              onPressed: () {
                incrementa();
              },
              icon: const Icon(
                Icons.add,
              )
            ),
            IconButton(
              onPressed: () {
                decrementa();
              },
              icon: const Icon(
                Icons.remove,
              )
            ),
          ]
        ),
        IconButton(
          onPressed: () => decrementa(),
          icon: const Icon(
            Icons.clear,
          ))
      ]
    );
  }
}
