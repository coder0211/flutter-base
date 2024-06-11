import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improve_base/base/page_base.dart';
import 'package:improve_base/main.cubit.dart';
import 'package:improve_base/theme/app_color.dart';
import 'package:improve_base/utils/app_error.dart';
import 'package:improve_base/utils/app_utils.dart';
import 'package:improve_base/widgets/scroll_hide_bottom_bar.dart';
import 'package:improve_base/widgets/search_widget.dart';

void main() {
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (dynamic error, StackTrace stackTrace) {
    _handleAppError(error, stackTrace);
  });
}

void _handleAppError(error, StackTrace stackTrace) {
  if (error is AppError) {
    showAboutDialog(context: error.context, children: [Text(error.content ?? '')]);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
              onClearSearch: () {},
            ),
            Expanded(
              child: ScrollHideBottomBar(
                bottomBar: Container(
                  color: AppColors.black,
                  height: 100,
                  width: AppUtils.getScreenWidth(context),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            mainCubit.updateDescription();
                          },
                          child: const Text('Update description'))
                    ],
                  ),
                ),
                child: BlocBuilder<MainCubit, MainState>(builder: (_, MainState state) {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final user = state.users[index];
                      return GestureDetector(
                        onTap: () => mainCubit.onItemPressed(user.id),
                        child: Container(
                          width: AppUtils.getScreenWidth(context),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              color: state.userIdSelected == user.id ? AppColors.primary : AppColors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Name: ${user.name}\nDescription: ${user.description}',
                              ),
                              const Divider(
                                color: Color.fromARGB(255, 238, 150, 150),
                              ),
                              if (user.todoList?.isLoading == true)
                                const SizedBox(
                                  height: 100,
                                  child: Center(child: CircularProgressIndicator()),
                                )
                              else
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    final item = user.todoList?.ls.elementAt(index);
                                    return Row(
                                      children: [
                                        Checkbox(
                                            value: item?.isCompleted,
                                            onChanged: (v) {
                                              mainCubit.onTodoPressed(user.id, item?.id ?? '');
                                            }),
                                        const SizedBox(width: 10),
                                        Expanded(child: Text(item?.content ?? ''))
                                      ],
                                    );
                                  },
                                  itemCount: user.todoList?.ls.length,
                                )
                            ],
                          ),
                        ),
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
          AppError(AppErrorEnum.someThingWhenWrong).log(context);
          mainCubit.testLoadingTodoList();
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
