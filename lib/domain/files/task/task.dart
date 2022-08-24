import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String filename;
  final int status;

  const Task({
    required this.id,
    required this.filename,
    required this.status,
  });

  @override
  List<Object> get props => [id, filename, status];
}
