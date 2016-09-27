$(document).ready(function (){
  if ($(".rm_pass").length == 0) {
    $(".smtbook").attr("disabled", true);
  };
});

function adder() {
  var cost =  parseInt($(".cost").text().match(/\d+/));
  var init_total =  parseInt($(".total").text().match(/\d+/));
  total = init_total + cost;
  totalizer(total);
  passenger_calc("add");
  $(".smtbook").attr("disabled", false);
}

function remover() {
  var cost =  parseInt($(".cost").text().match(/\d+/));
  var init_total =  parseInt($(".total").text().match(/\d+/));
  total = init_total - cost;
  totalizer(total);
  passenger_calc("subtract");
  if ($(".rm_pass").length == 1)
  {
    $(".smtbook").attr("disabled", true);
  };
}

function passenger_calc(action) {
  if (action  == "add")
  {
    pass = parseInt($(".pass_num").text().match(/\d+/)) + 1;
  }
  else if (action == "subtract")
  {
    pass = parseInt($(".pass_num").text().match(/\d+/)) - 1;
  }
  $(".pass_num").text(pass);
  $(".pass_tracker").val(pass);
}

function totalizer(total) {
  $(".cost_tracker").val(total);
  $(".total").text("$" + total);
}