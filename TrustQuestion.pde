class TrustQuestion {
    String question;
    int rating;

    TrustQuestion(String question) {
        this.question = question;
        this.rating = 0;
    }

    void setRating(int rating) {
        if (rating >= 1 && rating <= 7) {
            this.rating = rating;
        }
    }

    // Add the getText() method
    String getText() {
        return question; // Return the question text
    }
}
