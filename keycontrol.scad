
connectorLength = 3;
magnetDiameter = 5;
magnetThickness = 5;
keyWidth = 14;
moduleDepth = 60;
moduleHeight = 40;

matingShaftDepth = moduleDepth * .1;
matingPlateDepth = matingShaftDepth * 2;
matingPlateWidth = keyWidth * 0.2;
totalShaftLength = keyWidth * 0.5;
shaftOffset = moduleDepth / 2;  // Distance from front face to centreline of shaft


include <keycontrol-mate.scad>;

module structure() {
    union() {
        difference() {
            cube([keyWidth, moduleDepth, moduleHeight]);
            translate([totalShaftLength, moduleDepth - matingPlateDepth ,0 ]) femalemate();
        }
        translate([keyWidth, moduleDepth - matingPlateDepth ,0 ]) malemate();
    }
}

module footprint() {
    translate([0, 18, -2]) cube([20,5,5]);
}

module pcbslot() {
    socketWidth = 10.56;
    socketHeight = 3.4;
    
    translate([1.5, 14, 4]) cube([10, 8, 16]);
    translate([-1.5, 15.5, 7])  {
        cube([socketHeight, 5, socketWidth]);
        translate([13, 0, 0]) cube([socketHeight, 5, socketWidth]);
    }
}

difference() {
    
    //pcbslot();
    //footprint();
}

union() {
    structure();
    //color([1,0,0]) translate([-keyWidth-1.0, 0,0])structure();
}

echo(version=version());
render(1);