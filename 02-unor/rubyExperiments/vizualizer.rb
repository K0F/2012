################################
### VIZUALIZER BETA KOF 2012 ###
################################

full_screen


def setup
  size 1280,720,P2D

  header = "\n##################################\n# THIS IS VIZUALIZER BETA BY KOF #\n##################################\n\n"
  puts header

  textFont(createFont("Semplice Regular",8,false))
  textMode SCREEN


  frameRate 50
  noCursor

  noSmooth

  @move = -2

  @filename = ARGF.filename


  loadit = Thread.new do


    @raw = loadBytes @filename

    @siz = (@raw.length)


    @graf = createGraphics(width,(@siz/width).to_i,P2D)


    p "it has: "+@raw.size.to_s+" kb\nrendering ...\n\n"

    c = 0


    @graf.beginDraw

    (0..@graf.height).each do |y|
      (0..@graf.width).each do |x|

        @ready = y > height ? true : false

        @graf.set x,y,(@raw[c % @raw.size].to_i) * 10000000 * (-1)
        c += 1
      end
    end

    @done = true

    @graf.endDraw

  end

  @shift = 0

  p "using file: "+@filename

end



def draw
  background 0

  if(@graf != NIL)
    image @graf,0,@shift
  end

  @shift += @ready ? @move : 0


  anim = [".","..","...","....",".....",".......","......."]

  textAlign RIGHT
  fill 255
  text(" #{anim[@shift%anim.size]}"+(@siz).to_s+" kb <==  "+@filename.split("/").at(-1),width-20,20);



end

def keyPressed

  if(keyCode == DOWN)
    @move -= 1
  elsif(keyCode == UP)
    @move += 1
  end

end

