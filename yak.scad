// yet another kossel

side=475;
height=1000;
h = sqrt(3) / 3 * side;   //height_to_geometric_center
beam_width=15;										// width of openbeam
traveller_offset_x=40.1-(beam_width/2);	// distance from vertical beam surface to plate+15mm
traveller_offset_yz=50.1-(beam_width/2);	// allow 10mm extra for the angle on y and z

yz_length=side+(2*traveller_offset_yz);
x_length=side/2*sqrt(3)-(beam_width/2)+traveller_offset_x;

vertex_x=[h,0,0];
vertex_y=[-sin(30)*h, cos(30)*h,0];
vertex_z=[-sin(30)*h, -cos(30)*h,0];
tower_x=[h+traveller_offset_x,0,0];
tower_y=[-sin(30)*h, yz_length/2+beam_width/2,0];
tower_z=[-sin(30)*h, -yz_length/2-beam_width/2,0];

module tower(height) {
	translate([0,0,height/2])rotate([0,90,0])beam(height);
}

module beam(length) {
	cube([length,15,15],center=true);
}

// base of triangle

echo("x-length",x_length," yz-length",yz_length," total=",x_length+yz_length);

color("yellow",0.1){
	difference(){
		cylinder(r=h,h=height);
		translate([0,0,-1])cylinder(r=h-1,h=height+2);
	}
}

translate([-sin(30)*h+x_length/2,0,beam_width/2])beam(x_length);
rotate([0,0,90])translate([0,sin(30)*h,beam_width/2])beam(yz_length);
color("blue")translate(vertex_x)cube([2,2,15],center=true);
color("blue")translate(vertex_y)cube([2,2,15],center=true);
color("blue")translate(vertex_z)cube([2,2,15],center=true);
color("red")translate([0,0,-20])translate(tower_x)tower(height);
color("red")translate([0,0,-20])translate(tower_y)tower(height);
color("red")translate([0,0,-20])translate(tower_z)tower(height);
