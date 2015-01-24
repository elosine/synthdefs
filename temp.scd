

a = SynthDesc.read(SynthDef.synthDefDir++"petalsOfResonance"++".scsyndef")
a.[\petalsOfResonance2].controlNames[0]
a.[\petalsOfResonance2].controls.do{|it ix| it.name.postln}

k = ();
k[\ff] = [1,2]
k[\ff]

if(a[\petalsOfResonance].metadata[\specs][\fund].warp.asString == "a LinearWarp", {"yes".postln})

j = (\lo:123);

0.0001.ampdb
.dbamp
1.ampdb

-60.linlin(-inf


SynthDef(\ringmod, {
		arg obs, kbs, carbus, modbus, amp=1;
		var rm, rms;
		rm = DiodeRingMod.ar(In.ar(carbus), In.ar(modbus));
		rms = Amplitude.kr(rm).ampdb.linlin(-80.0, 0.0, 0.0, 1.0);
		Out.kr(kbs, rms); //send rms amplitude measure to a control bus
		Out.ar(obs, rm*amp);
	}, metadata:(specs:(amp:\amp))).load.store(mdPlugin:TextArchiveMDPlugin);

	f.store(mdPlugin:TextArchiveMDPlugin);

	