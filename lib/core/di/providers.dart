// lib/core/di/providers.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:portfolio/data/data_sources/contact_datasource.dart';
import 'package:portfolio/data/repositories/contact_impl.dart';
import 'package:portfolio/domain/repositories/contact_repository.dart';
import 'package:portfolio/domain/use_cases/contact_usecase.dart';
import 'package:portfolio/view_models/contact_view_model.dart';
import 'package:portfolio/view_models/home_view_model.dart';

// Firebase
final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

// Data Sources
final contactDatasourceProvider = Provider<ContactDatasource>(
  (ref) => ContactDatasource(firestore: ref.watch(firebaseFirestoreProvider)),
);

// Repositories
final contactRepositoryProvider = Provider<ContactRepository>(
  (ref) => ContactImpl(ref.watch(contactDatasourceProvider)),
);

// Use Cases
final contactUseCaseProvider = Provider<ContactUseCase>(
  (ref) => ContactUseCase(ref.watch(contactRepositoryProvider)),
);

// ViewModels
final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>(
  (ref) => HomeViewModel(),
);

final contactViewModelProvider = ChangeNotifierProvider<ContactViewModel>(
  (ref) => ContactViewModel(ref.watch(contactUseCaseProvider)),
);
