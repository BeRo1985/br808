unit BeRoFFT;
{$IFDEF FPC}
 {$MODE DELPHI}
 {$WARNINGS OFF}
 {$HINTS OFF}
 {$OVERFLOWCHECKS OFF}
 {$RANGECHECKS OFF}
 {$IFDEF CPUI386}
  {$DEFINE CPU386}
  {$ASMMODE INTEL}
 {$ENDIF}
 {$IFDEF FPC_LITTLE_ENDIAN}
  {$DEFINE LITTLE_ENDIAN}
 {$ELSE}
  {$IFDEF FPC_BIG_ENDIAN}
   {$DEFINE BIG_ENDIAN}
  {$ENDIF}
 {$ENDIF}
{$ELSE}
 {$DEFINE LITTLE_ENDIAN}
 {$IFNDEF CPU64}
  {$DEFINE CPU32}
 {$ENDIF}
 {$OPTIMIZATION ON}
{$ENDIF}

interface

type PBeRoFFTValue=^TBeRoFFTValue;
     TBeRoFFTValue=double;

     PBeRoFFTValueArray=^TBeRoFFTValueArray;
     TBeRoFFTValueArray=array[0..0] of TBeRoFFTValue;

     PBeRoFFTIntegerArray=^TBeRoFFTIntegerArray;
     TBeRoFFTIntegerArray=array[0..0] of longint;

     TBeRoFFTBitReversedLookUpTable=class
      public
       Data:PBeRoFFTIntegerArray;
       constructor Create(BitCount:longint);
       destructor Destroy; override;
     end;

     TBeRoFFTTrigonemtricTable=class
      public
       Data:PBeRoFFTValueArray;
       constructor Create(BitCount:longint);
       destructor Destroy; override;
       function GetData(Level:longint):PBeRoFFTValueArray;
     end;

     TBeRoFFT=class
      public
       BitReversedLookUpTable:TBeRoFFTBitReversedLookUpTable;
       TrigonemtricTable:TBeRoFFTTrigonemtricTable;
       Sqrt2Div2:TBeRoFFTValue;
       FrameSize:longint;
       BitCount:longint;
       BufferData:PBeRoFFTValueArray;
       constructor Create(const AFrameSize:longint);
       destructor Destroy; override;
       procedure FFT(FFTData,WaveData:PBeRoFFTValueArray);
       procedure IFFT(FFTData,WaveData:PBeRoFFTValueArray);
       procedure Rescale(WaveData:PBeRoFFTValueArray);
     end;

implementation

constructor TBeRoFFTBitReversedLookUpTable.Create(BitCount:longint);
var Size,i,j,k:longint;
begin
 inherited Create;
 Size:=1 shl BitCount;
 GetMem(Data,Size*sizeof(longint));
 j:=0;
 Data^[0]:=0;
 for i:=1 to Size-1 do begin
  k:=Size shr 1;
  j:=j xor k;
  while (j and k)=0 do begin
   k:=k shr 1;
   j:=j xor k;
  end;
  Data^[i]:=j;
 end;
end;

destructor TBeRoFFTBitReversedLookUpTable.Destroy;
begin
 FreeMem(Data);
 inherited Destroy;
end;

constructor TBeRoFFTTrigonemtricTable.Create(BitCount:longint);
var TotalLen,Level,LevelLen,i:longint;
    LevelData:PBeRoFFTValueArray;
    FFTData:double;
begin
 inherited Create;
 Data:=nil;
 if BitCount>3 then begin
  TotalLen:=(1 shl (BitCount-1))-4;
  GetMem(Data,TotalLen*sizeof(TBeRoFFTValue));
  for Level:=3 to BitCount-1 do begin
   LevelLen:=1 shl (Level-1);
   LevelData:=@Data^[(1 shl (Level-1))-4];
   FFTData:=pi/(LevelLen shl 1);
   for i:=0 to LevelLen-1 do begin
    LevelData^[i]:=cos(i*FFTData);
   end;
  end;
 end;
end;

destructor TBeRoFFTTrigonemtricTable.Destroy;
begin
 FreeMem(Data);
 inherited Destroy;
end;

function TBeRoFFTTrigonemtricTable.GetData(Level:longint):PBeRoFFTValueArray;
begin
 result:=@Data^[(1 shl (Level-1))-4];
end;

constructor TBeRoFFT.Create(const AFrameSize:longint);
begin
 inherited Create;
 FrameSize:=AFrameSize;
 BitCount:=trunc((ln(FrameSize)/ln(2))+0.5);
 BitReversedLookUpTable:=TBeRoFFTBitReversedLookUpTable.Create(trunc((ln(FrameSize)/ln(2))+0.5));
 TrigonemtricTable:=TBeRoFFTTrigonemtricTable.Create(trunc((ln(FrameSize)/ln(2))+0.05));
 Sqrt2Div2:=sqrt(2)*0.5;
 BufferData:=nil;
 if BitCount>2 then begin
  GetMem(BufferData,FrameSize*sizeof(TBeRoFFTValue));
 end;
end;

destructor TBeRoFFT.Destroy;
begin
 if assigned(BufferData) then begin
  FreeMem(BufferData);
 end;
 BitReversedLookUpTable.Destroy;
 TrigonemtricTable.Destroy;
 inherited Destroy;
end;

procedure TBeRoFFT.FFT(FFTData,WaveData:PBeRoFFTValueArray);
var sf,df,df2,trilut,sf1r,sf2r,dfr,dfi,sf1i,sf2i,temp:PBeRoFFTValueArray;
    pass,coefcount,coefhalfcount,coefdoublecount,coefindex,ri0,ri1,ri2,ri3,
    n1,n2,n3,i:longint;
    bitlut:PBeRoFFTIntegerArray;
    sf0,sf2,v,c,s,b0,b2:TBeRoFFTValue;
begin
 n1:=1;
 n2:=2;
 n3:=3;
 case BitCount of
  0:begin
   FFTData^[0]:=WaveData^[0];
  end;
  1:begin
   FFTData^[0]:=WaveData^[0]+WaveData^[n1];
   FFTData^[n1]:=WaveData^[0]-WaveData^[n1];
  end;
  2:begin
   FFTData^[n1]:=WaveData^[0]-WaveData^[n2];
   FFTData^[n3]:=WaveData^[n1]-WaveData^[n3];
   b0:=WaveData^[0]+WaveData^[n2];
   b2:=WaveData^[n1]+WaveData^[n3];
   FFTData^[0]:=b0+b2;
   FFTData^[n2]:=b0-b2;
  end;
  else begin
   if (BitCount and 1)<>0 then begin
    df:=BufferData;
    sf:=FFTData;
   end else begin
    df:=FFTData;
    sf:=BufferData;
   end;
   bitlut:=BitReversedLookUpTable.Data;
   coefindex:=0;
   repeat
    ri0:=bitlut^[coefindex];
    ri1:=bitlut^[coefindex+1];
    ri2:=bitlut^[coefindex+2];
    ri3:=bitlut^[coefindex+3];
    df2:=@df^[coefindex];
    df2^[n1]:=WaveData^[ri0]-WaveData^[ri1];
    df2^[n3]:=WaveData^[ri2]-WaveData^[ri3];
    sf0:=WaveData^[ri0]+WaveData^[ri1];
    sf2:=WaveData^[ri2]+WaveData^[ri3];
    df2^[0]:=sf0+sf2;
    df2^[n2]:=sf0-sf2;
    inc(coefindex,4);
   until coefindex>=FrameSize;
   coefindex:=0;
   repeat
    sf^[coefindex]:=df^[coefindex]+df^[coefindex+4];
    sf^[coefindex+4]:=df^[coefindex]-df^[coefindex+4];
    sf^[coefindex+2]:=df^[coefindex+2];
    sf^[coefindex+6]:=df^[coefindex+6];
    v:=(df[coefindex+5]-df^[coefindex+7])*Sqrt2Div2;
    sf^[coefindex+1]:=df^[coefindex+1]+v;
    sf^[coefindex+3]:=df^[coefindex+1]-v;
    v:=(df^[coefindex+5]+df^[coefindex+7])*Sqrt2Div2;
    sf[coefindex+5]:=v+df^[coefindex+3];
    sf[coefindex+7]:=v-df^[coefindex+3];
    inc(coefindex,8);
   until coefindex>=FrameSize;
   for pass:=3 to BitCount-1 do begin
    coefindex:=0;
    coefcount:=1 shl pass;
    coefhalfcount:=coefcount shr 1;
    coefdoublecount:=coefcount shl 1;
    trilut:=pointer(TrigonemtricTable.GetData(pass));
    repeat
     sf1r:=@sf^[coefindex];
     sf2r:=@sf1r^[coefcount];
     dfr:=@df^[coefindex];
     dfi:=@dfr^[coefcount];
     dfr^[0]:=sf1r^[0]+sf2r^[0];
     dfi^[0]:=sf1r^[0]-sf2r^[0];
     dfr^[coefhalfcount]:=sf1r^[coefhalfcount];
     dfi^[coefhalfcount]:=sf2r^[coefhalfcount];
     sf1i:=@sf1r^[coefhalfcount];
     sf2i:=@sf1i^[coefcount];
     for i:=1 to coefhalfcount-1 do  begin
      c:=trilut^[i];
      s:=trilut^[coefhalfcount-i];
      v:=(sf2r^[i]*c)-(sf2i^[i]*s);
      dfr^[i]:=sf1r^[i]+v;
      dfi^[-i]:=sf1r^[i]-v;
      v:=(sf2r^[i]*s)+(sf2i^[i]*c);
      dfi^[i]:=v+sf1i^[i];
      dfi^[coefcount-i]:=v-sf1i^[i];
     end;
     inc(coefindex,coefdoublecount);
    until coefindex>=FrameSize;
    temp:=df;
    df:=sf;
    sf:=temp;
   end;
  end;
 end;
end;

procedure TBeRoFFT.IFFT(FFTData,WaveData:PBeRoFFTValueArray);
var n1,n2,n3,n4,n5,n6,n7,pass,coefcount,coefhalfcount,coefdoublecount,
    coefindex,i:longint;
    sf,df,dft,trilut,sfr,sfi,df1r,df2r,df1i,df2i,temp,sf2:PBeRoFFTValueArray;
    c,s,vr,vi,b0,b1,b2,b3:TBeRoFFTValue;
    bitlut:PBeRoFFTIntegerArray;
begin
 n1:=1;
 n2:=2;
 n3:=3;
 n4:=4;
 n5:=5;
 n6:=6;
 n7:=7;
 case BitCount of
  0:begin
   WaveData^[0]:=FFTData^[0];
  end;
  1:begin
   WaveData^[0]:=FFTData^[0]+FFTData^[n1];
   WaveData^[n1]:=FFTData^[0]-FFTData^[n1];
  end;
  2:begin
   b0:=FFTData^[0]+FFTData[n2];
   b2:=FFTData^[0]-FFTData[n2];
   WaveData^[0]:=b0+(FFTData[n1]*2);
   WaveData^[n2]:=b0-(FFTData[n1]*2);
   WaveData^[n1]:=b2+(FFTData[n3]*2);
   WaveData^[n3]:=b2-(FFTData[n3]*2);
  end;
  else begin
   sf:=FFTData;
   if (BitCount and 1)<>0 then begin
    df:=BufferData;
    dft:=WaveData;
   end else begin
    df:=WaveData;
    dft:=pointer(BufferData);
   end;
   for pass:=BitCount-1 downto 3 do begin
    coefindex:=0;
    coefcount:=1 shl pass;
    coefhalfcount:=coefcount shr 1;
    coefdoublecount:=coefcount shl 1;
    trilut:=TrigonemtricTable.GetData(pass);
    repeat
     sfr:=@sf^[coefindex];
     sfi:=@sfr^[coefcount];
     df1r:=@df^[coefindex];
     df2r:=@df1r^[coefcount];
     df1r^[0]:=sfr^[0]+sfi^[0];
     df2r^[0]:=sfr^[0]-sfi^[0];
     df1r^[coefhalfcount]:=sfr^[coefhalfcount]*2;
     df2r^[coefhalfcount]:=sfi^[coefhalfcount]*2;
     df1i:=@df1r^[coefhalfcount];
     df2i:=@df1i^[coefcount];
     for i:=1 to coefhalfcount-1 do begin
      df1r^[i]:=sfr^[i]+sfi^[-i];
      df1i^[i]:=sfi^[i]-sfi^[coefcount-i];
      c:=trilut^[i];
      s:=trilut^[coefhalfcount-i];
      vr:=sfr^[i]-sfi^[-i];
      vi:=sfi^[i]+sfi^[coefcount-i];
      df2r^[i]:=(vr*c)+(vi*s);
      df2i^[i]:=(vi*c)-(vr*s);
     end;
     inc(coefindex,coefdoublecount);
    until coefindex>=FrameSize;
    if pass<BitCount-1 then begin
     temp:=df;
     df:=sf;
     sf:=temp;
    end else begin
     sf:=df;
     df:=dft;
    end;
   end;
   coefindex:=0;
   repeat
    df^[coefindex]:=sf^[coefindex]+sf^[coefindex+4];
    df^[coefindex+4]:=sf^[coefindex]-sf^[coefindex+4];
    df^[coefindex+2]:=sf^[coefindex+2]*2;
    df^[coefindex+6]:=sf^[coefindex+6]*2;
    df^[coefindex+1]:=sf^[coefindex+1]+sf^[coefindex+3];
    df^[coefindex+3]:=sf^[coefindex+5]-sf^[coefindex+7];
    vr:=sf^[coefindex+1]-sf^[coefindex+3];
    vi:=sf^[coefindex+5]+sf^[coefindex+7];
    df^[coefindex+5]:=(vr+vi)*Sqrt2Div2;
    df^[coefindex+7]:=(vi-vr)*Sqrt2Div2;
    inc(coefindex,8);
   until coefindex>=FrameSize;
   coefindex:=0;
   bitlut:=BitReversedLookUpTable.Data;
   sf2:=df;
   repeat
    b0:=sf2^[0]+sf2^[n2];
    b2:=sf2^[0]-sf2^[n2];
    b1:=sf2^[n1]*2;
    b3:=sf2^[n3]*2;
    WaveData^[bitlut^[0]]:=b0+b1;
    WaveData^[bitlut^[n1]]:=b0-b1;
    WaveData^[bitlut^[n2]]:=b2+b3;
    WaveData^[bitlut^[n3]]:=b2-b3;
    b0:=sf2^[n4]+sf2^[n6];
    b2:=sf2^[n4]-sf2^[n6];
    b1:=sf2^[n5]*2;
    b3:=sf2^[n7]*2;
    WaveData^[bitlut^[n4]]:=b0+b1;
    WaveData^[bitlut^[n5]]:=b0-b1;
    WaveData^[bitlut^[n6]]:=b2+b3;
    WaveData^[bitlut^[n7]]:=b2-b3;
    inc(sf2,8);
    inc(coefindex,8);
    inc(bitlut,8);
   until coefindex>=FrameSize;
  end;
 end;
end;

procedure TBeRoFFT.Rescale(WaveData:PBeRoFFTValueArray);
var FFTData:TBeRoFFTValue;
    i:longint;
begin
 FFTData:=1.0/FrameSize;
 for i:=0 to FrameSize-1 do begin
  WaveData^[i]:=WaveData^[i]*FFTData;
 end;
end;

end.
