class FemaleAgent extends VirtualAgent {
    FemaleAgent(String name, String imagePath) {
        super(name, imagePath); // Call the superclass constructor
    }

    @Override
    void display(int x, int y) {
        image(avatar, x, y, 200, 200); // Use avatar instead of agentImage
    }
}
