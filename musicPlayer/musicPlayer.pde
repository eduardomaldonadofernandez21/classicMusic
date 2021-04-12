import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;

float volume = 15;
int v = -5;
float maxVol = 15; float minVol = -50;

boolean pantallaControl;

void setup()
{
  size(512, 500, P3D);
  
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);

  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player = minim.loadFile("music/beethoven.mp3");
  pantallaControl = true;


}

void draw()
{
  if(!pantallaControl){
    background(0);
    stroke(255);
    for(int i = 0; i < player.bufferSize() - 1; i++)
    {
      float x1 = map( i, 0, player.bufferSize(), 0, width );
      float x2 = map( i+1, 0, player.bufferSize(), 0, width );
      line( x1, 50 + player.left.get(i)*50, x2, 50 + player.left.get(i+1)*50 );
      line( x1, 250 + player.right.get(i)*50, x2, 250 + player.right.get(i+1)*50 );
      textSize(20);
      text("Canal izquierdo", 270, 90);
      text("Canal derecho", 270, 290);
    }
  
    // Se dibuja la línea donde esta sonando la canción actualmente
    float posx = map(player.position(), 0, player.length(), 0, width);
    stroke(0,200,0);
    line(posx, 0, posx, height/2);
  
    if ( player.isPlaying() )
    {
      textSize(15);
      text("Pulsa ENTER para pausar la reproducción.", 160, 20 );
    }
    else
    {
      textSize(15);
      text("Pulsa ENTER para empezar la reproducción.", 160, 20 );
    }
    showVolumen();
  }else{
    showControl();
  }
}

void keyPressed()
{
  if(keyCode == ENTER ){ 
    if ( player.isPlaying() ){
      player.pause();
    }
    else if ( player.position() == player.length() ){
      player.rewind();
      player.play();
    }else{
      player.play();
    }
  }
   if (key == '-') {     
      if (v > minVol){ 
        v--;
      }
      player.setGain(v);    
      volume = map(v, minVol, maxVol, -10, 10);
    }
    
    if (key == '+') {  
      if (v < maxVol){ 
        v++;
      }
      player.setGain(v);  
      volume = map(v, minVol, maxVol, -10, 10);    
    }
    if(key == 'c' || key == 'C'){
      pantallaControl = !pantallaControl;
    }
}

void showVolumen(){
  fill(255);
  text("Volumen: " + nf(volume, 0, 2), 400, 350);

}

void showControl(){
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0); 
  background (0) ;
  textSize(30);
  textAlign(CENTER,CENTER);
  fill(255);
  text("Música clásica", width/2,100);
  textSize(22);
  textAlign(CENTER);
  text("Para reproducir la música pulse la tecla C", width/2, 290);
  textAlign(CENTER);
  text("*Tecla +: Incrementa el volumen\n*Tecla -: Disminuye el volumen\n*Tecla C: Mirar los controles", width/2, 330);
  textSize(14);
  text("© Eduardo Maldonado Fernández",width-350,height-10);

}
