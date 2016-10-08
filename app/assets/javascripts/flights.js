function validateFields(evt){
  evt.preventDefault();
  if (validateDepartsArrives() && validateSuppliedDate()){
    $('.search-flight').submit();
  }
  else{
    return false;
  }
}

function validateDepartsArrives(){
  if($('#from').val() === $('#to').val()){
    toastr.error("Departure and Arrival Airport cannot be the same", "Error!")
    return false;
  }
  else{
    return true;
  }
}

function validateSuppliedDate(){
  var suppliedDate = $('#date-picker').val();
  console.log(suppliedDate)
  console.log(new Date(suppliedDate));
  if (suppliedDate !== ""){
    var timeAllowance = 1000 * 60 * 60 * 23.99
    var presentTimeStamp = new Date().getTime();
    var suppliedTimeStamp = new Date(suppliedDate).getTime() + timeAllowance;

    if(suppliedTimeStamp < presentTimeStamp){
      toastr.error("You can\'t choose a date in the past", "Error!");
      return false;
    }
    else{
      return true
    }
  }
  toastr.error("Please choose a date", "Error!");
  return false;
}