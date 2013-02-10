include <yak_config.scad>
use <openrail.scad>
use <arm_end.scad>

module beam(length) {
        cube([beam_width,beam_width,length],center=true);
}

module tower(height,offset) {
	union() {
		beam(height);
		translate([-10,-10,base_offset/2])rotate([0,0,90])double_rail(height-(base_offset+beam_width*2));
	}
}

module brace() {
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
		translate([-sin(30)*h+brace_anchor/2,brace_anchor/2,0])rotate([0,0,-45])brace();
		translate([-sin(30)*h+brace_anchor/2,-brace_anchor/2,0])rotate([180,0,45])brace();

	}
}

module arm(length) {
	union() {
		cylinder(r=2.5, h=length-10, center=true);
		translate([0,0,length/2])arm_end();
		translate([0,0,-length/2])rotate([0,180,0])arm_end();
	}
}

