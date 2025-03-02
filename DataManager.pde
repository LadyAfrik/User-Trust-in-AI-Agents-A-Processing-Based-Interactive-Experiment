class DataManager {
    void saveRatings(String participantName, String agentType, String question, int rating) {
        String data = participantName + "," + agentType + "," + question + "," + rating;
        appendToFile("ratings.txt", data); // Ensure appendToFile() correctly appends data
    }
}
