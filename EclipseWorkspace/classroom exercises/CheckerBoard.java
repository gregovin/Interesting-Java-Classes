//for CheckerBoard
import java.awt.*;
import java.awt.geom.Rectangle2D;
import javax.swing.*;

public class CheckerBoard extends JApplet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void init() {
		setSize(650, 650);
		setBackground(Color.WHITE);
	}
	public void paint(Graphics g){
		Graphics2D g2 = (Graphics2D) g;
		Rectangle2D.Double filler = new Rectangle2D.Double(0, 0, getWidth(), getHeight());
		g2.setColor(Color.WHITE);
		g2.fill(filler);
		g2.setColor(Color.BLACK);
		for(int i = 0; i < 8; i += 1){
			for(int j = i%2; j < 8; j += 2){
				Rectangle2D.Double temp = new Rectangle2D.Double(
						j * getWidth()/8,i * getHeight()/8,getWidth()/8,getHeight()/8);
				g2.fill(temp);
			}
		}
	}
}
