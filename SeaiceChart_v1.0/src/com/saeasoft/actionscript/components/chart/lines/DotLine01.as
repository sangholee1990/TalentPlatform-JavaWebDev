package com.saeasoft.actionscript.components.chart.lines
{
    import flash.display.*;
    import flash.filters.*;
    
    import mx.charts.chartClasses.*;
    import mx.skins.*;

    public class DotLine01 extends DotLineBase
    {
    	public function DotLine01(){
			length=3; // 점선 길이
			lineWeight=2; // 선 굵기
			lineAlpha=1; // 선 알파
			gap = 3;
    	}
    }
}