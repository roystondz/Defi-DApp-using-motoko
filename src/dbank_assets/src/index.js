import { Bool } from "@dfinity/candid/lib/cjs/idl";
import {dbank} from "../../declarations/dbank";


window.addEventListener("load", async () => {
  update();
});

document.querySelector("form").addEventListener("submit", async (event) => {
  event.preventDefault();
  const inputAmount = document.getElementById("input-amount").value;
  const withdrawAmount = document.getElementById("withdrawal-amount").value;

  const button = event.target.querySelector("#submit-btn");

  button.setAttribute("disabled", "true");
  const amount = parseFloat(inputAmount) || 0;
  if (document.getElementById("input-amount").value < 0) {
    alert("Please enter a valid amount.");
    return;
  }
  console.log(amount);
  
  
    const withdraw = parseFloat(withdrawAmount) || 0;
    console.log(withdraw);
    if (document.getElementById("withdrawal-amount").value < 0 ) {
      alert("Please enter a valid withdrawal amount.");
      return;
    }

    await dbank.withdraw(withdraw);
  

  
  await dbank.topUp(amount);
  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";
  document.getElementById("value").innerText = "Compounding...";
  button.removeAttribute("disabled");
  await dbank.compound();
  
  
   // Wait for 2
  update();
})

async function update(){
  const value = await  dbank.checkBalance();
document.getElementById("value").innerText = Math.round(value * 100) / 100;
}