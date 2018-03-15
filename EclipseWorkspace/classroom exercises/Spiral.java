//for Spiral
import java.awt.*;
import java.awt.geom.Line2D;
import java.awt.geom.Rectangle2D;

import javax.swing.*;
public class Spiral extends JApplet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2L;

	public void init() {
		setSize(650, 650);
		setBackground(Color.WHITE);
	}
	public void paint(Graphics g){
		Graphics2D g2 = (Graphics2D) g;
		double width = getWidth();
		double height = getHeight();
		double dx = width/16;
		double dy = height/16;
		Rectangle2D.Double filler = new Rectangle2D.Double(0, 0, width, height);
		g2.setColor(Color.WHITE);
		g2.fill(filler);
		BasicStroke k = new BasicStroke(5);
		g2.setStroke(k);
		g2.setColor(Color.BLUE);
		for(int i = 0; i < 8; i ++){
			Line2D.Double right = new Line2D.Double(width - i * dx, dy * (i-1), width - i * dx, height  - i * dy);
			g2.draw(right);
			Line2D.Double botom = new Line2D.Double(width - i * dx, height  - i * dy, i*dx, height - i * dy);
			g2.draw(botom);
			Line2D.Double left = new Line2D.Double(i*dx, height - i * dy, i * dx, i * dy);
			g2.draw(left);
			Line2D.Double top = new Line2D.Double(i * dx, i * dy, width - (i+1) * dx, i * dy);
			g2.draw(top);
		}
		Line2D.Double last = new Line2D.Double(width - 8 * dx, 7 * dy, width- 8 * dx, 8 * dy);
		g2.draw(last);
	}
}
