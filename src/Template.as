package
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.Image;
	
	import spark.components.Group;
	import spark.components.RadioButton;

	public class Template extends Canvas
	{
		//---------------------------------------------------------------displayElements
		public var plot:Canvas;
		public var panelButtons:Canvas;
		public var settingsImage:Image;
		public var loadButton:Button;
		public var addChildButton:Button;
		public var intersectButton:RadioButton;
		private var loadTemplate:Button;
		
		
		//--------------------------------------------------------------All the ints
		public var templateID:int;
		public var templateOffset:int = 0;
		
		
		//--------------------------------------------------------------Arrays and so on
		public var dependentArray:Array;
		public  var myPoints:Array;
		
		//--------------------------------------------------------------file reader Elements
		
		var fileReference:FileReference;
		
		public function Template()
		{
			
			myPoints = new Array();
			
			
			
			plot = new Canvas(); //creates the general canvas for drawing on
			plot.height = 100;
			plot.width = 300
			this.setStyle("backgroundColor","#FFAD33"); 
			
			
			settingsImage = new Image(); //settings image properties
			settingsImage.source = "setting.png";
			settingsImage.setStyle("backgroundColor", "Black");
			settingsImage.left = 0;
			settingsImage.right = 0;
			settingsImage.width = 20;
			settingsImage.height = 20;
			
			
			panelButtons = new Canvas();
			panelButtons.setStyle("backgroundColor","#F8DEC2");
			panelButtons.left = 0;
			panelButtons.top = 0;
			panelButtons.width = 20;
			panelButtons.height = plot.height;
			
			
			
			loadTemplate= new Button(); //making loadButton
			loadTemplate.label = "Load Template";
			loadTemplate.addEventListener(MouseEvent.CLICK, loadClicked);
			loadTemplate.verticalCenter = 0;
			loadTemplate.right  = 20;
			this.addElement(loadTemplate);
			
			
			
			intersectButton = new RadioButton(); //testing radioButton
			intersectButton.x = 293;
			intersectButton.y = 42;
			this.addElement(intersectButton);
			intersectButton.selected = true;
			
			this.addElement(plot);
			this.addElement(panelButtons);
			this.addElement(settingsImage);
			this.addElement(loadTemplate);
			
			generateTickMarks(5);
		}
		
		

		
		
		public function offSetTemplate(a:int):void //function for  offseting the template
		{
			this.x = a;
			templateOffset = 0;
		}
		
		public function generateTickMarks(scale:int):void //dynamically generate tick marks based on scale value
		{
			var numberOfTicks:int = 5;
			plot.graphics.clear();
			plot.graphics.beginFill(0x000000, 1);
			plot.graphics.lineStyle(1, 0x990000, .75);
			for(var i:int; i < numberOfTicks; i++)
			{
				plot.graphics.moveTo(20, i*20);
				plot.graphics.lineTo(25,i*20);
			}
		}
		
		public function drawPlot(event:Event):void // function for drawing the Plot Line and points
		{
			
			//-----------hardwired points FOR TROUBLE SHOOTING PURPOSE------
			var myPoint:Point = new Point();
			myPoint.x = 100;
			myPoint.y = 50;
			var myPoint2:Point = new Point();
			myPoints.push(myPoint);
			myPoint2.x = 300;
			myPoint2.y = 50;
			var myPoint3:Point = new Point();
			myPoints.push(myPoint2);
			myPoint3.x = 600;
			myPoint3.y = 50;
			var myPoint4:Point = new Point();
			myPoints.push(myPoint3);
			myPoint4.x = 900;
			myPoint4.y = 50;
			myPoints.push(myPoint4);
			//----------------------------------------------------------------------------
			
			var maxDomain:int = 0;		
			var myPlotLine:Canvas= new Canvas();
			


			//------------------------graphing the points---------
			myPlotLine.graphics.beginFill(0x000000, 1);
			myPlotLine.graphics.lineStyle(1,0x006DFC);
			myPlotLine.graphics.moveTo(myPoints[0].x,myPoints[0].y);
			for(var index:int; index < myPoints.length; index++)
			{
				myPlotLine.graphics.lineTo(myPoints[index].x, myPoints[index].y);
				myPlotLine.graphics.moveTo(myPoints[0].x,myPoints[0].y);
				myPlotLine.graphics.drawCircle(myPoints[index].x, myPoints[index].y, 3);
			}
			

			
			myPlotLine.graphics.endFill();
			
			
			maxDomain = myPoints[myPoints.length-1].x;
			plot.width = maxDomain + 20;
			plot.addElement(myPlotLine);
			

			this.removeElement(loadTemplate);
		}
	}
}