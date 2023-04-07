unit Fixed_Return;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, DBGrids, Login, DB, ADODB, Public_Variable,
  AppEvnts;

type
  TForm_Fixed_Return = class(TForm)
	procedure Edit1Change(Sender: TObject);
 private
    { Private declarations }
  public
    { Public declarations }
      Change_SIM: Boolean;
  end;

var
  Form_Fixed_Return: TForm_Fixed_Return;

implementation

uses
  HzSpell;
  
{$R *.dfm}



procedure TForm_Fixed_Return.Edit_Equip_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
  begin
    DBGrid_to_be_Receive.SetFocus;
  end;
end;

procedure TForm_Fixed_Return.Edit1Change(Sender: TObject);
var
  i: Integer;
  prefix: AnsiString;
  Comb_Err_Desc_List: TStringList;
begin
  Comb_Err_Desc_List := TStringList.Create;

  sqlstring := 'select Err_ID,text from tbl_repair_Solution where Solution_id=''0'' and Analysis_id=''0'' order by text';
  qry_fuzzy.SQL.Add(sqlstring);
  qry_fuzzy.Open;

  while not qry_fuzzy.Eof do
  begin
    Comb_Err_Desc_List.Add(qry_fuzzy.FieldByName('text').AsString);
    qry_fuzzy.Next;
  end;
  qry_fuzzy.Close;


  prefix := Edit1.Text;
  try
    Comb_Err_Desc.Items.BeginUpdate;
    for i := 0 to Comb_Err_Desc_List.Count - 1 do
    begin
      //FirstChar := MyList[i][1];
      if Pos(prefix, HzSpell.THzSpell.PyHeadOfHz(Comb_Err_Desc_List.Strings[i]))>0 then //HzSpell.THzSpell.PyHeadOfHz(Comb_Err_Desc_List.Strings[i]) 获取汉字转拼音
      begin
        Comb_Err_Desc.ItemIndex := i;
         //模拟手动选中下拉框项的效果
        if Assigned(Comb_Err_Desc.OnSelect) then
          Comb_Err_Desc.OnSelect(Comb_Err_Desc);
        Break; // 找到匹配项后直接退出循环，提高效率
      end;
    end;
  finally
    Comb_Err_Desc.Items.EndUpdate;
  end;

  Comb_Err_Desc_List.Free;
end;



procedure TForm_Fixed_Return.FormCreate(Sender: TObject);
begin
end;
	query.open;


end.