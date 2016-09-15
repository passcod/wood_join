/* ******** FREE VAR ******** */

// Length of wood dedicated to the join
join_length = 40;

// Length of wood shown beyond the join
extra_length = 30;

// Size of wood
height = 4;
width =  6;

// Length of "wings" — must be less than
// (join_length - height) / 2
wing_length = 16;

// Used to make things bigger so boolean
// operations apply more cleanly
tolerance = 2;

/* ******** COMPUTED ******** */

total_length = join_length + extra_length;
side_width = width / 3;
wing_height = height / 2;

/* ********  THINGS  ******** */

module wood() {
    cube([
        join_length + extra_length,
        width,
        height
    ]);
}

module _wing_clip() {
    diagon = sqrt(2 * wing_height * wing_height);

    translate([
        -diagon / 2,
        0,
        -diagon / 8
    ]) rotate([
        0,
        45,
        0
    ]) cube([
        wing_height,
        width + tolerance * 2,
        wing_height
    ]);
}

module _wing() {
    translate([
        extra_length,
        -tolerance,
        wing_height
    ]) cube([
        wing_length,
        width + tolerance * 2,
        wing_height
    ]);
}

module _side(y) {
    difference() {
        translate([
            extra_length,
            y - tolerance,
            -tolerance
        ]) cube([
            join_length + tolerance,
            side_width + tolerance,
            height + tolerance * 2
        ]);

        _wing();

        translate ([
            join_length - wing_length,
            0,
            -wing_height
        ]) _wing();
    }
}

module _sideA() {
    _side(0);
}

module _sideB() {
    _side(2 * side_width + tolerance);
}


module partA() {
    color("white") difference() {
        wood();
        _sideA();
        _sideB();
    }
}

module partB() {
    color("blue") difference() {
        translate([
            extra_length,
            0,
            0
        ]) wood();

        partA();
    }
}


module side_by_side() {
    partA();

    translate([
        0,
        -width * 2,
        0
    ]) partB();
}

module insertion_before() {
    partA();

    translate([
        extra_length + wing_length / 1.5,
        0,
        -wing_length
    ]) rotate([
        0,
        -60,
        0
    ]) partB();
}


module insertion_during() {
    partA();

    translate([
        extra_length,
        0,
        -(extra_length + wing_length / 2)
    ]) rotate([
        0,
        -60,
        0
    ]) partB();
}

module insertion_after() {
    partA();

    translate([
        2,
        0,
        -wing_length + 3
    ]) rotate([
        0,
        -15,
        0
    ]) partB();
}

side_by_side();
//insertion_before();
//insertion_during();
//insertion_after();
