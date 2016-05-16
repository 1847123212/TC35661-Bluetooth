Attribute VB_Name = "FileDialog"
Option Explicit
 
Private Const OFN_READONLY = &H1  'ֻ����ʽ��
Private Const OFN_HIDEREADONLY = &H4
Private Const OFN_PATHMUSTEXIST = &H800
Private Const OFN_FILEMUSTEXIST = &H1000
Private Const OFN_ALLOWMULTISELECT = &H200  '��ѡ
Private Const OFN_EXPLORER = &H80000 '��Դ��������ʽ����ѡʱ�ῴ���������ò�ƻ������Զ���ʽ��

Private Type OPENFILENAME
  lStructSize As Long '�ṹ���С
  hwndOwner As Long '���ô���
  hInstance As Long '����ʵ��
  lpstrFilter As String '�ļ����͹���
  lpstrCustomFilter As String
  lMaxCustFilter As Long
  lFilterIndex As Long
  lpstrFile As String '�����ļ���
  lMaxFile As Long  '��������С
  lpstrFileTitle As String
  lMaxFileTitle As Long
  lpstrInitialDir As String '��ʼĿ¼
  lpstrTitle As String  '�Ի������
  flags As Long '����������ʶ
  iFileOffset As Integer
  iFileExtension As Integer
  lpstrDefExt As String
  lCustData As Long
  lpfnHook As Long
  lpTemplateName As String
End Type

'Public Declare Function GetFullPathName Lib "kernel32" Alias "GetFullPathNameA" (ByVal lpFileName As String, ByVal nBufferLength As Long, ByVal lpBuffer As String, ByVal lpFilePart As String) As Long
Private Declare Function GetSaveFileName Lib "comdlg32.dll" Alias "GetSaveFileNameA" (pOpenfilename As OPENFILENAME) As Long
Private Declare Function GetOpenFileName Lib "comdlg32.dll" Alias "GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long

Public Function GetFileName(hWnd As Long) As String
  Dim pFile As OPENFILENAME
  With pFile
    .lStructSize = Len(pFile)
    .hwndOwner = hWnd
    .hInstance = App.hInstance
    .lpstrFilter = "*.txt" & Chr(0) & "*.txt" & Chr(0)
    '����˵�����ļ���Լ����Chr(0)��������������ѡ��ͬ����Chr(0)����
    'ͬһ���Ͷ��ֺ�׺����Ӣ�ķֺ�";"�������磺*.jpg;*.jpeg / *.htm;*.html
    .lMaxFile = 255
    .lpstrFile = Space(254)
    .lpstrTitle = "���ļ�"
    .flags = OFN_FILEMUSTEXIST Or OFN_PATHMUSTEXIST '�Լ��趨����
    
  End With
  If GetOpenFileName(pFile) <> 0 Then
    GetFileName = pFile.lpstrFile
    
    GetFileName = Left(GetFileName, InStr(GetFileName, Chr(0)) - 1)
  End If
  '���ļ���ȡ��Left(��������ֵ, InStr(��������ֵ, Chr(0)) - 1)
  '���ļ�����������ֵ=�����ļ�����Ŀ¼(ͬһĿ¼) & Chr(0) & �ļ�1�� & Chr(0) & �ļ�2�� �� ��
End Function

 
Public Function SaveFileName(hWnd As Long)
     
    
    Dim i As Integer
    Dim Kuang As OPENFILENAME
    Dim FileName As String
    With Kuang
        .lStructSize = Len(Kuang)
        .hwndOwner = hWnd
        .hInstance = App.hInstance
        .lpstrFile = Space(254)
        .lMaxFile = 255
        .lpstrFileTitle = Space(254)
        .lMaxFileTitle = 255
        .lpstrInitialDir = App.Path
        .flags = 6148
        '���ǶԻ����ļ�����
        .lpstrFilter = "�����ļ� (*.LevelTable)" + Chr$(0) + "*.LevelTable" + Chr$(0) '+ "�����ļ� (*.LevelTable)" + Chr$(0) + "*.TXT" + Chr$(0)
        '�Ի������������
        .lpstrTitle = "�����ļ���·�����ļ���..."
    End With
    
    i = GetSaveFileName(Kuang) '��ʾ�����ļ��Ի���
    If i >= 1 Then 'ȡ�öԻ����û�ѡ��������ļ�����·��
        FileName = Kuang.lpstrFile
        FileName = Left(FileName, InStr(FileName, Chr(0)) - 1)
        If (Right(FileName, 11) <> ".Yuht") Then
            FileName = FileName & ".Yuht"
        End If
    End If
    
    If Len(FileName) = 0 Then Exit Function
        SaveFileName = FileName
    Exit Function
    
End Function


