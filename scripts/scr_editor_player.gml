///Script for moving Mario in the editor
var editMomentum = 0.5;
var editSpdX = 0;
var editSpdY = 0;

if keyboard_check(vk_left) && !keyboard_check(vk_right){
    editSpdX -= editMomentum;
} else if keyboard_check(vk_right){
    editSpdX += editMomentum;
} else if (keyboard_check(vk_left) && keyboard_check(argument[1])) || (!keyboard_check(vk_left) && !keyboard_check(vk_right)){
    editSpdX /= editDecel;
}

if keyboard_check(vk_up) && !keyboard_check(vk_down){
    editSpdY -= editMomentum;
} else if keyboard_check(vk_down){
    editSpdY += editMomentum;
} else if (keyboard_check(vk_up) && keyboard_check(vk_down)) || (!keyboard_check(vk_up) && !keyboard_check(vk_down)){
    editSpdY /= editDecel;
}

x += editSpdX;
y += editSpdY;

