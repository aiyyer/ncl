undef ("codeTime")
function codeTime(iy,im,id,ih)
local month,day,hh,time

begin
  
  month = im + ""
  day   = id + ""
  hh    = ih + ""
  if (im .lt. 10 ) then
    month = "0"+im
  end if
  if (id .lt. 10 ) then
    day = "0"+id
  end if
  if (ih .lt. 10 ) then
    hh = "0"+ih
  end if
  time  = iy+""+month+""+day+""+hh
  return (time)

end

;---------------------------------------------------------------

undef ("codeTimeNoYear")
function codeTimeNoYear(im,id,ih)
local month,day,hh,time

begin
  
  month = im + ""
  day   = id + ""
  hh    = ih + ""
  if (im .lt. 10 ) then
    month = "0"+im
  end if
  if (id .lt. 10 ) then
    day = "0"+id
  end if
  if (ih .lt. 10 ) then
    hh = "0"+ih
  end if
  time  = month+""+day+""+hh
  return (time)

end

