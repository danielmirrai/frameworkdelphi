library ProcessHide;
 
uses
  Windows,
  SysUtils,
  MagicApiHook in '..\MagicApiHook.pas';

type
PProcessInfo = ^TProcessInfo;
TProcessInfo=record
dwOffset : dword;
dwThreadCount : dword;
dwUnkown1 : array[0..5] of dword;
ftCreationTime : TFileTime;
dwUnkown2 : dword;
dwUnkown3 : dword;
dwUnkown4 : dword;
dwUnkown5 : dword;
dwUnkown6 : dword;
pszProcessName : PWideChar;
dwBasePriority : dword;
dwProcessID : dword;
dwParentProcessID : dword;
dwHandleCount : dword;
dwUnkown7 : dword;
dwUnkown8 : dword;
dwVirtualBytesPeak : dword;
dwVirtualBytes : dword;
dwPageFaults : dword;
dwWorkingSetPeak : dword;
dwWorkingSet : dword;
dwUnkown9 : dword;
dwPagedPool : dword;
dwUnkown10 : dword;
dwNonPagedPool : dword;
dwPageFileBytesPeak : dword;
dwPageFileBytes : dword;
dwPrivateBytes : dword;
dwUnkown11 : dword;
dwUnkown12 : dword;
dwUnkown13 : dword;
dwUnkown14 : dword;
ThreadInfo : PThreadInfo;
end;
 
var
NtQuerySystemInformationNextHook: function(dt : dword;
                                           buf : pointer;
                                           bufsize : dword;
                                           retlen : pointer) : dword; stdcall;
 
function NtQuerySystemInformationCallbackProc(dt : dword;
                                              buf : pointer;
                                              bufsize : dword;
                                              retlen : pointer) : dword; stdcall;
type
PBA = ^TBA;
TBA = array[0..1000000] of byte;
var
tmpbuf: PBA;
ProcessInfo ,LastPinfo : PProcessInfo;
cp: DWORD;
curproc:string;
begin
Result := NtQuerySystemInformationNextHook(dt,buf,bufsize,retlen);
if dt<>5 then exit;
if result<>0 then exit;
cp := 0;
tmpbuf := buf;
Repeat
ProcessInfo := PProcessInfo(@tmpbuf[cp]);
curproc:=WideCharToString(ProcessInfo^.pszProcessName);
if Pos('anticheat.exe',lowercase(curproc)) > 0 then
begin
 
if ProcessInfo^.dwOffset=0 then
begin
  LastPinfo^.dwOffset:=0;exit;end
  else
  LastPinfo^.dwOffset:=LastPinfo^.dwOffset+ProcessInfo.dwOffset;
end
else
begin
  LastPinfo:=ProcessInfo;
end;
 
cp := cp + ProcessInfo^.dwOffset;
until ProcessInfo^.dwOffset = 0;
end;
 
procedure DLLEntryPoint(dwReason:DWORD);
begin
 case dwReason of
   DLL_PROCESS_ATTACH: begin
                       ApiHook('ntdll.dll', 'NtQuerySystemInformation' , nil ,  
                                @NtQuerySystemInformationCallbackProc,
                                @NtQuerySystemInformationNextHook);
                       end;
   DLL_PROCESS_DETACH: begin
                       ApiUnHook('ntdll.dll', 'NtQuerySystemInformation' , nil ,  
                                 @NtQuerySystemInformationCallbackProc,
                                 @NtQuerySystemInformationNextHook);
                       end;
 end;
end;
 
begin
 DllProc:=@DLLEntryPoint;
 DLLEntryPoint(DLL_PROCESS_ATTACH);
end.
