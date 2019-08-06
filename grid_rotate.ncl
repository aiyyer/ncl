load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
;--------------------------------------------------------------
;--------------------------------------------------------------
; grid Rotation for 1D
;--------------------------------------------------------------
;--------------------------------------------------------------
;--------------------------------------------------------------
;--------------------------------------------------------------

undef ("grid_rotate_1d")
function grid_rotate_1d(vArray,cen_lon,tc_lon)
local vArrayS2,dims,nx,lon,dlon
;
begin
  dims = dimsizes(vArray)
  nx = dims(0)
  lon = vArray&lon
  dlon = ( lon(nx-1) - lon(0) ) / (nx - 1)
;
; rotate the grids
;
;
  ishift =  floattoint( (cen_lon - tc_lon)/dlon )
; 
  vArrayS2 = (/vArray/)
;
;
  if ( ishift .gt. 0 ) then
    vArrayS2(ishift:nx-1)   = (/vArray(0:nx-1-ishift)/)
    vArrayS2(0:ishift-1)    = (/vArray(nx-ishift:nx-1)/)
  end if
  if ( ishift .lt. 0 ) then
    vArrayS2(0:nx-1+ishift) = (/vArray(-ishift:nx-1)/)
    vArrayS2(nx+ishift:nx-1) = (/vArray(0:-ishift-1)/)
  end if
  
;  
  copy_VarMeta( vArray, vArrayS2)
  return(vArrayS2)
  delete(vArrayS2)
  
end

;--------------------------------------------------------------
;--------------------------------------------------------------
; grid Rotation for 1D with time as first dimension
;--------------------------------------------------------------
;--------------------------------------------------------------
;--------------------------------------------------------------
;--------------------------------------------------------------



undef ("grid_rotate_1d_t")
function grid_rotate_1d_t(vArray,cen_lon,tc_lon)
begin
  dims = dimsizes(vArray)
  nx = dims(1)
  lon = vArray&lon
  dlon = ( lon(nx-1) - lon(0) ) / (nx - 1)

; rotate the grids
;
  ishift =  floattoint( (cen_lon - tc_lon)/dlon )
; 
  vArrayS2 = (/vArray/)
;
  if ( ishift .gt. 0 ) then
    vArrayS2(:,ishift:nx-1)   = (/vArray(:,0:nx-1-ishift)/)
    vArrayS2(:,0:ishift-1)    = (/vArray(:,nx-ishift:nx-1)/)
  end if
  if ( ishift .lt. 0 ) then
    vArrayS2(:,0:nx-1+ishift) = (/vArray(:,-ishift:nx-1)/)
    vArrayS2(:,nx+ishift:nx-1) = (/vArray(:,0:-ishift-1)/)
  end if
  
;  
  copy_VarMeta( vArray, vArrayS2)
  return(vArrayS2)
  delete(vArrayS2)
  
end




;-----------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------
;--------------------------------------------------------------
; grid Rotation for 2D array 
;--------------------------------------------------------------
;-----------------------------------------------------------------------------------


undef ("grid_rotate_2d")
function grid_rotate_2d(vArray,cen_lat,cen_lon,tc_lat,tc_lon)
local vArrayS1,vArrayS2,ny,nx,lat,lon,dlon,dlat

begin
  dims = dimsizes(vArray)
  ny = dims(0)
  nx = dims(1)

  lat = vArray&lat
  lon = vArray&lon

  dlon = ( lon(nx-1) - lon(0) ) / (nx - 1)
  dlat = ( lat(ny-1) - lat(0) ) / (ny - 1)

;  print ( "dlat,dlon = " + dlat + " " + dlon )
;  print ( "tc lat lon = " +  tc_lat + " " + tc_lon )
  

;
; rotate the grids
;
;
  jshift =  floattoint( (cen_lat - tc_lat)/dlat )
  ishift =  floattoint( (cen_lon - tc_lon)/dlon )
; 

;  print ( (cen_lat-tc_lat) + " " + (cen_lon-tc_lon) )
;  print ( "j i shift = " + jshift + " " + ishift )

;
;
  vArrayS1 = (/vArray/)
  vArrayS2 = (/vArray/)
  
  vArrayS1@_FillValue = -999.0
  vArrayS1 = -999.0

;
;
  if ( jshift .ge. 0 ) then
    vArrayS1(jshift:ny-1,:)   = (/vArray(0:ny-1-jshift,:)/)
    vArrayS2 = vArrayS1
     if ( ishift .gt. 0 ) then
      vArrayS2(:,ishift:nx-1)   = (/vArrayS1(:,0:nx-1-ishift)/)
      vArrayS2(:,0:ishift-1)   = (/vArrayS1(:,nx-ishift:nx-1)/)
    end if
    if ( ishift .lt. 0 ) then
      vArrayS2(:,0:nx-1+ishift) = (/vArrayS1(:,-ishift:nx-1)/)
      vArrayS2(:,nx+ishift:nx-1) = (/vArrayS1(:,0:-ishift-1)/)
    end if
  end if
  if ( jshift .lt. 0 ) then
    vArrayS1(0:ny-1+jshift,:) = (/vArray(-jshift:ny-1,:)/)
    vArrayS2 = vArrayS1	
    if ( ishift .gt. 0 ) then
      vArrayS2(:,ishift:nx-1)   = (/vArrayS1(:,0:nx-1-ishift)/)
      vArrayS2(:,0:ishift-1)   = (/vArrayS1(:,nx-ishift:nx-1)/)
    end if
    if ( ishift .lt. 0 ) then
      vArrayS2(:,0:nx-1+ishift) = (/vArrayS1(:,-ishift:nx-1)/)
      vArrayS2(:,nx+ishift:nx-1) = (/vArrayS1(:,0:-ishift-1)/)
    end if
  end if
;  
  copy_VarMeta( vArray, vArrayS2)
  return(vArrayS2)
  delete(vArrayS1)
  delete(vArrayS2)

end

;-----------------------------------------------------------------------------------
;--------------------------------------------------------------
; grid Rotation for 3D array 
;--------------------------------------------------------------

undef ("grid_rotate_3d")
function grid_rotate_3d(vArray,cen_lat,cen_lon,tc_lat,tc_lon)
local vArrayS1,vArrayS2,dims,nt,ny,nx,lat,lon,dlon,dlat

begin
  dims = dimsizes(vArray)
  nt = dims(0)
  ny = dims(1)
  nx = dims(2)

  lat = vArray&lat
  lon = vArray&lon

  dlon = ( lon(nx-1) - lon(0) ) / (nx - 1)
  dlat = ( lat(ny-1) - lat(0) ) / (ny - 1)

;  print ( "dlat,dlon = " + dlat + " " + dlon )
;  print ( "tc lat lon = " +  tc_lat + " " + tc_lon )
  

;
; rotate the grids
;
;
  jshift =  floattoint( (cen_lat - tc_lat)/dlat )
  ishift =  floattoint( (cen_lon - tc_lon)/dlon )
; 

;  print ( (cen_lat-tc_lat) + " " + (cen_lon-tc_lon) )
;  print ( "j i shift = " + jshift + " " + ishift )

;
;
  vArrayS1 = (/vArray/)
  vArrayS2 = (/vArray/)

  vArrayS1@_FillValue = -999.0
  vArrayS1 = -999.0
  vArrayS2 = vArrayS1
;
;
;
  if ( jshift .ge. 0 ) then
    vArrayS1(:,jshift:ny-1,:)   = (/vArray(:,0:ny-1-jshift,:)/)
    vArrayS2 = vArrayS1
     if ( ishift .gt. 0 ) then
      vArrayS2(:,:,ishift:nx-1)   = (/vArrayS1(:,:,0:nx-1-ishift)/)
      vArrayS2(:,:,0:ishift-1)    = (/vArrayS1(:,:,nx-ishift:nx-1)/)
    end if
    if ( ishift .lt. 0 ) then
      vArrayS2(:,:,0:nx-1+ishift) = (/vArrayS1(:,:,-ishift:nx-1)/)
      vArrayS2(:,:,nx+ishift:nx-1) = (/vArrayS1(:,:,0:-ishift-1)/)
    end if
  end if
  if ( jshift .lt. 0 ) then
    vArrayS1(:,0:ny-1+jshift,:) = (/vArray(:,-jshift:ny-1,:)/)
    vArrayS2 = vArrayS1	
    if ( ishift .gt. 0 ) then
      vArrayS2(:,:,ishift:nx-1)   = (/vArrayS1(:,:,0:nx-1-ishift)/)
      vArrayS2(:,:,0:ishift-1)   = (/vArrayS1(:,:,nx-ishift:nx-1)/)
    end if
    if ( ishift .lt. 0 ) then
      vArrayS2(:,:,0:nx-1+ishift) = (/vArrayS1(:,:,-ishift:nx-1)/)
      vArrayS2(:,:,nx+ishift:nx-1) = (/vArrayS1(:,:,0:-ishift-1)/)
    end if
  end if
;

  copy_VarMeta( vArray, vArrayS2)
  return(vArrayS2)
  delete(vArrayS1)
  delete(vArrayS2)

end

;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------
; grid Rotation for 4D array nt,nz,ny,nx
;---------------------------------------------------------------------------------

undef ("grid_rotate_4d")
function grid_rotate_4d(vArray,cen_lat,cen_lon,tc_lat,tc_lon)
local vArrayS1,vArrayS2,dims,nt,nz,ny,nx,lat,lon,dlon,dlat

begin
  dims = dimsizes(vArray)
  nt = dims(0)
  nz = dims(1)
  ny = dims(2)
  nx = dims(3)

  lat = vArray&lat
  lon = vArray&lon

  dlon = ( lon(nx-1) - lon(0) ) / (nx - 1)
  dlat = ( lat(ny-1) - lat(0) ) / (ny - 1)

;  print ( "dlat,dlon = " + dlat + " " + dlon )
;  print ( "tc lat lon = " +  tc_lat + " " + tc_lon )
  

;
; rotate the grids
;
;
  jshift =  floattoint( (cen_lat - tc_lat)/dlat )
  ishift =  floattoint( (cen_lon - tc_lon)/dlon )
; 

;  print ( (cen_lat-tc_lat) + " " + (cen_lon-tc_lon) )
;  print ( "j i shift = " + jshift + " " + ishift )

;
;
  vArrayS1 = (/vArray/)
  vArrayS2 = (/vArray/)

  vArrayS1@_FillValue = -999.0
  vArrayS1 = -999.0
  vArrayS2 = vArrayS1
;
;
;
  if ( jshift .ge. 0 ) then
    vArrayS1(:,:,jshift:ny-1,:)   = (/vArray(:,:,0:ny-1-jshift,:)/)
    vArrayS2 = vArrayS1
     if ( ishift .gt. 0 ) then
      vArrayS2(:,:,:,ishift:nx-1)   = (/vArrayS1(:,:,:,0:nx-1-ishift)/)
      vArrayS2(:,:,:,0:ishift-1)    = (/vArrayS1(:,:,:,nx-ishift:nx-1)/)
    end if
    if ( ishift .lt. 0 ) then
      vArrayS2(:,:,:,0:nx-1+ishift)  = (/vArrayS1(:,:,:,-ishift:nx-1)/)
      vArrayS2(:,:,:,nx+ishift:nx-1) = (/vArrayS1(:,:,:,0:-ishift-1)/)
    end if
  end if
  if ( jshift .lt. 0 ) then
    vArrayS1(:,:,0:ny-1+jshift,:) = (/vArray(:,:,-jshift:ny-1,:)/)
    vArrayS2 = vArrayS1	
    if ( ishift .gt. 0 ) then
      vArrayS2(:,:,:,ishift:nx-1)   = (/vArrayS1(:,:,:,0:nx-1-ishift)/)
      vArrayS2(:,:,:,0:ishift-1)   =  (/vArrayS1(:,:,:,nx-ishift:nx-1)/)
    end if
    if ( ishift .lt. 0 ) then
      vArrayS2(:,:,:,0:nx-1+ishift) =  (/vArrayS1(:,:,:,-ishift:nx-1)/)
      vArrayS2(:,:,:,nx+ishift:nx-1) = (/vArrayS1(:,:,:,0:-ishift-1)/)
    end if
  end if
;

  copy_VarMeta( vArray, vArrayS2)
  delete(vArrayS1)
  return(vArrayS2)
  delete(vArrayS2)

end


