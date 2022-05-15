include <vars.scad>;

BoxPart1Height=BatteryDepth + WiringAllowance + BMCThickness-15;


color("orange")
   difference() {
        linear_extrude(height = BoxPart1Height )
            square([BatteryWidth+WallThickness*4+BatteryPadding*2, 
                    BatteryHeight+WallThickness*4+BatteryPadding*2
            ], center = true);
       translate ([0,0,WallThickness])
         linear_extrude(height = BoxPart1Height) // Outside dimensions of the edge, plus 0.6 for clearence
            square([BatteryWidth+WallThickness*2+BatteryPadding*2+.6, 
                    BatteryHeight+WallThickness*2+BatteryPadding*2+.6
            ], center = true)   ;

       /*translate ([35,0,WallThickness])
         linear_extrude(height = BoxPart1Height) // Outside dimensions of the edge, plus 0.6 for clearence
            square([BatteryWidth+WallThickness*2+BatteryPadding*2+.6, 
                    BatteryHeight+WallThickness*2+BatteryPadding*2+.6
            ], center = true)   ;  */

     // this hole is for a small voltmeter translate([-w+23.5+8*wall,l/2+1,basethickness+6])
    //rotate([90,0,0])
        translate ([0,0,-0.1])
        linear_extrude(height = 0)
            square(voltmetercutout,
            center = false);       
}

color("red")
   translate([0,0,WallThickness])
   difference() {
        linear_extrude(height = BoxPart1Height-40 )
            square([BatteryWidth+WallThickness*2+BatteryPadding*2+1, BatteryHeight+WallThickness*2+BatteryPadding*2+1
            ], center = true);
         linear_extrude(height = BoxPart1Height)
            square([BatteryWidth+BatteryPadding*2, BatteryHeight+BatteryPadding*2
            ], center = true)   ;
   }