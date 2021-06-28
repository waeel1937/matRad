
classdef matRad_visApertureInfo_test < matlab.unittest.TestCase
    

    properties
        TestFigure
    end
    methods(TestMethodSetup)
        function createFigure(testCase)
            testCase.TestFigure = figure;
        
        end
    end
    methods(TestMethodTeardown)
        function closeFigure(testCase)
            close(testCase.TestFigure)
        end
    end
    methods(Test)
        function defaultCurrentPoint(testCase)
            cp = testCase.TestFigure.CurrentPoint;
            testCase.verifyEqual(cp,[0 0], ...
                'Default current point is incorrect')
        end
        function defaultCurrentObject(testCase)
            import matlab.unittest.constraints.IsEmpty
            co = testCase.TestFigure.CurrentObject;
            testCase.verifyThat(co,IsEmpty, ...
                'Default current object should be empty')
        end
        function failingTest(testCase)
            import matlab.unittest.diagnostics.FigureDiagnostic
            fig = testCase.TestFigure;
            ax = axes(fig);
            surf(ax,peaks);
            
            testCase.verifyEqual(testCase.TestFigure.Children,FigureDiagnostic(testCase.TestFigure));
         
            import matlab.unittest.diagnostics.FigureDiagnostic
            testCase.log(FigureDiagnostic(fig,'Formats',{'png'},'Prefix','LoggedFigure_'));
        end
    end
end

