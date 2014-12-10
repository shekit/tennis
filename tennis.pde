import toxi.physics.*;
import toxi.physics.constraints.SphereConstraint;
import toxi.geom.*;
import toxi.physics.behaviors.*;
import geomerative.*;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

//Music Variables
Minim minim;
AudioPlayer backgroundAudio;
AudioPlayer wimbledon2013;
AudioPlayer wimbledon2012;
AudioPlayer wimbledon2011;
AudioPlayer wimbledon2010;

AudioPlayer us2013;
AudioPlayer us2012;
AudioPlayer us2011;
AudioPlayer us2010;

AudioPlayer aus2013;
AudioPlayer aus2012;
AudioPlayer aus2011;
AudioPlayer aus2010;

AudioPlayer french2013;
AudioPlayer french2012;
AudioPlayer french2011;

long backgroundAudioPosition;

ArrayList<AudioPlayer> tracks;
int fadeDuration = 500;
float minGain = -80;
float maxGain = -20;

//Physics Variables
VerletPhysics physics;
Vec3D worldCenter = new Vec3D(0, 0, 0);

//Spring Cluster
SpringCluster springCluster;
float springClusterDiameter = 100;
float springClusterStrength = 0.001;
float springClusterNumParticles = 30;

//Button Variables
color btnFill = color(0, 0, 0);
color btnStroke = color(255, 255, 255);
float[] btnDimensions = {
  120, 30
};
float[] resetBtnDimensions = {
  260, 30
};

//Button Enter
Button enterBtn;
float[] enterBtnCenter = new float[2];
color enterBtnHover = color(26, 165, 132);
String enterBtnText = "Click to Enter";

//Button Wimbledon
Button wimbledonBtn;
float[] wimbledonBtnCenter = {80, 360};
color wimbledonBtnHover = color(84, 0, 139);
String wimbledonBtnText = "Wimbledon";

//Button French
Button frenchBtn;
float[] frenchBtnCenter = {80, 410};
color frenchBtnHover = color(200, 90, 25);
String frenchBtnText = "French Open";

//Button French
Button usBtn;
float[] usBtnCenter = {80, 460};
color usBtnHover = color(229, 25, 55);
String usBtnText = "US Open";

//Button French
Button australianBtn;
float[] australianBtnCenter = {80, 510};
color australianBtnHover = color(0, 155, 222);
String australianBtnText = "Australian Open";

//Button 2013
Button _2013Btn;
float[] _2013BtnCenter = {220, 360};
color _2013BtnHover = color(167, 169, 171);
String _2013BtnText = "2013";

//Button 2012
Button _2012Btn;
float[] _2012BtnCenter = {220, 410};
color _2012BtnHover = color(167, 169, 171);
String _2012BtnText = "2012";

//Button 2011
Button _2011Btn;
float[] _2011BtnCenter = {220, 460};
color _2011BtnHover = color(167, 169, 171);
String _2011BtnText = "2011";

//Button 2010
Button _2010Btn;
float[] _2010BtnCenter = {220, 510};
color _2010BtnHover = color(167, 169, 171);
String _2010BtnText = "2010";

//Reset Button
Button resetBtn;
float[] resetBtnCenter = {150, 560};
color resetBtnHover = color(26, 165, 132);
String resetBtnText = "Reset";

//Background

Background background;
int backgroundNumParticles = 6000;

//Ball
Ball ball;
int ballNumParticles = 200;
int ballDiameter = 100;

//Moving Particles on Ball
MovingParticleSystem movingParticleSystem;

//Seam
SeamPath seam;
SeamParticleSystem seamParticleSystem;
int seamNumParticles = 100;

//Player Particles
PlayerParticleSystem playerParticleSystem;
int playerNumParticles = 3500;
int nameTargetParticles = 700; // use this number to find particles from system above that should go to form player name

//Grand Slam Particles
PlayerParticleSystem introParticleSystem;
int introNumParticles = 2000;

//Players
SvgImage federerPic;
SvgImage nadalPic;
SvgImage novakPic;
SvgImage murrayPic;
Vec3D yOffsetPic = new Vec3D(0, 0, 0);



PlayerImage federer;
PlayerImage nadal;
PlayerImage novak;
PlayerImage murray;

ArrayList<PlayerImage> playerImages;

//Players Name
SvgImage federerName;
SvgImage nadalName;
SvgImage novakName;
SvgImage murrayName;
SvgImage grandSlam;
Vec3D yOffsetName = new Vec3D(0, 200, 0);

ArrayList<SvgImage> playerNames;

//Booleans
boolean enter = false;
boolean enterAnimation = false;
boolean foundTarget = false;
boolean wimbledon = false;
boolean french = false;
boolean us = false;
boolean australian = false;
boolean _2013 = false;
boolean _2012 = false;
boolean _2011 = false;
boolean _2010 = false;
boolean reset = false;

boolean rotate = true;
boolean greenConnections = false;

//Other Variables
float introZ = 0;
float increment = 0;
float angle = 0;
int count = 0; // use to trigger first animation to ball
int displayEnterBtnCount = 0;
float theta = 0;

void setup() {
  size(displayWidth,displayHeight, P3D);

  physics = new VerletPhysics();



  RG.init(this);

  //start cluster
  springCluster = new SpringCluster(worldCenter, springClusterDiameter, springClusterStrength, springClusterNumParticles);

  //buttons
  enterBtnCenter[0] = width/2;
  enterBtnCenter[1] = height/2 + 150;
  enterBtn = new Button(enterBtnCenter, btnDimensions, btnFill, enterBtnHover, btnStroke, enterBtnText);
  wimbledonBtn = new Button(wimbledonBtnCenter, btnDimensions, btnFill, wimbledonBtnHover, btnStroke, wimbledonBtnText);
  frenchBtn = new Button(frenchBtnCenter, btnDimensions, btnFill, frenchBtnHover, btnStroke, frenchBtnText);
  usBtn = new Button(usBtnCenter, btnDimensions, btnFill, usBtnHover, btnStroke, usBtnText);
  australianBtn = new Button(australianBtnCenter, btnDimensions, btnFill, australianBtnHover, btnStroke, australianBtnText);
  _2013Btn = new Button(_2013BtnCenter, btnDimensions, btnFill, _2013BtnHover, btnStroke, _2013BtnText);
  _2012Btn = new Button(_2012BtnCenter, btnDimensions, btnFill, _2012BtnHover, btnStroke, _2012BtnText);
  _2011Btn = new Button(_2011BtnCenter, btnDimensions, btnFill, _2011BtnHover, btnStroke, _2011BtnText);
  _2010Btn = new Button(_2010BtnCenter, btnDimensions, btnFill, _2010BtnHover, btnStroke, _2010BtnText);
  resetBtn = new Button(resetBtnCenter, resetBtnDimensions, btnFill, resetBtnHover, btnStroke, resetBtnText);

  //background
  background = new Background(backgroundNumParticles);

  //ball
  ball = new Ball(ballNumParticles, ballDiameter);
  seam = new SeamPath();
  movingParticleSystem = new MovingParticleSystem(ballNumParticles);
  seamParticleSystem = new SeamParticleSystem(seamNumParticles);

  //player particle system
  playerParticleSystem = new PlayerParticleSystem(playerNumParticles);
  introParticleSystem = new PlayerParticleSystem(introNumParticles);

  //Svg Images
  float scale = 0.4;
  int sampleRatePic = 5;
  int sampleRateName = 1;
  federerPic = new SvgImage("star.svg", scale, yOffsetPic, sampleRatePic);
  nadalPic = new SvgImage("rect.svg", scale, yOffsetPic, sampleRatePic);
  novakPic = new SvgImage("circle.svg", scale, yOffsetPic, sampleRatePic);
  murrayPic = new SvgImage("circle.svg", scale, yOffsetPic, sampleRatePic);
  
  playerImages = new ArrayList<PlayerImage>();
  federer = new PlayerImage("federer.png");
  playerImages.add(federer);
  nadal = new PlayerImage("nadal.png");
  playerImages.add(nadal);
  novak = new PlayerImage("novak.png");
  playerImages.add(novak);
  murray = new PlayerImage("murray.png");
  playerImages.add(murray);

  //Svg Images names
  playerNames = new ArrayList<SvgImage>();
  federerName = new SvgImage("federer_name.svg", scale, yOffsetName, sampleRateName);
  playerNames.add(federerName);
  nadalName = new SvgImage("nadal_name.svg", scale, yOffsetName, sampleRateName);
  playerNames.add(nadalName);
  novakName = new SvgImage("novak_name.svg", scale, yOffsetName, sampleRateName);
  playerNames.add(novakName);
  murrayName = new SvgImage("murray_name.svg", scale, yOffsetName, sampleRateName);
  playerNames.add(murrayName);
  grandSlam = new SvgImage("grand_slam.svg", 0.6, new Vec3D(0, -200, 0), sampleRateName);

  introParticleSystem.setTarget(grandSlam.targets);
  playerParticleSystem.setTarget(background.targets);

  minim = new Minim(this);
  tracks = new ArrayList<AudioPlayer>();

  backgroundAudio = minim.loadFile("tennis_bg.mp3", 1024);
  backgroundAudio.loop();
  backgroundAudio.setGain(maxGain);
  tracks.add(backgroundAudio);

  wimbledon2013 = minim.loadFile("wimbledon2013.mp3", 1024);
  wimbledon2013.setGain(maxGain);
  tracks.add(wimbledon2013);

  wimbledon2012 = minim.loadFile("wimbledon2012.mp3", 1024);
  wimbledon2012.setGain(maxGain);
  tracks.add(wimbledon2012);

  wimbledon2011 = minim.loadFile("wimbledon2011.mp3", 1024);
  wimbledon2011.setGain(maxGain);
  tracks.add(wimbledon2011);

  wimbledon2010 = minim.loadFile("wimbledon2010.mp3", 1024);
  wimbledon2010.setGain(maxGain);
  tracks.add(wimbledon2010);

  us2013 = minim.loadFile("us2013.mp3", 1024);
  us2013.setGain(minGain);
  tracks.add(us2013);

  us2012 = minim.loadFile("us2012.mp3", 1024);
  us2012.setGain(minGain);
  tracks.add(us2012);

  us2011 = minim.loadFile("us2011.mp3", 1024);
  us2011.setGain(minGain);
  tracks.add(us2011);

  us2010 = minim.loadFile("us2010.mp3", 1024);
  us2010.setGain(minGain);
  tracks.add(us2010);

  aus2013 = minim.loadFile("aus2013.mp3", 1024);
  aus2013.setGain(minGain);
  tracks.add(aus2013);

  aus2012 = minim.loadFile("aus2012.mp3", 1024);
  aus2012.setGain(minGain);
  tracks.add(aus2012);

  aus2011 = minim.loadFile("aus2011.mp3", 1024);
  aus2011.setGain(minGain);
  tracks.add(aus2011);

  aus2010 = minim.loadFile("aus2010.mp3", 1024);
  aus2010.setGain(minGain);
  tracks.add(aus2010);

  french2013 = minim.loadFile("french2013.mp3", 1024);
  french2013.setGain(minGain);
  tracks.add(french2013);

  french2012 = minim.loadFile("french2012.mp3", 1024);
  french2012.setGain(minGain);
  tracks.add(french2012);

  french2011 = minim.loadFile("french2011.mp3", 1024);
  french2011.setGain(minGain);
  tracks.add(french2011);
}

void draw() {
  background(0);
  //println(frameRate);
  physics.update();

  if (!enter) {

    if (enterAnimation) {
      introZ += increment;
      increment += 0.5;
      displayEnterBtnCount++;
      if (introZ > 675) {
        enter = true;
      }
    } 

    pushMatrix();
    translate(width/2, height/2, introZ);
    pushMatrix();
    rotateY(angle);
    rotateZ(angle/.8);
    springCluster.display();
    popMatrix();

    // for(int i= 0; i< springCluster.particles.size(); i++){
    //     float f = lerp(groove.left.level()*1, groove.left.level()*80, 0.8);
    //     springCluster.particles.get(i).addForce(new Vec3D(0,0,f));          
    // }
    introParticleSystem.display();

    introParticleSystem.arrive();
    for (int i= 0; i< introParticleSystem.particles.size (); i++) {
      if (i%10==0) {

        introParticleSystem.particles.get(i).strokeWeightVar = lerp(backgroundAudio.left.level()*1, backgroundAudio.left.level()*80, 0.8);
        //introParticleSystem.particles.get(i).z = lerp(backgroundAudio.left.level()*1, backgroundAudio.left.level()*30, 0.8);
      }
    }
    popMatrix();

    if (displayEnterBtnCount < 30) {
      enterBtn.display();
    }
    angle += 0.02;
  } else {

    count++;
    // if(count == 1){   
    //    playerParticleSystem.setTarget(background.targets);
    //    foundTarget = true;
    // } else if(count == 2){
    //    foundTarget = false; 
    // }
    
    if (count == 120 && foundTarget == false) {  //trigger animation to ball after 120 frames
      greenConnections = true;
      foundTarget = true;
      movingParticleSystem.setTarget(ball.targets); 
      ball.applyForce(new Vec3D(0, 0, 3));
    }

    pushMatrix();
    translate(width/2+100, height/2, 0);
    if (rotate) {
      rotateY(angle);
      angle+=0.008;
      seamParticleSystem.appear();
    } else {
      rotateY(angle);
      angle-=0.05;
      angle = constrain(angle, 0, 360);
      seamParticleSystem.disappear();
    }
    ball.applyConstraint();
    //ball.display();
    //seam.display();
    movingParticleSystem.display();


    seamParticleSystem.follow();
    seamParticleSystem.run();

    if (foundTarget) {
      movingParticleSystem.arrive();
    }

    popMatrix();

    pushMatrix();
    translate(width/2+100, height/2, 0);
    playerParticleSystem.display();

    if (foundTarget) {
      for(PlayerImage i : playerImages){
        i.oscillate();
      }
      
      for(SvgImage i : playerNames){
        i.oscillate();
      }
      
      federerName.oscillate();
      playerParticleSystem.arrive();
    }
    
    
    for (int i= 0; i< movingParticleSystem.particles.size (); i++) {
      if (i%10==0) {
        movingParticleSystem.particles.get(i).strokeWeightVar = lerp(backgroundAudio.left.level()*1, backgroundAudio.left.level()*30, 0.9);
      }
    }
    for (int i= 0; i< playerParticleSystem.particles.size (); i++) {
      if (i%5==0) {
        playerParticleSystem.particles.get(i).strokeWeightVar = lerp(backgroundAudio.left.level()*1, backgroundAudio.left.level()*80, 0.8);
      }
    }


    //pause audio tracks if their gain is minumum
    // for (AudioPlayer a : tracks) {
    //   if (a.getGain() == minGain && a.isPlaying()) {
    //     a.pause();
    //     println("PAUSED");
    //   }
    // }

    //calling this manually to loop when it reaches the end. If you call loop elsewhere it starts track from beginning instead of last known position which is the behaviour when you call play
    if (backgroundAudio.position() == 118099) {
      backgroundAudio.loop(); 
    }

    popMatrix();

    //display buttons
    checkButtonStates();

    if (mousePressed) {
      movingParticleSystem.applyForce(new Vec3D(0, 0.7, 0)); 
      seamParticleSystem.applyForce(new Vec3D(0, 0.7, 0));
    }
    
    //to oscillate the player pics
    theta+=0.1;
    
  }

}

void mousePressed() {

  if (enterBtn.clicked() && !enter) {
    enterAnimation = true;
    angle = 0;
  }

  if (wimbledonBtn.clicked() && enter) {
    wimbledon = true;
    french = false;
    us = false;
    australian = false;
    setYearButtonColor(wimbledonBtnHover);
  }

  if (frenchBtn.clicked() && enter) {
    wimbledon = false;
    french = true;
    us = false;
    australian = false;
    setYearButtonColor(frenchBtnHover);
  }

  if (usBtn.clicked() && enter) {
    wimbledon = false;
    french = false;
    us = true;
    australian = false;
    setYearButtonColor(usBtnHover);
  }

  if (australianBtn.clicked() && enter) {
    wimbledon = false;
    french = false;
    us = false;
    australian = true;
    setYearButtonColor(australianBtnHover);
  }

  if (_2013Btn.clicked() && enter) {
    _2013 = true;
    _2012 = false;
    _2011 = false;
    _2010 = false;
  }

  if (_2012Btn.clicked() && enter) {
    _2013 = false;
    _2012 = true;
    _2011 = false;
    _2010 = false;
  }

  if (_2011Btn.clicked() && enter) {
    _2013 = false;
    _2012 = false;
    _2011 = true;
    _2010 = false;
  }

  if (_2010Btn.clicked() && enter) {
    _2013 = false;
    _2012 = false;
    _2011 = false;
    _2010 = true;
  }

  if (resetBtn.clicked() && enter) {
    foundTarget = true;
    movingParticleSystem.setTarget(ball.targets);
    playerParticleSystem.setTarget(background.targets);
    rotate = true;
    wimbledon = false;
    us = false;
    french = false;
    australian = false;
    _2013 = false;
    _2012 = false;
    _2011 = false;
    _2010 = false;
    ball.applyForce(new Vec3D(0, 0, 3));
    greenConnections = true;
    //play background music
    if (!backgroundAudio.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          //a.shiftGain(maxGain, minGain, 1000);
          a.pause();
        }
      }
      backgroundAudio.play();
      backgroundAudio.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if ((wimbledon && _2013) || (us && _2012)) {
    foundTarget = true;
    playerParticleSystem.setTwoTargets(murray.targets, murrayName.targets);
    movingParticleSystem.setTarget(murrayName.targets);
    rotate = false;
    greenConnections = false;
  }

  if ((wimbledon && _2012) || (australian && _2010)) {
    foundTarget = true;
    playerParticleSystem.setTwoTargets(federer.targets, federerName.targets);
    movingParticleSystem.setTarget(federerName.targets);
    rotate = false;
    greenConnections = false;
  }

  if ((us && _2013) || (french && _2013) || (french && _2012) || (french && _2011) || (us && _2010) || (wimbledon && _2010) || (french && _2010)) {
    foundTarget = true;
    playerParticleSystem.setTwoTargets(nadal.targets, nadalName.targets);
    movingParticleSystem.setTarget(nadalName.targets);
    rotate = false;
    greenConnections = false;
  }

  if ((australian && _2013) || (australian && _2012) || (us && _2011) || (wimbledon && _2011) || (australian && _2011)) {
    foundTarget = true;
    playerParticleSystem.setTwoTargets(novak.targets, novakName.targets);
    movingParticleSystem.setTarget(novakName.targets);
    rotate = false;
    greenConnections = false;
  }

  //setting audio for wimbledon
  if (wimbledon && _2013) {
    if (!wimbledon2013.isPlaying()) {      
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      wimbledon2013.rewind();
      wimbledon2013.play(); 
      wimbledon2013.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if (wimbledon && _2012) {
    if (!wimbledon2012.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      wimbledon2012.rewind();
      wimbledon2012.play(); 
      wimbledon2012.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if (wimbledon && _2011) {
    if (!wimbledon2011.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      wimbledon2011.rewind();
      wimbledon2011.play(); 
      wimbledon2011.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if (wimbledon && _2010) {
    if (!wimbledon2010.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
         // a.shiftGain(maxGain, minGain, 1000);
        }
      }
      wimbledon2010.rewind();
      wimbledon2010.play(); 
      wimbledon2010.shiftGain(minGain, maxGain, 1000);
    }
  }

  //setting audio for australian
  if (australian && _2013) {
    if (!aus2013.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      aus2013.rewind();
      aus2013.play(); 
      aus2013.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if (australian && _2012) {
    if (!aus2012.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      aus2012.rewind();
      aus2012.play(); 
      aus2012.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if (australian && _2011) {
    if (!aus2011.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      aus2011.rewind();
      aus2011.play(); 
      aus2011.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if (australian && _2010) {
    if (!aus2010.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, 1000);
        }
      }
      aus2010.rewind();
      aus2010.play(); 
      aus2010.shiftGain(minGain, maxGain, 1000);
    }
  }

  //setting audio for US
  if (us && _2013) {
    if (!us2013.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      us2013.rewind();
      us2013.play(); 
      us2013.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if (us && _2012) {
    if (!us2012.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      us2012.rewind();
      us2012.play(); 
      us2012.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if (us && _2011) {
    if (!us2011.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      us2011.rewind();
      us2011.play(); 
      us2011.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if (us && _2010) {
    if (!us2010.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, 1000);
        }
      }
      us2010.rewind();
      us2010.play(); 
      us2010.shiftGain(minGain, maxGain, 1000);
    }
  }

  //setting audio for French
  if (french && _2013) {
    if (!french2013.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      french2013.rewind();
      french2013.play(); 
      french2013.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if (french && _2012) {
    if (!french2012.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
         // a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      french2012.rewind();
      french2012.play(); 
      french2012.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if (french && _2011) {
    if (!french2011.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      french2011.rewind();
      french2011.play(); 
      french2011.shiftGain(minGain, maxGain, fadeDuration);
    }
  }

  if (french && _2010) {
    if (!french2011.isPlaying()) {
      for (AudioPlayer a : tracks) {
        if (a.isPlaying()) {
          a.pause();
          //a.shiftGain(maxGain, minGain, fadeDuration);
        }
      }
      french2011.rewind();
      french2011.play(); 
      french2011.shiftGain(minGain, maxGain, fadeDuration);
    }
  }
}

void keyPressed() {

  if (key == ' ') {
    foundTarget = true;
    movingParticleSystem.setTarget(ball.targets);
    playerParticleSystem.setTarget(background.targets);
    rotate = true;
    wimbledon = false;
    us = false;
    french = false;
    australian = false;
    _2013 = false;
    _2012 = false;
    _2011 = false;
    _2010 = false;
    ball.applyForce(new Vec3D(0, 0, 3));
    greenConnections = true;
  }

  //failsafe to start bg audio if it doesnt work
  if (key == 'p') {
    backgroundAudio.loop();
  }
}  

void checkButtonStates() {
  if (wimbledon) {
    wimbledonBtn.displaySelected();
  } else {
    wimbledonBtn.display();
  }

  if (french) {
    frenchBtn.displaySelected();
  } else {
    frenchBtn.display();
  }

  if (us) {
    usBtn.displaySelected();
  } else {
    usBtn.display();
  }

  if (australian) {
    australianBtn.displaySelected();
  } else {
    australianBtn.display();
  }

  if (_2013) {
    _2013Btn.displaySelected();
  } else {
    _2013Btn.display();
  }

  if (_2012) {
    _2012Btn.displaySelected();
  } else {
    _2012Btn.display();
  }

  if (_2011) {
    _2011Btn.displaySelected();
  } else {
    _2011Btn.display();
  }

  if (_2010) {
    _2010Btn.displaySelected();
  } else {
    _2010Btn.display();
  }

  if (reset) {
    resetBtn.displaySelected();
  } else {
    resetBtn.display();
  }
}

void setYearButtonColor(color c) {
  _2013Btn.setColor(c);
  _2012Btn.setColor(c);
  _2011Btn.setColor(c);
  _2010Btn.setColor(c);
}
