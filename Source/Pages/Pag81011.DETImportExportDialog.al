// SPDX-FileCopyrightText: 2021-2025 Volodymyr Dvernytskyi
// SPDX-License-Identifier: MIT
//
// Original author — Volodymyr Dvernytskyi (Data Editor Tool)
page 81011 "DET Import/Export Dialog"
{
    Caption = 'Import/Export Dialog';
    PageType = StandardDialog;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(InfoTxt; InfoTxt)
                {
                    Caption = 'Info';
                    ToolTip = 'Info';
                    Editable = false;
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field(FileFormat; FileFormat)
                {
                    Caption = 'File Format';
                    ToolTip = 'File Format';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ExportBLOB := false;
                        ExportMedia := false;
                    end;
                }
                group(ExportGroup)
                {
                    ShowCaption = false;
                    Visible = not IsImport and (FileFormat = FileFormat::JSON);
                    field(ExportBLOB; ExportBLOB)
                    {
                        Caption = 'Export BLOB (experemintal)';
                        ToolTip = 'Enable export of data from BLOB fields in Base64.';
                        ApplicationArea = All;
                    }
                    field(ExportMedia; ExportMedia)
                    {
                        Caption = 'Export Media (experemintal)';
                        ToolTip = 'Enable export of data from Media fields in Base64.';
                        ApplicationArea = All;
                    }
                }
                field(ImportOnFind; ImportOnFind)
                {
                    Caption = 'Import On Find';
                    ToolTip = 'Action to do when imported record is already exist in database';
                    Visible = IsImport;
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        InfoTxt := InfoLbl;
    end;

    procedure SetIsImport(inIsImport: Boolean)
    begin
        IsImport := inIsImport;
    end;

    procedure GetImportOnFind(): Enum "DET Import On Find"
    begin
        exit(ImportOnFind);
    end;

    procedure GetFileFormat(): Enum "DET File Format"
    begin
        exit(FileFormat);
    end;

    procedure GetExportBLOB(): Boolean
    begin
        exit(ExportBLOB);
    end;

    procedure GetExportMedia(): Boolean
    begin
        exit(ExportMedia);
    end;

    var
        InfoTxt: Text;
        IsImport: Boolean;
        ExportBLOB: Boolean;
        ExportMedia: Boolean;
        ImportOnFind: Enum "DET Import On Find";
        FileFormat: Enum "DET File Format";
        InfoLbl: Label 'Keep in mind that FlowFields and MediaSet fields will not be processed during Data Export/Import, Flow fields will be automatically calculated in the database after import. However, for JSON, you can enable experimental export of BLOB and Media fields. Excel in progress.';
}
