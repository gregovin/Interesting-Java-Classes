public class ApproximatorTester {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println(Approximator.approxE(10));
		System.out.println(Approximator.approxPi(101));
		Fraction pi = new Fraction(Math.PI);
		Fraction f2 = new Fraction(1, 4);
		System.out.println(pi.value());
		System.out.println(pi.mult(f2).value());
		System.out.println(pi.pow(f2).value());
		System.out.println(Approximator.approxRoot(4, 500));
	}

}
