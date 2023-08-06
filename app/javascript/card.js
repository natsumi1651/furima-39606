console.log("ok")
const pay = () => {
  console.log("ok")
  const payjp = Payjp('pk_test_81cee47978c9ac7a902721f7')
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');


  const form = document.getElementByClassName('form-group')
  form.addEventListener("submit", (e) => {
    
  payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        console.log(token)
      }
    });
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);
