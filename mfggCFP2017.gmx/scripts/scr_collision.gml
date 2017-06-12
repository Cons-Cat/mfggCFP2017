var col_phase = 0;

repeat(2)
{
  var currentsolid_up = collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top-1,obj_solid,false,true);
  var currentsolid_down = collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,obj_solid,false,true);
  var currentsolid_left = collision_rectangle(bbox_left-1,bbox_top,bbox_left-1,bbox_bottom-4,obj_solid,false,true);
  var currentsolid_right = collision_rectangle(bbox_right+1,bbox_top,bbox_right+1,bbox_bottom-4,obj_solid,false,true);
  var current_jt = collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom+1,obj_jumpthrough,false,true);

  //---Solids---
  if currentsolid_up
  && currentsolid_up.can_col == 1
  {
    if add_y <= 0
    add_y = 0;
    if c_vspeed <= 0
    c_vspeed = 0
   
    if collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_top,currentsolid_up,false,true){
        y += 1;
    }
  }
   
  if currentsolid_down
  && currentsolid_down.can_col == 1
  && dead != 3
  {
    if add_y >= 0
    add_y = 0;
    if c_vspeed >= 0
    c_vspeed = 0
   
    if collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,currentsolid_down,false,true)
    y -= 1;
    if pounding = 4{
        pounding = 0;
        poundRotateAlarm = 0;
        poundCounter = 0;
    }
  }
   
  if currentsolid_left
  && currentsolid_left.can_col == 1
  {
    if add_x <= 0
    add_x = 0;
    if c_hspeed <= 0
    c_hspeed = 0
   
    if collision_rectangle(bbox_left,bbox_top,bbox_left,bbox_bottom,currentsolid_left,false,true){
        x += 1;
    }
    if enemy = 1{
        dir = 1;
    }
  }
   
  if currentsolid_right
  && currentsolid_right.can_col == 1
  {
    if add_x >= 0
    add_x = 0;
    if c_hspeed >= 0
    c_hspeed = 0
   
    if collision_rectangle(bbox_right,bbox_top,bbox_right,bbox_bottom,currentsolid_right,false,true){
        x -= 1;
    }
    if enemy = 1{
        dir = -1;
    }
  }
  
  if c_vspeed > 0
  {  
    if current_jt
    && bbox_bottom <= current_jt.yprevious
    && dead != 3
    {
        if pounding = 4{
            pounding = 0;
            poundRotateAlarm = 0;
            poundCounter = 0;
        }
      
      //Stop vertical movement
      c_vspeed = 0
      if add_y > 0
        add_y = 0
    }
  }

  //Slopes
  if !in_air
  {
    if collision_rectangle(bbox_left,bbox_bottom-1,bbox_right,bbox_bottom+4,par_slope_top,1,0) 
    && !collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom-4,par_slope_top,1,0)
    && c_hspeed_slope+c_hspeed != 0
    {
      if (!collision_rectangle(bbox_left,bbox_bottom-1,bbox_right,bbox_bottom+1,current_jt,0,0))
      && (!collision_rectangle(bbox_left,bbox_bottom-1,bbox_right,bbox_bottom+1,currentsolid_down,0,0))
        y += 4;
    }
  }
  
  if in_air
  {
    if c_gravity != 0{
        if collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top+4,par_slope_bot,1,0){
            y += 0.5;
        }
      }
  }

  //Handle top slope collision
  if collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom,par_slope_top,1,0) 
  && !collision_rectangle(bbox_left,bbox_bottom-8,bbox_right,bbox_bottom-8,par_slope_top,1,0)
  && dead != 3
  {
    if add_y >= 0
    add_y = 0;
    if c_vspeed >= 0
    c_vspeed = 0

    //Prevent the player from getting embed inside a slope.
    if c_vspeed > -0.85 {
    
      while collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom-1,par_slope_top,1,0)
        y--;
        if pounding = 4{
            pounding = 0;
            poundRotateAlarm = 0;
            poundCounter = 0;
        }
    }
    
    // BEGIN steep slope push
    var loc_slope_push = 1; //init the variable for slopepushback speed
    if (object_index == obj_player) //make sure this applies only to player
    {
        if (collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom,obj_slopeR_05x,1,0))
        && !(collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom,obj_slopeL_05x,1,0))
        {
            if (abs(max_speed) > abs(c_hspeed - loc_slope_push)) && (round(c_hspeed) - loc_slope_push > 0)
            {
                c_hspeed_slope = -loc_slope_push;
            }
            else
            {
                c_hspeed_slope = 0;
            }
        }
        else if (collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom,obj_slopeL_05x,1,0))
        && !(collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom,obj_slopeR_05x,1,0))
        {
            if (abs(max_speed) > abs(c_hspeed + loc_slope_push)) && (round(c_hspeed) + loc_slope_push < 0)
            {
                c_hspeed_slope = loc_slope_push;
            }
            else
            {
                c_hspeed_slope = 0;
            }
        }   
        else
        {
            c_hspeed_slope = 0;
        }
    }
    else //cap the horiz speed if it's not the player obj
    {
        if (collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom,obj_slopeR_05x,1,0))
        && !(collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom,obj_slopeL_05x,1,0))
        {
            if (c_hspeed > 0) && (round(c_hspeed) - loc_slope_push <> 0)
            {
                c_hspeed_slope = -loc_slope_push;
            }
            else if (round(c_hspeed) - loc_slope_push <> 0)
            {
                c_hspeed -= 0.1;
            }
            else
            {
                c_hspeed_slope = 0;
            }
        }
        else if (collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom,obj_slopeL_05x,1,0))
        && !(collision_rectangle(bbox_left,bbox_bottom-4,bbox_right,bbox_bottom,obj_slopeR_05x,1,0))
        {
            if (c_hspeed < 0) && (round(c_hspeed) + loc_slope_push <> 0)
            {
                c_hspeed_slope = loc_slope_push;
            }
            else if (round(c_hspeed) + loc_slope_push <> 0)
            {
                c_hspeed += 0.1;
            }
            else
            {
                c_hspeed_slope = 0;
            }
        }   
        else
        {
            c_hspeed_slope = 0;
        }
    }
    
  }
  else if !collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_top-2,par_slope_bot,1,0)
  {
    c_hspeed_slope = 0;
  }
  // END steep slope push
  
  //Handle bottom slope collision
  if in_air{
      if collision_rectangle(bbox_left,bbox_top-4,bbox_right,bbox_top,par_slope_bot,1,0) 
      //&& !collision_rectangle(bbox_left,bbox_top-8,bbox_right,bbox_top-8,par_slope_bot,1,0)
      {
        if collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_top,par_slope_bot,true,false){
            if c_gravity != 0{
                if c_vspeed < 0{
                    if (collision_rectangle(bbox_left,bbox_top-4,bbox_right,bbox_top,par_slope_bot_R,1,0))
                    {
                        c_hspeed_slope = -1;
                        if c_hspeed > 0{
                            c_vspeed = 0;
                        }
                    }
                    if (collision_rectangle(bbox_left,bbox_top-4,bbox_right,bbox_top,par_slope_bot_L,1,0))
                    {
                        c_hspeed_slope = 1;
                        if c_hspeed < 0{
                            c_vspeed = 0;
                        }
                    }
                    c_vspeed += 0.05;
                }
            }
        }
        }
    }
}

