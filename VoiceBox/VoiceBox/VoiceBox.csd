<CsoundSynthesizer>
<CsOptions>
-i adc
-o dac
-d
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 10
nchnls = 2
0dbfs = 1.0


garvb init 0
gagrain init 0


instr 1;Helium

ainL, ainR ins

fftin1 pvsanal  ainL,    1024,
                256,    1024,   1

ftps  pvscale fftin1, 2

aout pvsynth ftps
aout1 clip aout, 0, .99
garvb += (aout1)
gagrain += (aout1)
out (aout1),(aout1)

endin

        //instr 2//
instr 2;Dry with Effects
ainL, ainR ins


aout1 clfilt ainL, 120, 1, 2


garvb += (aout1)
gagrain += (aout1)
out (aout1),(aout1)

endin

        //instr 3//
instr 3;Low Voice
ainL, ainR ins

fftin1 pvsanal  ainL,    1024,
256,    1024,   1

ftps  pvscale fftin1, .8

aout1 pvsynth ftps
asig1 clfilt aout1, 120, 1, 2
asig clip asig1, 0, .99

garvb += (asig)
gagrain += (asig)
out (asig),(asig)

endin
        //instr 4//
instr 4;MorphingPitch

ktest02        chnget    "ptrTest1"
ktest2        port    ktest02, 0.01
ktest22 = ktest2 * 2.5
ainL, ainR ins

fftin1 pvsanal  ainL,    1024,
256,    1024,   1

ftps  pvscale fftin1, ktest22

aout pvsynth ftps
aout1 clip aout, 0, .99

garvb += (aout1) + ainL
gagrain += (aout1) + ainL
out (aout1)+ainL,(aout1)+ainL

endin

instr 100
ktest        chnget    "ptrTest2copy"
ktest1         port     ktest, 0.01
ktest3copy0    chnget    "ptrTest3copy"
ktest3copy        port    ktest3copy0, 0.01

avL, avR  reverbsc        garvb,      garvb,     ktest1,     12000
acL       clip    avL, 0, .99
acR       clip    avR, 0, .99
outs             acL*ktest3copy,      acR*ktest3copy
clear           garvb
endin

;gagrain
instr 101

ktest0        chnget    "ptrTest"
ktest        port    ktest0, 0.01

ktest03        chnget    "ptrTest3"
ktest3        port    ktest03, 0.01
ktest02          chnget "ptrTest1copy"
ktest2         port    ktest02, 0.01

abuf        delayr  1
adelLL       deltap .4 * (ktest2 * .5)
adelMM       deltap 1 * ktest
delayw  gagrain + (adelLL * 0.65)

abuf2       delayr  1

adelRR       deltap  (ktest - 0.05)
delayw  gagrain + (adelRR * 0.6)

adelL clip adelLL, 0, .99
adelM clip adelMM, 0, .99
adelR clip adelRR, 0, .99

outs (adelL + adelM)*ktest3, (adelR + adelM)*ktest3

clear gagrain
endin


</CsInstruments>
<CsScore>
f0 z
i100 0 -1
i101 0 -1
</CsScore>
</CsoundSynthesizer>
