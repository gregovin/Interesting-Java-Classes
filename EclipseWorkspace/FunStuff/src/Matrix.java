
public class Matrix {
	double[][] internalVars;
	int rows = 0;
	int colls = 0;
	public Matrix(double[][] vars){
		internalVars = vars;
		rows = vars.length;
		for(int i = 0;i < vars.length; i++){
			if (vars[i].length > colls){
				colls = vars[i].length;
			}
		}
		for(int i = 0;i < vars.length; i++){
			while(vars[i].length < colls){
				vars[i][vars[i].length] = 0;
			}
		}
	}
	public void printMatrix(){
		System.out.println(internalVars);
	}
}
