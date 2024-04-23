import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'R.A.S';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  // Lista de URLs de las imágenes de serpientes
  final List<String> snakeImageUrls = [
    'https://i.pinimg.com/564x/78/67/dc/7867dc95583257c7434b66e5e58edafb.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/9/9b/B._constrictor.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/6/66/Indiancobra.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/0/09/Anaconda_Loreto_Peru.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/1/10/Brooding_female_Python_molurus_bivittatus.jpg',
    'https://www.ngenespanol.com/wp-content/uploads/2023/02/mamba-negra-la-serpiente-mortal-que-domina-el-africa-subsahariana-reptil.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color.fromARGB(255, 63, 201, 59),
      ),
      body: _buildGridView([]), // Inicialmente, no muestra imágenes
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 104, 216, 100),
              ),
              child: UserAccountsDrawerHeader(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 104, 216, 100)),
                accountName: Text(
                  "Leandro Perez",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("leandropz444@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://thelittledesignagency.co.uk/wp-content/uploads/2016/12/tlda-homepage-logo-RAS-e1481745720102.jpg'),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.article), // Icono de serpiente
              title: const Text('Serpientes'),
              onTap: () {
                Navigator.pop(context);
                // Muestra las imágenes de serpientes al hacer clic en "Serpientes"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text('Serpientes'),
                        backgroundColor: Color.fromARGB(255, 104, 216, 100),
                      ),
                      body: _buildSnakeList(),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                  Icons.verified_user_rounded), // Icono de desarrollador
              title: const Text('Desarrollador'),
              onTap: () {
                Navigator.pop(context);
                _showDeveloperInfo(
                    context); // Muestra la información del desarrollador
              },
            ),
            ListTile(
              leading: const Icon(Icons.post_add), // Icono de posts
              title: const Text('API Posts'),
              onTap: () {
                Navigator.pop(context);
                _fetchAndShowPosts(context); // Muestra los posts desde la API
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeveloperInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://thelittledesignagency.co.uk/wp-content/uploads/2016/12/tlda-homepage-logo-RAS-e1481745720102.jpg'),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Leandro Perez'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('leandropz444@gmail.com'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('+57 3045874963'),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Valledupar - Cesar'),
              ),
              // Agrega más información si es necesario
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridView(List<String> urls) {
    return GridView.count(
      crossAxisCount: 2, // Número de columnas
      children: List.generate(urls.length, (index) {
        return Center(
          child: Card(
            child: InkWell(
              onTap: () {
                // Acción al hacer clic en el elemento del grid
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(urls[index]), // URL de la imagen
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSnakeList() {
    return ListView.builder(
      itemCount: snakeImageUrls.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(
            snakeImageUrls[index],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(
            _getSnakeName(index), // Obtener el nombre de la serpiente
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            _showSnakeInfo(
                context, index); // Muestra la información de la serpiente
          },
        );
      },
    );
  }

  void _showSnakeInfo(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(
                  snakeImageUrls[index],
                  height:
                      300, // Ajusta la altura de la imagen según sea necesario
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                Text(
                  _getSnakeName(index),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  _getSnakeInfo(index),
                  textAlign: TextAlign.center,
                ),
                // Agregar más información si es necesario
              ],
            ),
          ),
        );
      },
    );
  }

  String _getSnakeName(int index) {
    // Lógica para obtener el nombre de la serpiente
    switch (index) {
      case 0:
        return "Serpientes de cascabel (Crotalus)";
      case 1:
        return "Boa constrictora (Boa constrictor)";
      case 2:
        return "Cobra de anteojos (Naja naja)";
      case 3:
        return "Anaconda verde (Eunectes murinus)";
      case 4:
        return "Piton (Pythonidae)";
      case 5:
        return "Mamba negra (Dendroaspis polylepis)";
      // Agregar más casos según sea necesario
      default:
        return "Serpiente $index";
    }
  }

  String _getSnakeInfo(int index) {
    // Lógica para obtener la información de la serpiente
    switch (index) {
      case 0:
        return "son un género de la subfamilia de las víboras de foseta dentro de la familia de los vipéridos. Son serpientes venenosas y endémicas del continente americano, desde el sureste de Canadá al norte de Argentina. Todas las especies menos una, C. catalinensis, son fácilmente reconocibles por el característico sonido de su cascabel el cual se encuentra en la punta de la cola. Existe otro género, Sistrurus, con especies más pequeñas, que también tienen un cascabel, pero no tan desarrollado. Se han reconocido 29 especies de serpientes de cascabel.";
      case 1:
        return "Es una especie de serpiente grande de la familia Boidae que habita en América, principalmente en gran parte de la cuenca del Amazonas. Es la única especie conocida del género Boa o, de acuerdo a otra clasificación, cada subespecie es una especie distinta y Boa constrictor sería la principal especie sudamericana.";
      case 2:
        return "Es una especie de serpiente venenosa originaria del Subcontinente indio. Como otras cobras, la cobra de anteojos es famosa por el capuchón que despliega alrededor de su cabeza cuando se encuentra excitada o amenazada. En la parte de atrás del capuchón tiene dos manchas negras unidas por una línea curva, que da la impresión de ser unos anteojos. El tamaño medio de estas cobras se encuentra en torno al metro, aunque rara vez superan los 2 metros de longitud.";
      case 3:
        return "Es una especie de serpiente constrictora de la familia de las boas (Boidae). Es endémica de los ríos del trópico de Sudamérica. De todas las serpientes esta es la de mayor tamaño (hablando de peso); se la hace rivalizar con la pitón reticulada (Malayopython reticulatus) por el título de la serpiente más grande del mundo, que suele ser más larga, pero menos voluminosa. Se conocen casos de humanos adultos atacados, aunque ninguna serpiente (Malayopython reticulatus como excepción) tiende a atacar a un ser humano, salvo por defensa propia, ya que estos no forman parte de su cadena trófica.";
      case 4:
        return "Son una familia de serpientes constrictoras propias del paleotrópico. Otras fuentes consideran a este grupo una subfamilia de la familia de las boas (Boidae) (subfamilia Pythoninae). Las pitones se pueden distinguir de las boas en que tienen dientes en el premaxilar, un pequeño hueso en la parte frontal de la mandíbula superior. La mayoría de las boas dan a luz crías vivas, mientras que las pitones ponen huevos. Algunas variedades pueden llegar a ser muy largas: hasta ocho metros. Ciertas especies de boas de arena (subfamilia Ericinae) son llamadas erróneamente pitones.";
      case 5:
        return "Es una especie de serpiente de la familia Elapidae extremadamente venenosa que habita en diversas zonas del África subsahariana. Descrita formalmente por Albert Günther en 1864, es la segunda serpiente venenosa de mayor tamaño, después de la cobra real; aunque hay informes de ejemplares de algo más de cuatro metros, los adultos normalmente miden entre dos y tres metros. El color de su piel varía de gris a marrón oscuro; los ejemplares jóvenes tienden a ser más pálidos que los adultos y se oscurecen con la edad.";
      // Agregar más casos según sea necesario
      default:
        return "Información de la serpiente $index";
    }
  }

  void _fetchAndShowPosts(BuildContext context) {
    // Llamar a la función para obtener los posts desde la API y mostrarlos
    Buscapost().then((r) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("API Post"),
            ),
            body: ListView.builder(
              itemCount: r.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  title: Text(r[i].title),
                  leading: Text(r[i].id.toString()),
                );
              },
            ),
          );
        },
      );
    });
  }
}

// Simulación de la función para buscar posts desde la API
Future<List<Post>> Buscapost() async {
  // Aquí iría tu lógica para llamar a la API y obtener los posts
  // Por simplicidad, aquí solo retornamos una lista predefinida de posts
  return List.generate(
    10,
    (index) => Post(
      id: index + 1,
      title: 'Post ${index + 1}',
    ),
  );
}

// Modelo de datos para un post
class Post {
  final int id;
  final String title;

  Post({required this.id, required this.title});
}
