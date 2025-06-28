pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
charcount = 13
charmin = 16
charmax = 255
charwidth = 8
charheight = 6
blinktimer = 0
blink = false
rows = flr(charmax/charcount)
curx = 0
cury = 1
bgcol= 3
textcol=7
bits = 0
inputtimer=0
inputrepeat=6
hold=0
copytimer=0
copyduration=30
function _draw()
  cls()
  local y = 0
  for i=charmin,255,charcount do
    local row=flr(i/charcount)
    local offnum = i
    local offcol = 0
    if(cury==row) then
      offnum = i + curx
      offcol = bgcol
    end
    local offset=(sub(tostr(offnum,3),5,6))
    local x=0
   
    print(chr(2) .. offcol..offset..":",x,y,textcol) 
    x = x + 20
    for c=0,charcount-1 do
      if(i+c > 255) then break end
      local bg = chr(2) .. "0"
      if(cury==row and curx==c) then
        if(blink) then
          bg = chr(2) .. bgcol
        end
      end
      print(bg .. chr(i+c),x,y,textcol)
      x = x + charwidth
    end
    y = y + charheight
  end
  y = y + charheight + 2
  local copytext = "copy"
  if(copytimer > 0) then copytext = "copied" end
  print("🅾️",0,y,14)
  print(":".. copytext,8,y,textcol)
  print("❎", 38,y,12)
  print(":exit",46,y,textcol)
  print("⬆️⬇️⬅️➡️",76,y,13)
  print(":move",108,y,textcol)
end

function _update()
  blink = blinktimer%30<15 and true or false
  bits = btn()
  local buffer = inputbuffer
  if(bits > 0) then hold = hold + 1
  else hold = 0
  end
  local allowinput = false
  if(inputtimer == 0 or hold >= 15) then allowinput = true end
  if(bits > 0 and allowinput) then
    blinktimer = 0
    inputtimer = inputtimer + 1
    curx=curx-getbit(bits,0)
    curx=curx+getbit(bits,1)
    cury=cury-getbit(bits,2)
    cury=cury+getbit(bits,3)
    if(getbit(bits,5)>0) then 
      cls()
      stop()
    end
    if(getbit(bits,4)>0) then
      local offnum = ((cury-1) * charcount) + curx + charmin
      printh("ox" .. sub(tostr(offnum,3),5,6), "@clip")
      copytimer = 1
    end
    bits = 0
  end
  curx = curx < 0 and 0 or curx
  cury = cury < 1 and 1 or cury
  curx = curx > charcount and charcount or curx
  cury = cury > rows and rows or cury
  blinktimer = (blinktimer + 1) % 30
  if(inputtimer >= 1) then inputtimer = (inputtimer + 1) % inputrepeat end
  if(copytimer >= 1) then copytimer = (copytimer + 1) % copyduration end
end

function getbit(bits,bit)
  return (bits&1<<bit)/1>>bit
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

