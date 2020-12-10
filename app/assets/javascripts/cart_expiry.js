const cart_expiry_time = 30
const confirm_dialog_time = 25

var timeoutIds = [];

document.addEventListener('turbolinks:load', function() {
  clearPreviousExpirationTime();
  setExpirationTime();

  $('#myModal').on('click','.btn-primary', function() {
    // Reloading the same page to keep the session active
    location.reload();

    $('#myModal').modal('hide');
  });

  function clearPreviousExpirationTime() {
    for(i = 0; i < timeoutIds.length; i++){
        window.clearTimeout(timeoutIds[i]);
    }
  }
  function setExpirationTime() {
    var sessionExpiry = window.setTimeout(function() {
      window.location.href = '/';
    }, cart_expiry_time * 60 * 1000);

    var confirmdialog = window.setTimeout(function() {
      $('#myModal').modal();
    }, confirm_dialog_time * 60 * 1000);

    timeoutIds = [sessionExpiry, confirmdialog];
  }
})
