if keyboard_check_pressed(_jump){
    if canJump = 1{
        vspeed = -jumpPower;
        canJump = 0;
        jumpY = y;
    }
}

if canJump = 0{
    if y <= jumpY - jumpHeight{
        canJump = 2;
    }
}

if !keyboard_check(_jump){
    if canJump = 0{
        canJump = 2;
    }
    
    if vspeed > maxFall{
        vspeed = maxFall;
        falling = 0;
    }
} else {
    if vspeed > maxFall /3.5{
        vspeed = maxFall/3.5;
        falling = 1;
    }
}

if canJump = 2{
    vspeed /= 1.2;
}

if canJump = 3{
    gravity = gravValue;
}
if vspeed > -0.2{
    if canJump = 2{
        vspeed = 0;
        canJump = 3;
    }
}

if canJump = 1{
    if !collision_rectangle(x-8, y+17, x+8, y+17, obj_solidtop, false, false){
        canJump = 3;
    }
}

