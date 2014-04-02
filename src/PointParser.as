package
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.net.FileReference;
	
	import mx.controls.Alert;

	public class PointParser extends FileReference
	{
		var mPoints:Array;
		
		public function PointParser()
		{
			mPoints = new Array();
			this.browse();
			this.addEventListener(Event.SELECT, onFileSelected); 
		}
		
		public function onFileSelected(event:Event):void 
		{ 
			this.addEventListener(ProgressEvent.PROGRESS, onProgress); 
			this.addEventListener(Event.COMPLETE, onComplete); 
			this.load(); 
		}
		
		public function onProgress(evt:ProgressEvent):void 
		{ 
			trace("Loaded " + evt.bytesLoaded + " of " + evt.bytesTotal + " bytes."); 
		}
		
		public function onComplete(evt:Event):void 
		{ 
			trace("File was successfully loaded."); 
		}
		
		public function getPoints():Array
		{
			return mPoints;	
		}
	}
}