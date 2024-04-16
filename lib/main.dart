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
          subtitle: Text(
            _getSnakeInfo(index), // Obtener la información de la serpiente
            textAlign: TextAlign.center,
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
        return "serpientes de cascabel (Crotalus)";
      case 1:
        return "Serpiente 2";
      // Agregar más casos según sea necesario
      default:
        return "Serpiente $index";
    }
  }

  String _getSnakeInfo(int index) {
    // Lógica para obtener la información de la serpiente
    switch (index) {
      case 0:
        return "Son un género de la subfamilia de las víboras de foseta dentro de la familia de los vipéridos.Son serpientes venenosas y endémicas del continente americano, desde el sureste de Canadá al norte de Argentina.";
      case 1:
        return "Información de la serpiente 2";
      // Agregar más casos según sea necesario
      default:
        return "Información de la serpiente $index";
    }
  }
}
