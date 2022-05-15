include <vars.scad>;

BoxPart1Height=10 + WiringAllowance + BMCThickness;


color("red")
   difference() {
        linear_extrude(height = BoxPart1Height )
            square([BatteryWidth+WallThickness*2+BatteryPadding*2, BatteryHeight+WallThickness*2+BatteryPadding*2
            ], center = true);
       translate ([0,0,WallThickness])
         linear_extrude(height = BoxPart1Height)
            square([BatteryWidth+BatteryPadding*2, BatteryHeight+BatteryPadding*2
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
       linear_extrude(height = 5)
         square(switchcutout, center = false);


    /* // this hole is for a small voltmeter translate([-w+23.5+8*wall,l/2+1,basethickness+6])
    rotate([90,0,0])
        linear_extrude(height = 5)
            square(voltmetercutout,
            center = false); */

       }
