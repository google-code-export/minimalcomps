package com.bit101.components
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class ComboBox extends Component
	{
		public static const TOP:String = "top";
		public static const BOTTOM:String = "bottom";
		
		protected var _list:List;
		protected var _numVisibleItems:int = 6;
		protected var _labelButton:PushButton;
		protected var _dropDownButton:PushButton;
		protected var _open:Boolean = false;
		protected var _openPosition:String = "top";
		
		
		public function ComboBox(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
		}
		
		protected override function init():void
		{
			super.init();
			setSize(100, 20);
		}
		
		protected override function addChildren():void
		{
			super.addChildren();
			_list = new List();
			_list.addEventListener(Event.SELECT, onSelect);
			
			_labelButton = new PushButton(this, 0, 0, "", onDropDown);
			_dropDownButton = new PushButton(this, 0, 0, "+", onDropDown);
		}
		
		
		public override function draw():void
		{
			super.draw();
			_labelButton.setSize(_width - _height, _height);
			_dropDownButton.setSize(_height, _height);
			_dropDownButton.x = _width - height;
			_list.setSize(_width, _numVisibleItems * _list.listItemHeight);
		}
		
		
		/**
		 * Adds an item to the list.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 */
		public function addItem(item:Object):void
		{
			_list.addItem(item);
		}
		
		/**
		 * Adds an item to the list at the specified index.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 * @param index The index at which to add the item.
		 */
		public function addItemAt(item:Object, index:int):void
		{
			_list.addItemAt(item, index);
		}
		
		/**
		 * Removes the referenced item from the list.
		 * @param item The item to remove. If a string, must match the item containing that string. If an object, must be a reference to the exact same object.
		 */
		public function removeItem(item:Object):void
		{
			_list.removeItem(item);
		}
		
		/**
		 * Removes the item from the list at the specified index
		 * @param index The index of the item to remove.
		 */
		public function removeItemAt(index:int):void
		{
			_list.removeItemAt(index);
		}
		
		/**
		 * Removes all items from the list.
		 */
		public function removeAll():void
		{
			_list.removeAll();
		}
	
		
		protected function onDropDown(event:MouseEvent):void
		{
			_open = !_open;
			if(_open)
			{
				var point:Point = new Point();
				if(_openPosition == BOTTOM)
				{
					point.y = _height;
				}
				else
				{
					point.y = -_numVisibleItems * _list.listItemHeight;
				}
				point = this.localToGlobal(point);
				_list.move(point.x, point.y);
				stage.addChild(_list);
				stage.addEventListener(MouseEvent.CLICK, onStageClick);
				_dropDownButton.label = "-";
			}
			else
			{
				if(stage.contains(_list)) stage.removeChild(_list);
				_dropDownButton.label = "+";
			}
		}
		
		protected function onStageClick(event:MouseEvent):void
		{
			// ignore clicks within buttons or list
			if(event.target == _dropDownButton || event.target == _labelButton) return;
			if(_list.getBounds(stage).contains(event.stageX, event.stageY)) return;
			
			_open = false;
			_dropDownButton.label = "+";
			if(stage.contains(_list))
			{
				stage.removeChild(_list);
			}
		}
		
		protected function onSelect(event:Event):void
		{
			_open = false;
			_dropDownButton.label = "+";
			if(stage.contains(_list))
			{
				stage.removeChild(_list);
			}
			
			if(selectedItem == null)
			{
				_labelButton.label = "";
			}
			else if(selectedItem is String)
			{
				_labelButton.label = selectedItem as String;
			}
			else if(selectedItem.label is String)
			{
				_labelButton.label = selectedItem.label;
			}
			else
			{
				_labelButton.label = "";
			}
			dispatchEvent(event);
		}
		
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the index of the selected list item.
		 */
		public function set selectedIndex(value:int):void
		{
			_list.selectedIndex = value;
		}
		public function get selectedIndex():int
		{
			return _list.selectedIndex;
		}
		
		/**
		 * Sets / gets the item in the list, if it exists.
		 */
		public function set selectedItem(item:Object):void
		{
			_list.selectedItem = item;
		}
		public function get selectedItem():Object
		{
			return _list.selectedItem;
		}
		
		/**
		 * Sets/gets the default background color of list items.
		 */
		public function set defaultColor(value:uint):void
		{
			_list.defaultColor = value;
		}
		public function get defaultColor():uint
		{
			return _list.defaultColor;
		}
		
		/**
		 * Sets/gets the selected background color of list items.
		 */
		public function set selectedColor(value:uint):void
		{
			_list.selectedColor = value;
		}
		public function get selectedColor():uint
		{
			return _list.selectedColor;
		}
		
		/**
		 * Sets/gets the rollover background color of list items.
		 */
		public function set rolloverColor(value:uint):void
		{
			_list.rolloverColor = value;
		}
		public function get rolloverColor():uint
		{
			return _list.rolloverColor;
		}
		
		/**
		 * Sets the height of each list item.
		 */
		public function set listItemHeight(value:Number):void
		{
			_list.listItemHeight = value;
			invalidate();
		}
		public function get listItemHeight():Number
		{
			return _list.listItemHeight;
		}
		
	}
}