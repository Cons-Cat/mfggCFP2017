var col_phase = 0;

repeat(2)
 {
 var currentsolid_up = collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top-1,obj_solid,false,true);
 var currentsolid_down = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,obj_solid,false,true);
 var currentsolid_left = collision_rectangle(bbox_left-1,bbox_top,bbox_left-1,bbox_bottom,obj_solid,false,true);
 var currentsolid_right = collision_rectangle(bbox_right+1,bbox_top,bbox_right+1,bbox_bottom,obj_solid,false,true);
 var current_jt = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,obj_jumpthrough,false,true);

 var currentslope_up = collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top-1,par_slope,true,true);
 var currentslope_down = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,par_slope,true,true);
 var currentslope_down2 = collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,par_slope,true,true);
 var currentslope_left = collision_rectangle(bbox_left-1,bbox_top,bbox_left-1,bbox_bottom-1,par_slope,true,true);
 var currentslope_right = collision_rectangle(bbox_right+1,bbox_top,bbox_right+1,bbox_bottom-2,par_slope,true,true);

 if col_phase == 1
  {
  //---Solids---
  if currentsolid_up
  && currentsolid_up.can_col == 1
   {
   if add_y <= 0
   add_y = 0;
   if c_vspeed <= 0
   c_vspeed = 0
   
   if collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_top,currentsolid_up,false,true)
   y += 1;
   }
   
  if currentsolid_down
  && currentsolid_down.can_col == 1
   {
   if add_y >= 0
   add_y = 0;
   if c_vspeed >= 0
   c_vspeed = 0
   
   if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,currentsolid_down,false,true)
   y -= 1;
   }
   
  if currentsolid_left
  && currentsolid_left.can_col == 1
   {
   if add_x <= 0
   add_x = 0;
   if c_hspeed <= 0
   c_hspeed = 0
   
   if collision_rectangle(bbox_left,bbox_top,bbox_left,bbox_bottom,currentsolid_left,false,true)
   x += 1;
   }
   
  if currentsolid_right
  && currentsolid_right.can_col == 1
   {
   if add_x >= 0
   add_x = 0;
   if c_hspeed >= 0
   c_hspeed = 0
   
   if collision_rectangle(bbox_right,bbox_top,bbox_right,bbox_bottom,currentsolid_right,false,true)
   x -= 1;
   }
   
  if current_jt
  && bbox_bottom < current_jt.bbox_top+1
   {
   if add_y >= 0
   add_y = 0;
   if c_vspeed >= 0
   c_vspeed = 0
   
   if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,current_jt,false,true)
   y -= 1;
   }
  }
 
 if col_phase == 0
  {
  //Slopes
  if currentslope_down
   {
   if add_y >= 0
   add_y = 0;
   if c_vspeed >= 0
   c_vspeed = 0
   }
   
  if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,currentslope_down2,false,true)
  y -= 1;
 
  if collision_rectangle(bbox_left,bbox_bottom+2,bbox_right,bbox_bottom+2,par_slope,0,1)
  && not currentslope_down
  && c_vspeed >= 0
  y += 1;
 
  col_phase = 1;
  }
 }

