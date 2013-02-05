use <20mmplate.scad>
use <metric_fasteners.scad>
use <openrailwheel.scad>
use <openrail.scad>
use <arm-plate.scad>
use <arm-mount.scad>

wheel_thickness=10.23;
plate_thickness=2.9;
spacer_height=6.2;

wheel_offset=wheel_thickness/2 + plate_thickness/2 + spacer_height;

module quarterinchspacer() {
	difference() {
		translate([0,0,plate_thickness/2])cylinder(r=4,h=spacer_height);
		translate([0,0,plate_thickness/2])cylinder(r=2.5,h=spacer_height);
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

	wheel_z=plate_thickness/2+wheel_thickness/2+spacer_height;
	translate([22.5,22.5,wheel_z])wheel();
	translate([-22.5,22.5,wheel_z])wheel();
	translate([22.5,-22.5,wheel_z])wheel();
	translate([-22.5,-22.5,wheel_z])wheel();

}

module traveller_with_rail(length) {
	traveller();
	color("blue") {
		rotate([90,0,0])translate([-10,plate_thickness/2+spacer_height+wheel_thickness/2,0])double_rail(length);
	}
}

module x_traveller() {
	traveller();
	translate([0,0,-5-plate_thickness/2])rotate([180,0,0])backPlate();
}
module yz_traveller() {
	traveller();
	translate([0,0,-5-plate_thickness/2])rotate([180,0,0])sidePlate();
}

x_traveller();

