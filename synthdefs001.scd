(

    ///////////////////////////////////////
   ////                              /////
  ////    \petalsOfResonance        /////
 ////                              /////
///////////////////////////////////////
SynthDef("petalsOfResonance", {
	arg masteramp= -6, inamp=0.0, ibs=0, obs=0, kbs, fund=200, firstPartial=2, bank2MidiOffset=0.25, spread=0.33, ringL1=7.75, ringL2=9.5, inputLen=1;
	var	pAmp, partialTunedA, partialTunedB, input, output, rms, outArrayA, outArrayA1, outArrayA2, outArray, inenv, ltdOutput, masterEnv, finalOut,
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
	inenv = EnvGen.ar( Env.perc(0.02, inputLen, 1.0, -1), \t_tr.kr(0, 0.0001));
	input =  input * inamp.dbamp * inenv;
	//input = PinkNoise.ar(0.5) * Decay2.ar(Impulse.ar(0.15), 0.15, 0.75);

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

	}, metadata: (
		specs: (
			masteramp: ControlSpec(-120.0, 18, \lin, default: -6.0, units: "db"),
			inamp: ControlSpec(-120.0, 18, \lin, default: 0.0, units: "db"),
			ibs: ControlSpec(0, Server.default.options.numAudioBusChannels-1, step: 1),
			obs: ControlSpec(0, Server.default.options.numAudioBusChannels-1, step: 1),
			kbs: ControlSpec(0, Server.default.options.numControlBusChannels-1, step: 1),
			fund: ControlSpec(20, 20000, \exp, 0, 440, units: " Hz"),
			firstPartial: ControlSpec(0, 99, \lin, default: 0, units: "partial"),
			bank2MidiOffset: ControlSpec(-36.0, 36.0, \lin, default: 0, units: "midioffset"),
			spread: ControlSpec(0, 12, \lin, default: 1, units: "spread"),
			ringL1: ControlSpec(0.1, 49, \lin, default: 5, units: "seconds"),
			ringL2: ControlSpec(0.1, 49, \lin, default: 9, units: "seconds"),
			t_tr: ControlSpec(0, 1, \lin, default: 0, units: "trig"),
			inputLen: ControlSpec(0.03, 21, \lin, default: 1.3, units: "seconds")
	))
).load.store(mdPlugin:TextArchiveMDPlugin);


    ///////////////////////////////////////
   ////                              /////
  ////       \audioin_mono          /////
 ////                              /////
///////////////////////////////////////
SynthDef( \audioin_mono, {
	arg ibs, obs, kbs, amp=0;
	var in, rms, ampv;
	in = SoundIn.ar(ibs)*amp.dbamp;
	rms = Amplitude.kr(in);
	Out.kr(kbs, rms); //send rms amplitude measure to a control bus
	Out.ar(obs, in)
	}, metadata: (
		specs: (
			ibs: ControlSpec(0, 8, step: 1),
			obs: ControlSpec(0, Server.default.options.numAudioBusChannels-1, step: 1),
			kbs: ControlSpec(0, Server.default.options.numControlBusChannels-1, step: 1),
			amp: ControlSpec(-120, 18, \lin, default: 0.0, units: "db")
	))
).load.store(mdPlugin:TextArchiveMDPlugin);


    ///////////////////////////////////////
   ////                              /////
  ////       \audioOut_mono          /////
 ////                              /////
///////////////////////////////////////
SynthDef( \audioOut_mono, {
		arg ibs, obs, kbs, amp=0;
		var in, rms;
		in = In.ar(ibs)*amp.dbamp;
	rms = Amplitude.kr(in).ampdb.linlin(-80.0, 0.0, 0.0, 1.0);
		Out.kr(kbs, rms); //send rms amplitude measure to a control bus
		Out.ar(obs, in)
	}, metadata: (
		specs: (
			ibs: ControlSpec(0, Server.default.options.numAudioBusChannels-1, step: 1),
			obs: ControlSpec(0, 49, step: 1),
			kbs: ControlSpec(0, Server.default.options.numControlBusChannels-1, step: 1),
			amp: ControlSpec(-120.0, 18, \lin, default: 0.0, units: "db")
	))
).load.store(mdPlugin:TextArchiveMDPlugin);


    ///////////////////////////////////////
   ////                              /////
  ////      \audioOut_stereo        /////
 ////                              /////
///////////////////////////////////////
SynthDef( \audioOut_stereo, {
	arg ibs, obs, kbs, amp=1;
	var in, rms;
	in = In.ar([ibs, ibs+1])*amp.dbamp;
	rms = Amplitude.kr(in);
	Out.kr(kbs, rms); //send rms amplitude measure to a control bus
	Out.ar(obs, in)
	}, metadata: (
		specs: (
			ibs: ControlSpec(0, Server.default.options.numAudioBusChannels-1, step: 1),
			obs: ControlSpec(0, 49, step: 1),
			kbs: ControlSpec(0, Server.default.options.numControlBusChannels-1, step: 1),
			amp: ControlSpec(-120.0, 18, \lin, default: 0.0, units: "db")
	))
).load.store(mdPlugin:TextArchiveMDPlugin);


    ///////////////////////////////////////
   ////                              /////
  ////         \sineWlfo            /////
 ////                              /////
///////////////////////////////////////
SynthDef(\sineWlfo, {
	arg obs, kbs, rate=0, freqlo=300, freqhi=300, amp=0;
	var sig, lfo, rms;
	lfo = SinOsc.kr(rate).range(freqlo, freqhi);
	sig = SinOsc.ar(lfo);
	sig = sig*amp.dbamp;
	rms = Amplitude.kr(sig);
	Out.kr(kbs, rms); //send rms amplitude measure to a control bus
	Out.ar(obs, sig)
	}, metadata: (
		specs: (
			obs: ControlSpec(0, Server.default.options.numAudioBusChannels-1, step: 1),
			kbs: ControlSpec(0, Server.default.options.numControlBusChannels-1, step: 1),
			rate: ControlSpec(0, 99, \lin, default: 0.0, units: "Hz"),
			freqlo: ControlSpec(20, 20000, \exp, 0, 300, units: " Hz"),
			freqhi: ControlSpec(20, 20000, \exp, 0, 300, units: " Hz"),
			amp: ControlSpec(-120.0, 18, \lin, default: 0.0, units: "db")
	))
).load.store(mdPlugin:TextArchiveMDPlugin);


    ///////////////////////////////////////
   ////                              /////
  ////        \noiseBurst           /////
 ////                              /////
///////////////////////////////////////
SynthDef(\noiseBurst, {
		arg obs, kbs, rate=1.0, atk=0.03, decay=0.75, amp=0;
		var sig, rms;
		sig = PinkNoise.ar(0.5) * Decay2.ar( Impulse.ar(rate), atk, decay );
		sig = sig*amp.dbamp;
		rms = Amplitude.kr(sig);
		Out.kr(kbs, rms); //send rms amplitude measure to a control bus
		Out.ar(obs, sig)
	}, metadata: (
		specs: (
			obs: ControlSpec(0, Server.default.options.numAudioBusChannels-1, step: 1),
			kbs: ControlSpec(0, Server.default.options.numControlBusChannels-1, step: 1),
			rate: ControlSpec(0, 99, \lin, default: 0.0, units: "Hz"),
			atk: ControlSpec(0.0, 9, \lin, 0, 0.01, units: "seconds"),
			decay: ControlSpec(0.0, 33.0, \lin, 0, 1.0, units: "seconds"),
			amp: ControlSpec(-120.0, 18, \lin, default: 0.0, units: "db")
	))
).load.store(mdPlugin:TextArchiveMDPlugin);


    ///////////////////////////////////////
   ////                              /////
  ////         \ringmod             /////
 ////                              /////
///////////////////////////////////////
SynthDef(\ringmod, {
		arg obs, kbs, carbus, modbus, amp=0;
		var rm, rms;
		rm = DiodeRingMod.ar(In.ar(carbus), In.ar(modbus))*amp.dbamp;
		rms = Amplitude.kr(rm);
		Out.kr(kbs, rms); //send rms amplitude measure to a control bus
		Out.ar(obs, rm)
	}, metadata: (
		specs: (
			obs: ControlSpec(0, Server.default.options.numAudioBusChannels-1, step: 1),
			kbs: ControlSpec(0, Server.default.options.numControlBusChannels-1, step: 1),
			carbus: ControlSpec(0, Server.default.options.numAudioBusChannels-1, step: 1),
			modbus: ControlSpec(0, Server.default.options.numAudioBusChannels-1, step: 1),
			amp: ControlSpec(-120.0, 18, \lin, default: 0.0, units: "db")
	))
).load.store(mdPlugin:TextArchiveMDPlugin);

)

// List of default specs:

\unipolar -> ControlSpec(0, 1),
\bipolar -> ControlSpec(-1, 1, default: 0),

\freq -> ControlSpec(minval: 20, maxval: 20000, warp: \exp, step: 0, default: 440, units: " Hz"),
\lofreq -> ControlSpec(0.1, 100, \exp, 0, 6, units: " Hz"),
\midfreq -> ControlSpec(25, 4200, \exp, 0, 440, units: " Hz"),
\widefreq -> ControlSpec(0.1, 20000, \exp, 0, 440, units: " Hz"),
\phase -> ControlSpec(0, 2pi),
\rq -> ControlSpec(0.001, 2, \exp, 0, 0.707),

\audiobus -> ControlSpec(0, Server.default.options.numAudioBusChannels-1, step: 1),
\controlbus -> ControlSpec(0, Server.default.options.numControlBusChannels-1, step: 1),

\midi -> ControlSpec(0, 127, default: 64),
\midinote -> ControlSpec(0, 127, default: 60),
\midivelocity -> ControlSpec(1, 127, default: 64),

\db -> ControlSpec(0.ampdb, 1.ampdb, \db, units: " dB"),
\amp -> ControlSpec(0, 1, \amp, 0, 0),
\boostcut -> ControlSpec(-20, 20, units: " dB",default: 0),

\pan -> ControlSpec(-1, 1, default: 0),
\detune -> ControlSpec(-20, 20, default: 0, units: " Hz"),
\rate -> ControlSpec(0.125, 8, \exp, 0, 1),
\beats -> ControlSpec(0, 20, units: " Hz"),

\delay -> ControlSpec(0.0001, 1, \exp, 0, 0.3, units: " secs")



