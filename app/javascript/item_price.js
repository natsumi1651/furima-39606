 const priceInput = document.getElementById("item-price");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const addProfitDom = document.getElementById("profit");
    
   if (inputValue !== "") {
    const price = parseInt(inputValue, 10);
    const taxRate = 0.1;
    const tax = Math.floor(price * taxRate);
    const profit = price - tax;

    addTaxDom.innerHTML = `${tax}`;
    addProfitDom.innerHTML = `${profit}`;
  } else {
    addTaxDom.innerHTML = "";
    addProfitDom.innerHTML = "";
  }
 })