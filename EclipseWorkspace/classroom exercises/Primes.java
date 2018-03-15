import java.util.Scanner;
import java.util.ArrayList;
public class Primes {

	private static Scanner in;

	public static void main(String[] args) {
		in = new Scanner(System.in);
		ArrayList<Number> primes = new ArrayList<Number>(2);
		int index;
		boolean isPrime;
		System.out.println("Enter a number");
		int upper = in.nextInt();
		for(int i = 2; i < upper; i ++){
			isPrime = true;
			index = 0;
			while(isPrime && index < primes.size() && (int) primes.get(index) <= Math.sqrt(i)){
				if(i % ((int) primes.get(index)) == 0){
					isPrime = false;
				}
				index ++;
			}
			if(isPrime) primes.add(i);
		}
		System.out.println(primes);
	}

}
