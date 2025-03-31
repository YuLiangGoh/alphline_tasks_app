enum TaskSortType {
  deadlineAscending('Deadline Ascending'),
  deadlineDescending('Deadline Descending'),
  creationAscending('Creation Ascending'),
  creationDescending('Creation Descending');

  const TaskSortType(this.label);
  final String label;
}
