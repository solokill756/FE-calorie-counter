import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';
import 'package:caloriecounter/src/core/data/remote/base/api_error.dart';
import 'package:caloriecounter/src/modules/auth/data/models/user_profile_model.dart';
import 'package:caloriecounter/src/modules/auth/data/onboarding_payload_mapper.dart';
import 'package:caloriecounter/src/modules/auth/presentation/widgets/common/health_profile_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditHealthProfilePage extends StatefulWidget {
  const EditHealthProfilePage({
    super.key,
    required this.profile,
    required this.onSave,
  });

  final UserProfileModel profile;
  final Future<ApiError?> Function(Map<String, Object?> changes) onSave;

  @override
  State<EditHealthProfilePage> createState() => _EditHealthProfilePageState();
}

class _EditHealthProfilePageState extends State<EditHealthProfilePage> {
  static const _mealLabels = {
    'breakfast': 'Breakfast',
    'lunch': 'Lunch',
    'dinner': 'Dinner',
    'snack': 'Snack',
  };

  final _formKey = GlobalKey<FormState>();
  final _customAllergy = TextEditingController();
  late final TextEditingController _age;
  late final TextEditingController _height;
  late final Map<String, TextEditingController> _meals;
  late final Set<String> _conditions;
  late final Set<String> _allergies;
  late final Map<String, String> _conditionOptions;
  late String _gender;

  bool _resetMeals = false;
  bool _saving = false;
  String? _error;

  UserProfileModel get _profile => widget.profile;
  String get _originalAge => _profile.age == 0 ? '' : '${_profile.age}';
  String get _originalHeight {
    final height = _profile.heightCm;
    if (height == 0) return '';
    final text = '$height';
    return text.endsWith('.0') ? text.substring(0, text.length - 2) : text;
  }

  @override
  void initState() {
    super.initState();
    _age = TextEditingController(text: _originalAge);
    _height = TextEditingController(text: _originalHeight);
    _gender = _profile.gender;
    _conditions = _profile.conditionTypes.toSet();
    _allergies = _profile.barriers.toSet();
    _conditionOptions = {
      ...medicalConditionOptions,
      for (final key in _conditions)
        if (!medicalConditionOptions.containsKey(key)) key: key,
    };
    _meals = {
      for (final key in _mealLabels.keys)
        key: TextEditingController(
          text: '${_profile.mealSplits[key] ?? defaultMealSplits[key]}',
        ),
    };
  }

  @override
  void dispose() {
    _age.dispose();
    _height.dispose();
    _customAllergy.dispose();
    for (final controller in _meals.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Map<String, int>? get _mealPercentages {
    final percentages = <String, int>{};
    for (final entry in _meals.entries) {
      final percentage = _wholeNumber(entry.value.text);
      if (percentage == null || percentage > 100) return null;
      percentages[entry.key] = percentage;
    }
    return percentages;
  }

  int? _wholeNumber(String? value) {
    final text = value?.trim() ?? '';
    return RegExp(r'^[0-9]+$').hasMatch(text) ? int.tryParse(text) : null;
  }

  List<String> get _pendingAllergies => _customAllergy.text
      .split(',')
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .toList();

  void _addAllergies() {
    setState(() {
      _allergies.addAll(_pendingAllergies);
      _customAllergy.clear();
    });
  }

  void _restoreMealDefaults() {
    setState(() {
      for (final entry in defaultMealSplits.entries) {
        _meals[entry.key]!.text = '${entry.value}';
      }
      _resetMeals = true;
      _error = null;
    });
  }

  Future<void> _save() async {
    if (_saving) return;
    final meals = _mealPercentages;
    if (!_formKey.currentState!.validate() || meals == null) {
      setState(() => _error = 'Check the highlighted fields before saving.');
      return;
    }
    if (meals.values.fold(0, (sum, value) => sum + value) != 100) {
      setState(() => _error = 'Meal percentages must add up to 100%.');
      return;
    }

    final allergies = {..._allergies, ..._pendingAllergies};
    final age = _wholeNumber(_age.text);
    final height = double.tryParse(_height.text.trim().replaceAll(',', '.'));
    final changes = <String, Object?>{
      if (age != null && age != _profile.age) 'age': age,
      if (_gender != _profile.gender)
        'gender': OnboardingPayloadMapper.genderToApi(_gender),
      if (height != null && height.isFinite && height != _profile.heightCm)
        'heightCm': height,
      if (!setEquals(_conditions, _profile.conditionTypes.toSet()))
        'conditionTypes': _conditions.toList(),
      if (!setEquals(allergies, _profile.barriers.toSet()))
        'allergies': allergies.toList(),
      if (_resetMeals || !mapEquals(meals, _profile.mealSplits))
        'mealSplits': _resetMeals ? null : meals,
    };

    if (changes.isEmpty) {
      Navigator.of(context).pop();
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _saving = true;
      _error = null;
    });
    final error = await widget.onSave(changes);
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _saving = false;
      _error = error.message.isEmpty
          ? 'Could not save health profile.'
          : error.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final genders = {
      'Female',
      'Male',
      if (_profile.gender.isNotEmpty) _profile.gender,
    };
    final total = _mealPercentages?.values.fold(0, (sum, value) => sum + value);

    return PopScope(
      canPop: !_saving,
      child: Scaffold(
        appBar: AppShellUi.appBar(context, 'Edit health profile'),
        backgroundColor: theme.colorScheme.surfaceContainerLowest,
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _numberField(
                    context,
                    label: 'Age',
                    controller: _age,
                    suffix: 'years',
                    validator: (value) {
                      if (value?.trim() == _originalAge) return null;
                      final age = _wholeNumber(value);
                      return age == null || age < 1 || age > 130
                          ? 'Enter an age from 1 to 130.'
                          : null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _gender.isEmpty ? null : _gender,
                    decoration: AppShellUi.filledField(
                      context,
                      label: 'Gender',
                    ),
                    items: genders
                        .map(
                          (gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ),
                        )
                        .toList(),
                    onChanged: _saving
                        ? null
                        : (value) {
                            if (value != null) setState(() => _gender = value);
                          },
                  ),
                  const SizedBox(height: 16),
                  _numberField(
                    context,
                    label: 'Height',
                    controller: _height,
                    suffix: 'cm',
                    decimal: true,
                    validator: (value) {
                      if (value?.trim() == _originalHeight) return null;
                      final height = double.tryParse(
                        (value ?? '').trim().replaceAll(',', '.'),
                      );
                      return height == null ||
                              !height.isFinite ||
                              height < 1 ||
                              height > 300
                          ? 'Enter a height from 1 to 300 cm.'
                          : null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Medical conditions',
                    style: theme.textTheme.titleMedium,
                  ),
                  _choices(_conditionOptions, _conditions),
                  const SizedBox(height: 24),
                  Text('Food allergies', style: theme.textTheme.titleMedium),
                  _choices({
                    for (final allergy in {
                      ...foodAllergyOptions,
                      ..._profile.barriers,
                      ..._allergies,
                    })
                      allergy: allergy,
                  }, _allergies),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _customAllergy,
                    enabled: !_saving,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _addAllergies(),
                    decoration:
                        AppShellUi.filledField(
                          context,
                          label: 'Add other allergies',
                          hint: 'Separate with commas',
                        ).copyWith(
                          suffixIcon: IconButton(
                            tooltip: 'Add allergies',
                            onPressed: _saving ? null : _addAllergies,
                            icon: const Icon(Icons.add),
                          ),
                        ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Meal calorie split',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Assign a whole percentage to each meal. The total must be 100%.',
                  ),
                  const SizedBox(height: 12),
                  for (final entry in _mealLabels.entries) ...[
                    _numberField(
                      context,
                      label: entry.value,
                      controller: _meals[entry.key]!,
                      suffix: '%',
                      validator: (value) {
                        final split = _wholeNumber(value);
                        return split == null || split > 100
                            ? 'Enter 0 to 100.'
                            : null;
                      },
                      onChanged: (_) => setState(() {
                        _resetMeals = false;
                        _error = null;
                      }),
                    ),
                    const SizedBox(height: 12),
                  ],
                  Text(total == null ? 'Total unavailable' : 'Total $total%'),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: _saving ? null : _restoreMealDefaults,
                      child: const Text('Reset to defaults'),
                    ),
                  ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        _error!,
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    ),
                  FilledButton(
                    onPressed: _saving ? null : _save,
                    child: Text(_saving ? 'Saving…' : 'Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _choices(Map<String, String> options, Set<String> selected) {
    return Wrap(
      spacing: 8,
      children: options.entries.map((option) {
        return FilterChip(
          label: Text(option.value),
          selected: selected.contains(option.key),
          onSelected: _saving
              ? null
              : (checked) {
                  setState(() {
                    if (checked) {
                      selected.add(option.key);
                    } else {
                      selected.remove(option.key);
                    }
                  });
                },
        );
      }).toList(),
    );
  }

  Widget _numberField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required String suffix,
    required FormFieldValidator<String> validator,
    bool decimal = false,
    ValueChanged<String>? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      enabled: !_saving,
      keyboardType: TextInputType.numberWithOptions(decimal: decimal),
      decoration: AppShellUi.filledField(
        context,
        label: label,
      ).copyWith(suffixText: suffix),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
