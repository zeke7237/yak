include <configuration.scad>								// johann's stuff
$fn=100;

// this is the stuff you'd probably want to change
side=360;															// side of base triangle
base_offset=35;													// height to Z0
x_armplate_offset=12.5;										// offset from face of x plate to center of arm mount axis
yz_armplate_offset=20*sqrt(3)-5;							// same thing for the y and z plates
brace_anchor=3*side/8;										// length of side of triangle brace

// other constants
beam_width=15;													// width of openbeam
wheel_thickness=10.23;										// width of openrail wheel
plate_thickness=2.9;											// width of openrail plate
rail_thickness=5;												// width of double rail
spacer_thickness=6.2;											// width of traveller spacer
ratio= side/300;													// factor for adjusting johann's values (until I understand the math ;)
separation = 37.2*ratio;										// distance between arm mounts
radius = 33*ratio;												// radius of effector

// everything else is calculated

// the triangle formed by the brace
brace_side=brace_anchor-beam_width-0.5*beam_width*sqrt(2);
brace_hypotenuse=brace_side*sqrt(2);

// the offsets from the face of the tower to the edge of the build circle
wheel_offset=wheel_thickness/2 + plate_thickness/2 + spacer_thickness;
traveller_offset=wheel_offset+rail_thickness/2;
traveller_offset_x=x_armplate_offset+traveller_offset;
traveller_offset_yz=yz_armplate_offset+traveller_offset;

// lengths of the openbeam
yz_length=side+(2*traveller_offset_yz);								// length of the top of the T
x_length=side/2*sqrt(3)-(beam_width/2)+traveller_offset_x;	// length of the vertical part of the T

// basic dimensions
height=side*2;													// height of towers
h = sqrt(3) / 3 * side;   									// normal from vertex to center, diameter of build cylinder
arm_length = side * 0.8;

// handy vectors
vertex_x=[h,0,0];
vertex_y=[-sin(30)*h, cos(30)*h,0];
vertex_z=[-sin(30)*h, -cos(30)*h,0];
tower_x=[h+traveller_offset_x+beam_width/2,0,0];
tower_y=[-sin(30)*h, yz_length/2+beam_width/2,0];
tower_z=[-sin(30)*h, -yz_length/2-beam_width/2,0];

echo("side", side);
echo("x-length",x_length," yz-length",yz_length);
echo("total=",x_length+yz_length);
echo("tower length", height, "rail length", height-(base_offset+beam_width*2));
echo("brace cut length", brace_hypotenuse+2*beam_width);



