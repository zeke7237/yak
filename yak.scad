// yet another kossel
use <traveller.scad>
use <openrail.scad>
use <effector.scad>

// center of model is geometric center of base triangle

$fn=100;

side=360;															// side of base triangle
height=side*2;													// height of towers
h = sqrt(3) / 3 * side;   									// normal from side to center
beam_width=15;													// width of openbeam
base_offset=35;													// height to Z0
wheel_thickness=10.23;
plate_thickness=2.9;
rail_thickness=5;
spacer_thickness=6.2;
x_armplate_offset=13;
yz_armplate_offset=29.75;

wheel_offset=wheel_thickness/2 + plate_thickness/2 + spacer_thickness;
traveller_offset=wheel_offset+rail_thickness/2;
traveller_offset_x=x_armplate_offset+traveller_offset;					// distance from vertical beam surface to plate+15mm
traveller_offset_yz=yz_armplate_offset+traveller_offset;				// allow 10mm extra for the angle on y and z

yz_length=side+(2*traveller_offset_yz);								// length of the top of the T
x_length=side/2*sqrt(3)-(beam_width/2)+traveller_offset_x;	// length of the vertical part of the T

// handy vectors
vertex_x=[h,0,0];
vertex_y=[-sin(30)*h, cos(30)*h,0];
vertex_z=[-sin(30)*h, -cos(30)*h,0];
tower_x=[h+traveller_offset_x+beam_width/2,0,0];
tower_y=[-sin(30)*h, yz_length/2+beam_width/2,0];
tower_z=[-sin(30)*h, -yz_length/2-beam_width/2,0];

module tower(height,offset) {
	union() {
		beam(height);
		translate([-10,-10,base_offset/2+beam_width/2])rotate([0,0,90])double_rail(height-(base_offset+beam_width));
	}
}

module beam(length) {
        cube([beam_width,beam_width,length],center=true);
}

echo("x-length",x_length," yz-length",yz_length," total=",x_length+yz_length);
echo("tower length", height, "rail length", height-(base_offset+beam_width));

// build area
%difference(){
	cylinder(r=h,h=height);
	translate([0,0,-1])cylinder(r=h-1,h=height-base_offset);
}

// T base
translate([h-x_length/2 +traveller_offset_x,0,beam_width/2])rotate([0,90,0])beam(x_length);
translate([-sin(30)*h,0,beam_width/2])rotate([90,0,0])beam(yz_length);

//verticies
color("blue")translate(vertex_x)cube([2,2,15],center=true);
color("blue")translate(vertex_y)cube([2,2,15],center=true);
color("blue")translate(vertex_z)cube([2,2,15],center=true);

//towers
color("red")translate([0,0,height/2-base_offset])translate(tower_x)tower(height,base_offset);
color("red")translate([0,0,height/2-base_offset])translate(tower_y)rotate([0,0,90])tower(height,base_offset);
color("red")translate([0,0,height/2-base_offset])translate(tower_z)rotate([0,0,-90])tower(height,base_offset);

//travelers
translate([h+x_armplate_offset,0,500])rotate([90,0,90])x_traveller();
translate([-sin(30)*h,side/2+yz_armplate_offset,500])rotate([-90,0,0])yz_traveller();
translate([-sin(30)*h,-side/2-yz_armplate_offset,500])rotate([90,0,0])yz_traveller();

//effector
translate([0,0,200])effector();