import java.util.Scanner;
import java.io.*;

public class SimpleGodotTilesetGenerator {
  static int numTileX = 0;
  static int numTileY = 0;
  static int sizeTileX = 0;
  static int sizeTileY = 0;
  static String texturepath = "res://assets/tilesets/Outside_A4.png";

  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    System.out.println("Enter numTileX: ");
    numTileX = Integer.parseInt(scanner.nextLine());
    System.out.println("Enter numTileY: ");
    numTileY = Integer.parseInt(scanner.nextLine());
    System.out.println("Enter sizeTileX: ");
    sizeTileX = Integer.parseInt(scanner.nextLine());
    System.out.println("Enter sizeTileY: ");
    sizeTileY = Integer.parseInt(scanner.nextLine());
    System.out.println("Enter texture path: ");
    texturepath = scanner.nextLine();
    System.out.println("number of tile : " + numTileX + " x " + numTileY);
    System.out.println("size of tile : " + numTileX + " x " + numTileY);
    scanner.close();
    generateGodotNode();
  }

  static void generateGodotNode() {
    int tile_counter = 1;
    try {
      PrintWriter writer = new PrintWriter("generated-node.txt", "UTF-8");
      writer.println("[gd_scene load_steps=2 format=1]");
      writer.println("");
      writer.println("[ext_resource path=\"" + texturepath + "\" type=\"Texture\" id=1]");
      writer.println("");
      writer.println("[node name=\"tileset\" type=\"Node2D\"]");
      writer.println("");
      for (int y = 0; y < numTileY; y++) {
        for (int x = 0; x < numTileX; x++) {
          writer.println("");
          writer.println("[node name=\"tile" + tile_counter + "\" type=\"Sprite\" parent=\".\"]");
          writer.println("");
          writer.println("texture = ExtResource( 1 )");
          writer.println("centered = false");
          writer.println("region = true");
          writer.println("region_rect = Rect2( " + (sizeTileX * x) + ", " + (sizeTileY * y) + ", " + sizeTileX + ", "
              + sizeTileY + " )");
          tile_counter++;
        }
      }
      writer.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

}
