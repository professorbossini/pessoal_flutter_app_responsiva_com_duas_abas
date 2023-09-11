import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação responsiva simples',
      //um ThemeData armazena dados de um tema, como estilos de texto, cores, estilo da AppBar etc
      theme: ThemeData(
          primarySwatch: Colors.blue //swatch significa algo como "amostra"
          ),
      //essa classe decide qual Widget usar
      home: MeuLayoutResponsivo(),
    );
  }
}

//Widget para telas "pequenas". Vamos exibir uma tela com duas abas.
class MobileLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MobileLayoutState();
  }
}

//classe que representa o estado do Widget para telas pequenas
class MobileLayoutState extends State<MobileLayout>
    with SingleTickerProviderStateMixin {
  //para lidar com as abas
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //gerenciador de layout que empilha seus filhos (coluna)
    return Column(
      children: [
        //A barra que exibe as abas
        TabBar(
          labelColor: Colors.black,
          controller: tabController,
          tabs: [Tab(text: "Aba 1"), Tab(text: 'Aba 2')],
        ),
        //gerenciador de layout para expandir seu conteúdo no eixo principal
        Expanded(
            child: TabBarView(
          controller: tabController,
          children: [
            Center(child: Text("Conteúdo da primeira aba")),
            Center(child: Text("Conteúdo da segunda aba"))
          ],
        ))
      ],
    );
  }
}

//Widget para telas "grandes". Vamos exibir os conteúdos das abas lado a lado.
class WebLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WebLayoutState();
  }
}

//classe que representa o estado do Widget para telas grandes
class WebLayoutState extends State<WebLayout> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Card(
            child: Center(child: Text("Conteúdo da primeira aba"))
          )
        ),
        Expanded(
          child: Card(
            child: Center(
              child: Text('Conteúdod da segunda aba'),
            )
          )
        )
      ],
    );
  }
}

//essa classe decide qual Widget usar, de acordo com o tamanho da tela
class MeuLayoutResponsivo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aplicação responsiva simples")),
      body: LayoutBuilder(builder: (context, constraints) {
        //breakpoint que definimos para dizer que a tela é pequena
        return constraints.maxWidth <= 578 ? MobileLayout() : WebLayout();
      }),
    );
  }
}

