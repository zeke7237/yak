// traxxas 5347
// no, it doesn't look anything like the part .. but dimensionally it's fine ;)

$fn=50;

total_length=22;
width_ball=10;
thickness_ball=3;
width_shaft=7;
hole_offset=5;
hole_radius=2.75;

module arm_end() {
	union() {
		rotate([90,0,0]) {
			difference() {
				cylinder(r=width_ball/2,h=thickness_ball,center=true);
				cylinder(r=hole_radius,h=5,center=true);
			}
		}
		translate([0,0,-(total_length-width_ball+2)/2-(width_ball/2)+2])cylinder(r1=width_shaft/2, r2=2, h=total_length-width_ball+2, center=true);
	}
}

arm_end();
