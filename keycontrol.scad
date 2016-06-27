
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

//http://sullinscorp.com/catalogs/145_PAGE118_.100_SBH11_SERIES_MALE_BOX_HDR_ST_RA_SMT.pdf
maleElectricalShroudWidth = 2.54*10 + 10.16;
maleElectricalShroudHeight = 9.10;
maleElectricalShroudDepth = 9.10;


//http://sullinscorp.com/catalogs/146_PAGE119_.100_SFH11_SERIES_FEMALE_HDR_ST_RA.pdf
femaleElectricalShroudWidth = 30.48;
femaleElectricalShroudDepth = 7.0;
femaleElectricalShroudHeight = 8.50;

connectorWidth = max(maleElectricalShroudWidth, femaleElectricalShroudWidth);
connectorDepth = max(maleElectricalShroudDepth, femaleElectricalShroudDepth);
connectorHeight = max(maleElectricalShroudHeight, femaleElectricalShroudHeight);

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
    cube([20,moduleDepth * 0.1,moduleHeight * 0.5]);
}

module connectors() {
    scale([5, 1, 1])  rotate([0, -90, -90]) cube([connectorWidth+3, connectorDepth, connectorHeight]);
    
}

module pcbslot() {
    width = keyWidth * .85;
    depth = moduleDepth * .5;
    height = max(connectorWidth + 3, moduleHeight*0.8);
    translate([(keyWidth-width)/2, connectorDepth, moduleHeight - height]) cube([width, depth, height]);
}


difference() {
    structure();
    translate([0, moduleDepth/2, (moduleHeight - connectorWidth)/ 2]) connectors();
    pcbslot();
    footprint();
}


union() {
    
    //color([1,0,0]) translate([-keyWidth-1.0, 0,0])structure();
}

echo(version=version());
render(1);