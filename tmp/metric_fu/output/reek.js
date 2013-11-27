              var g = new Bluff.Line('graph', "1000x600");
      g.theme_37signals();
      g.tooltips = true;
      g.title_font_size = "24px"
      g.legend_font_size = "12px"
      g.marker_font_size = "10px"

        g.title = 'Reek: code smells';
        g.data('BooleanParameter', [1]);
g.data('IrresponsibleModule', [1]);
g.data('RepeatedConditional', [1]);
g.data('UncommunicativeParameterName', [4]);
g.data('UncommunicativeVariableName', [4]);
g.data('DuplicateMethodCall', [20]);
g.data('TooManyStatements', [3]);
g.data('FeatureEnvy', [3]);
        g.labels = {"0":"11/27"};
        g.draw();
