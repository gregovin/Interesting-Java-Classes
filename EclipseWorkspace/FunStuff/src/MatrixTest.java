public class MatrixTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		double[][] testvars = {{1, 2},{3, 4}};
		Matrix m = new Matrix(testvars);
		System.out.println(m.internalVars.toString());
	}

}
