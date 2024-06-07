import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improve_base/base/page_base.dart';
import 'package:improve_base/main.cubit.dart';
import 'package:improve_base/theme/app_color.dart';
import 'package:improve_base/utils/app_utils.dart';
import 'package:improve_base/widgets/scroll_hide_bottom_bar.dart';
import 'package:improve_base/widgets/search_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<MainCubit>(
        create: (context) => MainCubit(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends PageBase {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends PageBaseState<MyHomePage> with PageLoadingMixin {
  late TextEditingController tfController;
  late MainCubit mainCubit;
  @override
  void initState() {
    super.initState();
    tfController = TextEditingController();
    mainCubit = context.read<MainCubit>();
    mainCubit.init();
  }

  @override
  void dispose() {
    if (mounted) {
      tfController.dispose();
    }
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SearchWidget(
              tfController: tfController,
              onSearch: onSearch,
              searchRule: searchRule,
              hintText: 'Search....',
            ),
            Expanded(
              child: ScrollHideBottomBar(
                bottomBar: Container(
                  color: AppColors.primary,
                  height: 100,
                  width: AppUtils.getScreenWidth(context),
                ),
                child: BlocConsumer<MainCubit, MainState>(
                    listener: (context, state) {},
                    builder: (_, MainState state) {
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          final user = state.users[index];
                          return Container(
                            height: 100,
                            width: AppUtils.getScreenWidth(context),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Text('${user.name}--${user.description}'),
                          );
                        },
                        itemCount: state.users.length,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          mainCubit.change();
          // showLoading(context);
          // await Future.delayed(const Duration(seconds: 1)).whenComplete(() => hideLoading(context));
        },
      ),
    );
  }

  bool searchRule(String q) {
    if (q.length < 2) return false;

    return true;
  }

  Future<void> onSearch(String q) async {
    showLoading(context);
    await Future.delayed(const Duration(seconds: 1)).whenComplete(() => hideLoading(context));
  }
}
