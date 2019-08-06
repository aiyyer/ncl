;===============================================================
; collection of useful sub programs for string manipulations
;
; A. Aiyyer NCL Tropical Dynamics Group
;===============================================================
;
;
;
;---------------------------------------------------------------
;---------------------------------------------------------------


undef("ymdh_string")
function ymdh_string(y,m,d,h:numeric)
; this function converts y,m,d,h to YYYYMMDDHH

local retVal
begin
  
  retVal = sprinti("%0.4i", y) +  sprinti("%0.2i", m)+  sprinti("%0.2i", d) + sprinti("%0.2i", h)
  return( retVal )
  
end

;----------------------------------------------------------------------------------------------------


;
;---------------------------------------------------------------
;---------------------------------------------------------------


undef("mdh_string")
function mdh_string(m,d,h:numeric)
; this function converts m,d,h to YYYYMMDDHH

local retVal
begin
  
  retVal = sprinti("%0.2i", m)+  sprinti("%0.2i", d) + sprinti("%0.2i", h)
  return( retVal )
  
end

;----------------------------------------------------------------------------------------------------


undef("messg")
function messg(name:string)

local retVal
begin

  retVal = "hello " + name
  return(retVal)

end
  
  

undef("ymddate")
function ymddate(date:numeric, units:string)

; this function converts a integer date YYYYMMDD to a numeric data of specified units
; example 

local y,m,d,opt,retVal

begin
  y =  date/10000
  m = (date-y*10000)/100
  d = date - (y*10000 + m*100)
  opt = 0
  retVal = ut_inv_calendar (y,m,d,0,0,0,units,opt)
  retVal@units=units
  return( retVal )  
end

;---------------------------------------------------------------
;---------------------------------------------------------------

