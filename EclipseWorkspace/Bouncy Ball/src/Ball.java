import java.awt.*;

/*
 * You will need to alter code in this class!
 * First, make sure a single ball bounces 
 * around the screen correctly.
 * Then, add collision between multiple objects.
 */
public class Ball {
   public double x, y;           // Ball's center x and y (package access)
   public double speedX, speedY; // Ball's speed per step in x and y (package access)
   public double radius;         // Ball's radius (package access)
   private Color color;  // Ball's color  

   public Ball(double x, double y, double radius, double speed, double angleInDegree,
         Color color) {
      this.x = x;
      this.y = y;
      // Convert (speed, angle) to (x, y)
      this.speedX = (speed * Math.cos(Math.toRadians(angleInDegree)));
      this.speedY = (-speed * Math.sin(Math.toRadians(angleInDegree)));
      this.radius = radius;
      this.color = color;
   }
   
   public void draw(Graphics g) {
      g.setColor(color);
      g.fillOval((int) x, (int) y, (int)(2 * radius), (int)(2 * radius));
   }
   
   /** 
    * Move, check for collision and react accordingly if collision occurs.
    * 
    * @param box: the container (obstacle) for this ball. 
    */
   // Determine how to reflect off the walls of the screen
   public void moveOneStepWithCollisionDetection(ContainerBox box) {
      // Use the variable box to get the max/min x/y values of the screen
   
	  // Next step
	   // add gravity
	   this.speedY ++;
	   this.x += speedX;
	   this.y += speedY;
	   if(box.maxX - 2 * this.radius < this.x) {
		   this.speedX *= -1;
		   this.x = box.maxX - 2 * this.radius;
	   }
	   else if(box.minX > this.x){
		   this.speedX *= -1;
		   this.x = box.minX;
	   }
	   if(box.maxY - 2 * this.radius < this.y){
		   this.speedY *= -1;
		   this.y = box.maxY - 2 * this.radius;
	   } else if(box.minY> this.y){
		   this.speedY *= -1;
		   this.y = box.minY;
	   }
   }
   public void collides(Ball b2){
	   // Use this classes x, y, and radius
	   // Compare versus the b2.x, b2.y, and b2.radius
	   // Determine if they collide and have them bounce off each other
	   //gets the middle x cord of this ball
	   double thisxCenter = this.x + this.radius;
	   //gets the middle y cord of this ball
	   double thisyCenter = this.y + this.radius;
	   //gets the middle x cord of the other ball
	   double b2xCenter = b2.x + b2.radius;
	   //gets the middle y cord of the other ball
	   double b2yCenter = b2.y + b2.radius;
	   //if the distance between the center of the balls is less than or equal to the sum of the radii
	   if(Math.sqrt(Math.pow(thisxCenter - b2xCenter, 2) + Math.pow(thisyCenter - b2yCenter, 2)) <= this.radius + b2.radius){
		   //get the angle of the connection between the center of the balls and the horizontal
		   double anglebetween = Math.toDegrees(Math.atan2(b2yCenter-thisyCenter, b2xCenter- thisxCenter));
		   //switch the balls' speeds
		   double tempx = this.speedX;
		   double tempy = this.speedY;
		   this.speedX = b2.speedX * b2.radius * b2.radius / (this.radius * this.radius);
		   this.speedY = b2.speedY * b2.radius * b2.radius / (this.radius * this.radius);
		   b2.speedX = tempx * this.radius * this.radius / (b2.radius * b2.radius);
		   b2.speedY = tempy * this.radius * this.radius / (b2.radius * b2.radius);
		   //calculate the overlap of the balls
		   double overlap = this.radius + b2.radius - Math.sqrt(Math.pow(thisxCenter - b2xCenter, 2) + Math.pow(thisyCenter - b2yCenter, 2));
		   //project the x and y of both balls so that they will not overlap.
		   this.x += overlap * Math.cos(Math.toRadians(anglebetween));
		   this.y -= overlap * Math.sin(Math.toRadians(anglebetween));
		   b2.x -= overlap * Math.cos(Math.toRadians(anglebetween));
		   b2.y += overlap * Math.sin(Math.toRadians(anglebetween));
	   }
   }
   
   /** Return the magnitude of speed. */
   public double getSpeed() {
      return Math.sqrt(speedX * speedX + speedY * speedY);
   }
   
   /** Return the direction of movement in degrees (counter-clockwise). */
   public double getMoveAngle() {
      return Math.toDegrees(Math.atan2(-speedY, speedX));
   }
}