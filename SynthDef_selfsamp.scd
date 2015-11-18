//allocate buffer on the fly in the oscdef
SynthDef(\selfsamp, {
	arg buf, rdur=3, rretrigt=10, pretrigt = 3;
	var rix, rixenv, rgate, pix, pixenv, pgate, play,rretrigf, pretrigf, pdur, pst, pnd, penv;
	rretrigf = 1.0/rretrigt;
	pretrigf = 1.0/pretrigt;
	rgate = Dust.kr(rretrigf);
	pgate = DelayL.kr(Dust.kr(pretrigf),10, rdur);
	pdur = TRand.kr(0.05/rdur, 1, pgate);
	pst = TRand.kr(0.0, 1-pdur, pgate);
	rixenv = EnvGen.ar(Env.linen(0, rdur, 0),rgate);
	rix = Phasor.ar(rgate, BufRateScale.kr(buf), 0, BufFrames.kr(buf));
	BufWr.ar(SoundIn.ar(0), buf, rix*rixenv);
	pixenv = EnvGen.ar(Env.linen(0, pdur*rdur, 0),pgate);
	penv = EnvGen.ar(Env.linen(0.05, pdur*rdur, 0.05),pgate);
	pix = Phasor.ar(pgate, BufRateScale.kr(buf), pst*BufFrames.kr(buf), BufFrames.kr(buf)*(pst+pdur));
	play = BufRd.ar(1, buf, pix*penv);
	//play = RLPF.ar(play, 1000);
	Out.ar(0, play*pixenv);
}).add;