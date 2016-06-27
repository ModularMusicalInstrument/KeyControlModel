module magnet(d, thickness = 2) {
   translate([0, thickness*-1, 0])
    rotate([0, 90, 90])
    color([0, 1, 0])
    cylinder(thickness,d=d);
}

module malematePlate(plateThickness, plateWidth, height) {
    
    magHeight1 = height - magnetDiameter;
    magHeight2 = magnetDiameter;
    
    difference() {
        cube([plateWidth, plateThickness, height]);
        color([0,0,1]) translate([-matingPlateWidth  + magnetThickness/2, matingPlateDepth/2, 0]) rotate ([0,0,90]) {
            translate([0, 0, magHeight1]) magnet(magnetDiameter, magnetThickness);
            translate([0, 0, magHeight2]) magnet(magnetDiameter, magnetThickness);
        }
    }
}


module malemateShaft(plateWidth, shaftLength, shaftWidth, height) {
    cube([shaftWidth, shaftLength, height]);
}

module malemate() {
    // Plate = front facing magnet holder
    // shaft = thing holding plate to structure
    shaftWid = matingShaftDepth;
    plateThick = matingPlateDepth;
    plateWid = matingPlateWidth;
    shaftLength = totalShaftLength - matingPlateWidth;

    rotate([0, 0, 270]) union() {
        translate( [-matingPlateDepth/2, totalShaftLength, 0] )rotate ([0, 0, -90]) malematePlate(plateThick, plateWid, moduleHeight);
        translate([-matingShaftDepth/2, 0, 0]) malemateShaft(plateWid, shaftLength, shaftWid, moduleHeight);
    }
}

module femalemateShaft(holeInset, holeWidth) {
    color([1, 1, 0]) translate([holeWidth, matingShaftDepth/2, 0]) cube([holeInset+1, matingShaftDepth, moduleHeight]);
}

module femalematePlate(holeWidth) {
    cube([holeWidth, matingPlateDepth, moduleHeight]);
}

module femaleHoles(plateThickness, plateWidth, height) {
    
    magHeight1 = height - magnetDiameter;
    magHeight2 = magnetDiameter;
    
    color([0,0,1]) translate([-magnetThickness, matingPlateDepth/2, 0]) rotate ([0,0,90]) {
        translate([0, 0,magHeight1]) magnet(magnetDiameter, magnetThickness);
        translate([0, 0,magHeight2]) magnet(magnetDiameter, magnetThickness);
    }
}

module femalemate() {
    height = moduleHeight;
    shaftWid = matingShaftDepth;
    magDiam = magnetDiameter;
    plateThick = matingPlateWidth;
    plateWid = matingPlateWidth;
    
    connectorLen = connectorLength;
    
    shaftLen = plateThick + connectorLen + shaftOffset;
    holeSize = plateThick + connectorLen;
    holeInsetThickness = matingPlateWidth;
    holeWidth = totalShaftLength - holeInsetThickness;
    
    rotate([0, 0, 180]) translate([0, -matingPlateDepth/2, 0]) union() {
        femalemateShaft(holeInsetThickness, holeWidth);
        femalematePlate(holeWidth);
        femaleHoles(plateThick, plateWid, height);
    }
}


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
