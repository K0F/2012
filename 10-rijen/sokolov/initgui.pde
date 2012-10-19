void initGUI() {


  cp5 = new ControlP5(this);


  controlWindow = cp5.addControlWindow("vizKontrol", 1024, 0, 500, 400)
    .hideCoordinates()
      .setBackground(color(15))
        ;

  int x = ctlskip*2;

  // create a toggle
  cp5.addToggle("on1")
    .setPosition(x, ctlskip*2)
      .setSize(20, 20)
        .moveTo(controlWindow)
          ;
  x+=30;

  // create a toggle
  cp5.addToggle("on2")
    .setPosition(x, ctlskip*2)
      .setSize(20, 20)
        .moveTo(controlWindow)
          ;
  x+=30;

  // create a toggle
  cp5.addToggle("on3")
    .setPosition(x, ctlskip*2)
      .setSize(20, 20)
        .moveTo(controlWindow)
          ;
  x+=30;

  // create a toggle
  cp5.addToggle("on4")
    .setPosition(x, ctlskip*2)
      .setSize(20, 20)
        .moveTo(controlWindow)
          ;
  x+=30;

  // create a toggle
  cp5.addToggle("on5")
    .setPosition(x, ctlskip*2)
      .setSize(20, 20)
        .moveTo(controlWindow)
          ;
  x+=30;

  // create a toggle
  cp5.addToggle("on6")
    .setPosition(x, ctlskip*2)
      .setSize(20, 20)
        .moveTo(controlWindow)
          ;
  x+=30;

  // create a toggle
  cp5.addToggle("on7")
    .setPosition(x, ctlskip*2)
      .setSize(20, 20)
        .moveTo(controlWindow)
          ;
  x+=30;
  
  
  int y = ctlskip*6;

  cp5.addSlider("fade")
    .setRange(0, 255)
      .setPosition(40, y)
        .setSize(200, 10)
          .moveTo(controlWindow)
            ;
  y+=ctlskip;
  




  //  controlWindow.setUndecorated(true);

  one = controlWindow.addTab("one");
  two = controlWindow.addTab("two");
  three = controlWindow.addTab("three");
  four = controlWindow.addTab("four");
  five = controlWindow.addTab("five");
  six = controlWindow.addTab("six");
 seven = controlWindow.addTab("seven");



  oneGUI();
  twoGUI();
  threeGUI();
  fourGUI();

  sixGUI();
  sevenGUI();


  guidone = true;
}

