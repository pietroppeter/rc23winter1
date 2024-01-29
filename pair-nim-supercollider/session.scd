// Cmd + Enter to start, Cmd + period to stop
{
  var snare, bdrum, hihat;
  var tempo = 4;

  tempo = Impulse.ar(tempo); // for a drunk drummer replace Impulse with Dust !!!
  snare = WhiteNoise.ar(Decay2.ar(PulseDivider.ar(tempo, 4, 2), 0.005, 0.5));
  bdrum = SinOsc.ar(Line.ar(120,60, 1), 0, Decay2.ar(PulseDivider.ar(tempo, 4, 0), 0.005, 0.5));
  hihat = HPF.ar(WhiteNoise.ar(1), 10000) * Decay2.ar(tempo, 0.005, 0.5);

  Out.ar(0, (snare + bdrum + hihat) * 0.4 ! 2)
}.play

s.options.outDevice = "ZoomAudioD"; s.options.inDevice = "ZoomAudioD"; s.reboot;

SynthDef("PolyPerc", {
			arg out, freq = 440, pw=0.5, amp=0.3, cutoff=1000, gain=2, release=0.5;
			var snd = Pulse.ar(freq, pw);
			var filt = MoogFF.ar(snd,cutoff,gain);
			var env = Env.perc(level: amp, releaseTime: release).kr(2);
			//			out.poll;
			Out.ar(out, (filt*env).dup);
		}).add;

Synth("PolyPerc",[\freq,220])
//now we try to trigger from nim


n = NetAddr.new("127.0.0.1", 7771);    // create the NetAddr
// create the OSCFunc
o = OSCFunc({ arg msg, time, addr, recvPort; [msg, time, addr, recvPort].postln; }, '/goodbye', n);

