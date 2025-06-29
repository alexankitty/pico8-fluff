pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
x=0
y=0
ilut = {
  0,  --0000
  -1, --0001
  1,  --0010
  0   --0011
}

function _update()
  local b=btn()
  x+=ilut[(b&3)+1]
  y+=ilut[(b>>2&3)+1]
end

function _draw()
  cls()
  rectfill(x,y,x+1,y+1)
end
