import java.awt.*;
import java.awt.event.*;
import java.util.Random;
import javax.swing.*;
import java.util.ArrayList;
/*
 * You DO need to change things in this Class!
 * This contains control logic and main display panel for the objects.
 * * Add a second ball in here - but first, understand how the first one is made
 * Don't forget the update class to get detection between objects
 */
public class BallWorld extends JPanel {
   /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final int UPDATE_RATE = 30;  // Frames per second (fps)
	private ArrayList<Ball> ballList = new ArrayList<Ball>(); // initializes a list of the balls to simulate
	private ContainerBox box;  // The container... rectangular box
	private DrawCanvas canvas; // Custom canvas for drawing the box/ball
	private int canvasWidth;
	private int canvasHeight;
	public final int NUMBEROFBALLS = 3;
	/**
	* Constructor to create the UI components and init the game objects.
	* Set the drawing canvas to fill the screen (given its width and height).
	* 
	* @param width : screen width
	* @param height : screen height
	*/
	public BallWorld(int width, int height) {  
		canvasWidth = width;
		canvasHeight = height;      
		// Initiate the ball at a random location (inside the box)
		Random rand = new Random();
		for(int i = 0;i < NUMBEROFBALLS;i ++){
			int radius = rand.nextInt(40) + 10;
			int x = rand.nextInt(canvasWidth - (radius * 2));
			int y = rand.nextInt(canvasHeight - (radius * 2));
			int speed = rand.nextInt(15)+5;
			int angleInDegree = rand.nextInt(360);
			int r = rand.nextInt(200) + 55;
			int b = rand.nextInt(200) + 55;
			int g = rand.nextInt(200) + 55;
			Color k = new Color(r, b, g);
			Ball temp = new Ball(x, y, radius, speed, angleInDegree, k);
			ballList.add(temp);
		}
		// Initialize the Container to fill the screen
		box = new ContainerBox(0, 0, canvasWidth, canvasHeight, Color.BLACK, Color.WHITE);    
		// Initialize the custom drawing panel
		canvas = new DrawCanvas();
		this.setLayout(new BorderLayout());
		this.add(canvas, BorderLayout.CENTER);
		// Handling window resize
		this.addComponentListener(new ComponentAdapter() {
			@Override
			public void componentResized(ComponentEvent e) {
				Component c = (Component)e.getSource();
				Dimension dim = c.getSize();
				canvasWidth = dim.width;
				canvasHeight = dim.height;
				// Adjust the bounds of the container to fill the window
				box.set(0, 0, canvasWidth, canvasHeight);
			}
		});
		// Start the ball bouncing
		this.bounce();
	}
	/** Start the ball bouncing. */
	public void bounce() {
		// Run the game logic in its own thread.
		Thread thread = new Thread() {
			public void run() {
				while (true) {
					// Calculate what happens next 
					update();
					// Refresh the display
					repaint();
					// Makes the program slow down so things can be drawn properly
					try {
						Thread.sleep(1000 / UPDATE_RATE);
					} catch (InterruptedException ex) {}
				}
			}
		};
		thread.start();  // start the thread for graphics
	}
	/** 
	* One time-step. 
	* Update the objects, with collision detection and response
	*/
	public void update() {
		for(int i = 0;i < ballList.size(); i ++){
			ballList.get(i).moveOneStepWithCollisionDetection(box);
		}
		for(int i = 0; i < ballList.size(); i ++){
			for(int j = i + 1;j <ballList.size(); j ++){
				ballList.get(i).collides(ballList.get(j));
			}
		}
	}   
	/** The custom drawing panel for the bouncing ball (inner class). */
	class DrawCanvas extends JPanel {
		/**
		 * 
		 */
		private static final long serialVersionUID = 2075516595114986593L;
		/** Custom drawing codes */
		@Override
		public void paintComponent(Graphics g) {
			super.paintComponent(g);    // Paint background
			// Draw the box and the ball
			box.draw(g);
			for(int i = 0; i < ballList.size(); i ++){
				ballList.get(i).draw(g);
			}
		}
		/** Called back to get the preferred size of the component. */
		@Override
		public Dimension getPreferredSize() {
			return (new Dimension(canvasWidth, canvasHeight));
		}
	}
}