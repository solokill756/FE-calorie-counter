import 'dart:async';



import 'package:auto_route/auto_route.dart';

import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';

import 'package:caloriecounter/src/modules/app/app_router.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gap/gap.dart';



import '../application/exercise_cubit/exercise_cubit.dart';

import '../widgets/exercise_notes_preview.dart';

import '../widgets/exercise_verification_badge.dart';

import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';



const _kSearchDebounceMs = Duration(milliseconds: 300);



@RoutePage()

class ExerciseCatalogPage extends StatefulWidget {

  const ExerciseCatalogPage({super.key});



  @override

  State<ExerciseCatalogPage> createState() => _ExerciseCatalogPageState();

}



class _ExerciseCatalogPageState extends State<ExerciseCatalogPage> {

  final _search = TextEditingController();

  Timer? _debounce;

  String? _typeFilter;

  bool _myExercisesMode = false;



  @override

  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      context.read<ExerciseCubit>().loadCatalog(mineOnly: false);

    });

  }



  @override

  void dispose() {

    _search.dispose();

    _debounce?.cancel();

    super.dispose();

  }



  void _reload({bool? mineOnly}) {

    if (mineOnly != null && mineOnly != _myExercisesMode) {

      setState(() => _myExercisesMode = mineOnly);

    }

    _debounce?.cancel();

    _debounce = Timer(_kSearchDebounceMs, () {

      if (!mounted) return;

      context.read<ExerciseCubit>().loadCatalog(

        q: _search.text.isEmpty ? null : _search.text,

        type: _typeFilter,

        mineOnly: mineOnly ?? _myExercisesMode,

      );

    });

  }



  @override

  Widget build(BuildContext context) {

    final scheme = Theme.of(context).colorScheme;

    final chipTheme = ChipThemeData(

      side: BorderSide(color: scheme.outlineVariant),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),

      labelStyle: TextStyle(

        fontSize: 13.sp,

        fontWeight: FontWeight.w500,

        color: scheme.onSurface,

      ),

      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0),

    );



    return Scaffold(

      backgroundColor: scheme.surfaceContainerLow,

      appBar: AppShellUi.appBar(

        context,

        'Exercises',

        actions: [

          IconButton(

            icon: Icon(Icons.add, color: scheme.primary, size: 26.sp),

            tooltip: 'New exercise',

            onPressed: () async {

              final changed = await context.router.push(ExerciseFormRoute());

              if (context.mounted && changed == true) {

                _reload(mineOnly: true);

              }

            },

          ),

        ],

      ),

      body: Column(

        children: [

          Padding(

            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),

            child: Container(

              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),

              decoration: AppShellUi.cardDecoration(context),

              child: Row(

                children: [

                  Expanded(

                    child: TextField(

                      controller: _search,

                      style: TextStyle(fontSize: 15.sp),

                      decoration: AppShellUi.searchField(context).copyWith(

                        hintText: _myExercisesMode

                            ? 'Search my exercises'

                            : 'Search global exercises',

                      ),

                      onChanged: (_) => _reload(),

                    ),

                  ),

                  Gap(10.w),

                  ChoiceChip(

                    backgroundColor: scheme.surface,

                    selectedColor: scheme.primaryContainer,

                    label: Text(

                      _myExercisesMode ? 'My Exercises' : 'Global',

                      style: TextStyle(fontSize: 13.sp, color: scheme.onSurface),

                    ),

                    selected: _myExercisesMode,

                    onSelected: (selected) {

                      setState(() => _myExercisesMode = selected);

                      _reload(mineOnly: selected);

                    },

                  ),

                ],

              ),

            ),

          ),

          Gap(12.h),

          Padding(

            padding: EdgeInsets.symmetric(horizontal: 16.w),

            child: Align(

              alignment: Alignment.centerLeft,

              child: Theme(

                data: Theme.of(context).copyWith(chipTheme: chipTheme),

                child: Wrap(

                  spacing: 8.w,

                  runSpacing: 8.h,

                  children: [

                    FilterChip(

                      label: Text(

                        'All',

                        style: TextStyle(

                          fontSize: 13.sp,

                          color: scheme.onSurface,

                        ),

                      ),

                      selected: _typeFilter == null,

                      selectedColor: scheme.primaryContainer,

                      checkmarkColor: scheme.primary,

                      backgroundColor: Colors.white,

                      onSelected: (_) {

                        setState(() => _typeFilter = null);

                        _reload();

                      },

                    ),

                    FilterChip(

                      label: Text(

                        'Cardio',

                        style: TextStyle(

                          fontSize: 13.sp,

                          color: scheme.onSurface,

                        ),

                      ),

                      selected: _typeFilter == 'cardio',

                      selectedColor: scheme.primaryContainer,

                      checkmarkColor: scheme.primary,

                      backgroundColor: Colors.white,

                      onSelected: (_) {

                        setState(() => _typeFilter = 'cardio');

                        _reload();

                      },

                    ),

                    FilterChip(

                      label: Text(

                        'Strength',

                        style: TextStyle(

                          fontSize: 13.sp,

                          color: scheme.onSurface,

                        ),

                      ),

                      selected: _typeFilter == 'strength',

                      selectedColor: scheme.secondaryContainer,

                      checkmarkColor: scheme.secondary,

                      backgroundColor: Colors.white,

                      onSelected: (_) {

                        setState(() => _typeFilter = 'strength');

                        _reload();

                      },

                    ),

                  ],

                ),

              ),

            ),

          ),

          Gap(8.h),

          Expanded(

            child: BlocBuilder<ExerciseCubit, ExerciseUiState>(

              builder: (context, s) {

                if (s.listLoading && s.catalog == null) {

                  return Center(

                    child: CircularProgressIndicator(color: scheme.primary),

                  );

                }

                final items = s.catalog?.items ?? [];

                if (items.isEmpty) {

                  final emptyMessage = s.error ??

                      (_myExercisesMode

                          ? (_search.text.trim().isEmpty

                              ? 'No custom exercises yet. Tap + to create one.'

                              : 'No exercises match your search')

                          : (_search.text.trim().isEmpty

                              ? 'No global exercises found'

                              : 'No exercises match your search'));

                  return Center(

                    child: Padding(

                      padding: EdgeInsets.all(24.w),

                      child: Text(

                        emptyMessage,

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontSize: 14.sp,

                          color: Colors.grey[700],

                          height: 1.4,

                        ),

                      ),

                    ),

                  );

                }

                return ListView.builder(

                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),

                  itemCount: items.length,

                  itemBuilder: (context, i) {

                    final e = items[i];

                    return AppShellUi.listRowCard(

                      context,

                      child: ListTile(

                        contentPadding: EdgeInsets.symmetric(

                          horizontal: 8.w,

                          vertical: 6.h,

                        ),

                        leading: CircleAvatar(

                          backgroundColor: scheme.primaryContainer,

                          child: Icon(

                            Icons.fitness_center,

                            color: scheme.primary,

                            size: 20.sp,

                          ),

                        ),

                        title: Text(

                          e.name,

                          style: TextStyle(

                            fontWeight: FontWeight.w600,

                            fontSize: 15.sp,

                            color: Colors.grey[900],

                          ),

                        ),

                        subtitle: Padding(

                          padding: EdgeInsets.only(top: 6.h),

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Wrap(

                                spacing: 8.w,

                                runSpacing: 6.h,

                                crossAxisAlignment: WrapCrossAlignment.center,

                                children: [

                                  Text(

                                    e.type,

                                    style: TextStyle(

                                      fontSize: 13.sp,

                                      color: Colors.grey[600],

                                    ),

                                  ),

                                  ExerciseVerificationBadge(

                                    isVerified: e.isVerified,

                                  ),

                                ],

                              ),

                              if (e.notes != null && e.notes!.trim().isNotEmpty) ...[

                                Gap(6.h),

                                ExerciseNotesPreview(

                                  notes: e.notes,

                                  compact: true,

                                  maxLines: 2,

                                ),

                              ],

                            ],

                          ),

                        ),

                        trailing: PopupMenuButton<String>(

                          icon: Icon(

                            Icons.more_vert,

                            color: Colors.grey[600],

                            size: 22.sp,

                          ),

                          onSelected: (value) async {

                            if (value == 'log') {

                              if (!context.mounted) return;

                              await context.router.push(

                                ExerciseAddLogRoute(exerciseId: e.id),

                              );

                              return;

                            }

                            if (value == 'edit') {

                              if (!context.mounted) return;

                              final changed = await context.router.push(

                                ExerciseFormRoute(exerciseId: e.id),

                              );

                              if (context.mounted && changed == true) _reload();

                              return;

                            }

                            if (value == 'delete') {

                              if (!context.mounted) return;

                              final ok =

                                  await showDialog<bool>(

                                    context: context,

                                    builder: (ctx) {

                                      return AlertDialog(

                                        shape: RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(

                                            20.r,

                                          ),

                                        ),

                                        title: Text(

                                          'Delete exercise?',

                                          style: TextStyle(

                                            fontSize: 18.sp,

                                            fontWeight: FontWeight.w700,

                                          ),

                                        ),

                                        content: Text(

                                          'This hides "${e.name}" from the catalog. Past workout logs stay in history.',

                                          style: TextStyle(

                                            fontSize: 14.sp,

                                            height: 1.4,

                                          ),

                                        ),

                                        actions: [

                                          TextButton(

                                            onPressed: () =>

                                                Navigator.pop(ctx, false),

                                            child: const Text('Cancel'),

                                          ),

                                          FilledButton(

                                            style: FilledButton.styleFrom(

                                              backgroundColor:

                                                  Colors.red.shade700,

                                            ),

                                            onPressed: () =>

                                                Navigator.pop(ctx, true),

                                            child: const Text('Delete'),

                                          ),

                                        ],

                                      );

                                    },

                                  ) ??

                                  false;

                              if (!ok || !context.mounted) return;

                              final deleted = await context

                                  .read<ExerciseCubit>()

                                  .deleteExerciseFromCatalog(e.id);

                              if (context.mounted) {

                                if (deleted) {

                                  AppDialogs.showSuccessSnackBar(

                                    message: 'Exercise removed',

                                  );

                                } else {

                                  AppDialogs.showErrorSnackBar(

                                    message: 'Failed to delete exercise',

                                  );

                                }

                              }

                            }

                          },

                          itemBuilder: (ctx) => [

                            PopupMenuItem(

                              value: 'log',

                              child: Text(

                                'Log workout',

                                style: TextStyle(fontSize: 14.sp),

                              ),

                            ),

                            if (e.isOwned) ...[

                              PopupMenuItem(

                                value: 'edit',

                                child: Text(

                                  'Edit',

                                  style: TextStyle(fontSize: 14.sp),

                                ),

                              ),

                              PopupMenuItem(

                                value: 'delete',

                                child: Text(

                                  'Delete',

                                  style: TextStyle(

                                    fontSize: 14.sp,

                                    color: Colors.red[700],

                                  ),

                                ),

                              ),

                            ],

                          ],

                        ),

                        onTap: () => context.router.push(

                          ExerciseAddLogRoute(exerciseId: e.id),

                        ),

                      ),

                    );

                  },

                );

              },

            ),

          ),

        ],

      ),

      floatingActionButton: FloatingActionButton.extended(

        backgroundColor: scheme.tertiary,

        foregroundColor: scheme.onTertiary,

        elevation: 2,

        icon: Icon(Icons.add, size: 22.sp),

        label: Text(

          'New exercise',

          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),

        ),

        onPressed: () async {

          final changed = await context.router.push(ExerciseFormRoute());

          if (context.mounted && changed == true) {

            _reload(mineOnly: true);

          }

        },

      ),

    );

  }

}


