/**
 * A class for storing fractions that is immune to most floating type errors.
 * Has many intuitive methods
 * @author Gregory Hess
 *
 */
public class Fraction {
	// the number of accurate significant figures when converting decimals to fractions
	public final int PRECISION = 10;
	private int numerator;
	private int denominator;
	/**
	 * Makes a fraction out of a decimal
	 * @param decimal a double you would like to make into a fraction
	 */
	public Fraction(double decimal){
		Fraction res = Approximator.decimalToFrac(decimal, PRECISION);
		this.numerator = res.numerator();
		this.denominator = res.denominator();
	}
	/**
	 * Makes a fraction out of 2 ints.
	 * @param num the numerator of the fraction
	 * @param den the denominator of the fraction
	 */
	public Fraction(int num, int den){
		int greatest  = gcd(num, den);
		if(den < 0){
			den *= -1;
			num *= -1;
		}
		this.numerator = num / greatest;
		this.denominator = den / greatest;
	}
	/**
	 * Get the gcd for use in making the fractions fully simplified
	 * @param num1 One of the numbers you would like to gcd
	 * @param num2 the other number you would like to gcd
	 * @return the greatest common denominator
	 */
	private static int gcd(int num1, int num2){
		while (num2 > 0){
			int temp = num2;
			num2 = num1 % num2;
			num1 = temp;
		}
		return num1;
	}
	/**
	 * Get the lowest common multiple
	 * @param a one of the numbers you would like to lcm
	 * @param b the other number you would like to lcm
	 * @return the lowest common multiple
	 */
	private static int lcm(int a, int b){
		return a * (b / gcd(a, b));
	}
	/**
	 * Adds a fraction to this fraction
	 * @param f2 The fraction you would like to add this fraction to
	 * @return the sum of the fractions
	 */
	public Fraction add(Fraction f2){
		int lowest = lcm(this.denominator, f2.denominator());
		int newNum = this.numerator * lowest/this.denominator + f2.numerator() * lowest/f2.denominator();
		return new Fraction(newNum,lowest);
	}
	/**
	 * Returns this fraction minus another fraction
	 * @param f2 the other fraction
	 * @return the difference between the two
	 */
	public Fraction sub(Fraction f2){
		int lowest = lcm(this.denominator, f2.denominator());
		int newNum = this.numerator * lowest/this.denominator - f2.numerator() * lowest/f2.denominator();
		return new Fraction(newNum, lowest);
	}
	/**
	 * Makes a string of the form "a / b"
	 */
	public String toString(){
		return ((this.numerator + " / ") + this.denominator);
	}
	/**
	 * Multiplies the fraction by another fraction
	 * @param f2 the fraction to multiply by
	 * @return the product of the fractions
	 */
	public Fraction mult(Fraction f2){
		return new Fraction(this.numerator * f2.numerator(), this.denominator * f2.denominator());
	}
	public Fraction div(Fraction f2){
		return new Fraction(this.numerator * f2.denominator(), this.denominator * f2.numerator());
	}
	/**
	 * Gets the reciprocal of this fraction
	 * @return the reciprocal of this fraction
	 */
	public Fraction recip(){
		return new Fraction(this.denominator, this.numerator);
	}
	/**
	 * Takes the fraction to an integer power
	 * @param exp the integer power you would like to take it to
	 * @return the resultant fraction
	 */
	public Fraction pow(int exp){
		if(exp >= 0){
			return new Fraction((int) (Math.pow(this.numerator, exp)), (int) (Math.pow(this.denominator, exp)));
		} else {
			return new Fraction((int) (Math.pow(this.denominator, exp * -1)), (int) (Math.pow(this.numerator, exp * -1)));
		}
	}
	/**
	 * Takes the fraction to a non-integer power
	 * @param exp the double power for exponentiation
	 * @return the approximate fraction that results from this exponentiation(note: has precision of floating point)
	 */
	public Fraction pow(double exp){
		return new Fraction(Math.pow(this.numerator, exp) / Math.pow(this.denominator, exp));
	}
	/**
	 * Takes the fraction to the power of a fraction
	 * @param exp the fractional power for exponentiation
	 * @return the approximate fraction that results from this exponentiation(note: has precision of floating point)
	 */
	public Fraction pow(Fraction exp){
		return this.pow(exp.value());
	}
	/**
	 * Gets the double version of the fraction
	 * @return a double that is num/dem
	 */
	public double value(){
		return (((double) this.numerator)/this.denominator);
	}
	/**
	 * Gets the numerator
	 * @return the numerator
	 */
	public int numerator(){
		return this.numerator;
	}
	/**
	 * Gets the denominator
	 * @return the denominator
	 */
	public int denominator(){
		return this.denominator;
	}
	public Fraction abs(){
		return new Fraction(Math.abs(this.numerator), this.denominator);
	}
}
