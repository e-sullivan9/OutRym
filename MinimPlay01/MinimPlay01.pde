import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer song;
FFT         fft;
BeatDetect beat;
BeatListener bl;

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
  size(1024, 300, P3D);
  frameRate(30);
  minim = new Minim(this);
  
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
  fill(0,75);
  rect(0,0,width,height);
  fill(255);
  stroke(255);
  int C0 = fft.freqToIndex(16.35);
  int C1 = fft.freqToIndex(32.7);
  int C2 = fft.freqToIndex(65.41);
  int C4 = fft.freqToIndex(261.6);
  int C5 = fft.freqToIndex(523.25);
  int C6 = fft.freqToIndex(1046.50);
  int C7 = fft.freqToIndex(2093.00);
  int C8 = fft.freqToIndex(4186.01);
  int max = fft.freqToIndex(18000.0);
  
  fft.forward( song.mix );
  for(int i = 0; i < fft.specSize(); i++)
  {
    if(i == C0 || i == C1 || i == C2 || i == C4 || i == C5 || i == C6 || i == C7)
    {
      stroke(125,0,0);
    }
    else if(max == i)
    {
      stroke(0,125,0);
    }
    else
    {
      stroke(255);
    }
    line( i*3+10, height/2+fft.getBand(i)*2, i*3+15, height/2 - fft.getBand(i)*2 );
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
  
}
