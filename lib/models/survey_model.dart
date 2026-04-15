class SurveyData {
  String? intentToVote; // Step 1
  String? votingPattern; // Step 2
  bool? pvcAvailable; // Step 3
  String? mainConcern; // Step 4
  String? partyChoice; // Step 5
  String? voiceNotePath; // Step 6
  String? textNote; // Step 7

  // Helper to check if step 1 is complete, etc.
  bool isStepComplete(int step) {
    switch (step) {
      case 1:
        return intentToVote != null;
      case 2:
        return votingPattern != null;
      case 3:
        return intentToVote != null;
      case 4:
        return votingPattern != null;
      case 5:
        return intentToVote != null;
      default:
        return false;
    }
  }
}
