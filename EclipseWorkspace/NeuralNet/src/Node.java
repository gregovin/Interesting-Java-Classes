import java.util.Random;
public class Node {
	private double bias;
	private String type;
	public Node(String type){
		Random generator = new Random();
		bias = generator.nextDouble() * 10 - 5;
		if(type == "in") bias = 0;
		this.type = type;
	}
	public double activation(double in){
		return Math.min(Math.max(in - bias, 0), 1);
	}
	public void changeBias(double newBias){
		this.bias = newBias;
	}
	public double getBias(){
		return this.bias;
	}
	public String getType(){
		return this.type;
	}
}
