package NonAcademic;

import java.io.*;
import java.awt.*;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.util.Random;
import java.util.Scanner;

/*
 *  Pizza
 *  Chaidhat Chaimongkol  	6 Sep 2018
 *  Will assertively instigate a formal interrogation of the user on what choice of pizza they prefer
 */

public class DotProject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static Scanner userinput;
	
	// territory, pixel, xy
			static int[][][] ydot = new int[10][10000][2];
			static int ydav[] = new int[10];
			

	public static void main(String args[]) throws IOException 
	{	
		
		/*
		 * 
		 * 
		 * 		USERINPUT
		 */
		int gridColumns = 2;
		int gridRows = 2;
		
		/*
		 * 
		 * 
		 * 		USERINPUT
		 */
		
		File[] inImageFile = new File[gridRows];
		
		for (int i = 0; i < gridRows; i++)
		{
			inImageFile[i] = new File("/Users/chaidhatchaimongkol/Desktop/dots/" + i + ".png");
		}
		File outputfile = new File("/Users/chaidhatchaimongkol/Desktop/dots.png");
		
		int[][][] dots = new int[gridColumns][10][2];
		
		// To record colour
		//int[][] imagePixelColors = null;
		
		// Image dimensions
		
		// All input must be same dimensions
		int imageWidth = ImageIO.read(inImageFile[0]).getWidth();
		int imageHeight = ImageIO.read(inImageFile[0]).getHeight();
		int c = -1;
	
		int[][] d = new int[imageHeight][imageWidth];
		
		BufferedImage outImage = new BufferedImage(imageWidth,imageHeight,BufferedImage.TYPE_INT_ARGB);
		
		for (int x = 0; x < outImage.getWidth(); x++) {
			for (int y = 0; y < outImage.getHeight(); y++) {
				d[x][y] = -1;
			}
		}
		
		for (int i = 0; i < inImageFile.length; i++)
		{
			BufferedImage inImage = ImageIO.read(inImageFile[i]);
			
			for (int x = 0; x < outImage.getWidth(); x++) {
				for (int y = 0; y < outImage.getHeight(); y++) {
					//inImage.getRGB((int) dX, (int) dY)do
					
					
					int pixelColorInt = new Color(255, 0, 0).getRGB();
					
					if (new Color(inImage.getRGB(x, y)).getRed() == 255 && d [x][y] == -1)
						c++;
					d = Query(x, y, d, inImage, c);
					
					//count++;
					//System.out.println(count);
				}
			}
			
			/*for (int x = 0; x < outImage.getWidth(); x++) {
				for (int y = 0; y < outImage.getHeight(); y++) {
					//inImage.getRGB((int) dX, (int) dY)do
					
					int pixelColorInt = new Color((d[x][y] + 1) * 80, 0, 0).getRGB();
					
					outImage.setRGB(x, y, pixelColorInt);
					//count++;
					//System.out.println(count);
				}
			}*/
			
			for (int x = 0; x < c + 1; x++)
			{
				int pixelColorInt = new Color(255, 255, 0).getRGB();
				
				outImage.setRGB(ydot[x][0][0], ydot[x][0][1], pixelColorInt);
				dots[i][x] = ydot[x][0]; // bit complex
			}
		}
		
		ImageIO.write(outImage, "png", outputfile);
		
		
		
		//Display Programmer name and date
		System.out.println(); 	// Output a blank line
		System.out.print(c + " " + dots[0][0][1] + "Created by Chaidhat Chaimongkol on 6 September 2018");
	} //main
	
	static int[][] Query (int x, int y, int[][] d, BufferedImage i, int c)
	{
		int[][] d2 = d;
		if (new Color(i.getRGB(x, y)).getRed() == 255 && d2[x][y] == -1)
		{
			ydot[c][ydav[c]][0] = x;
			ydot[c][ydav[c]][1] = y;
			ydav[c]++;
			System.out.println(ydav[c] + "" + c);
			
			d2[x][y] = c;
			d2 = Query(x + 1, y, d2, i, c);
			d2 = Query(x, y + 1, d2, i, c);
			d2 = Query(x, y - 1, d2, i, c);
			d2 = Query(x - 1, y, d2, i, c);
		}
		
		return d2;
	}

} //video6