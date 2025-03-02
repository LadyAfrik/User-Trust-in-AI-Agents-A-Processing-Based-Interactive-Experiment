abstract class VirtualAgent {
    String name;
    PImage avatar; // Change this to `avatar` since it's the name you're using in display()

    VirtualAgent(String name, String imagePath) {
        this.name = name;
        this.avatar = loadImage(imagePath); // Load the image into `avatar`
    }

    String getName() {
        return name;
    }

    PImage getImage() {
        return avatar; // Return avatar image
    }

    abstract void display(int x, int y);
}
