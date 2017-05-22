///Jumping script

/* States:
canJump = 0 - Player is jumping up
canJump = 1 - Player is on the floor and ready to jump
canJump = 2 - Player has reached the peak of their jump
canJump = 3 - Player is falling down
*/

//Max height of jump
if canJump = 1{
    if y <= jumpY - jumpHeight - 1{
        canJump = 2;
    }
}

//Jump upwards
if keyboard_check_pressed(global.p1_a){
    if canJump = 1{
        c_vspeed = -phy_jumppower;
        canJump = 0;
        jumpY = y;
    }
}

//Cut jump short
if !keyboard_check(global.p1_a){
    if canJump = 1{
        canJump = 2;
    }
}

//Stop jump momentum after the jump ends
if canJump = 2{
    c_vspeed /= 1.2;
}

//Fall down after jump momentum gets near 0
if c_vspeed > -0.25{
    if canJump = 2{
        c_vspeed = 0;
        canJump = 3;
    }
}

if collision_rectangle(bbox_left,bbox_bottom+1,bbox_right,bbox_bottom+1,obj_solid_parent,false,true){
    canJump = 1;
}

