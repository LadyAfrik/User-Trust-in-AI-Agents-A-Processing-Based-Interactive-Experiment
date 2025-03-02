TrustQuestion[] questions;
VirtualAgent[] agents;
Participant currentParticipant;
int currentAgentIndex = 0;
boolean registrationComplete = false;
Dashboard dashboard;

void setup() {
    size(800, 600);
    dashboard = new Dashboard();

    // Create agents
    agents = new VirtualAgent[]{
        new MaleAgent("Male Agent", "assets/male.png"),
        new FemaleAgent("Female Agent", "assets/female.png"),
        new AndrogynousAgent("Androgynous Agent", "assets/androgynous.png")
    };

    // Shuffle agents to avoid order effects
    shuffleArray(agents);

    // Define trust questions
    questions = new TrustQuestion[]{
        new TrustQuestion("I trust this AI agent."),
        new TrustQuestion("This agent is reliable."),
        new TrustQuestion("I feel comfortable using this agent.")
    };
}

void draw() {
    background(255);

    if (!registrationComplete) {
        showRegistrationScreen();
    } else if (currentAgentIndex < agents.length) {
        showAgentScreen();
    } else {
        dashboard.display(); // Show survey results
    }
}

// Shuffle function
void shuffleArray(VirtualAgent[] arr) {
    for (int i = arr.length - 1; i > 0; i--) {
        int j = (int) random(i + 1);
        VirtualAgent temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}

String participantName = "";
String selectedGender = "";
String age = "";
String selectedEducation = "Select Education";
String selectedExperience = "Select Experience";
boolean nameEntered = false;
boolean genderSelected = false;
boolean ageEntered = false;
boolean educationSelected = false;
boolean experienceSelected = false;
boolean typingAge = false; // Track if user is typing age

void showRegistrationScreen() {
    background(220);
    fill(0);
    textSize(16);

    // Title
    text("User Registration", width / 2 - 80, 50);

    // Name input
    text("Enter your name:", 50, 100);
    fill(255);
    rect(50, 120, 200, 30);
    fill(0);
    text(participantName, 60, 140);

    // Age input
    text("Enter your age:", 50, 170);
    fill(255);
    rect(50, 190, 200, 30);
    fill(0);
    text(age, 60, 210);

    // Gender selection
    text("Select your gender:", 50, 240);
    fill(selectedGender.equals("Male") ? color(0, 200, 0) : 255);
    rect(50, 260, 80, 30);
    fill(0);
    text("Male", 70, 280);

    fill(selectedGender.equals("Female") ? color(0, 200, 0) : 255);
    rect(150, 260, 80, 30);
    fill(0);
    text("Female", 170, 280);

    // Education selection
    text("Education Level:", 50, 310);
    fill(255);
    rect(50, 330, 200, 30);
    fill(0);
    text(selectedEducation, 60, 350);

    // Experience selection
    text("Tech Experience:", 50, 380);
    fill(255);
    rect(50, 400, 200, 30);
    fill(0);
    text(selectedExperience, 60, 420);

    // Submit button
    fill(nameEntered && genderSelected && ageEntered && educationSelected && experienceSelected ? color(0, 200, 0) : 150);
    rect(50, 460, 120, 40);
    fill(0);
    text("Submit", 85, 485);
}


void mousePressed() {
    if (!registrationComplete) {
        // Gender selection
        if (mouseX > 50 && mouseX < 130 && mouseY > 260 && mouseY < 290) {
            selectedGender = "Male";
            genderSelected = true;
        } else if (mouseX > 150 && mouseX < 230 && mouseY > 260 && mouseY < 290) {
            selectedGender = "Female";
            genderSelected = true;
        }

        // Education selection (Dropdown)
        if (mouseX > 50 && mouseX < 250 && mouseY > 330 && mouseY < 360) {
            String[] educationLevels = {"High School", "Bachelor's", "Master's", "PhD"};
            selectedEducation = educationLevels[(int) random(educationLevels.length)];
            educationSelected = true;
        }

        // Tech Experience selection (Dropdown)
        if (mouseX > 50 && mouseX < 250 && mouseY > 400 && mouseY < 430) {
            String[] experienceLevels = {"Beginner", "Intermediate", "Advanced"};
            selectedExperience = experienceLevels[(int) random(experienceLevels.length)];
            experienceSelected = true;
        }

        // Age input activation
        if (mouseX > 50 && mouseX < 250 && mouseY > 190 && mouseY < 220) {
            typingAge = true;
        } else {
            typingAge = false;
        }

        // Submit button
        if (mouseX > 50 && mouseX < 170 && mouseY > 460 && mouseY < 500) {
            if (!participantName.isEmpty() && genderSelected && !age.isEmpty() && educationSelected && experienceSelected) {
                currentParticipant = new Participant(participantName, selectedGender, age, selectedEducation, selectedExperience);
                currentParticipant.saveData();
                registrationComplete = true; // Move to rating phase
            }
        }
    } else {
        // ✅ Handle clicking on rating buttons (1-7)
        for (int i = 1; i <= 7; i++) {
            if (mouseX > 100 + (i - 1) * 80 && mouseX < 160 + (i - 1) * 80 && mouseY > 380 && mouseY < 420) {
                ratings[currentQuestionIndex] = i;
            }
        }

        // ✅ Handle clicking "Next" button after selecting a rating
        if (mouseX > width / 2 - 60 && mouseX < width / 2 + 60 && mouseY > 450 && mouseY < 490) {
            if (ratings[currentQuestionIndex] != 0) { // Ensure a rating was given
                currentQuestionIndex++;

                if (currentQuestionIndex >= questions.length) {
                    saveRatings();
                    currentQuestionIndex = 0;
                    currentAgentIndex++;

                    if (currentAgentIndex >= agents.length) {
                        registrationComplete = false;
                        dashboard.loadData();
                    }
                }
            }
        }
    }
}



void keyPressed() {
    if (!registrationComplete) {
        if (typingAge) {
            if (key == BACKSPACE && age.length() > 0) {
                age = age.substring(0, age.length() - 1);
            } else if (Character.isDigit(key)) {
                age += key;
            }
        } else {
            if (key == BACKSPACE && participantName.length() > 0) {
                participantName = participantName.substring(0, participantName.length() - 1);
            } else if (key != CODED && key != ENTER && key != RETURN) {
                participantName += key;
            }
        }
    }
}


int currentQuestionIndex = 0;
int[] ratings = new int[3];

void showAgentScreen() {
    background(255);

    VirtualAgent currentAgent = agents[currentAgentIndex];
    image(currentAgent.getImage(), width / 2 - 100, 50, 200, 200);
    fill(0);
    textSize(20);
    text(currentAgent.getName(), width / 2 - 50, 270);

    TrustQuestion currentQuestion = questions[currentQuestionIndex];
    textSize(18);
    text(currentQuestion.getText(), width / 2 - 150, 330);

    for (int i = 1; i <= 7; i++) {
        fill(ratings[currentQuestionIndex] == i ? color(0, 200, 0) : 200);
        rect(100 + (i - 1) * 80, 380, 60, 40);
        fill(0);
        text(i, 125 + (i - 1) * 80, 410);
    }

    fill(100, 100, 255);
    rect(width / 2 - 60, 450, 120, 40);
    fill(255);
    text("Next", width / 2 - 20, 475);
}

DataManager dataManager = new DataManager();

void saveRatings() {
    String agentName = agents[currentAgentIndex].getName();
    for (int i = 0; i < ratings.length; i++) {
        String questionText = questions[i].getText(); // Get question text
        dataManager.saveRatings(currentParticipant.getName(), agentName, questionText, ratings[i]);
    }
}
