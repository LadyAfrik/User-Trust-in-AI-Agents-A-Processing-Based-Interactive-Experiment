import java.io.*;

void appendToFile(String filename, String data) {
    try {
        // Get the absolute file path
        String filePath = dataPath(filename);
        File file = new File(filePath);

        // Ensure the parent directory exists
        File parentDir = file.getParentFile();
        if (parentDir != null && !parentDir.exists()) {
            parentDir.mkdirs(); // Create directories if missing
        }

        // Create the file if it doesn't exist
        if (!file.exists()) {
            file.createNewFile();
        }

        // Append mode
        FileWriter fw = new FileWriter(file, true);
        PrintWriter output = new PrintWriter(fw);

        output.println(data);
        output.close(); // Flush and close
        println("Data successfully saved to " + filePath + ": " + data);
    } catch (IOException e) {
        println("Error writing to file: " + e.getMessage());
    }
}
