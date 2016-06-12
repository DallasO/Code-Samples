/* Dallas Opelt :: Used to convert Liquid Volume                   **
** Copied from http://fantes.net/conversion-charts.html#liquidconv **
** and adapted **
*/

// Dallas Opelt :: Client asked to round up to 30
// var mloz = 29.5729;
var mloz = 30;

// Dallas Opelt :: Adding 'drop' measurement to Volume Calculator
var dropml = 20;

function oztoml(d)
{
	oz=d*mloz;
	return oz;
}
function mltooz(d)
{
	ml=d/mloz;
	return ml;
}
function mltoml(d)
{
	return d;
}
function tsptoml(d)
{
	ml=d*(mloz/6);
	return ml;
}
function mltotsp(d)
{
	tps=d/(mloz/6);
	return tps;
}
function tbsptoml(d)
{
	ml=d*(mloz/2);
	return ml;
}
function mltotbsp(d)
{
	tbsp=d/(mloz/2);
	return tbsp;
}
function cuptoml(d)
{
	ml=d*(mloz*8);
	return ml;
}
function mltocup(d)
{
	cup=d/(mloz*8);
	return cup;
}
function pinttoml(d)
{
	ml=d*(mloz*16);
	return ml;
}
function mltopint(d)
{
	pint=d/(mloz*16);
	return pint;
}
function quarttoml(d)
{
	ml=d*(mloz*32);
	return ml;
}
function mltoquart(d)
{
	quart=d/(mloz*32);
	return quart;
}
function litertoml(d)
{
	ml=d*1000;
	return ml;
}
function mltoliter(d)
{
	liter=d/1000;
	return liter;
}
function gltoml(d)
{
	ml=d*(mloz*128);
	return ml;
}
function mltogl(d)
{
	gl=d/(mloz*128);
	return gl;
}
function cctoml(d)
{
	ml=d/1.000027051794;
	return ml;
}
function mltocc(d)
{
	cc=d*1.000027051794;
	return cc;
}
// Dallas Opelt :: Adding 'drop' measurement to Volume Calculator
function droptoml(d)
{
	ml=d/dropml;
	return ml;
}
// Dallas Opelt :: Adding 'drop' measurement to Volume Calculator
function mltodrop(d)
{
	gl=d*dropml;
	return gl;
}
function SourceToHub(index,d)
{
	if (index==1)
		hub=mltoml(d);
	else if (index==2)
		hub=oztoml(d);
	else if (index==3)
		hub=tsptoml(d);
	else if (index==4)
		hub=tbsptoml(d);
	else if (index==5)
		hub=cuptoml(d);
	else if (index==6)
		hub=pinttoml(d);
	else if (index==7)
		hub=quarttoml(d);
	else if (index==8)
		hub=litertoml(d);
	else if (index==9)
		hub=gltoml(d);
    // Dallas Opelt :: Adding 'drop' measurement to Volume Calculator
	else if (index==10)
		hub=droptoml(d);
	else if (index==0)
		hub=cctoml(d);
	return hub;
}
function HubToDest(index,ml)
{
	if (index==1)
		dest=mltoml(ml)+" ml";
	else if (index==2)
		dest=mltooz(ml)+" oz";
	else if (index==3)
		dest=mltotsp(ml)+" tps";
	else if (index==4)
		dest=mltotbsp(ml)+" tbsp";
	else if (index==5)
		dest=mltocup(ml)+" cup";
	else if (index==6)
		dest=mltopint(ml)+" pint";
	else if (index==7)

		dest=mltoquart(ml)+" quart";
	else if (index==8)
		dest=mltoliter(ml)+" liter";
	else if (index==9)
		dest=mltogl(ml)+" gallon";
    // Dallas Opelt :: Adding 'drop' measurement to Volume Calculator
	else if (index==10)
		dest=mltodrop(ml)+" drops";
	else if (index==0)
		dest=mltocc(ml)+" cc";
	return dest;
}

function convertLiquidVolume()
{
	var sToString="";
	text=document.conv.unitsToConvert.value;
	d=parseFloat(text);
	if (isNaN(d))
	{
		alert("Please enter a number in the Liquid Volume To Convert prompt");
	}
	else
	{
		index=document.conv.convertFrom.selectedIndex;
		ml=SourceToHub(index,d);
		index=document.conv.convertTo.selectedIndex;
		ans=roundDec(parseFloat(HubToDest(index,ml)),2);
		sToString = ans.toString();
		document.conv.convertedUnits.value = sToString.substring(0,sToString.indexOf(".") + 6);


	}
}

//-------------------------------------------------------
// Rounds a value to a specified number of decimal places and returns it.
if (typeof roundDec !== 'function') {
  function roundDec(val, dig) {

	// If no value is specified for number of significant digits
	// then set a predetermined value
	if (dig == "" || dig == undefined || dig == null)
		dig = 10

	var div = Math.pow(10, dig)
	return (Math.round(val * div) / div)
  }
}
