import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer song;
FFT         fft;
BeatDetect beat;
BeatListener bl;
boolean reverse;

float kickSize, snareSize, hatSize;

class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;
  
  BeatListener(BeatDetect beat, AudioPlayer source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }
  
  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }
  
  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}

void setup()
{
  size(1024, 450, P3D);
  frameRate(30);
  minim = new Minim(this);
  reverse = false;
  song = minim.loadFile("in.mp3", 2048);
  
  song.loop();
  
  fft = new FFT( song.bufferSize(), song.sampleRate() );
  
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  beat.setSensitivity(50);  
  
  kickSize = snareSize = hatSize = 16;
  bl = new BeatListener(beat, song);  
  textFont(createFont("Helvetica", 16));
  textAlign(CENTER);
  
}

void draw()
{
  fill(0);
  rect(0,0,width,height);
  fill(255);
  stroke(255);
  
  if(!reverse)
  {
    fft.forward( song.mix );
  
    int stop = fft.freqToIndex(10000);
    for(int i = 0; i <= stop; i++)
    {
      float x = map(i,0,stop,10,width-10);
      float yMod = map(fft.getBand(i),0,100,0,75);
      line( x, height/2+yMod, x+5, height/2 - yMod );
    }
    stroke(75);
    line(0,50,width,50);
    line(0,100,width,100);
    stroke(255);
    for(int i = 0; i < song.bufferSize() -1; i++)
    {
      float x = map(i,0,song.bufferSize()-1,10,width-10);
      if(song.left.get(i) == song.right.get(i))
      {
        stroke(15,125,15);
        line(x,50+song.left.get(i)*75, x, 100+song.right.get(i)*75);
        stroke(255);
      }
      line(x,50+song.left.get(i)*75, x+1, 50 + song.left.get(i+1)*75);
      line(x,100+song.right.get(i)*75,x+1,100+song.right.get(i+1)*75);
    
    }
    if ( beat.isKick() ) kickSize = 32;
    if ( beat.isSnare() ) snareSize = 32;
    if ( beat.isHat() ) hatSize = 32;
    textSize(kickSize);
    text("KICK", width/4, height-50);
    textSize(snareSize);
    text("SNARE", width/2, height-50);
    textSize(hatSize);
    text("HAT", 3*width/4, height-50);
    kickSize = constrain(kickSize * 0.95, 16, 32);
    snareSize = constrain(snareSize * 0.95, 16, 32);
    hatSize = constrain(hatSize * 0.95, 16, 32);
  }
  int seconds = song.length()/1000 % 60;
  int minutes = song.length()/1000 / 60;
  int cSeconds = song.position()/1000 % 60;
  int cMinutes = song.position()/1000 / 60;
  textSize(12);
  text(""+cMinutes+":"+cSeconds + " / "+minutes+":"+seconds,width/2,325);
  System.out.println(song.position());
  System.out.println("" + minutes + ":" + seconds);
  line(25,300,width-25,300);
  float pos = map(song.position(),0,song.length(),25,width-25);
  line(pos,290,pos,310);
  
}

void keyPressed()
{  
  if(key == '1')
  {
    song.pause();
    song = minim.loadFile("in.mp3", 2048);
    fft = new FFT( song.bufferSize(), song.sampleRate() );
  
    beat = new BeatDetect(song.bufferSize(), song.sampleRate());
    beat.setSensitivity(50); 
    bl = new BeatListener(beat, song);   
    song.loop();
  }
  
  if(key == '2')
  {
    song.pause();
    song = minim.loadFile("in2.mp3", 2048);
    fft = new FFT( song.bufferSize(), song.sampleRate() );
  
    beat = new BeatDetect(song.bufferSize(), song.sampleRate());
    beat.setSensitivity(50);  
    bl = new BeatListener(beat, song);  
    song.loop();
  }
    if(key == '3')
  {
    song.pause();
    song = minim.loadFile("in3.mp3", 2048);
    fft = new FFT( song.bufferSize(), song.sampleRate() );
  
    beat = new BeatDetect(song.bufferSize(), song.sampleRate());
    beat.setSensitivity(50);  
    bl = new BeatListener(beat, song);  
    song.loop();
  }
  if(keyCode == LEFT)
  {
  }
  if(keyCode == RIGHT)
  {
    song.skip(300);
  }  
  
}

void keyReleased()
{
  if(keyCode == LEFT)
  {
    song.skip(-2500);
  }
}

//  int C0 = fft.freqToIndex(16.35);
//  int C1 = fft.freqToIndex(32.7);
//  int C2 = fft.freqToIndex(65.41);
//  int C4 = fft.freqToIndex(261.6);
//  int C5 = fft.freqToIndex(523.25);
//  int C6 = fft.freqToIndex(1046.50);
//  int C7 = fft.freqToIndex(2093.00);
//  int C8 = fft.freqToIndex(4186.01);
//  int stop = fft.freqToIndex(10000);
//  int max = fft.freqToIndex(18000.0);
