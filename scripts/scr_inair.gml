var c_solid = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,obj_solid,0,0);
 
var cjt = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,obj_jumpthrough,0,0);

var c_slope = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+3,par_slope_top,1,0);

/*-------------------------------*/

//Solid check
if c_solid && c_solid.can_col
  return false
  
//Jumpthrough check
else if (cjt) && (add_y == 0) //else if ((cjt) || (c_slope)) && (add_y == 0)
  return false
  
//Slope check
else if (c_slope) && (add_y == 0)
  return false
  
//No collision
else
  return true

