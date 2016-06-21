module magnet(thickness = 2) {
   translate([0, thickness*-1, 0] rotate([0, 90, 90]) cylinder(thickness,d=5);
}

union() {
    union() {
        cube([10, 2, 20]);
        //translate([-3, -6, 0]) cube([3, 6, 20]);
        //translate([1, 1, 1]) cube([3, 6, 20]);
    }
    union () {
        translate([10,-2,15]) magnet();
        translate([10,-2,5]) magnet();
    }
}