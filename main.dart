import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const CameraApp());
}

class CameraApp extends StatelessWidget {
  const CameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF064E40);
    const secondary = Color(0xFF40064E);
    const tertiary = Color(0xFF4E4006);
    const accent = Color(0xFF117A65);

    final theme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF4F7F6),
      colorScheme: ColorScheme.fromSeed(seedColor: primary).copyWith(
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        surface: const Color(0xFFF4F7F6),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        elevation: 3,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: accent.withValues(alpha: 0.18),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );

    return MaterialApp(
      title: 'Camera App',
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (_) => const WelcomeScreen(),
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const MainShell(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF064E40),
              Color(0xFF117A65),
              Color(0xFF40064E),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.camera_alt_rounded, size: 92, color: Colors.white),
                const SizedBox(height: 16),
                const Text(
                  'Camera & Consulta',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Acesse rapidamente o login, as consultas e as funções do aplicativo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    icon: const Icon(Icons.login_rounded),
                    label: const Text('Entrar'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFF064E40),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'aluno@escola.com');
  final _passwordController = TextEditingController(text: '123456');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainShell()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color(0xFF064E40),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF064E40).withValues(alpha: 0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.person_pin_rounded,
                        size: 80,
                        color: Color(0xFF117A65),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Acesso ao Sistema',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF064E40),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          prefixIcon: Icon(Icons.email_rounded),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o e-mail.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: Icon(Icons.lock_rounded),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe a senha.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _login,
                          icon: const Icon(Icons.arrow_forward_rounded),
                          label: const Text('Entrar'),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF064E40),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    WorkScreen(),
    LocationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema Principal'),
      ),
      drawer: const AppDrawer(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.work_rounded), label: 'Trabalho'),
          NavigationDestination(icon: Icon(Icons.location_on_rounded), label: 'Localização'),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF064E40),
                  Color(0xFF117A65),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_circle_rounded, size: 48, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  'Menu Lateral',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_rounded, color: Color(0xFF064E40)),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainShell()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_city_rounded, color: Color(0xFF117A65)),
            title: const Text('Consulta CEP'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CepScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.business_rounded, color: Color(0xFF40064E)),
            title: const Text('Consulta CNPJ'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CnpjScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.work_rounded, color: Color(0xFF4E4006)),
            title: const Text('Tela de Trabalho'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WorkScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.gps_fixed_rounded, color: Color(0xFF117A65)),
            title: const Text('Localização GPS'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LocationScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded, color: Color(0xFF40064E)),
            title: const Text('Sair'),
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sejam Bem Vindos',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Color(0xFF064E40),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Seus principais acessos e informações em um único lugar.',
            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black87),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
            children: [
              _QuickCard(
                title: 'CEP',
                icon: Icons.location_on_rounded,
                color: const Color(0xFF064E40),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CepScreen()),
                ),
              ),
              _QuickCard(
                title: 'CNPJ',
                icon: Icons.business_rounded,
                color: const Color(0xFF40064E),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CnpjScreen()),
                ),
              ),
              _QuickCard(
                title: 'GPS',
                icon: Icons.gps_fixed_rounded,
                color: const Color(0xFF117A65),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LocationScreen()),
                ),
              ),
              _QuickCard(
                title: 'Trabalho',
                icon: Icons.work_rounded,
                color: const Color(0xFF4E4006),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WorkScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FutureBuilder<Map<String, dynamic>>(
            future: _fetchDollarRate(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const _InfoPanel(
                  title: 'Cotação do dólar',
                  value: 'Não disponível',
                  color: Color(0xFF117A65),
                );
              }

              final data = snapshot.data ?? {};
              final value = data['bid'] ?? '0.00';
              return _InfoPanel(
                title: 'Cotação do dólar',
                value: 'R\$ $value',
                color: const Color(0xFF117A65),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchDollarRate() async {
    final response = await http.get(Uri.parse('https://economia.awesomeapi.com.br/last/USD-BRL'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Map<String, dynamic>.from(body['USDBRL'] ?? {});
    }

    throw Exception('Erro ao buscar cotação');
  }
}

class CepScreen extends StatefulWidget {
  const CepScreen({super.key});

  @override
  State<CepScreen> createState() => _CepScreenState();
}

class _CepScreenState extends State<CepScreen> {
  final _controller = TextEditingController();
  bool _loading = false;
  Map<String, dynamic>? _result;
  String? _error;

  Future<void> _searchCep() async {
    final cep = _controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cep.length != 8) {
      setState(() {
        _error = 'Informe um CEP com 8 dígitos.';
        _result = null;
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['erro'] == true) {
          setState(() {
            _result = null;
            _error = 'CEP não encontrado.';
          });
        } else {
          setState(() {
            _result = Map<String, dynamic>.from(data);
            _error = null;
          });
        }
      } else {
        setState(() {
          _result = null;
          _error = 'Erro na consulta do CEP.';
        });
      }
    } catch (_) {
      setState(() {
        _result = null;
        _error = 'Não foi possível consultar o CEP.';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consulta de CEP')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              maxLength: 8,
              decoration: const InputDecoration(
                labelText: 'Digite o CEP',
                prefixIcon: Icon(Icons.location_on_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _loading ? null : _searchCep,
                icon: const Icon(Icons.search_rounded),
                label: Text(_loading ? 'Consultando...' : 'Consultar'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF064E40),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_error != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _error!,
                  style: TextStyle(color: Colors.red.shade800),
                ),
              )
            else if (_result != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF064E40).withValues(alpha: 0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resultado da consulta', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    _DetailRow(label: 'CEP', value: _result!['cep'] ?? '---'),
                    _DetailRow(label: 'Logradouro', value: _result!['logradouro'] ?? '---'),
                    _DetailRow(label: 'Bairro', value: _result!['bairro'] ?? '---'),
                    _DetailRow(label: 'Cidade', value: _result!['localidade'] ?? '---'),
                    _DetailRow(label: 'UF', value: _result!['uf'] ?? '---'),
                  ],
                ),
              )
            else
              const Expanded(
                child: Center(
                  child: Text('Realize a consulta de um CEP.'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CnpjScreen extends StatefulWidget {
  const CnpjScreen({super.key});

  @override
  State<CnpjScreen> createState() => _CnpjScreenState();
}

class _CnpjScreenState extends State<CnpjScreen> {
  final _controller = TextEditingController();
  bool _loading = false;
  Map<String, dynamic>? _result;
  String? _error;

  Future<void> _searchCnpj() async {
    final cnpj = _controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cnpj.length != 14) {
      setState(() {
        _error = 'Informe um CNPJ com 14 dígitos.';
        _result = null;
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final response = await http.get(Uri.parse('https://api.opencnpj.org/$cnpj'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _result = data is Map ? Map<String, dynamic>.from(data) : null;
          _error = _result == null ? 'CNPJ não encontrado.' : null;
        });
      } else {
        setState(() {
          _result = null;
          _error = 'Erro ao consultar CNPJ.';
        });
      }
    } catch (_) {
      setState(() {
        _result = null;
        _error = 'Não foi possível consultar o CNPJ.';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consulta de CNPJ')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              maxLength: 14,
              decoration: const InputDecoration(
                labelText: 'Digite o CNPJ',
                prefixIcon: Icon(Icons.business_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _loading ? null : _searchCnpj,
                icon: const Icon(Icons.search_rounded),
                label: Text(_loading ? 'Consultando...' : 'Consultar'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF40064E),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_error != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _error!,
                  style: TextStyle(color: Colors.red.shade800),
                ),
              )
            else if (_result != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF40064E).withValues(alpha: 0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resultado da consulta', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    _DetailRow(label: 'CNPJ', value: _result!['cnpj'] ?? _controller.text),
                    _DetailRow(label: 'Nome', value: _result!['nome'] ?? '---'),
                    _DetailRow(label: 'Fantasia', value: _result!['fantasia'] ?? '---'),
                    _DetailRow(label: 'Cidade', value: _result!['municipio'] ?? '---'),
                    _DetailRow(label: 'UF', value: _result!['uf'] ?? '---'),
                  ],
                ),
              )
            else
              const Expanded(
                child: Center(
                  child: Text('Realize a consulta de um CNPJ.'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tela de Trabalho',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF4E4006)),
          ),
          const SizedBox(height: 12),
          const Text(
            'Área de atividades do sistema com acesso rápido e organização do fluxo de trabalho.',
            style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _TaskCard(
                  title: 'Projetos',
                  subtitle: '12 ativos',
                  color: const Color(0xFF064E40),
                  icon: Icons.folder_copy_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _TaskCard(
                  title: 'Atividades',
                  subtitle: '8 pendentes',
                  color: const Color(0xFF40064E),
                  icon: Icons.task_alt_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const _InfoPanel(
            title: 'Status do dia',
            value: 'Operação em andamento',
            color: Color(0xFF4E4006),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF4E4006).withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Resumo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text('• 3 consultas realizadas hoje'),
                Text('• 1 tarefa crítica em revisão'),
                Text('• Geolocalização e APIs em uso'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Position? _currentPosition;
  String? _errorMessage;
  bool _loading = false;

  Future<void> _loadLocation() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw const FormatException('Serviço de localização desativado.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        throw const FormatException('Permissão permanente negada.');
      }

      if (permission == LocationPermission.denied) {
        throw const FormatException('Permissão de localização negada.');
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Localização Geográfica',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF117A65)),
          ),
          const SizedBox(height: 8),
          const Text(
            'Abaixo estão os dados da localização conforme padrão do GPS.',
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _loading ? null : _loadLocation,
              icon: const Icon(Icons.my_location_rounded),
              label: Text(_loading ? 'Localizando...' : 'Atualizar localização'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF117A65),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red.shade800),
              ),
            )
          else if (_currentPosition != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF117A65).withValues(alpha: 0.15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Coordenadas atuais', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 14),
                  _DetailRow(label: 'Latitude', value: _currentPosition!.latitude.toStringAsFixed(6)),
                  _DetailRow(label: 'Longitude', value: _currentPosition!.longitude.toStringAsFixed(6)),
                  _DetailRow(label: 'Precisão', value: '${_currentPosition!.accuracy.toStringAsFixed(2)} m'),
                ],
              ),
            )
          else
            const Expanded(
              child: Center(
                child: Text('Aguardando localização do GPS...'),
              ),
            ),
        ],
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  const _QuickCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.18)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  const _InfoPanel({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
