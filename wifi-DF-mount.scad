// Facet number
$fn=100;

// - - - CLAMP dimensions
chips_cylinder = 74/2;
holder_tickness = 5;
height = 10;
gap = 5;
clamp_l = 17;
clamp_t = 5;
hole_large = 3/2;
hole_small = 2.1/2;

// - - - USB HOLDER dimensions
usb_h = 25;
usb_w = 11;
usb_holder_t = 5;
usb_holder_h = 20;
usb_holder_b = 6;

// - - - MOTOR dimensions
motor_w = 10;
motor_h = 7;
axis_d = 5;
axis_t = 3;

// - ring
difference() {
   cylinder(h = height, r = chips_cylinder+(holder_tickness), center=true);
   cylinder(h = height+2, r = chips_cylinder, center=true);    
   translate([0,gap/2,0])
      cube([2*(chips_cylinder+(3*holder_tickness)),gap,height+2], center=true);
}

difference() {
   translate([chips_cylinder,gap,-height/2])
      cube([clamp_l, clamp_t, height]);
   rotate([90,0,0])
      translate([chips_cylinder+clamp_t+(clamp_l-clamp_t)/2,0,-gap-clamp_t/2])
         cylinder(h = 1.1*clamp_t, r = hole_small, center=true);   
}

mirror([1,0,0])
   difference() {
      translate([chips_cylinder,gap,-height/2])
         cube([clamp_l, clamp_t, height]);
      rotate([90,0,0])
         translate([chips_cylinder+clamp_t+(clamp_l-clamp_t)/2,0,-gap-clamp_t/2])
            cylinder(h = 1.1*clamp_t, r = hole_small, center=true);   
   }


difference() {
   translate([chips_cylinder,-clamp_t,-height/2])
      cube([clamp_l, clamp_t, height]);
   rotate([90,0,0])
      translate([chips_cylinder+clamp_t+(clamp_l-clamp_t)/2,0,+clamp_t/2])
         cylinder(h = 1.1*clamp_t, r = hole_large, center=true);   
}

mirror([1,0,0])
   difference() {
      translate([chips_cylinder,-clamp_t,-height/2])
         cube([clamp_l, clamp_t, height]);
      rotate([90,0,0])
         translate([chips_cylinder+clamp_t+(clamp_l-clamp_t)/2,0,+clamp_t/2])
            cylinder(h = 1.1*clamp_t, r = hole_large, center=true);   
   }


// USB holder

// - base
translate([0,-chips_cylinder-(usb_holder_h/2)-(usb_holder_t/2),0])
   cube([usb_holder_b, usb_holder_t+usb_holder_h, height],center=true);
   
// - U-shape
translate([0,-chips_cylinder-(usb_holder_h)-(usb_holder_t/2)-usb_holder_t,0])
   cube([usb_w+(2*usb_holder_t),usb_holder_t,height],center=true);

translate(
   [(usb_holder_t/2+usb_w/2),
    -(usb_h/2)-chips_cylinder-usb_holder_h-(2*usb_holder_t),
    0])
   cube([usb_holder_t,usb_h,height],center=true);

mirror([1,0,0])
   translate(
      [(usb_holder_t/2+usb_w/2),
       -(usb_h/2)-chips_cylinder-usb_holder_h-(2*usb_holder_t),
       0])
      cube([usb_holder_t,usb_h,height],center=true);

// Motor adapter
difference() {
   translate([0,chips_cylinder+(motor_h+clamp_t)/2,0])
      cube([motor_w, motor_h+clamp_t, height], center=true);
   translate([0,chips_cylinder+(motor_h/2+clamp_t),0])
      cube([axis_t,1.01*motor_h,axis_d], center=true);
}
