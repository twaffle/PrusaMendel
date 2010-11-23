// PRUSA Mendel
// Frame vertex
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

// Based on http://www.thingiverse.com/thing:2003 aka Viks footed 
// frame vertex, which is based on http://www.thingiverse.com/thing:1780 
// aka Tonokps parametric frame vertex
// Thank you guys for your great work
include <configuration.scad>

vfM8=m8_diameter+0.9;
vfvertex_height=m8_diameter;

vfFN=100;

module vertex_foot() {
	union () {
		cube([18,4,vfvertex_height],center=true);
		translate ([-5,8,0]) cube([5,18,vfvertex_height],center=true);
		translate ([5,9,0]) cube([5,18,vfvertex_height],center=true);
	}
}

module vertex(){

	translate ([0,0,vfvertex_height/2])difference() 
	{
		union () {
			dxf_linear_extrude(file = "vertex-body-fixed-qcad.dxf",height=vfvertex_height,center=true);
			translate([40,-15,0]) vertex_foot();
		}

		translate([11.013,59.912]) zhole(vfM8); 
		translate([40.274,9.249,0]) zhole(vfM8); 
	}
}

module zhole(diameter) cylinder(h=100,r=(diameter/2),center=true,$fn=vfFN); 

module motor_mount()
{
	union () {
		difference (){
			union() {
				vertex();
				translate ([16,29,vfvertex_height/2]) rotate(a=[0,0,78]) cube(size = [46,43,vfvertex_height], center = true); 
			}

			translate ([16,29,vfvertex_height/2]) rotate(a=[0,0,78]) union () {
				translate ([0,0,-20]) cylinder(h = 100, r=15, $fn=100); 
				translate(v=[15,15,0]) rotate(a=[0,0,45]) cube(size = [9,3.2,25], center = true); 
				translate(v=[-15,15,0]) rotate(a=[0,0,-45]) cube(size = [9,3.2,25], center = true);
				translate(v=[15,-15,0]) rotate(a=[0,0,-45]) cube(size = [9,3.2,25], center = true);
				translate(v=[-15,-15,0]) rotate(a=[0,0,45]) cube(size = [9,3.2,25], center = true);
			}
		}
	}
}

motor_mount();
