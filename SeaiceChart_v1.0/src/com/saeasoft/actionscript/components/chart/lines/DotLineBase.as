package com.saeasoft.actionscript.components.chart.lines
{
    import flash.display.*;
    import flash.filters.*;
    
    import mx.charts.chartClasses.*;
    import mx.core.IDataRenderer;
    import mx.skins.*;

    public class DotLineBase extends ProgrammaticSkin implements IDataRenderer
    {
        // 복제시 이 부분을 바꿀 것 --------------------
		public var gap:Number=6;
		public var length:Number=6;
		public var lineWeight:Number=3;
		public var lineAlpha:Number=1;
		// ---------------------------------------
		
		private var _lineSegment:Object;
		
        public function get data() : Object
        {
            return _lineSegment;
        }

        public function set data(Graphics:Object) : void
        {
			 _lineSegment = Graphics;
            invalidateDisplayList();
            return;
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
			super.updateDisplayList(unscaledWidth, unscaledHeight);

            var _loc_3:* = getStyle("lineStroke");
            var _loc_4:* = getStyle("form");
            graphics.clear();
            
            var lineArray:Array=Object(_lineSegment).items as Array;
            var fromX:Number;
            var fromY:Number;
            var toX:Number;
            var toY:Number;
            var modeObj:Object={mode:true, count:0}
            
            for (var i:int=1; i<lineArray.length; i++){
        		fromX=lineArray[i-1].x;
        		fromY=lineArray[i-1].y;
        		toX=lineArray[i].x;
        		toY=lineArray[i].y;
        		modeObj=drawDashedLine(graphics, fromX, fromY, toX, toY, _loc_3.color, modeObj);
        	}
            return;
        }
		
    	public function drawDashedLine(target:Graphics, x0:Number, y0:Number, x1:Number, y1:Number, col:uint, modeObj:Object) : Object {
    		target.lineStyle(lineWeight,col,lineAlpha);
    		
    		var fdX:Number = x1 - x0;
			var fdY:Number = y1 - y0;
			var dX:Number = fdX;
			var dY:Number = fdY;
			var tMax:Number = len;
			var len:Number = Math.sqrt(dX*dX + dY*dY);
			var t:Number = 0;
			var gapfirtime:Number=length+gap;
			
			var unitLen:Number=len/gapfirtime;
			
			dX /= len;
			dY /= len;
			
			var mode:Boolean=modeObj.mode;
			var count:int=modeObj.count;
			
			for(var i:int=0; i<len; i++){
				var fromX:Number=dX*i+x0;
				var fromY:Number=dY*i+y0;
				
				var toX:Number=fromX+dX;
				var toY:Number=fromY+dY;
				
				if(mode){
					if(toX>x1){
						toX=x1;
						toY=y1;
					}
					target.moveTo(fromX,fromY);
					target.lineTo(toX,toY);
				}
				
				count++;
				
				if(mode){
					if(count>=length){
						mode=false;
						count=0;
					}
				} else {
					if(count>=gap){
						mode=true;
						count=0;
					}
				}
			}
			
			modeObj.mode=mode;
			modeObj.length=count;
			
			return modeObj;
		}
    }
}