class Dot{
  public PVector pos;
  public PVector vel;
  public PVector acc;
  public Dot(){
    pos = new PVector(0, 10, 0);
    vel = new PVector(0, 0, 0);
    vel.limit(100);
    acc = new PVector(0, 0, 0);
  }
  public void update(){
    pos.add(vel.div(fps));
    vel.add(acc.div(fps));
  }
  public void applyForce(PVector force){
    acc = force;
  }
}