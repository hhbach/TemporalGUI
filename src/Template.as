package
{
	import mx.containers.Canvas;
	import mx.controls.Button;
	import mx.controls.Image;
	
	import spark.components.Group;

	public class Template extends Group
	{
		public var plot:Canvas;
		public var panelButtons:Canvas;
		public var settingsImage:Image;
		public var loadButton:Button;
		public var addChildButton:Button;
		public var templateID:int;
		
		public var dependentArray:Template;
		
		public function Template()
		{
			plot = new Canvas(); //creates the general canvas for drawing on
			plot.height = 100;
			plot.width = 1000;
			plot.setStyle("backgroundColor","#FF9933"); 
			
			
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
			
			this.addElement(plot);
			this.addElement(panelButtons);
			this.addElement(settingsImage);
		}
	}
}