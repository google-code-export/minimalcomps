package com.bit101.graphics
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import mx.effects.Tween;
	
	public class PointCollection extends EventDispatcher
	{
		private var _centerX:Number = 0;
		private var _centerY:Number = 0;
		private var _points:Array;
		private var _rawPoints:Array;
		private var _tween:Tween;
		
		
		
		public function PointCollection(points:Array = null)
		{
			if(points == null)
			{
				_rawPoints = new Array();
			}
			else
			{
				_rawPoints = points;
			}
			
			_points = new Array();
			for(var i:int = 0; i < _rawPoints.length; i++)
			{
				var p:Point = _rawPoints[i] as Point;
				_points.push({point:p});
			}
		}
		
		public function addPoint(p:Point):void
		{
			_rawPoints.push(p);
			_points.push({point:p});
		}
		
		public function setCenter(x:Number, y:Number):void
		{
			_centerX = x;
			_centerY = y;
		}
		
		public function toCircle(radius:Number, time:int = 0):void
		{
			for(var i:int = 0; i < _points.length; i++)
			{
				var angle:Number = Math.PI * 2 / _points.length * i;
				var x:Number = _centerX + Math.cos(angle) * radius;
				var y:Number = _centerY + Math.sin(angle) * radius;
				setTween(i, x, y);
			}
			startTween(time);
		}
		
		public function scatterCircle(radius:Number, time:int = 0):void
		{
			for(var i:int = 0; i < _points.length; i++)
			{
				var angle:Number = Math.random() * Math.PI * 2;
				var r:Number = Math.random() * radius;
				var x:Number = _centerX + Math.cos(angle) * r;
				var y:Number = _centerY + Math.sin(angle) * r;
				setTween(i, x, y);
			}
			startTween(time);
		}
		
		public function scatter(width:Number, height:Number, time:int = 0):void
		{
			for(var i:int = 0; i < _points.length; i++)
			{
				var x:Number = _centerX + Math.random() * width - width / 2;
				var y:Number = _centerY + Math.random() * height - height / 2;
				setTween(i, x, y);
			}
			startTween(time);
		}
		
		public function toGrid(size:Number, time:int = 0):void
		{
			var cols:int = Math.ceil(Math.sqrt(_points.length));
			var rows:int = Math.ceil(_points.length / cols);
			var spaceX:Number = size / rows;
			var spaceY:Number = size / cols;
			var index:Number = 0;
			var x:Number = _centerX - spaceX * (rows - 1) / 2;
			var y:Number = _centerY - spaceY * (cols - 1) / 2;
			for(var i:int = 0; i < _points.length; i++)
			{
				_points[i].start = _points[i].point.clone();
				_points[i].end = new Point(x, y);
				x += spaceX;
				if(x > _centerX + spaceX * (rows - 1) / 2)
				{
					x = _centerX - spaceX * (rows - 1) / 2;
					y += spaceY;
				}
			}
			startTween(time);
		}
		
		public function toSquare(size:Number, time:int = 0):void
		{
			var space:Number = size * 4 / _points.length;
			
			var x:Number = _centerX - space * _points.length / 8;
			var y:Number = _centerY - space * _points.length / 8;
			var i:int = 0;
			
			while(i < _points.length / 4)
			{
				x += space;
				_points[i].start = _points[i].point.clone();
				_points[i].end = new Point(x, y);
				i++;
			}
			while(i < _points.length / 2)
			{
				y += space
				_points[i].start = _points[i].point.clone();
				_points[i].end = new Point(x, y);
				i++;
			}
			while(i < _points.length * 3 / 4)
			{
				x -= space;
				_points[i].start = _points[i].point.clone();
				_points[i].end = new Point(x, y);
				i++;
			}
			while(i < _points.length)
			{
				y -= space;
				_points[i].start = _points[i].point.clone();
				_points[i].end = new Point(x, y);
				i++;
			}
			startTween(time);
		}
		
		public function randomize(amount:Number, time:int = 0):void
		{
			for(var i:int = 0; i < _points.length; i++)
			{
				var x:Number = _points[i].point.x + Math.random() * amount * 2 - amount;
				var y:Number = _points[i].point.y + Math.random() * amount * 2 - amount;
				setTween(i, x, y);
			}
			startTween(time);
		}
		
		public function toPoints(targets:Array, time:int = 0):void
		{
			if(targets.length != _points.length)
			{
				throw(new Error("PointCollection.tweenToPoints(targets:Array) error: targets points array and internal points array must have same number of points"));
			}
			for(var i:int = 0; i < _points.length; i++)
			{
				_points[i].start = _points[i].point.clone();
				_points[i].end = targets[i];
			}
			startTween(time);
		}
		
		public function toCenter(time:int = 0):void
		{
			for(var i:int = 0; i < _points.length; i++)
			{
				_points[i].start = _points[i].point.clone();
				_points[i].end = new Point(_centerX, _centerY);
			}
			startTween(time);
		}
		
		public function toVLine(size:Number, time:int = 0):void
		{
			var space:Number = size / (_points.length - 1);
			var y:Number = _centerY - size / 2;
			
			for(var i:int = 0; i < _points.length; i++)
			{
				setTween(i, _centerX, y);
				y += space;
			}
			startTween(time);
		}
		
		public function toHLine(size:Number, time:int = 0):void
		{
			var space:Number = size / (_points.length - 1);
			var x:Number = _centerX - size / 2;
			
			for(var i:int = 0; i < _points.length; i++)
			{
				setTween(i, x, _centerY);
				x += space;
			}
			startTween(time);
		}
		
		public function toStar(radius:Number, spokes:int, time:int = 0):void
		{
			var pointsPerSpoke:int = Math.ceil(_points.length / spokes);
			var space:Number = radius / pointsPerSpoke;
			var angle:Number = 0;
			var r:Number = space;
			trace(pointsPerSpoke, space, angle, r);
			for(var i:int = 0; i < _points.length; i++)
			{
				var x:Number = _centerX + Math.cos(angle) * r;
				var y:Number = _centerY + Math.sin(angle) * r;
				setTween(i, x, y);
				
				r += space;
				if(r > radius)
				{
					angle += Math.PI * 2 / spokes;
					r = space;
				}
			}
			startTween(time);
		}
		
		
		
		
		private function setPoint(index:int, x:Number, y:Number):void
		{
			_points[index].point.x = x;
			_points[index].point.y = y;
		}
		
		private function setTween(index:int, x:Number, y:Number):void
		{
			_points[index].start = _points[index].point.clone();
			_points[index].end = new Point(x, y);
		}
		
		public function render(graphics:Graphics, color:uint = 0, radius:Number = 1):void
		{
			for(var i:int = 0; i < _points.length; i++)
			{
				graphics.beginFill(color);
				graphics.drawCircle(_points[i].point.x, _points[i].point.y, radius);
				graphics.endFill();
			}
		}
		
		private function startTween(time:int):void
		{
			if(_tween != null)
			{
				_tween.stop();
			}
			_tween = new Tween(this, 0, 1, time, -1, onTween, onTweenEnd);
		}
		
		private function onTween(value:Object):void
		{
			update(value as Number);
		}
		
		private function onTweenEnd(value:Object):void
		{
			update(value as Number);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function update(value:Number):void
		{
			for(var i:int = 0; i < _points.length; i++)
			{
				var p:Object = _points[i];
				var x:Number = p.start.x + (p.end.x - p.start.x) * value;
				var y:Number = p.start.y + (p.end.y - p.start.y) * value;
				setPoint(i, x, y);
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get numPoints():int
		{
			return _points.length;
		}
		
	}
}