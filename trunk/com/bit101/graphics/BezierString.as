package com.bit101.graphics
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	public class BezierString
	{
		private var _pixelHinting:Boolean;
		private var _scaleMode:String;
		private var _caps:String;
		private var _joints:String;
		private var _meterLimit:Number;
		private var _alpha:Number;
		private var _closed:Boolean;
		private var _color:uint;
		private var _lineStyleSet:Boolean = false;
		private var _points:Array;
		private var _width:Number;
		
		
		public function BezierString(points:Array = null, closed:Boolean = false)
		{
			_closed = closed;
			if(points == null)
			{
				_points = new Array();
			}
			else
			{
				_points = points;
			}
		}
		
		public function lineStyle(width:Number, color:uint = 0, alpha:Number = 1, _pixelHinting:Boolean = false, _scaleMode:String = "normal", _caps:String = null, _joints:String = null, _meterLimit:Number = 3):void
		{
			_width = width;
			_color = color;
			_alpha = alpha;
			_lineStyleSet = true;
		}
		
		public function removeLineStyle():void
		{
			_lineStyleSet = false;
		}
		
		
		public function addPoint(p:Point):void
		{
			_points.push(p);
		}
		
		public function render(graphics:Graphics):void
		{
			if(_points.length < 3) return;
			
			var i:int;
			
			if(_lineStyleSet)
			{
				graphics.lineStyle(_width, _color, _alpha, _pixelHinting, _scaleMode, _caps, _joints, _meterLimit);
			}
			var mids:Array = getMids();
			
			if(_closed)
			{
				graphics.moveTo(mids[0].x, mids[0].y);
				for(i = 1; i < _points.length; i++)
				{
					graphics.curveTo(_points[i].x, _points[i].y, mids[i].x, mids[i].y);
				}
				graphics.curveTo(_points[0].x, _points[0].y, mids[0].x, mids[0].y);
			}
			else
			{
				graphics.moveTo(_points[0].x, _points[0].y);
				for(i = 1; i < _points.length - 2; i++)
				{
					graphics.curveTo(_points[i].x, _points[i].y, mids[i].x, mids[i].y);
				}
				graphics.curveTo(_points[i].x, _points[i].y, _points[i + 1].x, _points[i + 1].y);
			}
		}
		
		private function getMids():Array
		{
			var mids:Array = new Array();
			var numPoints:int = _points.length - 1;
			var pointA:Point;
			var pointB:Point;
			for(var i:int = 0; i < numPoints; i++)
			{
				pointA = _points[i];
				pointB = _points[i + 1];
				mids[i] = new Point((pointA.x + pointB.x) * .5, (pointA.y + pointB.y) * .5);  
			}
			pointA = _points[i];
			pointB = _points[0];
			mids[i] = new Point((pointA.x + pointB.x) * .5, (pointA.y + pointB.y) * .5);
			
			return mids;
		}
		
		public function set closed(value:Boolean):void
		{
			_closed = value;
		}
		public function get closed():Boolean
		{
			return _closed;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
		}
		public function get color():uint
		{
			return _color;
		}
		
		public function set points(value:Array):void
		{
			_points = value;
		}
		public function get points():Array
		{
			return _points;
		}
		
		public function set width(value:Number):void
		{
			_width = value;
		}
		public function get width():Number
		{
			return _width;
		}
		
	}
}