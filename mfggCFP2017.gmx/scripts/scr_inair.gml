var c_solid = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,obj_solid,0,1);
 
var cjt = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,obj_jumpthrough,0,1);
var cjt_top = 0;
 
if cjt
&& bbox_bottom <= cjt.bbox_top
cjt_top = 1;
 
//-----
if c_vspeed >= 0
 {
 if (c_solid && c_solid.can_col == 1)
 or cjt_top
 or collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,par_slope,true,true)
 return 0;
  
 else
 return 1;
 }
  
else
return 1;
