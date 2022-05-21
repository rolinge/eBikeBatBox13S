include <vars.scad>;

TotalDepth=BatteryDepth+2*WallThickness+SwitchProtrude+BMCThickness+WiringAllowance;
MidBoxHeight=TotalDepth/3+2*overlap;
EndBoxHeight=TotalDepth/3;

//EndBox with switch.
module endboxWithCutout(){
color("red")
   difference() {
        linear_extrude(height = EndBoxHeight )
            square([BatteryWidth+WallThickness*2+BatteryPadding*2,
                    BatteryHeight+WallThickness*2+BatteryPadding*2
            ], center = true);
       translate ([0,0,WallThickness])
         linear_extrude(height = EndBoxHeight)
            square([BatteryWidth+BatteryPadding*2,
                    BatteryHeight+BatteryPadding*2
            ], center = true)   ;
        translate([BatteryWidth/3,BatteryHeight/3,-0.1])
    //rotate([90,0,0])
    cylinder(h = WallThickness+.2,
            r1 = wireholddiameter/2,
            r2 = wireholddiameter/2,
            $fn = 36,
            center = false);
       // Add the On/Off Switch Cutout
    translate([WallThickness -8 ,WallThickness +4 ,   -0.1])
    rotate([0,0,90])
       linear_extrude(height = WallThickness+.2)
         square(switchcutout, center = false);


    /* // this hole is for a small voltmeter translate([-w+23.5+8*wall,l/2+1,basethickness+6])
    rotate([90,0,0])redMidBoxHeight-overlap*2
        linear_extrude(height = 5)
            square(voltmetercutout,
            centunioner = false); */

   }
}

//EndBox with no cutout.
module endboxNoCutout(){
color("blue") translate ([-0100,0,0])
   difference() {
        linear_extrude(height = EndBoxHeight )
            square([BatteryWidth+WallThickness*2+BatteryPadding*2,
                    BatteryHeight+WallThickness*2+BatteryPadding*2
            ], center = true);
       translate ([0,0,WallThickness])
         linear_extrude(height = EndBoxHeight)
            square([BatteryWidth+BatteryPadding*2,
                    BatteryHeight+BatteryPadding*2
            ], center = true)   ;

   }
}

//Now do MidBox
module midBox(){
difference(){
union(){
color("orange")
translate ([0100,0,0])
  difference(){
    linear_extrude(height=MidBoxHeight)
      square([BatteryWidth+WallThickness*4+BatteryPadding*2,
              BatteryHeight+WallThickness*4+BatteryPadding*2
        ], center = true);
    translate([0,0,-.1])
    linear_extrude(height = MidBoxHeight+.2)
    square([BatteryWidth+WallThickness*2+BatteryPadding*2+interference,
            BatteryHeight+WallThickness*2+BatteryPadding*2+interference
            ], center = true);
}

color("yellow")
translate ([0100,0,overlap])
  difference(){
    linear_extrude(height=MidBoxHeight-overlap*2)
      square([BatteryWidth+WallThickness*2+BatteryPadding*2+interference+.1,
              BatteryHeight+WallThickness*2+BatteryPadding*2+interference+.1
        ], center = true);
    translate([0,0,-.1])
    linear_extrude(height = MidBoxHeight+.2)
    square([BatteryWidth+BatteryPadding*2,
            BatteryHeight+BatteryPadding*2
      ], center = true);
}
}
translate ([(BatteryWidth+WallThickness*2+BatteryPadding*2)/2+5,
  0,0])
linear_extrude(height=MidBoxHeight+overlap*2)
  square([2*BatteryWidth+WallThickness*2+BatteryPadding*2+.1,
          BatteryHeight+WallThickness*2+BatteryPadding*2
    ], center = false);

}
}

if (enableEndboxNoCutout) {
  endboxNoCutout();
}
if (enableEndboxWithCutout) {
  endboxWithCutout();
}
if (enableMidBox) {
  midBox();
}
