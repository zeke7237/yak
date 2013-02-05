$fn=50;

length_to_hole=14.25;
hole=5.5;
diameter=7;

difference() {
	union() {
		translate([0,0,1])cylinder(r=diameter/2, h=14.25, center=true);
		translate([0,0,length_to_hole-6.125+hole/2])rotate([90,0,0]){
			difference() {
				cylinder(r=5,h=3,center=true);
				cylinder(r=hole/2,h=5,center=true);
			}
		}
	}
translate([0,3,length_to_hole-6.125+hole/2])rotate([90,0,0])cylinder(r=5.1,h=3,center=true);
translate([0,-3,length_to_hole-6.125+hole/2])rotate([90,0,0])cylinder(r=5.1,h=3,center=true);
}