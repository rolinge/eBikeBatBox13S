enableMidBox=true;
enableEndboxWithCutout=true;
enableEndboxNoCutout=true;
interference=0.8;
BatteryPadding=4;
overlap=15;
WallThickness=2.5;

include <vars.scad>;

TotalDepth=BatteryDepth+2*WallThickness+SwitchProtrude+BMCThickness+WiringAllowance;
MidBoxHeight=TotalDepth/3+2*overlap;
EndBoxHeight=TotalDepth/3;


module difstripe() {
  translate ([0,0,EndBoxHeight-overlap])
    difference(){
      linear_extrude(height = overlap+1 )
        square([BatteryWidth+WallThickness*4+BatteryPadding*2+.1,
                BatteryHeight+WallThickness*4+BatteryPadding*2+.1
                ], center = true);
      linear_extrude(height = overlap+2 )
        square([BatteryWidth+WallThickness*2+BatteryPadding*2,
                BatteryHeight+WallThickness*2+BatteryPadding*2
                ], center = true);

    }
}

//EndBox with switch.
module endboxWithCutout(){
  color("red")
    difference() {
      linear_extrude(height = EndBoxHeight )  //outside surface
        square([BatteryWidth+WallThickness*4+
                BatteryPadding*2,
                BatteryHeight+WallThickness*4+
                BatteryPadding*2
                ], center = true);
      translate ([0,0,WallThickness])         //inside surface
        linear_extrude(height = EndBoxHeight)
          square([BatteryWidth+
                  BatteryPadding*2,
                  BatteryHeight+
                  BatteryPadding*2
                  ], center = true)   ;
      translate([BatteryWidth/3,BatteryHeight/3,-0.1])  //hole for wires
        cylinder(h = WallThickness+.2,
                r1 = wireholddiameter/2,
                r2 = wireholddiameter/2,
                $fn = 36,
                center = false);
         // Add the On/Off Switch Cutout
      translate([WallThickness -8 ,WallThickness +4 , -0.1]) //power switch cutout
        rotate([0,0,90])
         linear_extrude(height = WallThickness+.2)
           square(switchcutout, center = false);
      difstripe();                                //inset


      /* // this hole is for a small voltmeter translate([-w+23.5+8*wall,l/2+1,basethickness+6])
      rotate([90,0,0])redMidBoxHeight-overlap*2
          linear_extrude(height = 5)
              square(voltmetercutout,
              centunioner = false); */

     }
}


//EndBox with no cutout.
module endboxNoCutout(){
color("pink")
   difference() {
        linear_extrude(height = EndBoxHeight )
            square([BatteryWidth+WallThickness*4+BatteryPadding*2,
                    BatteryHeight+WallThickness*4+BatteryPadding*2
            ], center = true);
       translate ([0,0,WallThickness])
         linear_extrude(height = EndBoxHeight)
            square([BatteryWidth+BatteryPadding*2,
                    BatteryHeight+BatteryPadding*2
            ], center = true)   ;
        difstripe();

   }
}

//Now do MidBox
module midBox(){
  difference(){
    union(){
      color("orange")  difference(){
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

      color("yellow") translate([0,0,overlap])
        difference(){
          linear_extrude(height=MidBoxHeight-overlap*2)
            square([BatteryWidth+
                    WallThickness*2+
                    BatteryPadding*2+
                    interference+.1   ,
                    BatteryHeight+
                    WallThickness*2+
                    BatteryPadding*2+
                    interference+.1
              ], center = true);
              translate([0,0,-.1]) linear_extrude(height = MidBoxHeight+.2)
                square([BatteryWidth+BatteryPadding*2,
                        BatteryHeight+BatteryPadding*2
                  ], center = true);
          }
  }
  translate ([-BatteryWidth+WallThickness*2+BatteryPadding*2,0,-.1])
  linear_extrude(height=MidBoxHeight+overlap*2)
    square([2*BatteryWidth+WallThickness*2+BatteryPadding*2+.1,
            BatteryHeight+WallThickness*2+BatteryPadding*2
      ], center = false);


  }
}

if (enableEndboxNoCutout) {
  translate ([-0100,0,0]) endboxNoCutout();
}
if (enableEndboxWithCutout) {
  endboxWithCutout();
}
if (enableMidBox) {
  translate ([100,0,0])
  midBox();
}
