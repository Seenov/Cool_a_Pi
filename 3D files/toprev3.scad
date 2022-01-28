//rev3 top
$fn=40;
boxWidth = 56+1;
boxLenght = 85+1.1;
boxHeight = 24;
cornerRadius = 2;
doubleradius = 2*cornerRadius;
wall =2.1;
doubleWall = 2*wall;
topmountingindent = wall;
mil2mm = 0.0254;
M2ScrewHole = 2.1;
pcb = [56, 85, 1.5]; // main board
pcb2floor = 4.0; // 3.5
pcb2roof = 17.0; // 15.7
pcbClearance =1;
pcbmntdia = 2.5; // mounting holes
pcbmnt1x= 3.5 ;
pcbmnt1y = 3.5 ;
pcbmnt2x= 52.5 ;
pcbmnt2y = 3.5 ;
pcbmnt3x= 52.5 ;
pcbmnt3y = 61.5 ;
pcbmnt4x= 3.5 ;
pcbmnt4y = 61.5 ;

pcbmnt1dx = pcb[0]/2 - 3.5;  // 
pcbmnt1dy = 3.5 - pcb[1]/2;
pcbmnt2dx = pcb[0]/2 - 3.5 - 58.0; // 
pcbmnt2dy = pcb[1]/2 - 3.5;
pcbmnthead = 5.5; // countersunk
pcbmntthreads = 2.2;
breakaway = 0.3; // have hidden hole for screw, 0 for no extra pegs 
pcbmntheight = 5;
cardsy = 12.0; // card measures 11.0
cardsz = 3.1;
cardsx = 8.0; // size of internal platform
carddy = pcb[1]/2 - 28.0;
etherx = 45.75; // ethernet contact width
ethersz = 13.5;
etherwidth = 16.4;
etherHeight = 14.1 ;
usbCwidth = 9.8;
usbCHeight =4.4;
usbCHeightz =1.5;
USB_C_Y= 8.2;
USB_C_Z = 0.7;
microHDM1w = 5.3;
microHDMIh = 2.2;
microHDMIholeheight=3.5;
microHDMIz= 1.5;
usbsy = 13.5; // core
usbframe = 1.0; // frame
usbsz = 16;
usb1x = 9;
usb2x= 27;
usbwidth = 15.4;
usbheight=  17;
powerpsx = 11.0; // power plug width 
powerpsz = 4.5; // plug height
powerssx = 8.0; // power socket width 
powerssz = 3.3; // socket height
powerdz = -1.7; // for plug 
powerdx = pcb[0]/2 - 10.6; // 
audior = 7.0; // audio contact radius
audiodz = 6.0; // above pcb
audiodx = 3.5+7.7+14.8+13.5+7+7.5;
leddx = pcb[0]/2 - 1.3;
led1dy = -8.9 + 2.4/2  + pcb[1]/2;
led2dy = -12.9 + 2.4/2 + pcb[1]/2 - 0.2;
leddia = 2.0;
// BUG: fine tune, maybe add slot out of box
plugrow1 = [pcb[0]/2 - 29.0 - mil2mm*100*11, 3.5 - pcb[1]/2, 0]; // coordinates D7 pin, mid

cam_box = 34.5;
frame_w = 2.5; // width of lip for frame 
snap_dia = 1.8; // snap lock ridge diameter
snap_len = 50.0; // snap lock length
tol = 0.5; // general tolerance

//wall = 1.2; // general wall thickness
thinwall = 0.4;
corner_r = wall; // casing corner radius
corner2_r = wall+tol+wall; // corners of top casing
d = 0.01;

extra_y = 0; // extra space in y 
// show pcb
//%translate([0,0,0])cube([pcb[0],pcb[1],pcb[2]]);
//******** use to measure distances ************
//translate([15,boxLenght,-5]) cube([30,3,17]);
//********************************************
// show top
translate([boxWidth/2-0.5,-6.0,-6.346]) rotate ([-90,0,0])fanmounting(10);
difference(){
translate([boxWidth/2-0.5,boxLenght/2-0.5,0.4]) rotate ([0,0,0]) rpi4Bottom();
  contourHoles();
}
//  snaps to top and bottom
// front left
translate([-wall+0.35,-wall+0.4,boxHeight/2+2])rotate([180,0,45])cornertopbottomclips();
// front right
translate([boxWidth+1.5,boxLenght-7.8,boxHeight/2+1.0])rotate([180,0,180]) sidetopbottomclips();
//rear left
translate([boxWidth+wall-1.3,-wall+0.3,boxHeight/2+2])rotate([180,0,135])cornertopbottomclips();
//rrear right
translate([-2.5,boxLenght-8,boxHeight/2+1.0])rotate([180,0,0])sidetopbottomclips();


module contourHoles(){
    sdcardx=24.5+3.5;
    sdcardwidth= 15;
    sdcardholeheight =6;
    outsidehole = 3.6;
    insidehole = 3.1; // 
    union(){
     translate([0,0,boxHeight/2]) union(){
     microHDMIHole();
     USB_C();
     sideIndent();
      translate([-4,audiodx,-audiodz+audior/1.7]) rotate ([0,90,0]) cylinder(h=5,d=audior);
    //translate([sdcardx-sdcardwidth/2,-4,-sdcardholeheight+pcb[2]+2])cube([sdcardwidth,8,sdcardholeheight]);
    translate([etherx-etherwidth/2,89-22+5,-etherHeight])cube([etherwidth,22,etherHeight]);
    translate([usb1x-usbwidth/2,89-22+5,-usbheight])cube([usbwidth,22,usbheight]);
    translate([usb2x-usbwidth/2,89-22+5,-usbheight])cube([usbwidth,22,usbheight]);
        }
    // FAN HOLE
   translate([boxWidth/2,-1,3.5])rotate ([90,0,0])cylinder( h = 10, d= 28.8,center = true);
     // mounting holes short sides
    translate([1.3*M2ScrewHole,-2.5-wall,-boxHeight/2+wall]) rotate([0,90,90])cylinder(h=5, d2=insidehole, d1 =outsidehole); 
    translate([boxWidth -1.3*M2ScrewHole,-2.5-wall,-boxHeight/2+wall]) rotate([0,90,90])cylinder(h=5, d2=insidehole, d1 =outsidehole);
        
    translate([1.3*M2ScrewHole,boxLenght+5-wall+0.9,-boxHeight/2+wall]) rotate([0,90,-90])cylinder(h=5, d2=insidehole, d1 =outsidehole); 
    translate([boxWidth -1.8*M2ScrewHole,boxLenght+5-wall+0.9,-boxHeight/2+wall]) rotate([0,90,-90])cylinder(h=5, d2=insidehole, d1 =outsidehole);
        // MOUNTING  long side
        //front left
    translate([-4.4,3,-boxHeight/2+wall]) rotate([0,90,0])cylinder(h=5, d2=insidehole, d1 =outsidehole); 
  // back left
    translate([boxWidth+ 1.3*M2ScrewHole+0.7,3,-boxHeight/2+wall]) rotate([0,90,180])cylinder(h=5, d2=insidehole, d1 =outsidehole); 
     //front right
    translate([-4.4,boxLenght-4,-boxHeight/2+wall]) rotate([0,90,0])cylinder(h=5, d2=insidehole, d1 =outsidehole); 
// back right   
   translate([boxWidth+ 1.3*M2ScrewHole +0.7,boxLenght-4,-boxHeight/2+wall]) rotate([0,90,180])cylinder(h=5, d2=insidehole, d1 =outsidehole);  
// top mounting indents  top will have balls taht mate with these holes
// 1
//translate([-wall/2,-wall/2,-0.5]) sphere(topmountingindent);
//2
//translate([-wall,boxLenght-8,-0.5]) sphere(topmountingindent);
//3
//translate([boxWidth,-wall/2,-0.5]) sphere(topmountingindent);
//4
 //translate([boxWidth+wall/2,boxLenght-8,-0.5]) sphere(topmountingindent);

    }
}

module microHDMIHole(){
    
translate([-4,21.5,-microHDMIz+microHDMIholeheight/2]) rotate ([0,90,0]) linear_extrude(height = 10) polygon(points=[[0,0],[1.5,0],[3.4,0],[3.4,8.5], [1.5,8.5],[0,7],[0,1.5],[1.5,0]]);
    translate([-4,35.0,-microHDMIz+microHDMIholeheight/2]) rotate ([0,90,0]) linear_extrude(height = 10) polygon(points=[[0,0],[1.5,0],[3.4,0],[3.4,8.5], [1.5,8.5],[0,7],[0,1.5],[1.5,0]]);
}
module USB_C(){
translate([-4,USB_C_Y,-usbCHeightz-USB_C_Z]) rotate ([0,90,0]) cylinder(h=5,d=usbCHeight);
    translate([-4,usbCwidth-usbCHeight+USB_C_Y,-usbCHeightz-USB_C_Z]) rotate ([0,90,0]) cylinder(h=5,d=usbCHeight);
    translate([-4,USB_C_Y,-usbCHeightz+usbCHeight/2-USB_C_Z]) rotate ([0,90,0]) cube([usbCHeight,usbCwidth-usbCHeight,5]);
}
module sideIndent(){
    indentLen = 57;
    indentheight = 3.6;
translate([-4,6,-usbCHeightz-USB_C_Z]) rotate ([0,90,0]) cylinder(h=2.5,d=2*indentheight);
 translate([-4,indentLen,-usbCHeightz-USB_C_Z]) rotate ([0,90,0]) cylinder(h=2.5,d=2*indentheight);
 translate([-4,6,indentheight/2-USB_C_Z+0.35]) rotate ([0,90,0]) cube([2*indentheight,indentLen-6,2.5]);
}


module pcbStandoff(){
//pcbmntdia = 2.75; // mounting holes
    /*pcbmnthead = 6.0; // countersunk
pcbmntthreads = 2.2;
    pcbmntheight
    */
pcbmnt1dx = pcb[0]/2 - 3.5;  // 
pcbmnt1dy = 3.5 - pcb[1]/2;
pcbmnt2dx = pcb[0]/2 - 3.5 - 58.0; // 
pcbmnt2dy = pcb[1]/2 - 3.5;
    module pcbstandoff(){
        difference(){
           cylinder( pcbmntheight ,d=pcbmnthead );
           translate([0,0,-0.01]) cylinder( pcbmntheight+1 , d=pcbmntthreads);     
        } 
    }
   translate([pcbmnt1x,pcbmnt1y,pcb[2]]) pcbstandoff();
   translate([pcbmnt2x,pcbmnt2y,pcb[2]]) pcbstandoff();
   translate([pcbmnt3x,pcbmnt3y,pcb[2]]) pcbstandoff();
   translate([pcbmnt4x,pcbmnt4y,pcb[2]]) pcbstandoff();
}

module rpi4Bottom(){
difference(){
    difference(){
    minkowski(){
        cube([boxWidth,boxLenght, boxHeight ], center =true);
      sphere(cornerRadius);  
    }
    // chop off top
   // translate([0,0,boxHeight/2]) cube([boxWidth+doubleradius+1,boxLenght+doubleradius+1, boxHeight ], center =true);
     translate([0,0,boxHeight-cornerRadius]) cube([boxWidth+doubleradius+1,boxLenght+doubleradius+1, boxHeight ], center =true);
    
    // hollow inside
    
    minkowski(){
        cube([boxWidth-doubleWall,boxLenght-doubleWall, boxHeight-doubleWall ], center =true);
        sphere(cornerRadius);  
    }
}
// remove vent holes leaving room for supports
// the x translate is related to the i in the module, 4 is the same as the param in the module call, same for y


// tbd translate([-4*(4+1.2),-6*(4+1.2),boxHeight/2]) botttomVentilation(4,3);

//front vent
translate([-boxWidth/2+7.5,boxLenght/2,-boxHeight/2+3])VentilationLine(4,3,11);
// FRONT side vent
translate([-boxWidth/2-1,-boxLenght/2+9,-boxHeight/2+3])rotate([0,0,90])VentilationLine(4,3,17);
translate([-boxWidth/2-1,-boxLenght/2+9,-boxHeight/2+3+4])rotate([0,0,90])VentilationLine(4,3,16);
translate([-boxWidth/2-1,-boxLenght/2+9,-boxHeight/2+3+8])rotate([0,0,90])VentilationLine(4,3,16);
translate([-boxWidth/2-1,-boxLenght/2+9,-boxHeight/2+3+12])rotate([0,0,90])VentilationLine(4,3,16);
// BACK side vent
translate([boxWidth/2+1,-boxLenght/2+9.5,-boxHeight/2+3])rotate([0,0,90])VentilationLine(4,3,17);
translate([boxWidth/2+1,-boxLenght/2+9.5,-boxHeight/2+3+4])rotate([0,0,90])VentilationLine(4,3,17);
translate([boxWidth/2+1,-boxLenght/2+9.5,-boxHeight/2+3+8])rotate([0,0,90])VentilationLine(4,3,16);
translate([boxWidth/2+1,-boxLenght/2+9.5,-boxHeight/2+3+12])rotate([0,0,90])VentilationLine(4,3,16);
translate([boxWidth/2+1,-boxLenght/2+9.5,-boxHeight/2+3+16])rotate([0,0,90])VentilationLine(4,3,16);
// top slot for touch screen
translate([boxWidth/4-1.7,-boxLenght/2+3,-boxHeight/1.5])rotate([0,0,90])cube([3,25,16]);
// top slot for camera
translate([-boxWidth/2+25+0.7,3,-boxHeight/1.5])rotate([0,0,90])cube([3,25,16]);
// top slot for 40 pin header
translate([boxWidth/2-2,-boxLenght/2+4,-boxHeight/1.5])rotate([0,0,90])cube([56,7,16]);
     
}

// top slot filler 40 pin header
translate([boxWidth/2-3,-boxLenght/2+5,-boxHeight/1.715])rotate([0,0,90])cube([54,5,2]);
translate([boxWidth/2-2,-boxLenght/2+5+8,-boxHeight/1.715])rotate([0,0,90])cube([1.5,8,2]);
translate([boxWidth/2-2,+6,-boxHeight/1.715])rotate([0,0,90])cube([1.5,8,2]);

//translate([0,boxLenght/2-9,boxHeight/2+0.7]) rotate([0,180,0]) linear_extrude(1.5)  text("COOLAPI", size =6.2,font= "Ariel:style= Bold", halign="center");
//translate([0,3-boxLenght/2,boxHeight/2+0.7]) rotate([0,180,0]) linear_extrude(1.5)  text("SEENOV", size =6.2,font= "Ariel:style= Bold", halign="center");
}

module botttomVentilation(a,b){
    // works for diam b = 4, try to get odd number of holes so one hole is in center 0,0. then translate to center whole thing
    for(i=[0:b+1.2:11*(b+1.2)]){
        for(j=[0:b+1.2:16*(b+1.2)]){
            translate([i,j,0])cylinder(h=a,d=b,center = true);   
    }
}
  
}
module VentilationLine(a,b,l){
    // works for diam b = 4, try to get odd number of holes so one hole is in center 0,0. then translate to center whole thing
    for(i=[0:b+1.2:l*(b+1.2)]){
       
            rotate([90,0,0]) translate([i,0,0])cylinder(h=a,d=b,center = true);   
    
}
  
}
 module fanmounting(lenght1){
   fanwidth = 30;
     fanthickness = 10.8+2;
     fanmnthole = 2.6;
     fanwall=2.4;
     
     difference(){
       rotate([0,0,0]) translate([0,0,-fanwall])cube([fanwidth+2*fanwall,lenght1+2*fanwall, fanthickness+fanwall ], center =true);  
         rotate([0,0,0]) translate([0,0,-1])cube([fanwidth,lenght1+2.5*fanwall, fanthickness ], center =true); 
         
         rotate([0,0,0]) translate([0,0,-3])cube([fanwidth-2*fanwall,lenght1+2.5*fanwall, 18 ], center =true);     
 }
 translate([fanwidth/2-fanwall,fanwidth/2-11.7,fanthickness/3.5])sphere(d=fanmnthole);
 }

module pcbSnaps(){
    difference(){
    union(){
    cylinder( h = 1.8+2*pcb[2], d1= pcbmntdia, d2= pcbmntdia-0.1, center = true);
    translate([0,0,-2])cylinder( h = 4, d= pcbmntdia+2, center = true);
    translate([-pcbmntdia/3,0,1.3+pcb[2]/2])sphere(d=pcbmntdia/2);
    translate([pcbmntdia/3,0,1.3+pcb[2]/2])sphere(d=pcbmntdia/2);
    }
    translate([-0.35,-pcbmntdia,-2])cube([0.7,6,8]);
}
}

module mountingflat1(){
     difference(){
          translate([0,0,0])cylinder( h = 6, d= 3.8*M2ScrewHole, center = true);
         translate([0,0,-0.1])cylinder( h = 6.5, d= M2ScrewHole+1, center = true);
     }
    translate([1.3*M2ScrewHole,0,-1.1]) rotate([0,90,0])cylinder(h=8, d1=3.4, d2 =2.9);  
}
module sidetopbottomclips(){
    clipdiam= 3.5;
    cliplen = 12;
     difference(){
         union(){
    cylinder( h =cliplen, d= clipdiam);
    translate([0,0,0])sphere(d=clipdiam);
    translate([0,0,cliplen])sphere(d=clipdiam);
         }
        rotate([0,0,0]) translate([clipdiam-3.5,-4,-4])cube([8,8,20]);  
         
     }
    translate([clipdiam-3.7,0,-0.3])sphere(d=3);
}
module cornertopbottomclips(){
    clipdiam= 3.5;
    cliplen = 12;
    difference(){
         union(){
    cylinder( h =cliplen, d= clipdiam);
    translate([0,0,0])sphere(d=clipdiam);
    translate([0,0,cliplen])sphere(d=clipdiam);
         }
        rotate([0,0,0]) translate([clipdiam-2,0,-4])cylinder( h =4*cliplen, d= 3.5);  
         
     }
    translate([clipdiam-3.3,0,-0.3])sphere(d=3.0);
}

//mountingflat1();
// fan
//translate([13,-13.3,-15]) rotate ([0,0,0]) cube([30,10.6,30]);
// for test
 //translate([0,0,4]) pcbSnaps();
// measurement
 //translate([40.2,-25,1.2])cube([0.2,1,1.47]);


 
