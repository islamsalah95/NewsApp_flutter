import 'package:flutter/material.dart';
import 'package:login/Cache/cache_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  String _savedName = '';
  String _savedPassword = '';
  String _savedEmail = '';

  @override
  void initState() {
    super.initState();
    _loadSavedData(); // Load saved data when the widget is initialized
  }

  // Load data from shared preferences
  void _loadSavedData() async {
    String? name = CacheHelper.getData(key: 'name');
    String? password = CacheHelper.getData(key: 'password');
    String? email = CacheHelper.getData(key: 'email');

    setState(() {
      _savedName = name ?? '';
      _savedPassword = password ?? '';
      _savedEmail = email ?? '';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Welcome User",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/logo.webp'),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your Name',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name Is Empty";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email Is Empty";
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: _obscureText
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password Is Empty";
                        } else {
                          return null;
                        }
                      },
                      obscureText: _obscureText,
                      obscuringCharacter: "*",
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          CacheHelper.saveData(
                              key: "name", value: _nameController.text);
                          CacheHelper.saveData(
                              key: "password", value: _passwordController.text);
                          CacheHelper.saveData(
                              key: "email", value: _emailController.text);
                          // Update the UI after saving data
                          setState(() {
                            _savedName = _nameController.text;
                            _savedPassword = _passwordController.text;
                            _savedEmail = _emailController.text;
                          });
                        }
                      },
                      child: const Text('Save'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        CacheHelper.clearData();
                        // Clear the displayed values
                        setState(() {
                          _savedName = '';
                          _savedPassword = '';
                          _savedEmail = '';
                        });
                      },
                      child: const Text("Reset"),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              "Name: $_savedName",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Email: $_savedEmail",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Password: $_savedPassword",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
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
    );
  }
}
