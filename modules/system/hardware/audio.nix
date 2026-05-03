{ ... }:
/*
 Audio stack module
 Provides PipeWire (with ALSA 32‑bit, PulseAudio compatibility, JACK) and rtkit scheduling.
*/
{
  security.rtkit.enable = true; # Realtime permissions for low-latency audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;   # PulseAudio compatibility layer
    jack.enable = true;    # JACK emulation
  };
}
