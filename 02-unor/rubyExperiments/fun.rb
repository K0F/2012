##########################
# RUBY RAKY PIC HO TAKY  #
##########################

#load_libraries :opengl
#include_package "processing.opengl"

full_screen


@@width = 1280
@@height = 720
@@render = P2D

@@position = 0

def setup 
  #hack to loose focus
  frame.setFocusableWindowState(false)
  #frame.setAlwaysOnTop(false)
  #frame.setLocation(0,0);



  size @@width,@@height,@@render


  @@li = (height - 10) / 10
  smooth

  textFont createFont("Times",8,false)
  textMode SCREEN

  @@t = T.new

  @@raw = `tree -f -u -g -s /sketchBook`.split("\n")
  #p @@raw
end

def draw
  background 0 
  frameRate 30

  noStroke

  @@t.draw

  @@position += 10
  fill 255

  (1+@@position..@@li+@@position).each do |i|
    textAlign LEFT
    text @@raw[i].to_s,0,i*10-@@position*10
  end

  fill 255,127,0
  ln = @@raw[@@position+@@li].split(" ").at(-1)
  text ln,720,10

  if(ln.reverse[0..3].eql? (".pde".reverse))
    p "bang"
    text `cat #{ln} | head -n #{@@li}`,720,30
  end

end


class T
  @x
  @y
  @trail

  attr_accessor :x,:y,:z

  def initialize
    @x = width/2
    @y = height/2
    @trail = []
  end

  def draw
    rectMode CENTER
    #rect @x,@y,10,10


    @x =noise(frameCount/30.0)*width 
    @y = noise(frameCount/60.0)*height



    @trail << (PVector.new(@x,@y))

    i=0
    @last = @trail.at(0)
    @trail.each do |pos1| 
      d = 40 #dist pos1.x,pos1.y,pos2.x,pos2.y * 1.2
      noFill
      stroke 127,255,0,20
      i+=1.0
      ellipse noise((frameCount-i)/(30.0+i/100.0))*width,
        noise((frameCount-i)/(60.0+i/200.0))*height,d,d
    end

    if(@trail.size>300)
      @trail.delete_at(-1)
    end
  end

end
