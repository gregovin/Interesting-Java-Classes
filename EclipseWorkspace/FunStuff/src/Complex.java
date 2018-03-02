public class Complex {
	private double a;
	private double b;
	private double theta;
	private double r;
	public Complex(double real, double im){
		this.a = real;
		this.b = im;
		this.r = Math.sqrt(real * real + im * im);
		this.theta = getTheta(real, im);
		
	}
	private double getTheta(double real, double im){
		if(real != 0 && im != 0){
			if (real > 0){
				return Math.atan(im / real);
			} else if (real < 0 && im > 0){
				return Math.PI + Math.atan(im/real);
			} else{
				return -1 * Math.PI + Math.atan(im/real);
			}
		} else if (im == 0){
			if(real >= 0){
				return 0;
			} else {
				return -1*Math.PI;
			}
		} else {
			if(im > 0){
				return Math.PI /2;
			} else {
				return -1*Math.PI/2;
			}
		}
	}
	public void print(){
		System.out.println(this.a + " + " + this.b + "i");
	}
	private Complex otherConstructor(double radius, double angle){
		return new Complex(radius * Math.cos(angle), radius * Math.sin(angle));
	}
	public Complex add(Complex c2){
		return new Complex(this.a + c2.a, this.b + c2.b);
	}
	public Complex sub(Complex c2){
		return new Complex(this.a - c2.a, this.b - c2.b);
	}
	public Complex mult(Complex c2){
		return otherConstructor(this.r * c2.r, this.theta + c2.theta);
	}
	public Complex div(Complex c2){
		return otherConstructor(this.r / c2.r, this.theta - c2.theta);
	}
	public Complex ln(){
		return new Complex(Math.log(this.r), this.theta);
	}
	public Complex eToThisPow(){
		double newR = Math.pow(Math.E, this.a);
		double newTheta = this.b;
		return otherConstructor(newR, newTheta);
	}
	public Complex pow(double real){
		return otherConstructor(Math.pow(this.r, real), this.theta * real);
	}
	public Complex pow(Complex c2){
		Complex logorithm = this.ln();
		Complex power = logorithm.mult(c2);
		return power.eToThisPow();
	}
	public Complex recip(){
		Complex one = new Complex(1, 0);
		return one.div(this);
	}
	public double re(){
		return this.a;
	}
	public double im(){
		return this.b;
	}
	public Complex conj(){
		return new Complex(this.a, -this.b);
	}
	public Complex mtheta(){
		return new Complex(this.r, this.theta);
	}
	public String toString(){
		return (this.re() + " " + this.im() + "i");
	}
}
