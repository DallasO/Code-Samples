/* ********************************************
** I wrote this Javascript file for a custom **
** calulator used on the site                **
** LotionCrafter.com                         **
** *******************************************/


function diluteSolution(inForm) {
  desiredAmount        = inForm.amountToMake.value ? parseFloat(inForm.amountToMake.value) : 1;

  if(inForm.conDesired.value && parseFloat(inForm.conStock.value)) {
    desiredConcentration = parseFloat(inForm.conDesired.value);
    stockConcentration   = parseFloat(inForm.conStock.value);

    neededStock = (desiredConcentration / stockConcentration);
    neededBase  = (1 - neededStock);

    inForm.neededBase.value    = roundDec(desiredAmount * neededBase, 2);
    inForm.neededStock.value   = roundDec(desiredAmount * neededStock, 2);
    inForm.desiredAmount.value = roundDec(desiredAmount, 2);
  } else {
    inForm.amountToMake.value  = roundDec(desiredAmount, 2);
    inForm.neededBase.value    = 0;
    inForm.neededStock.value   = 0;
    inForm.conDesired.value    = 0;
    inForm.conStock.value      = 0;
    inForm.desiredAmount.value = roundDec(desiredAmount, 2);
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
