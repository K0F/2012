

def setup
  size 720,720,P2D
  imageMode CENTER
  @@prazdny = load_image "prazdny.png"
  @@plny = load_image "plny.png"


  @@rot = [1,2,4]
  @@theta = []
  moznosti = [0,90,180,270]
  (0..3000).each do
    @@theta << moznosti[random(4).to_i]
  end

end

def draw
  background 0


  r = @@plny.width
  idx = 0

  (0..(height/@@plny.height)).each do |y|
    (0..(width/@@plny.width)).each do |x|
      push_matrix
        translate x*r+@@plny.width/2,y*r+@@plny.height/2
        rotate(radians(@@theta[idx]))
        @@theta[idx] += degrees(atan2(cos(frameCount/30.0+mouseY-y*r),sin(frameCount/39+mouseX-x*r)))#@@rot[(idx+x+y)%@@rot.size]
        idx += 1

        image @@plny,0,0
        #image idx%((frameCount/2)%1000+1)==0?@@plny:@@prazdny,0,0
      pop_matrix
    end
  end
end


