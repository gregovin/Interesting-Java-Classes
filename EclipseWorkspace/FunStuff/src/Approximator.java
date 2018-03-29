public class Approximator {
	/**
	 * Approximate E with a truncated infinite sum
	 * @param times how many times you want to do it for
	 * @return the approximation
	 */
	public static double approxE(int times){
		double divby = 1;
		double nearE = 0;
		for(int i = 1; i <= times; i ++){
			nearE += 1/divby;
			divby *= i;
		}
		return nearE;
	}
	/**
	 * Approximate Pi with a truncated infinite sum
	 * @param times the number of times to do it for
	 * @return the approximation
	 */
	public static double approxPi(int times){
		double nearPi = 0;
		for(double i = 1; i <= times; i ++){
			nearPi += 1/(2*i - 1) * (((i % 2) - .5) * 2);
		}
		return nearPi * 4;
	}
	/**
	 * Approximate a decimal
	 * @param frac the decimal to approximate
	 * @param precision how many significant figures to approximate to
	 * @return the approximation
	 */
	public static Fraction decimalToFrac(double frac, int precision){
		//figure out what power of 10 to approximate to so it has precision significant figures
		int place = (int) Math.floor(Math.log(frac) + 1)-precision;
		// if the decimal is not on the interval 0, 1 ...
		if(frac < 0 || frac > 1){
			// find the greatest integer less than the decimal
			int lower = (int) Math.floor(frac);
			// find the number of digits in front of the decimal point
			int lowPer = (int) Math.floor(Math.log(lower+1));
			// Call the function on the fraction - lower and with a precision decreased by the number of digits in front of the decimal point for lower.
			Fraction remainingFrac = Approximator.decimalToFrac(frac - lower, precision - lowPer);
			// return the sum of that fraction and lower
			return new Fraction(remainingFrac.numerator() + lower * remainingFrac.denominator(), remainingFrac.denominator());
		} else if (place < 0 && frac != 0){ //make sure there is actual approximation that needs to happen
			int num = 1; //set the numerator to 1
			//set the denominator to 1(double so division returns a double)
			double dem = 1;
			//keep going while the difference between the numerator divided by the denominator and the decimal is greater than 10 ^ place
			while (Math.abs(num / dem - frac) > Math.pow(10, place)){
				if (num / dem < frac){ // if the numerator divided my the denominator is to small ...
					num += 1; // add 1 to the numerator(make the fraction bigger)
				} else{ // otherwise ...
					dem += 1; //add 1 to the denominator(make the fraction smaller)
				}
			}
			return new Fraction(num, (int) dem); // return the Fraction with the numerator and denominator resulting from the loop above 
		} else return new Fraction(0, 1);
	}
	//approximate the square root of k with newton's method r times
	public static double approxRoot(double k, int r){
		if (r <= 1){ // if we are done ...
			return 1 + (k-1)/2; // return 1 + the distance * the derivative of the square root at 1
		} else { // otherwise ...
			//Recursively call approxRoot on the fractional splits by r so that the newton's method works
			double temp = approxRoot(k - (k-1)/r, r-1);
			//this is some more horrible derivative equation.
			return (k-1)/r * 1 / (2 * temp) + temp; 
		}
	}
}
