// yet another kossel
use <traveller.scad>
use <openrail.scad>
use <effector.scad>

// center of model is geometric center of base triangle

$fn=100;

// this is the stuff you'd probably want to change
side=360;															// side of base triangle
base_offset=35;													// height to Z0
x_armplate_offset=13;											// offset from face of x plate to center of arm mount axis
yz_armplate_offset=29.75;									// same thing for the y and z plates
brace_anchor=3*side/8;										// length of side of triangle brace

// everything else is calculated
beam_width=15;													// width of openbeam
wheel_thickness=10.23;										// width of openrail wheel
plate_thickness=2.9;											// width of openrail plate
rail_thickness=5;												// width of double rail
spacer_thickness=6.2;											// width of traveller spacer

// basic dimensions
height=side*2;													// height of towers
h = sqrt(3) / 3 * side;   									// normal from vertex to center

// the triangle formed by the brace
brace_side=brace_anchor-beam_width-0.5*beam_width*sqrt(2);
brace_hypotenuse=brace_side*sqrt(2);

// the offsets from the center of the tower axis to the edge of the build circle
wheel_offset=wheel_thickness/2 + plate_thickness/2 + spacer_thickness;
traveller_offset=wheel_offset+rail_thickness/2;
traveller_offset_x=x_armplate_offset+traveller_offset;
traveller_offset_yz=yz_armplate_offset+traveller_offset;

// lengths of the openbeam
yz_length=side+(2*traveller_offset_yz);								// length of the top of the T
x_length=side/2*sqrt(3)-(beam_width/2)+traveller_offset_x;	// length of the vertical part of the T

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

module tower(height,offset) {
	union() {
		beam(height);
		translate([-10,-10,base_offset/2])rotate([0,0,90])double_rail(height-(base_offset+beam_width*2));
	}
}

module beam(length) {
        cube([beam_width,beam_width,length],center=true);
}

module brace(z) {
		polyhedron(
			points = 		[	[-brace_hypotenuse/2-beam_width,beam_width/2,-beam_width/2],
									[brace_hypotenuse/2+beam_width,beam_width/2,-beam_width/2],
									[brace_hypotenuse/2,-beam_width/2,-beam_width/2],
									[-brace_hypotenuse/2,-beam_width/2,-beam_width/2],
									[-brace_hypotenuse/2-beam_width,beam_width/2,beam_width/2],
									[brace_hypotenuse/2+beam_width,beam_width/2,beam_width/2],
									[brace_hypotenuse/2,-beam_width/2,beam_width/2],
									[-brace_hypotenuse/2,-beam_width/2,beam_width/2]	],
			triangles = 	[	[0,4,7],[7,3,0],[1,2,6],[6,5,1],		// small ends
									[4,5,7],[7,5,6],[0,2,1],[2,0,3],		// trapezoidal sides
									[3,7,2],[2,7,6],[5,4,1],[1,4,0]	]);
}


module tframe() {
	translate([0,0,beam_width/2]) {
		// T base
		translate([h-x_length/2 +traveller_offset_x,0,0])rotate([0,90,0])beam(x_length);
		translate([-sin(30)*h,0,0])rotate([90,0,0])beam(yz_length);
	
		// braces
		translate([-sin(30)*h+brace_anchor/2,brace_anchor/2,0])rotate([0,0,-45])brace(z);
		translate([-sin(30)*h+brace_anchor/2,-brace_anchor/2,0])rotate([180,0,45])brace(z);

	}
}


// build area
%difference(){
	cylinder(r=h,h=height);
	translate([0,0,-1])cylinder(r=h-1,h=height-base_offset);
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
translate([h+x_armplate_offset,0,500])rotate([90,0,90])x_traveller();
translate([-sin(30)*h,side/2+yz_armplate_offset,500])rotate([-90,0,0])yz_traveller();
translate([-sin(30)*h,-side/2-yz_armplate_offset,500])rotate([90,0,0])yz_traveller();

//effector
translate([0,0,200])effector();

// arms


