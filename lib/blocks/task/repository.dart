import '../../services/db_service.dart';
import 'model.dart';

class TaskRepository {
  final DatabaseService _dbService = DatabaseService.instance;

  Future<List<TaskModel>> fetchTasks() async {
    return await _dbService.getAllTasks();
  }

  Future<void> saveTask(TaskModel task) async {
    await _dbService.insertTask(task);
  }

  Future<void> updateTaskStatus(String id, TaskStatus status) async {
    await _dbService.updateTaskStatus(id, status.name);
  }

  Future<void> deleteTask(String id) async {
    await _dbService.deleteTask(id);
  }

}