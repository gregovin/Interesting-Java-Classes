
public class Layer {
	private String type;
	private Node[] nodes;
	public Layer(int nodes, String type){
		this.type = type;
		this.nodes = new Node[nodes];
		for(int i = 0; i < nodes; i ++){
			this.nodes[i] = new Node(type);
		}
	}
	public double[] getActivations(double[] in){
		double[] res = new double[nodes.length];
		for(int i = 0; i < nodes.length; i ++){
			res[i] = nodes[i].activation(in[i]);
		}
		return res;
	}
	public String getType(){
		return this.type;
	}
	public Node[] getNodes(){
		return this.nodes;
	}
	public void setBias(int node,double newBias){
		this.nodes[node].changeBias(newBias);
	}
	public double getBias(int node){
		return this.nodes[node].getBias();
	}
}
