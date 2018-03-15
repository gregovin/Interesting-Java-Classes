import java.util.Scanner;
import java.util.ArrayList;
public class Factor {

	private static Scanner in;
	public static void main(String[] args) {
		in = new Scanner(System.in);
		System.out.println("Enter a number");
		int num = in.nextInt();
		int test = 2;
		ArrayList<Integer> factors = new ArrayList<Integer>();
		while(test <= Math.sqrt(num)){
			if(isPrime(test) && num % test == 0){
				num = num / test;
				factors.add(test);
			} else {
				test ++;
			}
		}
		factors.add(num);
		System.out.println(factors);
	}
	public static boolean isPrime(int n){
		for(int i = 2; i < Math.sqrt(n); i ++){
			if(n % i == 0){
				return false;
			}
		}
		return true;
	}
}
