import 'package:flutter/material.dart';
import 'package:lazyload_lessons/widgets/example/example_model.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final model = ExampleWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ExampleModelProvider(
          model: model,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _ReloadButton(),
              const _CreateButton(),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _UsersWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReloadButton extends StatelessWidget {
  const _ReloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => ExampleModelProvider.read(context)?.model.reloadUsers(),
      child: const Text("Reload"),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => ExampleModelProvider.read(context)?.model.createUsers(),
      child: const Text("Create"),
    );
  }
}

class _UsersWidget extends StatelessWidget {
  const _UsersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ExampleModelProvider.watch(context)?.model.users.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return _UsersRowWidget(index: index);
      },
    );
  }
}

class _UsersRowWidget extends StatelessWidget {
  final int index;

  const _UsersRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = ExampleModelProvider.read(context)!.model.users[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(user.name),
        const SizedBox(
          height: 10
        ),
        Text(user.phone),
        const SizedBox(
          height: 10
        ),
        Text(user.email),
        const SizedBox(
          height: 40
        ),
      ],
    );
  }
}
