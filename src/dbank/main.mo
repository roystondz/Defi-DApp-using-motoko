import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";
import Nat "mo:base/Nat";

actor DBank {
  stable var currentValue : Float = 300;
  //currentValue := 100;
  stable var startTime = Time.now();
  //Debug.print("DBank actor initialized at " # debug_show(startTime));
  //let id = 21346587; //cannot reassign

  //Debug.print() -> prints only string 
  //Debug.print(debug_show(currentValue)); // This will print the value of currentValue to the console
  //Debug.print(debug_show(id)); // This will print the value of id to the console

  public func topUp(amount:Float){
    currentValue += amount;
    Debug.print(debug_show(currentValue)); // This will print the updated value of currentValue to the console
  };

  public func withdraw(amount:Float){
    if (amount > currentValue) {
      Debug.print("Insufficient funds");
    } else {
      currentValue -= amount;
       // This will print the updated value of currentValue to the console
    };
    Debug.print(debug_show(currentValue)); // This will print the updated value of currentValue to
  };

 
  public query func checkBalance() : async  Float{
    return currentValue;
  };

  public func compound(){
    let currentTime = Time.now();
    let elapsedTimeNS = currentTime - startTime;
    let elapsedTimeS = elapsedTimeNS / 1000000000;
    
    currentValue += currentValue * (1.01 ** Float.fromInt(elapsedTimeS)); 
    startTime := currentTime; // Reset start time after compounding
  }
  //topUp();
}