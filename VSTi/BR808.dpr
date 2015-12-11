library BR808;

uses
  FastMM4 in 'Delphi\FastMM4.pas',
  FastMove in 'Delphi\FastMove.pas',
  FastcodeCPUID in 'Delphi\FastcodeCPUID.pas',
  FastMM4Messages in 'Delphi\FastMM4Messages.pas',
  ControlResizeBugFix in 'VSTCore\ControlResizeBugFix.pas',
  UnitVSTiPlugin in 'VSTCore\UnitVSTiPlugin.pas',
  UnitMIDIEvent in 'VSTCore\UnitMIDIEvent.pas',
  UnitMIDIEventList in 'VSTCore\UnitMIDIEventList.pas',
  UnitVSTiEditor in 'VSTCore\UnitVSTiEditor.pas' {VSTiEditor},
  BeRoXML in 'BeRoUtils\BeRoXML.pas',
  BeRoCriticalSection in 'BeRoUtils\BeRoCriticalSection.pas',
  BeRoStream in 'BeRoUtils\BeRoStream.pas',
  BeRoStringTree in 'BeRoUtils\BeRoStringTree.pas',
  BeRoThread in 'BeRoUtils\BeRoThread.pas',
  BeRoUtils in 'BeRoUtils\BeRoUtils.pas',
  MIDIConstants in 'Internals\MIDIConstants.pas',
  Functions in 'Internals\Functions.pas',
  Synth in '..\Synth.pas',
  UnitFormEnvelopeEditor in 'VSTCore\UnitFormEnvelopeEditor.pas' {EnvelopeForm},
  BeRoTinyFlexibleDataStorage in 'BeRoUtils\BeRoTinyFlexibleDataStorage.pas',
  BeRoFlexibleDataStorage in 'BeRoUtils\BeRoFlexibleDataStorage.pas',
  UnitVSTiGUI in 'VSTCore\UnitVSTiGUI.pas',
  UnitVSTiFormModulationMatrixItem in 'VSTCore\UnitVSTiFormModulationMatrixItem.pas' {FormModulationMatrixitem},
  SpeechTools in 'Speech\SpeechTools.pas',
  SpeechGerman in 'Speech\SpeechGerman.pas',
  SpeechRules in 'Speech\SpeechRules.pas',
  SpeechEnglish in 'Speech\SpeechEnglish.pas',
  UnitWaveEditor in 'VSTCore\UnitWaveEditor.pas',
  BeRoDrawTools in 'VSTCore\BeRoDrawTools.pas',
  VersionInfo in 'VersionInfo.pas',
  PEUtilsEx in 'VSTCore\PEUtilsEx.pas',
  BMFPlayerStubfile in '..\BMFPlayerStub\BMFPlayerStubfile.pas',
  Globals in 'VSTCore\Globals.pas',
  StringTree in 'BeRoUtils\StringTree.pas',
  UCS4 in 'BeRoUtils\UCS4.pas',
  UTF8 in 'BeRoUtils\UTF8.pas',
  LZBRX in 'VSTCore\LZBRX.pas',
  BeRoFFT in 'VSTCore\BeRoFFT.pas',
  BeRoDoubleToString in 'BeRoUtils\BeRoDoubleToString.pas',
  BeRoStringToDouble in 'BeRoUtils\BeRoStringToDouble.pas',
  BeRoPascalScript in 'BeRoUtils\BeRoPascalScript.pas';

{  stubexetlslzmaibhfile in '..\..\BeRoEXEPacker\stub\stubexetlslzmaibhfile.pas',
  stubdlllzbrribhfile in '..\..\BeRoEXEPacker\stub\stubdlllzbrribhfile.pas',
  stubdlllzbrsfile in '..\..\BeRoEXEPacker\stub\stubdlllzbrsfile.pas',
  stubdlllzbrsibhfile in '..\..\BeRoEXEPacker\stub\stubdlllzbrsibhfile.pas',
  stubdlllzmafile in '..\..\BeRoEXEPacker\stub\stubdlllzmafile.pas',
  stubdlllzmaibhfile in '..\..\BeRoEXEPacker\stub\stubdlllzmaibhfile.pas',
  stubdlltlslzbrrfile in '..\..\BeRoEXEPacker\stub\stubdlltlslzbrrfile.pas',
  stubdlltlslzbrribhfile in '..\..\BeRoEXEPacker\stub\stubdlltlslzbrribhfile.pas',
  stubdlltlslzbrsfile in '..\..\BeRoEXEPacker\stub\stubdlltlslzbrsfile.pas',
  stubdlltlslzbrsibhfile in '..\..\BeRoEXEPacker\stub\stubdlltlslzbrsibhfile.pas',
  stubdlltlslzmafile in '..\..\BeRoEXEPacker\stub\stubdlltlslzmafile.pas',
  stubdlltlslzmaibhfile in '..\..\BeRoEXEPacker\stub\stubdlltlslzmaibhfile.pas',
  stubexelzbrrfile in '..\..\BeRoEXEPacker\stub\stubexelzbrrfile.pas',
  stubexelzbrribhfile in '..\..\BeRoEXEPacker\stub\stubexelzbrribhfile.pas',
  stubexelzbrsfile in '..\..\BeRoEXEPacker\stub\stubexelzbrsfile.pas',
  stubexelzbrsibhfile in '..\..\BeRoEXEPacker\stub\stubexelzbrsibhfile.pas',
  stubexelzmafile in '..\..\BeRoEXEPacker\stub\stubexelzmafile.pas',
  stubexelzmaibhfile in '..\..\BeRoEXEPacker\stub\stubexelzmaibhfile.pas',
  stubexetlslzbrrfile in '..\..\BeRoEXEPacker\stub\stubexetlslzbrrfile.pas',
  stubexetlslzbrribhfile in '..\..\BeRoEXEPacker\stub\stubexetlslzbrribhfile.pas',
  stubexetlslzbrsfile in '..\..\BeRoEXEPacker\stub\stubexetlslzbrsfile.pas',
  stubexetlslzbrsibhfile in '..\..\BeRoEXEPacker\stub\stubexetlslzbrsibhfile.pas',
  stubexetlslzmafile in '..\..\BeRoEXEPacker\stub\stubexetlslzmafile.pas',
  stubdlllzbrrfile in '..\..\BeRoEXEPacker\stub\stubdlllzbrrfile.pas',
  lzmadllFile in '..\..\BeRoEXEPacker\lzma\lzmadllFile.pas',
  CompressorLZBRR in '..\..\BeRoEXEPacker\CompressorLZBRR.pas',
  DLLLoader in '..\..\BeRoEXEPacker\DLLLoader.pas',
  CompressorLZMA in '..\..\BeRoEXEPacker\CompressorLZMA.pas',
  Core in '..\..\BeRoEXEPacker\Core.pas',
  DLLExports in '..\..\BeRoEXEPacker\DLLExports.pas',
  CompressorLZBRS in '..\..\BeRoEXEPacker\CompressorLZBRS.pas',
  Intervals in '..\..\BeRoEXEPacker\Intervals.pas',
  LZMADecoder in '..\..\BeRoEXEPacker\LZMADecoder.pas',
  PEUtils in '..\..\BeRoEXEPacker\PEUtils.pas',
  Relocations in '..\..\BeRoEXEPacker\Relocations.pas',
  Resources in '..\..\BeRoEXEPacker\Resources.pas',
  StringUtils in '..\..\BeRoEXEPacker\StringUtils.pas',
  UnpackBEP in '..\..\BeRoEXEPacker\UnpackBEP.pas',
  stubexetlsibhfile in '..\..\BeRoEXEPacker\stub\stubexetlsibhfile.pas',
  stubdllibhfile in '..\..\BeRoEXEPacker\stub\stubdllibhfile.pas',
  stubdlltlsfile in '..\..\BeRoEXEPacker\stub\stubdlltlsfile.pas',
  stubexefile in '..\..\BeRoEXEPacker\stub\stubexefile.pas',
  stubexeibhfile in '..\..\BeRoEXEPacker\stub\stubexeibhfile.pas',
  stubexetlsfile in '..\..\BeRoEXEPacker\stub\stubexetlsfile.pas',
  stubdllfile in '..\..\BeRoEXEPacker\stub\stubdllfile.pas',
  stubdlltlsibhfile in '..\..\BeRoEXEPacker\stub\stubdlltlsibhfile.pas',
}

function Main(AudioMaster:TAudioMasterCallbackFunc):PVSTEffect; cdecl;
var VSTiPlugin:TVSTiPlugin;
begin
 result:=nil;
 if AudioMaster(nil,audioMasterVersion,0,0,nil,0)<>0 then begin
  VSTiPlugin:=TVSTiPlugin.CreatePlugin(AudioMaster);
  if assigned(VSTiPlugin) then begin
   result:=@VSTiPlugin.VSTEffect;
  end;
 end;
end;

exports Main name 'main';

begin
end.
