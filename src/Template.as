package
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import flashx.textLayout.formats.Float;
	
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import mx.controls.Button;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.effects.Move;
	import mx.effects.Resize;
	import mx.effects.Sequence;
	
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
		public var xImage:Image;
		private var loadTemplate:Button;
		private var myPlotLine:Canvas;
		private var logicOperator:int;
		private var logicOperatorPanel:Canvas;
		
		
		//--------------------------------------------------------------All the ints
		public var templateID:int;
		public var offset:int = 0;
		private var leftBound:int;
		private var rightBound:int = 0;
		
		//--------------------------------------------------------------floats
		
		
		private var nSec1:Number = -1.0;
		private var nSec2:Number = -1.0;
		private var hLine:Number;

		
		//--------------------------------------------------------------Arrays and so on
		private var dependentArray:Array;
		private  var myPoints:Array;
		
		//--------------------------------------------------------------file reader Elements
		private var mPointParser:PointParser;
		
		public function Template()
		{
			
			myPoints = new Array();
			xImage = new Image();
			
			logicOperatorPanel = new Canvas();
			logicOperatorPanel.setStyle("backgroundColor","#FF9900"); 
			logicOperatorPanel.setStyle("textColor", "FFFFFF");
			
			
			plot = new Canvas(); //creates the general canvas for drawing on
			plot.setStyle("backgroundColor","#F7C36D"); 
			plot.setStyle("borderStyle","solid");
			plot.height = 130;
			plot.width = 150;
			plot.top = 20;
			plot.x = 20;

			
			
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
			panelButtons.top = 20
			panelButtons.width = 20;
			panelButtons.height = plot.height;
			panelButtons.setStyle("borderStyle","solid");
			
			
			
			loadTemplate= new Button(); //making loadButton
			loadTemplate.label = "Load Template";
			loadTemplate.addEventListener(MouseEvent.CLICK, loadClicked);
			loadTemplate.verticalCenter = 0;
			loadTemplate.right  = 20;
			this.addElement(loadTemplate);
			
			
			
			this.addElement(plot);
			this.addElement(panelButtons);
			panelButtons.addElement(settingsImage);
			this.addElement(loadTemplate);
			
			//testing
			setLogicOperator(0);
			//generateTickMarks(5);
		}
		
		

		
		
		public function getOffSet():int
		{
			return offset;
		}
		
		public function setOffSet(a:int):void //function for  offseting the template
		{
			//this.x = a;
			offset = a;
		}
		
		public function generateTickMarks(scale:int):void //dynamically generate tick marks based on scale value
		{
			var numberOfTicks:int = 5;
			plot.graphics.clear();
			plot.graphics.beginFill(0x000000, 1);
			plot.graphics.lineStyle(1, 0x990000, .75);
			for(var i:int; i < numberOfTicks; i++)
			{
				plot.graphics.moveTo(0, i*20);
				plot.graphics.lineTo(5,i*20);
			}
		}
		
		public function drawPlot(event:Event):void // function for drawing the Plot Line and points
		{
			
			
			var fileString:String = mPointParser.data.toString();
			
			var stringArray:Array = fileString.split('\n');
			
			for(var i:int; i < stringArray.length-1; i++)
			{
				var pointString:Array = stringArray[i].split(',');
				var mPoint:Point = new Point();
				mPoint.x = parseInt(pointString[0],10);
				mPoint.y = parseInt(pointString[1],10);
				myPoints.push(mPoint);
			}
			
			var maxDomain:int = 0;		
			myPlotLine= new Canvas();
			myPlotLine.x = 20;
			

			paintPlot();
			
			maxDomain = myPoints[myPoints.length-1].x;
			//plot.width = maxDomain + 20;
			
			var mResize:Resize = new Resize();
			mResize.target = plot;
			mResize.widthFrom = plot.width;
			mResize.widthBy = 2;
			mResize.widthTo = maxDomain+20;
			
			rightBound = maxDomain;
			
			mResize.play();
			this.addElement(myPlotLine);
			

			this.removeElement(loadTemplate);
		}
		
		public function loadClicked(event:Event):void
		{
			mPointParser = new PointParser();
			
			mPointParser.addEventListener(Event.COMPLETE, drawPlot);
		}
		
		public function paintPlot():void
		{
			myPlotLine.graphics.beginFill(0x000000, 1);
			myPlotLine.graphics.lineStyle(1,0x006DFC);
			myPlotLine.graphics.moveTo(myPoints[0].x,myPoints[0].y);
			for(var index:int; index < myPoints.length; index++)
			{
				myPlotLine.graphics.lineTo(myPoints[index].x, plot.height - myPoints[index].y);
				myPlotLine.graphics.moveTo(myPoints[0].x,plot.height - myPoints[0].y);
				myPlotLine.graphics.drawCircle(myPoints[index].x, plot.height -myPoints[index].y, 3);
			}
			
			
			
			myPlotLine.graphics.endFill();
		}
		
		//-----------------------------------------------------------------------status checkers
		
		public function plotIsSet():Boolean
		{
			if(myPoints.length == 0)
				return false;
			else
				return true;
		}
		
		//---------------------------------------------------------------------Getters and Setters---------
		
		
		public function setTemplateID(a:int):void
		{
			templateID = a;
		}
		public function getTemplateID():int
		{
			return templateID;
		}
		
		
		public function setLogicOperator(operator:int ):void //sets logic Operator
		{
			
			
			logicOperatorPanel.removeAllElements();
			var tempLabel:Label = new Label();
			logicOperator = operator;
			
			if(logicOperator == 0)
			{
			}
			
			if(logicOperator == 1)
			{
				tempLabel.text = "Always";
				logicOperatorPanel.addElement(tempLabel);
			}
			
			if(logicOperator == 2)
			{
				tempLabel.text = "At Least Once";
				logicOperatorPanel.addElement(tempLabel);
			}
			
			if(logicOperator == 3)
			{
				tempLabel.text = "Repeatedly";
				logicOperatorPanel.addElement(tempLabel);
			}
			
			if(logicOperator == 4)
			{
				tempLabel.text = "Eventually Repeatedly";
				logicOperatorPanel.addElement(tempLabel);
			}
			
			
			this.addElement(logicOperatorPanel);
			
		}
		
		public function setHLine(a:Number):void
		{
			myPlotLine.graphics.clear();
			paintPlot();
			myPlotLine.graphics.beginFill(0x000000, 1);
			myPlotLine.graphics.lineStyle(1,0x006DFC);
			
			hLine = a;
			for(var index:int; index < myPoints[myPoints.length-1].x; index  = index + 10)
			{
				myPlotLine.graphics.moveTo( index + 5,plot.height - a);
				myPlotLine.graphics.lineTo(index, plot.height -  a);
			}
			
			calculateIntersection(a);
		}
		
		public function setLeftBound(a:int):void
		{
			leftBound = a * 10 + 20;
			
			
			plot.x = leftBound;
			plot.width = rightBound - leftBound + 20;
			
		}
		

		public function setRightBound(a:int):void
		{
			rightBound = a * 10 + 20;
			
			
			plot.width = rightBound - leftBound;
		}

		
		public function setBounds(a:int, b:int):void
		{
			leftBound = a*10 + 20;
			rightBound = b*10 + 20;
			
			plot.x = leftBound;
			plot.width = rightBound - leftBound;
		}
		
		
		public function calculateIntersection(hLine:int):void
		{
			var slope:Number;
			var x:Number;
			var b:Number;
			
			xImage.source = "redX.png";
			xImage.height = 20;
			xImage.width = 20;
			
			for(var i:int = 0; i < myPoints.length ; i++)
			{
				if(myPoints[i].y == hLine)
				{
					if(nSec1 != -1)
					{
						nSec2 = myPoints[i].x;

						xImage.x = myPoints[i].x-10;
						xImage.y = plot.height - myPoints[i].y-10;

						
						myPlotLine.addElement(xImage);
						
					}
					else
					{
						nSec1 = myPoints[i].x;
						xImage.x = myPoints[i].x-10;
						xImage.y = plot.height -  myPoints[i].y-10;
						
						myPlotLine.addElement(xImage);
					}
					
					
				}
			}
			
			for(var i:int = 0; myPoints.length > 1 && i < myPoints.length-1; i++)
			{
				
			}
			
		}
		
		public function getNSec():Number
		{
			return nSec1;
		}
		
	}
}