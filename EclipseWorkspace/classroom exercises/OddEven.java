import java.util.Scanner;
public class OddEven {

	private static Scanner scan;

	public static void main(String[] args) {
		scan = new Scanner(System.in);
		System.out.println("Enter an integer:");
		int n = scan.nextInt();
		int even = 0;
		int odd = 0;
		while(n > 0){
			even += (n + 1) % 2;
			odd += n % 2;
			// if statements are for chumps
			n = n / 10;
		}
		System.out.println("Evens: " + even);
		System.out.println("Odds: " + odd);
	}

}
