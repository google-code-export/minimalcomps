/**
 * ScrollPane.as
 * Keith Peters
 * version 0.9.4
 * 
 * A panel with scroll bars for scrolling content that is larger.
 * 
 * Copyright (c) 2010 Keith Peters
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.bit101
{
	import com.bit101.components.HScrollBar;
	import com.bit101.components.Panel;
	import com.bit101.components.Style;
	import com.bit101.components.VScrollBar;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class ScrollPane extends Panel
	{
		protected var _vScrollbar:VScrollBar;
		protected var _hScrollbar:HScrollBar;
		protected var _corner:Shape;
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this ScrollPane.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function ScrollPane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		/**
		 * Initializes this component.
		 */
		override protected function init():void
		{
			super.init();
			setSize(100, 100);
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			super.addChildren();
			_vScrollbar = new VScrollBar(this, width - 10, 0, onScroll);
			_hScrollbar = new HScrollBar(this, 0, height - 10, onScroll);
			_corner = new Shape();
			_corner.graphics.beginFill(Style.BUTTON_FACE);
			_corner.graphics.drawRect(0, 0, 10, 10);
			_corner.graphics.endFill();
			addChild(_corner);
		}
		

		
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			_vScrollbar.x = width - 10;
			_vScrollbar.height = height - 10;
			_hScrollbar.y = height - 10;
			_hScrollbar.width = width - 10;
			
			_vScrollbar.setThumbPercent((_height - 10) / content.height);
			_vScrollbar.setSliderParams(0, content.height - _height + 10, _vScrollbar.value);
			_vScrollbar.pageSize = _height - 10;
			_hScrollbar.setThumbPercent((_width - 10) / content.width);
			_hScrollbar.setSliderParams(0, content.width - _width + 10, _hScrollbar.value);
			_hScrollbar.pageSize = _width - 10;
			
			_corner.x = width - 10;
			_corner.y = height - 10;
		}
		
		/**
		 * Updates the scrollbars when content is changed. Needs to be done manually.
		 */
		public function update():void
		{
			invalidate();
		}
		
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Called when either scroll bar is scrolled.
		 */
		protected function onScroll(event:Event):void
		{
			content.scrollRect = new Rectangle(_hScrollbar.value, _vScrollbar.value, _width, _height);
		}
	}
}