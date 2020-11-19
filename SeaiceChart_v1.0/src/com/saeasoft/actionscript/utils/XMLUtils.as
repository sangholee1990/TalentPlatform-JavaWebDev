package com.saeasoft.actionscript.utils
{
	public class XMLUtils
	{
		public function XMLUtils()
		{
		}
		
		public static function sortXMLByAttribute(
			$xml		:	XML,
			$attribute	:	String,
			$options	:	Object	=	null,
			$copy		:	Boolean	=	false
		):XML
		{
			//store in array to sort on
			var xmlArray:Array	= new Array();
			var item:XML;
			for each(item in $xml.children())
			{
				var object:Object = {
					data	: item, 
					order	: item.attribute($attribute)
				};
				xmlArray.push(object);
			}
			
			//sort using the power of Array.sortOn()
			xmlArray.sortOn('order',$options);
			
			//create a new XMLList with sorted XML
			var sortedXmlList:XMLList = new XMLList();
			var xmlObject:Object;
			for each(xmlObject in xmlArray )
			{
				sortedXmlList += xmlObject.data;
			}
			
			if($copy)
			{
				//don't modify original
				return	$xml.copy().setChildren(sortedXmlList);
			}
			else
			{
				//original modified41.		
				return $xml.setChildren(sortedXmlList);
			}
		}		
	}
}