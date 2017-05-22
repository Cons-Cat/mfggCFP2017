var col_phase = 0;

if c_vspeed > 1{
    if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+8,obj_slopeR_1x,false,false)
    || collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+8,obj_slopeL_1x,false,false){
        slopeVOff = 1;
    }
    
    if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+8,obj_slopeR_2x,false,false)
    || collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+8,obj_slopeL_2x,false,false){
        slopeVOff = 1;
    }
    
    if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+8,obj_slopeL_05x,true,true){
        if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+8,obj_slopeL_05x,true,true).x+8 < self.x{
            slopeVOff = -8;
        } else {
            slopeVOff = 0;
        }
    }
    if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+8,obj_slopeR_05x,true,true){
        if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+8,obj_slopeR_05x,true,true).x+8 > self.x{
            slopeVOff = -8;
        } else {
            slopeVOff = 0;
        }
    }
} else {
    slopeVOff = 0;
}

repeat(2)
 {
 var currentsolid_up = collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top-1,obj_solid,false,true);
 var currentsolid_down = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,obj_solid,false,true);
 var currentsolid_left = collision_rectangle(bbox_left-1,bbox_top,bbox_left-1,bbox_bottom,obj_solid,false,true);
 var currentsolid_right = collision_rectangle(bbox_right+1,bbox_top,bbox_right+1,bbox_bottom,obj_solid,false,true);
 var current_jt = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,obj_jumpthrough,false,true);

 var currentslope_up = collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top-1,par_slope,true,true);
 var currentslope_down = collision_rectangle(bbox_left,bbox_bottom+1-slopeVOff,bbox_right,bbox_bottom+1-slopeVOff,par_slope,true,true);
 var currentslope_down2 = collision_rectangle(bbox_left,bbox_bottom-slopeVOff,bbox_right,bbox_bottom-slopeVOff,par_slope,true,true);
 var currentslope_down_id = self.id;
 var currentslope_down2_id = self.id;
 var currentslope_left = collision_rectangle(bbox_left-1,bbox_top,bbox_left-1,bbox_bottom-1-slopeVOff,par_slope,true,true);
 var currentslope_right = collision_rectangle(bbox_right+1,bbox_top,bbox_right+1,bbox_bottom-2-slopeVOff,par_slope,true,true);

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
  y -= collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,currentslope_down2,false,true).raisePixels;
 
  if collision_rectangle(bbox_left,bbox_bottom+3,bbox_right,bbox_bottom+3,par_slope,0,1)
  && not currentslope_down
  && c_vspeed >= 0
  y += collision_rectangle(bbox_left,bbox_bottom+3,bbox_right,bbox_bottom+3,par_slope,0,1).raisePixels;
 
  col_phase = 1;
  }
 }
