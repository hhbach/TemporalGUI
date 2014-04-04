package
{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.controls.TextInput;
	import mx.controls.VSlider;
	import mx.events.DropdownEvent;
	
	import spark.components.ComboBox;
	import spark.components.TextInput;

	public class SidePanel extends Canvas
	{
		public  var oKB:Button;
		public  var cB:Button;
		private var operators:ArrayCollection;
		private var operatorDropDown:mx.controls.ComboBox;
		private var panelID:int;
		private var panelName:Label;
		private var selectedTemplate:Template;
		private var hLineTextInput:mx.controls.TextInput;
		private var leftBoundTextInput:mx.controls.TextInput;
		private var rightBoundTextInput:mx.controls.TextInput;
		public function SidePanel()
		{
		
			//--------------------------------------------------------define different labels
			
			var titleCanvas:Canvas = new Canvas();
			titleCanvas.setStyle("backgroundColor","#FFFFFF"); 
			titleCanvas.width = 173;
			titleCanvas.height = 20;
			titleCanvas.addEventListener(MouseEvent.MOUSE_DOWN ,moveSidePanel);
			titleCanvas.addEventListener(MouseEvent.MOUSE_UP, stopMoveSidePanel);
			panelName = new Label();
			panelName.text = "Panel Number: ";
			this.addElement(titleCanvas);
			this.addElement(panelName);
			
			
			

			addHLTextInput();
			addLogicComboBox();
			addOkayButton();
			addCancelButton();
			addAboveOrBelowButton();
			addLeftBound();
			addRightBound();
			
			//---------------------------------------------defines the layout of the side panel
			this.setStyle("backgroundColor","#979795"); 
			this.setStyle("borderStyle","solid");
			this.width = 175;
			this.height = 400;
			this.y = 100;
			
			
		}

		//--------------------------------------------------------------buttons and textbox
		
		public function addOkayButton():void
		{
			oKB = new Button();
			oKB.label = "Accept";
			oKB.right = 15;
			oKB.bottom = 5;
			oKB.addEventListener(MouseEvent.CLICK, setTemplateVariables);
			oKB.enabled = false;
			this.addElement(oKB);
		}
		
		
		
		public function addCancelButton():void
		{
			cB = new Button();
			cB.label = "Cancel";
			cB.left = 15;
			cB.bottom = 5;
			this.addElement(cB);
		}
		
		public function addLogicComboBox():void
		{
			
			
			var logicOperatorLabel:Label= new Label();
			logicOperatorLabel.text = "Logic Operator";
			logicOperatorLabel.y = 35
			
			
			operators = new ArrayCollection( [{label: "None", data: 0},{label: "always", data: 1}, {label: "At Least Once", data: 2}, {label: "Repeatedly", data: 3}, {label: "Eventually Repeatedly", data: 4}]);
			operatorDropDown = new mx.controls.ComboBox();
			operatorDropDown.dataProvider = operators;
			
			operatorDropDown.y =55
			operatorDropDown.x = 10;
			operatorDropDown.addEventListener(DropdownEvent.CLOSE, closeHandler);
			operatorDropDown.width = 150;
			this.addElement(operatorDropDown);
			this.addElement(logicOperatorLabel);
		}
		
		
		
		public function addHLTextInput():void
		{
			var hLineLabel:Label = new Label();
			hLineLabel.text = "Horizontal Line";
			hLineLabel.y = 80;
			hLineTextInput = new  mx.controls.TextInput();
			hLineTextInput.y = 100;
			hLineTextInput.x = 10;
			hLineTextInput.restrict = "0-9.";
			hLineTextInput.width = 150;
			
			this.addElement(hLineLabel);
			this.addElement(hLineTextInput);
		}
		
		
		
		public function addAboveOrBelowButton():void
		{
			var aboveOrBelow:VSlider= new VSlider();
			aboveOrBelow.maximum = 2;
			aboveOrBelow.minimum = 0;
			aboveOrBelow.value = 1;
			aboveOrBelow.snapInterval = 1;
			aboveOrBelow.y = 130;
			aboveOrBelow.height = 60;
			aboveOrBelow.right = 25;
			aboveOrBelow.showDataTip = false;
			aboveOrBelow.labels= ["Above"," =" , "Below"];
			this.addElement(aboveOrBelow);
		}
		
		
		
		public function addLeftBound():void
		{
			var leftBoundLabel:Label = new Label();
			leftBoundLabel.text = "Left Bound: ";
			leftBoundLabel.y = 180;
			
			leftBoundTextInput = new mx.controls.TextInput();
			leftBoundTextInput.x = 10;
			leftBoundTextInput.y = 200;
			leftBoundTextInput.restrict = "0-9";
			leftBoundTextInput.width = 150;
		
			
			this.addElement(leftBoundLabel);
			this.addElement(leftBoundTextInput);
		}
		
		public function addRightBound():void
		{
			var leftBoundLabel:Label = new Label();
			leftBoundLabel.text = "Right Bound: ";
			leftBoundLabel.y = 230;
			
			rightBoundTextInput= new mx.controls.TextInput();
			rightBoundTextInput.x = 10;
			rightBoundTextInput.y = 250;
			rightBoundTextInput.restrict = "0-9";
			rightBoundTextInput.width = 150;
			
			
			this.addElement(leftBoundLabel);
			this.addElement(rightBoundTextInput);
		}
		
		
		//setters and getters
		
		public function setTemplateVariables(event:Event):void
		{
			
			if(hLineTextInput.text != "")
				selectedTemplate.setHLine(parseInt(hLineTextInput.text));

			
			if(rightBoundTextInput.text != "" && leftBoundTextInput.text != "")
				selectedTemplate.setBounds(parseInt(leftBoundTextInput.text), parseInt(rightBoundTextInput.text));
			else
			{
				if(rightBoundTextInput.text != "")
					selectedTemplate.setRightBound(parseInt(rightBoundTextInput.text));
				
				if(leftBoundTextInput.text != "")
					selectedTemplate.setLeftBound(parseInt(leftBoundTextInput.text));
			}
			
			
			
		}
		
		public function setPanel(mTemplate:Template):void
		{
			panelID = mTemplate.getTemplateID();
			selectedTemplate = mTemplate;
			panelName.text = "Template ID: " + selectedTemplate.getTemplateID();
			hLineTextInput.text = "";
			leftBoundTextInput.text = "";
			rightBoundTextInput.text = "";
			
			//enable apply Button if plot is Set
			
			if(selectedTemplate.plotIsSet())
			{
				oKB.enabled = true;
			}
			else
			{
				oKB.enabled = false;
			}
		}
		
		//----------------------------------------------------------------------- Event handlers
		
		
		private function closeHandler(event:DropdownEvent):void {
			var logicType:int = parseInt(mx.controls.ComboBox(event.target).selectedItem.data, 10);
			selectedTemplate.setLogicOperator(logicType);
		}
		
		// moving Panel
		public function moveSidePanel(event:Event):void{
			this.startDrag();
		}
		
		public function stopMoveSidePanel(event:Event):void{
			this.stopDrag();
		}
	}

	

}