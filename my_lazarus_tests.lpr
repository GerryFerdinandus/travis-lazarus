program my_lazarus_tests;

{$mode objfpc}{$H+}

uses
  Classes, Interfaces, consoletestrunner, fpcunit,
  fpcunitreport, my_lazarus_test;

type

  { TLazTestRunner }

  { TMyTestRunner }

  TMyTestRunner = class(TTestRunner)
  protected
    // override the protected methods of TTestRunner to customize its behavior
    procedure DoTestRun(ATest: TTest); override;
  end;

var
  Application: TMyTestRunner;

{ TMyTestRunner }

procedure TMyTestRunner.DoTestRun(ATest: TTest);
var
  ResultsWriter: TCustomResultsWriter;
  TestResult: TTestResult;
begin
  ResultsWriter := GetResultsWriter;
  ResultsWriter.Filename := FileName;
  TestResult := TTestResult.Create;
  try
    TestResult.AddListener(ResultsWriter);
    ATest.Run(TestResult);
    ResultsWriter.WriteResult(TestResult);

    //if something failed then exit with error: 1
    if (TestResult.NumberOfErrors > 0) or (TestResult.NumberOfFailures > 0) then
    begin
      System.ExitCode := 1;
    end;

  finally
    TestResult.Free;
    ResultsWriter.Free;
  end;
end;

begin
  Application := TMyTestRunner.Create(nil);
  Application.Initialize;
  Application.Run;
  Application.Free;
end.
