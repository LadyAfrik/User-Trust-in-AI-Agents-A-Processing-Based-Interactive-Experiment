class Dashboard {
    String[] data;

    void loadData() {
        data = loadStrings("ratings.txt"); // Load participant responses
    }

    void display() {
        background(230);
        fill(0);
        textSize(20);
        text("Survey Results", width / 2 - 70, 50);

        if (data == null || data.length == 0) {
            textSize(16);
            text("No data available.", width / 2 - 50, height / 2);
            return;
        }

        textSize(14);
        int y = 100;
        for (String line : data) {
            text(line, 50, y);
            y += 20;
        }
    }
}
