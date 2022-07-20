class ChallengeTask {

  bool get isComplete => this.isItemComplete();

  int get progress => this.progressData == null ? 0 : this.progressData;

  ChallengeTask(
      {this.name, this.progressData, this.id}
  );



  bool isItemComplete() {
    if (this.progress == null) {
      return false;
    }
    return this.progress >= 100;
  }

  final String id;
  final int progressData;
  final String name;
}