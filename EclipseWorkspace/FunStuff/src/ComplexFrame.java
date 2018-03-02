import java.awt.*;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JFrame;
public class ComplexFrame extends JFrame{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int index;
	public ComplexFrame(int i){
		this.index = i;
		init();
	}
	public void init(){
		setSize(799, 799);
		setBackground(Color.WHITE);
		repaint();
	}
	
	public void paint(Graphics g){
		List<Complex> points = new ArrayList<Complex>();
		for(int i = -800; i < 800; i += 80){
			for(int j = -800; j < 800; j ++){
				points.add(new Complex(i/20.0, j/20.0));
				if(j != i){
					points.add(new Complex(j/20.0, i/20.0));
				}
			}
		}
		List<Complex> transformed = func(index, points);
		List<Complex> differences = new ArrayList<Complex>();
		for(int i = 0; i < points.size(); i ++){
			differences.add(transformed.get(i).sub(points.get(i)));
		}
		g.setColor(Color.BLACK);
		for(int i = 0; i < points.size(); i ++){
			g.drawLine((int) (points.get(i).re() * 10 + 400), (int) (points.get(i).im() * 10 +400), 
					(int) (points.get(i).re() * 10 + 400), (int) (points.get(i).im() * 10 +400));
		}
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		for(int j = 1; j < 101; j ++){
			g.setColor(Color.WHITE);
			g.fillRect(0, 0, 799, 799);
			g.setColor(Color.BLACK);
			for(int i = 0; i < points.size(); i ++){
				g.drawLine((int) (points.get(i).re() * 10 + 400 + j * differences.get(i).re()/10),
						(int) (points.get(i).im() * -10 + 400 - j * differences.get(i).im()/10),
						(int) (points.get(i).re() * 10 + 400 + j * differences.get(i).re()/10),
						(int) (points.get(i).im() * -10 + 400 - j * differences.get(i).im()/10));
			}
			try {
				Thread.sleep(200);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.exit(0);
	}
	private List<Complex> func(int index, List<Complex> inputs){
		List<Complex> output = new ArrayList<Complex>();
		if(index == 0){
			for(int i = 0; i < inputs.size(); i ++){
				output.add(inputs.get(i).pow(2));
			}
		} else if (index == 1){
			Complex im = new Complex(0, 1);
			for(int i = 0; i < inputs.size(); i ++){
				output.add(im.pow(inputs.get(i)));
			}
		} else if (index == 2){
			Complex im = new Complex(0, 1);
			for(int i = 0; i < inputs.size(); i++){
				output.add(inputs.get(i).pow(im));
			}
		} else if (index == 3){
			for(int i = 0; i < inputs.size(); i ++){
				output.add(inputs.get(i).pow(inputs.get(i)));
			}
		} else if (index == 4){
			Complex e = new Complex(Math.E, 0);
			for(int i = 0; i < inputs.size(); i ++){
				output.add(e.pow(inputs.get(i)));
			}
		} else if (index == 5){
			for(int i = 0; i < inputs.size(); i ++){
				output.add(inputs.get(i).ln());
			}
		} else if (index == 6){
			for(int i = 0; i < inputs.size(); i ++){
				output.add(inputs.get(i).pow(.5));
			}
		} else if (index == 7){
			Complex im = new Complex(0, 1);
			for(int i = 0; i < inputs.size(); i ++){
				output.add(inputs.get(i).mult(im));
			}
		} else if (index == 8){
			for(int i = 0; i < inputs.size(); i ++){
				output.add(inputs.get(i).conj());
			}
		} else if (index == 9){
			for(int i = 0; i < inputs.size(); i ++){
				output.add(inputs.get(i).pow(2).pow(1.0/2));
			}
		}
		return output;
	}
}
