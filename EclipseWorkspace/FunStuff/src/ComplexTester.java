import java.util.Scanner;

import javax.swing.JFrame;

public class ComplexTester {

	private static Scanner scan;

	public static void main(String[] args) {
		scan = new Scanner(System.in);
		System.out.println("Here are the availible functions with their identifiers:\n"
				+ "0 : x^2, 1: i^x, 2: x ^ i, 3: x ^x, 4: e^x, 5: ln(x), 6: x^(1/2), 7: ix, "
				+ "\n\t8 : conj(x), 9 : (x^2)^(1/2)");
		System.out.println("Enter the identifier of the function you want");
		int index = scan.nextInt();
		ComplexFrame c = new ComplexFrame(index);
		c.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		c.setVisible(true);
	}

}
