include <yak_config.scad>
use <20mmplate.scad>
use <arm-mount.scad>

w= separation;
h= 25;
thickness=4;
basethickness=5;
offset= sin(30) * w/2;
sidel= sin(30) * w;
extra_radius=0.2;
m3_nut_od = 6.1;
m3_nut_radius = m3_nut_od/2 + 0.2 + extra_radius;


module triangle(o_len, a_len, depth)
{
    linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}

module armPlate(w=w, h=h) {
	difference() {
		// base plate
		cube([w,h,basethickness], center=true);
		
		// attachment holes
		#translate([-10,0,-thickness/2-4]) cylinder(r=5/2+0.2, h= thickness+5);
		#translate([10,0,-thickness/2-4]) cylinder(r=5/2+0.2, h= thickness+5);
	}
}

module backPlate() {
	union() translate([0,0,basethickness/2]){
		armPlate();
		translate([0,-h/2+8/2,-1]) rotate([90,0,0]) arm_mount();
	}
}	

module sidePlate() {
	aw1= tan(60)*sidel;
	sl1= sidel-1;
	sidel2= sin(30) * w/2;
	aw2= tan(60)*(sidel2);
	sl2= sidel2;
	aw3= 16;
	sl3= 5;
	translate([0,0,basethickness]) {
		union() {
			translate([0,0,-basethickness/2]) armPlate(w=aw1);
//			translate([0,0,-basethickness-basethickness/2]) armPlate(w=aw1);
	
			// vertical supports
			translate([-aw1/2+thickness/2,-h/2+8/2,sl1/2]) cube([thickness, 8, sl1], center=true);
			translate([0,-h/2+8/2,sl2/2-1]) cube([thickness+2, 8, sl2], center=true);
			translate([aw3,-h/2+8/2,sl3/2]) cube([thickness+3, 8, sl3], center=true);
	
			// buttress
			translate([-aw1/2+thickness/2+thickness/2,-5,-0.1]) rotate([0,-90,0]) triangle(h-8, sl1, thickness);		
	
			translate([10/sqrt(3),-h/2+8/2,20])rotate([0,30,0])translate([-2.5,0,-10])  {
				union() {
					rotate([90,0,0])arm_mount();
					// extra thickness for base
					cube([w,8,2], center=true);
				}
			}
		}
	}
}

module printPlate() {
	translate([0,30,0]) rotate([90,0,0]) backPlate();
	
	// left
	translate([30,0,0]) rotate([-90,0,180]) mirror([0,1,0]) sidePlate();
	
	//right
	translate([-30,0,0]) rotate([90,0,0]) sidePlate();
}

//printPlate();
sidePlate();
//%translate([0,0,-3.175-thickness]) rotate([0,0,-90]) translate([-90/2,-160/2,0]) standard_wheel_carriage_plate();
