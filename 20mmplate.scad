$fn=50;

module hole(diameter) {
	cylinder(r=diameter/2,h=5,center=true);
}

module 20mmplate() {
	difference() {
		// the plate
		minkowski() {
			cube([60,60,1.45],center=true);
			cylinder(r=10, h=1.45,center=true);
		}
		// the holes
		hole(5.2);
		translate([10,0,0])hole(5.2);
		translate([-10,0,0])hole(5.2);
		translate([22.5,0,0])hole(5.2);
		translate([-22.5,0,0])hole(5.2);
		translate([0,10,0])hole(5.2);
		translate([0,-10,0])hole(5.2);
		translate([0,-22.5,0])hole(5.2);
		translate([0,+22.5,0])hole(7.1);
		translate([22.5,+22.5,0])hole(7.1);
		translate([-22.5,+22.5,0])hole(7.1);
		translate([22.5,-22.5,0])hole(5.2);
		translate([-22.5,-22.5,0])hole(5.2);
	}
}
