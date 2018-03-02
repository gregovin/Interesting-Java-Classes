public class Approximator {
	/**
	 * Approximate E
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
	 * Approximate Pi with an infinite sum
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
		int place = (int) Math.floor(Math.log(frac) + 1)-precision;
		if (frac > 0){
			int num = 1;
			double dem = 1;
			while (Math.abs(num / dem - frac) > Math.pow(10, place)){
				if (num / dem < frac){
					num += 1;
				} else{
					dem += 1;
				}
			}
			return new Fraction(num, (int) dem);
		} else if(frac < 0){
			int num = -1;
			double dem = 1;
			while (Math.abs(num / dem - frac) > Math.pow(10, place)){
				if (num / dem > frac){
					num -= 1;
				} else{
					dem += 1;
				}
			}
			return new Fraction(num, (int) dem);
		} else {
			return new Fraction(0, 1);
		}
	}
	public static double approxRoot(double k, int r){
		if (r == 1){
			return 1 + (k-1)/2;
		} else {
			double temp = approxRoot(k - (k-1)/r, r-1);
			return (k-1)/r * 1 / (2 * temp) + temp; 
		}
	}
}
