(*
 *                         Super Object Toolkit
 *
 * Usage allowed under the restrictions of the Lesser GNU General Public License
 * or alternatively the restrictions of the Mozilla Public License 1.1
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 *
 * Embarcadero Technologies Inc is not permitted to use or redistribute
 * this source code without explicit permission.
 *
 * Unit owner : Henri Gourvest <hgourvest@gmail.com>
 * Web site   : http://www.progdigy.com
 *)
 
 unit superdate;

interface

uses
  supertypes, supertimezone;

function JavaToDelphiDateTime(const dt: Int64; const TimeZone: SOString = ''): TDateTime;
function DelphiToJavaDateTime(const dt: TDateTime; const TimeZone: SOString = ''): Int64;
function JavaDateTimeToISO8601Date(const dt: Int64; const TimeZone: SOString = ''): SOString;
function DelphiDateTimeToISO8601Date(const dt: TDateTime; const TimeZone: SOString = ''): SOString;
function ISO8601DateToJavaDateTime(const str: SOString; var ms: Int64; const TimeZone: SOString = ''): Boolean;
function ISO8601DateToDelphiDateTime(const str: SOString; var dt: TDateTime; const TimeZone: SOString = ''): Boolean;

implementation

function JavaToDelphiDateTime(const dt: Int64; const TimeZone: SOString = ''): TDateTime;
begin
  Result := TSuperTimeZone.Zone[TimeZone].JavaToDelphi(dt);
end;

function DelphiToJavaDateTime(const dt: TDateTime; const TimeZone: SOString = ''): Int64;
begin
  Result := TSuperTimeZone.Zone[TimeZone].DelphiToJava(dt);
end;

function JavaDateTimeToISO8601Date(const dt: Int64; const TimeZone: SOString = ''): SOString;
begin
  Result := TSuperTimeZone.Zone[TimeZone].JavaToISO8601(dt);
end;

function DelphiDateTimeToISO8601Date(const dt: TDateTime; const TimeZone: SOString = ''): SOString;
begin
  Result := TSuperTimeZone.Zone[TimeZone].DelphiToISO8601(dt);
end;

function ISO8601DateToJavaDateTime(const str: SOString; var ms: Int64; const TimeZone: SOString = ''): Boolean;
begin
  Result := TSuperTimeZone.Zone[TimeZone].ISO8601ToJava(str, ms);
end;

function ISO8601DateToDelphiDateTime(const str: SOString; var dt: TDateTime; const TimeZone: SOString = ''): Boolean;
begin
  Result := TSuperTimeZone.Zone[TimeZone].ISO8601ToDelphi(str, dt);
end;

end.
