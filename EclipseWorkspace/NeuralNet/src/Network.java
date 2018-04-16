import java.util.Random;
public class Network {
	private Layer[] layers;
	private double[][][] weights;
	public Network(int inputNodes, int hidenLayers, int nodesPerHidenLayer, int outputNodes){
		Random generator = new Random();
		this.layers = new Layer[2 + hidenLayers];
		this.layers[0] = new Layer(inputNodes, "in");
		for(int i = 1; i < 1 + hidenLayers; i ++){
			this.layers[i] = new Layer(nodesPerHidenLayer, "hidden");
		}
		this.layers[1 + hidenLayers] = new Layer(outputNodes, "out");
		this.weights = new double[1 + hidenLayers][][];
		for(int i = 0; i < this.layers.length -1; i ++){
			this.weights[i] = new double[this.layers[i].getNodes().length][this.layers[i+1].getNodes().length];
			for(int j = 0; j < this.weights[i].length; j ++){
				for(int k = 0; k < this.weights[i][j].length; i ++){
						this.weights[i][j][k] = generator.nextDouble() * 2 -1;
				}
			}
		}
	}
	public double[] getOutput(double[] input){
		int hdnlength = layers[1].getNodes().length;
		double[] temp = new double[hdnlength];
		for(int i = 0; i < input.length; i ++){
			for(int j = 0; j < layers[1].getNodes().length; j++){
				temp[j] += input[i] * weights[0][i][j];
			}
		}
		double[] nextIn = layers[1].getActivations(temp);
		for(int i = 1; i < layers.length - 1; i ++){
			temp = new double[hdnlength];
			for(int j = 0; j< hdnlength; j ++){
				for(int k = 0; k < hdnlength; k ++){
					temp[k] += nextIn[j] * weights[i][j][k];
				}
			}
			nextIn = layers[i+1].getActivations(temp);
		}
		double[] res = new double[layers[layers.length - 1].getNodes().length];
		for(int i = 0; i < hdnlength; i ++){
			for(int j = 0; j < res.length; j ++){
				res[j] += nextIn[i] * weights[weights.length - 1][i][j];
			}
		}
		return layers[layers.length - 1].getActivations(res);
	}
	public void setWieght(int baseLayer, int elementThisLayer, int elementNextLayer, double newWeight){
		weights[baseLayer][elementThisLayer][elementNextLayer] = newWeight;
	}
	public double getWeight(int baseLayer, int nodeThisLayer, int nodeNextLayer){
		return weights[baseLayer][nodeThisLayer][nodeNextLayer];
	}
	public double getBias(int layer, int node){
		return layers[layer].getBias(node);
	}
	public void setBias(int layer, int node, int newBias){
		layers[layer].setBias(node, newBias);
	}
}
