class Participant {
    String name;
    String gender;
    String age;
    String educationLevel;
    String techExperience;

    Participant(String name, String gender, String age, String educationLevel, String techExperience) {
        this.name = name;
        this.gender = gender;
        this.age = age;
        this.educationLevel = educationLevel;
        this.techExperience = techExperience;
    }

    void saveData() {
        if (!isParticipantAlreadySaved()) { // Prevent duplicate entries
            String data = name + "," + gender + "," + age + "," + educationLevel + "," + techExperience;
            appendToFile("participants.txt", data);
        }
    }

    boolean isParticipantAlreadySaved() {
        String[] existingData = loadStrings("participants.txt"); // Load existing data
        if (existingData != null) {
            for (String line : existingData) {
                if (line.equals(name + "," + gender + "," + age + "," + educationLevel + "," + techExperience)) {
                    return true; // Participant already exists
                }
            }
        }
        return false;
    }

    String getName() {
        return name;
    }

    String getGender() {
        return gender;
    }

    String getAge() {
        return age;
    }

    String getEducationLevel() {
        return educationLevel;
    }

    String getTechExperience() {
        return techExperience;
    }
}
