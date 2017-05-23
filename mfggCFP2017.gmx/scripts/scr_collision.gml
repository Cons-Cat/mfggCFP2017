var col_phase = 0;

/*
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
*/

repeat(2)
{
  var currentsolid_up = collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top-1,obj_solid,false,true);
  var currentsolid_down = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,obj_solid,false,true);
  var currentsolid_left = collision_rectangle(bbox_left-1,bbox_top,bbox_left-1,bbox_bottom-4,obj_solid,false,true);
  var currentsolid_right = collision_rectangle(bbox_right+1,bbox_top,bbox_right+1,bbox_bottom-4,obj_solid,false,true);
  var current_jt = collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+1,obj_jumpthrough,false,true);

  /*
  var currentslope_up = collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top-1,par_slope,true,true);
  var currentslope_down = collision_rectangle(bbox_left,bbox_bottom+4-slopeVOff,bbox_right,bbox_bottom+4-slopeVOff,par_slope,true,true);
  var currentslope_down2 = collision_rectangle(bbox_left,bbox_bottom-slopeVOff,bbox_right,bbox_bottom-slopeVOff,par_slope,true,true);
  var currentslope_down_id = self.id;
  var currentslope_down2_id = self.id;
  var currentslope_left = collision_rectangle(bbox_left-1,bbox_top,bbox_left-1,bbox_bottom-1-slopeVOff,par_slope,true,true);
  var currentslope_right = collision_rectangle(bbox_right+1,bbox_top,bbox_right+1,bbox_bottom-2-slopeVOff,par_slope,true,true);
  */

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
  
  if c_vspeed > 0
  {  
    if current_jt
    && bbox_bottom < current_jt.yprevious+2
    {
    
      //Stay above the jumpthrough platform
      y = current_jt.bbox_top-12;
      
      //Stop vertical movement
      c_vspeed = 0
      if add_y > 0
        add_y = 0   
    }
  }

  //Slopes
  if !in_air
  {
    if collision_rectangle(bbox_left,bbox_bottom-1,bbox_right,bbox_bottom+4,par_slope,1,0) 
    && !collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom-4,par_slope,1,0)
    && c_hspeed != 0
    {
      if (!collision_rectangle(bbox_left,bbox_bottom-1,bbox_right,bbox_bottom+1,current_jt,0,0))
      && (!collision_rectangle(bbox_left,bbox_bottom-1,bbox_right,bbox_bottom+1,currentsolid_down,0,0))
        y += 4;
    }
  }

  //Handle slope collision
  if collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom,par_slope,1,0) 
  && !collision_rectangle(bbox_left,bbox_bottom-8,bbox_right,bbox_bottom-8,par_slope,1,0)
  {
    if add_y >= 0
    add_y = 0;
    if c_vspeed >= 0
    c_vspeed = 0

    //Prevent the player from getting embed inside a slope.
    if c_vspeed > -0.85 {
    
      while collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom-1,par_slope,1,0)
        y--;
    }
  }
  
  /*  OLD SLOPE CODE
  //Slopes
  if collision_rectangle(bbox_left
  {
    if add_y >= 0
    add_y = 0;
    if c_vspeed >= 0
    c_vspeed = 0
  }
      
  if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+1,currentslope_down2,true,true)
    y -= collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+1,currentslope_down2,true,true).raisePixels;
 
  if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+1,par_slope,1,1)
  && not currentslope_down
  && c_vspeed >= 0
    y += collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+1,par_slope,1,1).raisePixels;
  */
}
