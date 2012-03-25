// Filament clip

ol = 40;     // Overall length
ow = 10;     // Overall width
oh = 4;      // Overall height
cr = 3;      // Corner radius
d1 = 4;      // Diameter of filament
d2 = 3;      // Diameter of clip entry
d3 = 20;     // Diameter of finger grip
d4 = 11;     // Diamater of finger grip hole

module RoundedRectPlate(l, w, h, r)
{
    translate([0,0,h/2])
    {
        cube(size = [l,w-2*r,h], center = true);
        cube(size = [l-2*r,w,h], center = true);
    }
    for (dx = [-(l/2-r),(l/2-r)])
    {
        for (dy = [-(w/2-r),(w/2-r)])
        {
            translate([dx,dy,0]) cylinder(r=r, h=h);
        }
    }
}

module CutoutHole(x,y,r,h)
{
    delta = 0.5;
    translate([x,y,-delta]) cylinder(r=r,h=h+2*delta,$fs=0.5);
}

// dir: 0: +x
//      1: +y
//      2: -x
//      3: -y
module FilamentJaw(pos,dir,fd,fe,h)
{
    translate(pos)
    {
        rotate([0,0,dir*90])
        {
            CutoutHole(-fd*0.7, 0, fd/2, h);
            CutoutHole(    0, 0, fe/2, h);
        }
    }
}


difference()
{
    union()
    {
        RoundedRectPlate(ol, ow, oh, cr );
        translate([0,ow/2,0]) cylinder(r=d3/2, h=oh);
    }
    CutoutHole(0, ow/2, d4/2, oh);
    FilamentJaw([ ol/2,0,0], 0, d1, d2, oh);
    FilamentJaw([-ol/2,0,0], 2, d1, d2, oh);
    FilamentJaw([ ol/4,-ow/2,0],3,d1,d2,oh);
    FilamentJaw([-ol/4,-ow/2,0],3,d1,d2,oh);
}
