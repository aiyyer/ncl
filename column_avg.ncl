;--------------------------------------------------------------------------------------
;;
;--------------------------------------------------------------------------------------
; NCSU Tropical Dynamics Group
; Aiyyer 04/2018
;--------------------------------------------------------------------------------------
; Updates: 04/27/2019 in the definition of delP [see below within the code]
;-------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------
;
undef("column_avg")
; does a column average of variables in pressure co-ods
; expects 3-D input data with level, lat, lon
; plevels must be in hPa
function column_avg(dat,plevels)
local DC, nz, delP,grav, dims

;---------------------------------------------------------------------------------------
begin



  ;printVarSummary(dat)
  ;print ("Under testing column avg")

  grav = 9.8
  if ( plevels@units .ne. "hPa" ) then
    print ("Check plevels. Should be in hPa")
    print ("Error in column_avg.ncl! Terminating")
    exit
  end if
  
  nz    = dimsizes(plevels)
  dims  =  dimsizes(dat)
  rank  =  dimsizes(dims)
  
  if ( rank .ne. 1 .and. rank .ne. 3 ) then
    print ("the input array must be 1-D or 3-D for now")
    print ("rank = " + rank)
    print ("Error in column_avg.ncl! Terminating")
    exit
  end if

  if ( nz .ne. dims(0) ) then
    print ("the input array must have first dimension as pressure level")
    print ("Error in column_avg.ncl! Terminating")
    exit
  end if
 
  if ( rank .eq. 1 ) then
    DC = dat(0)
    DC = 0.0
    nz = dimsizes(plevels)
    do k = 1,nz-1
      delP =abs(plevels(k-1) - plevels(k))*100.
      DC  =  DC + delP*.5*(dat(k-1)+dat(k))
    end do      
  end if

  if ( rank .eq. 3 ) then
    DC = dat(0,:,:)
    DC = 0.0
    nz = dimsizes(plevels)
    do k = 1,nz-1
      
; Aiyyer 04/27/19    
; Notes: abs of the delP used since erai data is
; arranged low to high P levels (top to bottom)
; In the context of the calculation, the abs(delP)
; is the correct way to define delP that can safegaurd
; against levels arranged top to bottom
      delP =abs(plevels(k-1) - plevels(k))*100.
      DC  =  DC + delP*.5*(dat(k-1,:,:)+dat(k,:,:))
    end do  
  end if
  
  DC  =    DC/grav
  return(DC)
  
end
