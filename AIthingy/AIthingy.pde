final int NUMDOTS = 400;
final int fps = 30;
public Dot[] dotls;
void setup(){
  size(1024, 768, P3D);
  dotls = new Dot[NUMDOTS];
  for(int i = 0; i < NUMDOTS; i ++){
    dotls[i] = new Dot();
  }
}
void draw(){
  
}