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
  if($('#from').val()===$('#to').val()){
    toastr.error("Departing and Arriving Airport cannot be the same", "Error!")
    return false;
  }
  else{
    return true;
  }
}

function validateSuppliedDate(){
  var suppliedDate = $('#date-picker').val();
  if (suppliedDate !== ""){
    var timeAllowance = 1000 * 60 * 60 * 23.99
    var presentTimeStamp = new Date().getTime();
    var suppliedTimeStamp = new Date(suppliedDate).getTime() + timeAllowance;

    if(suppliedTimeStamp < presentTimeStamp){
      toastr.error("You cant enter a date in the past", "Error!");
      return false;
    }
    else{
      return true
    }
  }
  toastr.error("Please enter a date", "Error!");
  return false;
}