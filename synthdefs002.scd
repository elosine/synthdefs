//Only Modulatable args get metadata
//Add Variants

(

    ///////////////////////////////////////
   ////                              /////
  ////    \petalsOfResonance        /////
 ////                              /////
///////////////////////////////////////
SynthDef("petalsOfResonance", {
	arg masteramp= -6, inamp=0.0, ibs=0, obs=0, kbs, fund=200, firstPartial=2, bank2MidiOffset=0.25, spread=0.33, ringL1=7.75, ringL2=9.5;
	var	pAmp, partialTunedA, partialTunedB, input, output, rms, outArrayA, outArrayA1, outArrayA2, outArray, ltdOutput, masterEnv, finalOut,
	p1a, p2a, p3a, p4a, p5a, p6a, p7a, p8a, p9a, p10a, p11a, p12a, p13a,
	p1b, p2b, p3b, p4b, p5b, p6b, p7b, p8b, p9b, p10b, p11b, p12b, p13b,
	resA1, resA2, resA3, resA4, resA5, resA6, resA7, resA8, resA9, resA10, resA11, resA12, resA13,
	resB1, resB2, resB3, resB4, resB5, resB6, resB7, resB8, resB9, resB10, resB11, resB12, resB13;

	pAmp = -40.dbamp;

	//Two functions to create two sets of partials
	partialTunedA = 	{
		arg partialNum;
		var freq, freqMidi, tuner, freqTunedMidi, freqTuned;
		//firstPartial allows you to start the series at a higher partial than the fund
		//the fund and spread work together (maybe redundantly)
		//to determine the space between each partial
		freq = fund *( firstPartial + (spread*partialNum) );
		freqMidi = freq.cpsmidi;
		//constantly shifting tuner for each partial
		//so the sound is constantly shifting
		tuner = SinOsc.kr(rrand(0.07, 0.013), 0, 0.5);
		freqTunedMidi = freqMidi + tuner;
		freqTuned = freqTunedMidi.midicps;
	};

	partialTunedB = 	{
		arg partialNum;
		var freq, freqMidi, tuner, freqTunedMidi, freqTuned;
		freq = fund *( firstPartial + (spread*partialNum) );
		freqMidi = freq.cpsmidi;
		tuner = SinOsc.kr(rrand(0.07, 0.013), 0, 0.5);
		freqTunedMidi = freqMidi + tuner + bank2MidiOffset;
		freqTuned = freqTunedMidi.midicps;
	};

	p1a= partialTunedA.value(0);
	p2a= partialTunedA.value(1);
	p3a= partialTunedA.value(2);
	p4a= partialTunedA.value(3);
	p5a= partialTunedA.value(4);
	p6a= partialTunedA.value(5);
	p7a= partialTunedA.value(6);
	p8a= partialTunedA.value(7);
	p9a= partialTunedA.value(8);
	p10a= partialTunedA.value(9);
	p11a= partialTunedA.value(10);
	p12a= partialTunedA.value(11);
	p13a= partialTunedA.value(12);

	p1b= partialTunedB.value(0);
	p2b= partialTunedB.value(1);
	p3b= partialTunedB.value(2);
	p4b= partialTunedB.value(3);
	p5b= partialTunedB.value(4);
	p6b= partialTunedB.value(5);
	p7b= partialTunedB.value(6);
	p8b= partialTunedB.value(7);
	p9b= partialTunedB.value(8);
	p10b= partialTunedB.value(9);
	p11b= partialTunedB.value(10);
	p12b= partialTunedB.value(11);
	p13b= partialTunedB.value(12);

	input = In.ar(ibs);
	input =  input * inamp.dbamp;

	//Form 13 resonators for each bank/spectrum
	resA1 = DynKlank.ar(`[[p1a], nil, [rrand(ringL1, ringL2)]], input);
	resA2 = DynKlank.ar(`[[p2a], nil, [rrand(ringL1, ringL2)]], input);
	resA3 = DynKlank.ar(`[[p3a], nil, [rrand(ringL1, ringL2)]], input);
	resA4 = DynKlank.ar(`[[p4a], nil, [rrand(ringL1, ringL2)]], input);
	resA5 = DynKlank.ar(`[[p5a], nil, [rrand(ringL1, ringL2)]], input);
	resA6 = DynKlank.ar(`[[p6a], nil, [rrand(ringL1, ringL2)]], input);
	resA7 = DynKlank.ar(`[[p7a], nil, [rrand(ringL1, ringL2)]], input);
	resA8 = DynKlank.ar(`[[p8a], nil, [rrand(ringL1, ringL2)]], input);
	resA9 = DynKlank.ar(`[[p9a], nil, [rrand(ringL1, ringL2)]], input);
	resA10 = DynKlank.ar(`[[p10a], nil, [rrand(ringL1, ringL2)]], input);
	resA11 = DynKlank.ar(`[[p11a], nil, [rrand(ringL1, ringL2)]], input);
	resA12 = DynKlank.ar(`[[p12a], nil, [rrand(ringL1, ringL2)]], input);
	resA13 = DynKlank.ar(`[[p13a], nil, [rrand(ringL1, ringL2)]], input);

	resB1 = DynKlank.ar(`[[p1b], nil, [rrand(ringL1, ringL2)]], input);
	resB2 = DynKlank.ar(`[[p2b], nil, [rrand(ringL1, ringL2)]], input);
	resB3 = DynKlank.ar(`[[p3b], nil, [rrand(ringL1, ringL2)]], input);
	resB4 = DynKlank.ar(`[[p4b], nil, [rrand(ringL1, ringL2)]], input);
	resB5 = DynKlank.ar(`[[p5b], nil, [rrand(ringL1, ringL2)]], input);
	resB6 = DynKlank.ar(`[[p6b], nil, [rrand(ringL1, ringL2)]], input);
	resB7 = DynKlank.ar(`[[p7b], nil, [rrand(ringL1, ringL2)]], input);
	resB8 = DynKlank.ar(`[[p8b], nil, [rrand(ringL1, ringL2)]], input);
	resB9 = DynKlank.ar(`[[p9b], nil, [rrand(ringL1, ringL2)]], input);
	resB10 = DynKlank.ar(`[[p10b], nil, [rrand(ringL1, ringL2)]], input);
	resB11 = DynKlank.ar(`[[p11b], nil, [rrand(ringL1, ringL2)]], input);
	resB12 = DynKlank.ar(`[[p12b], nil, [rrand(ringL1, ringL2)]], input);
	resB13 = DynKlank.ar(`[[p13b], nil, [rrand(ringL1, ringL2)]], input);

	//Make an array of resonators and scramble them up
	outArrayA = [ resA1*pAmp, resA2*pAmp, resA3*pAmp, resA4*pAmp, resA5*pAmp, resA6*pAmp, resA7*pAmp, resA8*pAmp, resA9*pAmp, resA10*pAmp,
		resA11*pAmp, resA12*pAmp, resA13*pAmp, resB1*pAmp, resB2*pAmp, resB3*pAmp, resB4*pAmp, resB5*pAmp, resB6*pAmp, resB7*pAmp,
		resB8*pAmp, resB9*pAmp, resB10*pAmp, resB11*pAmp, resB12*pAmp, resB13*pAmp ].scramble;

	//For Stereo or Multichannel
	//outArrayA1 = outArrayA.copyRange(0, (outArrayA.size/2).asInteger);
	//outArrayA2 = outArrayA.copyRange((outArrayA.size/2).asInteger, outArray.size);
	//outArrayA1 = Mix.ar(outArrayA1);
	//outArrayA2 = Mix.ar(outArrayA2);

	//Mixes resonators to a mono channel
	outArrayA = Mix.ar(outArrayA);

	ltdOutput = Limiter.ar(outArrayA, 0.98, 0.01);
	ltdOutput = ltdOutput*masteramp.dbamp;

	rms = Amplitude.kr(ltdOutput).ampdb.linlin(-80.0, 0.0, 0.0, 1.0);
	Out.kr(kbs, rms); //send rms amplitude measure to a control bus

	Out.ar(obs, ltdOutput);

	},
	metadata: (
		specs: (
			masteramp: ControlSpec(-120.0, 18, \lin, default: -6.0, units: "db"),
			inamp: ControlSpec(-120.0, 18, \lin, default: 0.0, units: "db"),
			fund: ControlSpec(20, 20000, \exp, 0, 440, units: " Hz"),
			firstPartial: ControlSpec(0, 99, \lin, default: 0, units: "partial"),
			bank2MidiOffset: ControlSpec(-36.0, 36.0, \lin, default: 0, units: "midioffset"),
			spread: ControlSpec(0, 12, \lin, default: 1, units: "spread"),
			ringL1: ControlSpec(0.1, 49, \lin, default: 5, units: "seconds"),
			ringL2: ControlSpec(0.1, 49, \lin, default: 9, units: "seconds")
		)
	),
	variants:(
	)
).add;

    ///////////////////////////////////////
   ////                              /////
  ////       \audioin_mono          /////
 ////                              /////
///////////////////////////////////////
SynthDef( \audioin_mono, {
	arg ibs, obs, kbs, amp=0, gate=1;
	var in, rms, env;
	in = SoundIn.ar(ibs)*amp.dbamp;
	env = EnvGen.ar(Env.adsr(\atk.kr(0.001, 0), \decay.kr(0, 0), \suslev.kr(1.0, 0), \rel.kr(0.01, 0), curve:\crv.kr(0, 0) ), gate);
	rms = Amplitude.kr(in*env);
	Out.kr(kbs, rms); //send rms amplitude measure to a control bus
	Out.ar(obs, in*env)
	},
	metadata: (
		specs: (
			amp: ControlSpec(-120, 18, \lin, default: 0.0, units: "db"),
			atk: ControlSpec(0.0, 9, \lin, units: "sec"),
			decay: ControlSpec(0.0, 9, \lin, units: "sec"),
			suslev: ControlSpec(0.0, 1.0, \lin),
			rel: ControlSpec(0.0, 9, \lin, units: "sec"),
			crv: ControlSpec(-9, 9, \lin, units: "crv")
		)
	),
	variants:(
	)
).add;

    ///////////////////////////////////////
   ////                              /////
  ////       \audioin_mono_tr       /////
 ////                              /////
///////////////////////////////////////
SynthDef( \audioin_mono_tr, {
	arg gate=0, ibs, obs, kbs, amp=0;
	var in, rms, env;
	in = SoundIn.ar(ibs)*amp.dbamp;
	env = EnvGen.ar( Env.linen( \atk.kr(0.001, 0), \sus.kr(1.0, 0), \rel.kr(0.01, 0), curve:\crv.kr(0, 0) ), gate);
	rms = Amplitude.kr(in*env);
	Out.kr(kbs, rms); //send rms amplitude measure to a control bus
	Out.ar(obs, in*env)
	},
	rates: [\tr, 0],
	metadata: (
		specs: (
			amp: ControlSpec(-120, 18, \lin, default: 0.0, units: "db"),
			atk: ControlSpec(0.0, 9, \lin, units: "sec"),
			sus: ControlSpec(0.0, 1.0, \lin),
			rel: ControlSpec(0.0, 9, \lin, units: "sec"),
			crv: ControlSpec(-9, 9, \lin, units: "crv")
		)
	),
	variants:(
	)
).add;

    ///////////////////////////////////////
   ////                              /////
  ////       \audioOut_mono         /////
 ////                              /////
///////////////////////////////////////
SynthDef( \audioOut_mono, {
	arg ibs, obs, kbs, amp=0;
	var in, rms;
	in = In.ar(ibs)*amp.dbamp;
	rms = Amplitude.kr(in).ampdb.linlin(-80.0, 0.0, 0.0, 1.0);
	Out.kr(kbs, rms); //send rms amplitude measure to a control bus
	Out.ar(obs, in)
	},
	metadata: (
		specs: (
			amp: ControlSpec(-120.0, 18, \lin, default: 0.0, units: "db")
		)
	),
	variants: (
	)
).add;


    ///////////////////////////////////////
   ////                              /////
  ////      \audioOut_stereo        /////
 ////                              /////
///////////////////////////////////////
SynthDef( \audioOut_stereo, {
	arg ibs1, ibs2, obs, kbs, amp=0;
	var in, rms;
	in = In.ar([ibs1, ibs2])*amp.dbamp;
	rms = Amplitude.kr(in).ampdb.linlin(-80.0, 0.0, 0.0, 1.0);
	Out.kr(kbs, rms); //send rms amplitude measure to a control bus
	Out.ar(obs, in)
	},
	metadata: (
		specs: (
			amp: ControlSpec(-120.0, 18, \lin, default: 0.0, units: "db")
		)
	),
	variants: (
	)
).add;


    ///////////////////////////////////////
   ////                              /////
  ////         \ringmod_sine        /////
 ////                              /////
///////////////////////////////////////
SynthDef(\ringmod, {
	arg ibs, obs, kbs, amp=0, pitch=60, pitchshift=0, rate=0;
	var rm, rms, in, mod, lfo, freq;
	in = In.ar(ibs);
	lfo = SinOsc.kr(rate).range(pitch-pitchshift, pitch+pitchshift);
	freq = lfo.midicps;
	mod = SinOsc.ar(freq);
	rm = DiodeRingMod.ar(in, mod)*amp.dbamp;
	rms = Amplitude.kr(rm);
	Out.kr(kbs, rms); //send rms amplitude measure to a control bus
	Out.ar(obs, rm)
	},
	metadata: (
		specs: (
			amp: ControlSpec(-120.0, 18, \lin, default: 0.0, units: "db"),
			pitch: ControlSpec(16, 136, \lin, units: "note"),
			pitchshift: ControlSpec(0, 24, \lin, units: "note"),
			rate: ControlSpec(0, 99, \lin, units: "hz")
		)
	),
	variants: (
	)
).add;

)



