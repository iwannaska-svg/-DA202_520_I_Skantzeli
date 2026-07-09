(
// =======================================================
// Midnight Dialogue
// Jazz Electroacoustic Composition
// Part 1 - Foundation
// =======================================================

s.waitForBoot({

TempoClock.default.tempo = 95/60;


// =======================================================
// Jazz Piano
// =======================================================

SynthDef(\jazzPiano, {

    |out=0, freq=440, amp=0.18, gate=1, pan=0|

    var sig;
    var env;


    env =
    EnvGen.kr(
        Env.adsr(
            0.02,
            0.4,
            0.6,
            3
        ),
        gate,
        doneAction:2
    );


    sig =
    Mix([
        SinOsc.ar(freq),
        SinOsc.ar(freq*2, 0, 0.25),
        Saw.ar(freq,0.08)
    ]);


    sig =
    LPF.ar(
        sig,
        2500
    );


    sig =
    FreeVerb.ar(
        sig,
        mix:0.3,
        room:0.8,
        damp:0.5
    );


    Out.ar(
        out,
        Pan2.ar(
            sig*env*amp,
            pan
        )
    );


}).add;



// =======================================================
// Warm Jazz Bass
// =======================================================

SynthDef(\jazzBass, {

    |out=0, freq=110, amp=0.12|

    var sig;
    var env;


    env =
    EnvGen.kr(
        Env.perc(
            0.01,
            1.5
        ),
        doneAction:2
    );


    sig =
    Mix([
        SinOsc.ar(freq),
        Saw.ar(freq,0.15)
    ]);


    sig =
    LPF.ar(
        sig,
        700
    );


    sig =
    sig * env * amp;


    Out.ar(
        out,
        Pan2.ar(
            sig,
            -0.25
        )
    );


}).add;



s.sync;


// =======================================================
// Harmonic Material
// =======================================================


~chords = [

    // Dm7
    [62,65,69,72],

    // G7
    [67,71,74,77],

    // Cmaj7
    [60,64,67,71],

    // Am7
    [57,60,64,67]

];


// Theme material

~theme = [

69,71,72,74,
76,74,72,69,


67,69,71,72,
74,72,69,67

];



"Midnight Dialogue - Part 1 loaded".postln;


});
)


(
// =======================================================
// Part 2 - Intro + Jazz Theme
// =======================================================


Pdef(\theme,

Pbind(

\instrument,\jazzPiano,


\midinote,

Pseq([

    // Intro chords

    [62,65,69,72],
    [67,71,74,77],
    [60,64,67,71],
    [57,60,64,67],


    // Theme melody

    69,71,72,74,
    76,74,72,69,

    67,69,71,72,
    74,72,69,67


],4),



\dur,

Pseq([

    2,2,2,2,

    0.5,0.5,1,1,
    0.5,0.5,1,1

],1),



\amp,

0.18,


\legato,

0.8


)

);

)


(
// =======================================================
// Part 3 - Walking Bass
// =======================================================

Pdef(\walkingBass,

Pbind(

\instrument,\jazzBass,

\midinote,

Pseq([

50,53,57,60,
55,59,62,65,
48,52,55,59,
45,48,52,55

],inf),

\dur,
0.5,

\amp,
0.10

)

);

)



(
// =======================================================
// Part 5 - Jazz Piano Improvisation
// =======================================================


Pdef(\solo,

Pbind(

\instrument,\jazzPiano,


\midinote,

Pseq([

    // Dm7 phrase
    74,72,69,65,
    69,72,74,77,

    // G7 phrase
    74,71,67,71,
    74,77,79,74,

    // Cmaj7 phrase
    72,71,67,64,
    67,71,76,72,

    // Am7 phrase
    69,72,76,79,
    76,72,69,67


],2),



\dur,

Pseq([

0.5,0.5,1,1,
0.5,0.5,1,1,

0.5,0.5,1,1,
0.5,0.5,1,1

],inf),



\amp,

0.16,


\legato,

0.7


)

);

)


(
// =======================================================
// Part 6 - Jazz Bridge
// =======================================================


Pdef(\bridge,

Pbind(

\instrument,\jazzPiano,


\midinote,

Pseq([

    // Fmaj7 color

    72,76,79,81,
    79,76,72,69,


    // Em7 color

    71,74,76,79,
    76,74,71,67,


    // A7 tension

    69,73,76,79,
    76,73,69,66,


    // Return preparation

    67,71,74,77,
    74,71,67,64


],2),



\dur,

Pseq([

0.5,0.5,1,1,
0.5,0.5,1,1

],inf),



\amp,

0.15,


\legato,

0.8


)

);

)

(
// =======================================================
// Part 7 - Return Theme + Ending
// =======================================================


Pdef(\returnTheme,

Pbind(

\instrument,\jazzPiano,


\midinote,

Pseq([

    // Return to Dm7

    69,71,72,74,
    76,74,72,69,


    // Closing phrase

    67,69,71,72,
    74,72,69,65,


    // Final chord tones

    62,65,69,72,
    62,65,69,74


],2),



\dur,

Pseq([

0.5,0.5,1,1,
0.5,0.5,1,1

],inf),



\amp,

Pseq([

0.16,0.15,
0.14,0.12,
0.10,0.08,
0.06,0.04

],inf),



\legato,

0.9


)

);

)

(
// =======================================================
// Part 8 - Electroacoustic Atmosphere
// =======================================================

SynthDef(\midnightAtmosphere, {

    |out=0, amp=0.04|

    var sig;
    var freq;


    freq =
    LFNoise2.kr(0.05)
    .range(300,900);


    sig =
    SinOsc.ar(
        freq,
        0,
        0.15
    );


    sig =
    sig +
    (
        PinkNoise.ar(0.03)
        *
        LFNoise1.kr(0.1).range(0,1)
    );


    sig =
    BPF.ar(
        sig,
        freq,
        0.3
    );


    sig =
    FreeVerb.ar(
        sig,
        mix:0.6,
        room:0.9,
        damp:0.6
    );


    Out.ar(
        out,
        sig * amp ! 2
    );


}).add;



s.sync;


~midnightAir =
Synth(
    \midnightAtmosphere,
    [
        \amp,0.04
    ]
);


)


(
// =======================================================
// FINAL PERFORMANCE
// Midnight Dialogue
// =======================================================

Routine({

    // Atmosphere
    ~midnightAir = Synth(
        \midnightAtmosphere,
        [\amp,0.015
        ]
    );


    // Intro / Theme
    Pdef(\theme).play;

    16.wait;


    // Bass + Rhythm enter
    Pdef(\walkingBass).play;
    Pdef(\jazzPulse).play;

    32.wait;


    // Solo
    Pdef(\solo).play;

    32.wait;


    // Bridge
    Pdef(\bridge).play;

    32.wait;


    // Return
    Pdef(\returnTheme).play;
~midnightAir.free;
Pdef(\walkingBass).stop;
Pdef(\jazzPulse).stop;
}).play;

)

