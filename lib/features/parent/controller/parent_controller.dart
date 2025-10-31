import 'package:edutech_app/core/api/dio_consumer.dart';
import 'package:edutech_app/core/api/endpoints.dart';
import 'package:edutech_app/core/errors/exceptions.dart';
import 'package:edutech_app/features/parent/model/child_sessions.dart';
import 'package:edutech_app/features/parent/model/parent_home.dart';
import 'package:edutech_app/features/parent/model/student_model.dart';
import 'package:edutech_app/features/parent/model/child_info_model.dart';
import 'package:flutter/material.dart';

class ParentProvider extends ChangeNotifier {
  final DioConsumer api;

  ParentProvider({required this.api});

  // State for Parent Home (shows 2 children)
  bool _loadingHome = false;
  Parent? _parentData;
  String? _homeError;

  // State for All Children (full list)
  bool _loadingAllChildren = false;
  List<Student> _allChildren = [];
  String? _childrenError;

  // State for Child Info
  bool _loadingChildInfo = false;
  ChildInfoModel? _selectedChildInfo;
  String? _childInfoError;

  // State for Child Sessions
  bool _loadingChildSessions = false;
  ChildSessions? _selectedChildSessions;
  String? _childSessionsError;

  // Getters - Home Data
  bool get loadingHome => _loadingHome;
  Parent? get parentData => _parentData;
  String? get homeError => _homeError;
  List<Child> get homeChildren => _parentData?.children ?? [];
  int get numberOfChildren => _parentData?.numberOfChildren ?? 0;
  int get numberOfClasses => _parentData?.numberOfClasses ?? 0;

  // Getters - All Children
  bool get loadingAllChildren => _loadingAllChildren;
  List<Student> get allChildren => _allChildren;
  String? get childrenError => _childrenError;

  // Getters - Child Info
  bool get loadingChildInfo => _loadingChildInfo;
  ChildInfoModel? get selectedChildInfo => _selectedChildInfo;
  String? get childInfoError => _childInfoError;

  // Getters - Child Sessions
  bool get loadingChildSessions => _loadingChildSessions;
  ChildSessions? get selectedChildSessions => _selectedChildSessions;
  String? get childSessionsError => _childSessionsError;

  // 1. Fetch Parent Home Data (shows 2 children)
  Future<void> fetchParentHomeData() async {
    _loadingHome = true;
    _homeError = null;
    notifyListeners();

    try {
      final response = await api.get(Endpoints.parentHome);

      _parentData = Parent.fromJson(response);

      print('Parent data loaded: ${_parentData?.fullName}');
      print('Number of children: ${_parentData?.numberOfChildren}');
    } on ServerException catch (e) {
      _homeError = e.errorModel.errorMessage;
      print("Server Exception: $_homeError");
    } catch (e) {
      _homeError = "Unexpected error: $e";
      print("Unexpected Error: $_homeError");
    } finally {
      _loadingHome = false;
      notifyListeners();
    }
  }

  // 2. Fetch All Children (full list)
  Future<void> fetchAllChildren() async {
    _loadingAllChildren = true;
    _childrenError = null;
    notifyListeners();

    try {
      final response = await api.get(
        Endpoints.parentChildren,
      ); // Update with your endpoint

      // Assuming response is a list
      if (response is List) {
        _allChildren = Student.listFromJson(response);
      } else if (response is Map && response.containsKey('children')) {
        _allChildren = Student.listFromJson(response['children']);
      }

      print('All children loaded: ${_allChildren.length}');
    } on ServerException catch (e) {
      _childrenError = e.errorModel.errorMessage;
      print("Server Exception: $_childrenError");
    } catch (e) {
      _childrenError = "Unexpected error: $e";
      print("Unexpected Error: $_childrenError");
    } finally {
      _loadingAllChildren = false;
      notifyListeners();
    }
  }

  // 3. Fetch Child Info by ID
  Future<void> fetchChildInfo(int childId) async {
    _loadingChildInfo = true;
    _childInfoError = null;
    _selectedChildInfo = null;
    notifyListeners();

    try {
      final response = await api.get('${Endpoints.childInfo}/$childId');

      _selectedChildInfo = ChildInfoModel.fromJson(response);

      print('Child info loaded: ${_selectedChildInfo?.personalInfo.fullName}');
    } on ServerException catch (e) {
      _childInfoError = e.errorModel.errorMessage;
      print("Server Exception: $_childInfoError");
    } catch (e) {
      _childInfoError = "Unexpected error: $e";
      print("Unexpected Error: $_childInfoError");
    } finally {
      _loadingChildInfo = false;
      notifyListeners();
    }
  }

  // 4. Fetch Child Sessions by ID
  Future<void> fetchChildSessions(int childId) async {
    _loadingChildSessions = true;
    _childSessionsError = null;
    _selectedChildSessions = null;
    notifyListeners();

    try {
      final response = await api.get('${Endpoints.childSessions}/$childId');

      _selectedChildSessions = ChildSessions.fromJson(response);

      print(
        'Child sessions loaded: ${_selectedChildSessions?.sessions.length}',
      );
    } on ServerException catch (e) {
      _childSessionsError = e.errorModel.errorMessage;
      print("Server Exception: $_childSessionsError");
    } catch (e) {
      _childSessionsError = "Unexpected error: $e";
      print("Unexpected Error: $_childSessionsError");
    } finally {
      _loadingChildSessions = false;
      notifyListeners();
    }
  }

  // Get specific child from all children by id
  Student? getChildById(int childId) {
    try {
      return _allChildren.firstWhere((child) => child.studentId == childId);
    } catch (e) {
      return null;
    }
  }

  // Refresh home data
  Future<void> refreshHome() async {
    await fetchParentHomeData();
  }

  // Refresh all children
  Future<void> refreshAllChildren() async {
    await fetchAllChildren();
  }

  // Clear all data
  void clearData() {
    _parentData = null;
    _allChildren = [];
    _selectedChildInfo = null;
    _selectedChildSessions = null;
    _homeError = null;
    _childrenError = null;
    _childInfoError = null;
    _childSessionsError = null;
    notifyListeners();
  }

  // Clear selected child data
  void clearSelectedChildData() {
    _selectedChildInfo = null;
    _selectedChildSessions = null;
    _childInfoError = null;
    _childSessionsError = null;
    notifyListeners();
  }
}
