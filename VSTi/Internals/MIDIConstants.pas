(*
 * 
 * Zlib license:
 * 
 * Copyright (c) 2006-2015, Benjamin 'BeRo' Rosseaux (benjamin@rosseaux.de)
 * 
 * This software is provided 'as-is', without any express or implied
 * warranty. In no event will the authors be held liable for any damages
 * arising from the use of this software.
 * 
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 * 
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgement in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 * 
 *)
unit MIDIConstants;

interface

const MIDI_ALLNOTESOFF=$7b;
      MIDI_NOTEOFF=$80;
      MIDI_NOTEON=$90;
      MIDI_KEYAFTERTOUCH=$a0;
      MIDI_CONTROLCHANGE=$b0;
      MIDI_PROGRAMCHANGE=$c0;
      MIDI_CHANNELAFTERTOUCH=$d0;
      MIDI_PITCHBEND=$e0;
      MIDI_SYSTEMMESSAGE=$f0;
      MIDI_BEGINSYSEX=$f0;
      MIDI_MTCQUARTERFRAME=$f1;
      MIDI_SONGPOSPTR=$f2;
      MIDI_SONGSELECT=$f3;
      MIDI_ENDSYSEX=$f7;
      MIDI_TIMINGCLOCK=$f8;
      MIDI_START=$fa;
      MIDI_CONTINUE=$fb;
      MIDI_STOP=$fc;
      MIDI_ACTIVESENSING=$fe;
      MIDI_SYSTEMRESET=$ff;

implementation

end.
 