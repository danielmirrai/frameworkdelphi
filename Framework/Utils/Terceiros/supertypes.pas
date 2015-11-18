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
 *)unit supertypes;

{$IFDEF FPC}
  {$MODE OBJFPC}{$H+}
{$ENDIF}

interface

type
{$IFNDEF FPC}
{$IFDEF CPUX64}
  PtrInt = Int64;
  PtrUInt = UInt64;
{$ELSE}
  PtrInt = longint;
  PtrUInt = Longword;
{$ENDIF}
{$ENDIF}
  SuperInt = Int64;

{$if (sizeof(Char) = 1)}
  SOChar = WideChar;
  SOIChar = Word;
  PSOChar = PWideChar;
{$IFDEF FPC}
  SOString = UnicodeString;
{$ELSE}
  SOString = WideString;
{$ENDIF}
{$else}
  SOChar = Char;
  SOIChar = Word;
  PSOChar = PChar;
  SOString = string;
{$ifend}
implementation

end.
