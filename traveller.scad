include </home/john/work/yak/20mmplate.scad>
include </home/john/work/yak/metric_fasteners.scad>

module quarterinchspacer() {
	difference() {
		translate([0,0,1.6])cylinder(r=4,h=6.2);
		translate([0,0,1.6])cylinder(r=2.5,h=6.2);
	}
}

module wheel() {
	difference() {
		cylinder(r=12.25,h=10);
		cylinder(r=3.1,h=10);
	}
}

module traveller() {
	20mmplate();

	color("red")translate([22.5,22.5,0])cap_bolt(5,20);
	color("red")translate([-22.5,22.5,0])cap_bolt(5,20);
	color("red")translate([22.5,-22.5,0])cap_bolt(5,20);
	color("red")translate([-22.5,-22.5,0])cap_bolt(5,20);
	color("green")translate([22.5,22.5,0])quarterinchspacer();
	color("green")translate([-22.5,22.5,0])quarterinchspacer();
	color("green")translate([22.5,-22.5,0])quarterinchspacer();
	color("green")translate([-22.5,-22.5,0])quarterinchspacer();

	translate([22.5,22.5,6.2+1.6])wheel();
	translate([-22.5,22.5,6.2+1.6])wheel();
	translate([22.5,-22.5,6.2+1.6])wheel();
	translate([-22.5,-22.5,6.2+1.6])wheel();
}

module rail(length) {
	union() {
		cube([length,20,5], center=true);
		translate([0,10,0])rotate([45,0,0])cube([length,3.2,3.2],center=true);
		translate([0,-10,0])rotate([45,0,0])cube([length,3.2,3.2],center=true);
	}
}

