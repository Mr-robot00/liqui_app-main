class LabelListModel {
  ///add values
  late String title;
  late bool isDisabled;

  LabelListModel({required String label, bool disabled = false}) {
    title = label;
    isDisabled = disabled;
  }
}
