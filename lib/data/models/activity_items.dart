class ActivityItem {
  final String id;
  final String name;
  bool isChecked;

  ActivityItem({required this.id, required this.name, this.isChecked = false});
}

final activities = [
  ActivityItem(id: '1', name: 'Product Demo'),
  ActivityItem(id: '2', name: 'Client Meeting'),
  ActivityItem(id: '3', name: 'Follow-up Call'),
  ActivityItem(id: '4', name: 'Contract Signing'),
  ActivityItem(id: '5', name: 'Feedback Session'),
  ActivityItem(id: '6', name: 'Training Session'),
  ActivityItem(id: '7', name: 'Networking Event'),
  ActivityItem(id: '8', name: 'Sales Pitch'),
  ActivityItem(id: '9', name: 'Market Research'),
  ActivityItem(id: '10', name: 'Customer Support'),
];