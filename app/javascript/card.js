const pay = () => {
  Payjp.setPublicKey("pk_test_d6240218af77b9fb1e4af848"); // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", () => {

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("card-number"),
      cvc: formData.get("card-cvc"),
      exp_month: formData.get("card-exp-month"),
      exp_year: `20${formData.get("card-exp-year")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        console.log(token)
      }
    });

  });
};

window.addEventListener("load", pay);