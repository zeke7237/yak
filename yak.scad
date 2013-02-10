// yet another kossel
include <yak_config.scad>
use <yak_components.scad>
use <traveller.scad>
use <effector.scad>

// center of model is geometric center of base triangle

// just for setting the travellers and effector in one place, centered at 200mm
arm_angle = asin((h-radius)/arm_length);
effector_height = 200;

// build area
%difference(){
	translate([0,0,beam_width])cylinder(r=h,h=height-base_offset-beam_width*2);
	translate([0,0,beam_width])cylinder(r=h-1,h=height-base_offset-beam_width*2);
}

tframe();
translate([0,0,height-base_offset-beam_width])tframe();

//verticies
for (v = [vertex_x,vertex_y,vertex_z]) {
	color("blue")translate(v)cube([2,2,15],center=true);
}

//towers
color("red")translate([0,0,height/2-base_offset])translate(tower_x)tower(height,base_offset);
color("red")translate([0,0,height/2-base_offset])translate(tower_y)rotate([0,0,90])tower(height,base_offset);
color("red")translate([0,0,height/2-base_offset])translate(tower_z)rotate([0,0,-90])tower(height,base_offset);

//travelers
translate([h+x_armplate_offset,0,200+cos(arm_angle)*arm_length-10])rotate([90,0,90])x_traveller();
translate([-sin(30)*h,side/2+yz_armplate_offset,200+cos(arm_angle)*arm_length-10])rotate([-90,180,0])mirror([1,0,0])yz_traveller();
translate([-sin(30)*h,-side/2-yz_armplate_offset,200+cos(arm_angle)*arm_length-10])rotate([90,0,0])yz_traveller();

//effector
rotate([0,0,90])translate([0,0,effector_height])effector();

// arms
for (a = [0:120:240]) rotate([0, 0, a]) {
	for (s = [-1, 1]) scale([1, s, 1]) {
		translate([sin(arm_angle)*arm_length/2+radius,separation/2-8-1.5,effector_height+cos(arm_angle)*arm_length/2])rotate([0,arm_angle,0])arm(arm_length-3);
	}
}

