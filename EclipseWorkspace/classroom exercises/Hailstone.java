import java.util.Scanner;
public class Hailstone {

	private static Scanner in;

	public static void main(String[] args) {
		in = new Scanner(System.in);
		System.out.println("Enter a number");
		int curr = in.nextInt();
		int next;
		while(curr != 1){
			if(curr % 2 == 0){
				next = curr / 2;
				System.out.println(curr + " is even, so I devide by 2 to get " + next);
				curr = next;
			} else {
				next = curr * 3 + 1;
				System.out.println(curr + " is odd, so I multiply by 3 and add 1 to get " + next);
				curr = next;
			}
		}
		System.out.println(curr + " is 1, so I can stop");
	}

}
